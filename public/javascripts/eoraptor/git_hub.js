/* DO NOT MODIFY. This file was compiled Sat, 04 Dec 2010 18:59:41 GMT from
 * /Users/sutto/Code/OSS/eoraptor/app/coffeescripts/eoraptor/git_hub.coffee
 */

var __indexOf = Array.prototype.indexOf || function(item) {
  for (var i = 0, l = this.length; i < l; i++) {
    if (this[i] === item) return i;
  }
  return -1;
};
Eoraptor.withNS('GitHub', function(ns) {
  var ghParseDate, spanWithClass;
  ns.showCommits = function(results) {
    var commit, _i, _len, _ref, _results;
    if (__indexOf.call(results, "commits") < 0) {
      return;
    }
    ns.commits = results.commits;
    ns.container = $("#commit-listing");
    ns.container.empty();
    _ref = ns.commits.slice(0, 10);
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      commit = _ref[_i];
      _results.push(ns.showCommit(commit));
    }
    return _results;
  };
  spanWithClass = function(klass, content) {
    return $("<span />", {
      'class': "gh-commit-" + klass,
      'html': content
    });
  };
  ghParseDate = function(dateString) {
    var date;
    date = new Date();
    date.setISO8601(dateString);
    return date;
  };
  ns.showCommit = function(commit) {
    var author, commitLink, commitedTime, inner;
    author = commit.author;
    inner = $("<li />", {
      'class': 'github-commit'
    });
    author = $("<a />", {
      'href': "http://github.com/" + author.login,
      'text': author.name,
      'class': 'gh-commit-author'
    });
    inner.append(author);
    inner.append(spanWithClass('misc', ' committed '));
    commitLink = $("<a />", {
      'href': commit.url,
      'html': Eoraptor.Util.truncate(commit.message, 45),
      'class': 'gh-commit-message',
      title: commit.message
    });
    inner.append(commitLink);
    inner.append(spanWithClass('misc', ' about '));
    commitedTime = ghParseDate(commit.committed_date);
    ({
      time: spanWithClass('commited-at', '')
    });
    Eoraptor.Util.attachUpdatingTimeAgo(time, commitedTime);
    inner.append(time);
    inner.append(spanWithClass('misc', ' ago.'));
    return ns.container.append(inner);
  };
  ns.commitsURL = function() {
    return "http://github.com/api/v2/json/commits/list/" + ns.user + "/" + ns.repository + "/master?callback=" + (ns.toNSName()) + ".showCommits";
  };
  ns.loadCommits = function() {
    if ((ns.user != null) && (ns.repository != null)) {
      return $.getScript(ns.commitsURL());
    }
  };
  return ns.setup = function() {
    ns.user = $.metaAttr("github.user");
    ns.repository = $.metaAttr("github.repository");
    return ns.loadCommits();
  };
});