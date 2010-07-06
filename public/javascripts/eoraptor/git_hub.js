Eoraptor.withNS('GitHub', function(ns) {
  var ghParseDate, spanWithClass;
  ns.showCommits = function showCommits(results) {
    var _a, _b, _c, _d, commit;
    if (!("commits" in results)) {
      return null;
    }
    ns.commits = results.commits;
    ns.container = $("#commit-listing");
    ns.container.empty();
    _a = []; _c = ns.commits.slice(0, 10);
    for (_b = 0, _d = _c.length; _b < _d; _b++) {
      commit = _c[_b];
      _a.push(ns.showCommit(commit));
    }
    return _a;
  };
  spanWithClass = function spanWithClass(klass, content) {
    return $("<span />", {
      'class': ("gh-commit-" + klass),
      'html': content
    });
  };
  ghParseDate = function ghParseDate(dateString) {
    var date;
    date = new Date();
    date.setISO8601(dateString);
    return date;
  };
  ns.showCommit = function showCommit(commit) {
    var author, commitLink, commitedTime, inner, time;
    author = commit.author;
    inner = $("<li />", {
      'class': 'github-commit'
    });
    // Author Info
    author = $("<a />", {
      'href': ("http://github.com/" + author.login),
      'text': author.name,
      'class': 'gh-commit-author'
    });
    inner.append(author);
    inner.append(spanWithClass('misc', ' committed '));
    // Commit information
    commitLink = $("<a />", {
      'href': commit.url,
      'html': Eoraptor.Util.truncate(commit.message, 45),
      'class': 'gh-commit-message',
      title: commit.message
    });
    inner.append(commitLink);
    inner.append(spanWithClass('misc', ' about '));
    commitedTime = ghParseDate(commit.committed_date);
    time = spanWithClass('commited-at', '');
    Eoraptor.Util.attachUpdatingTimeAgo(time, commitedTime);
    inner.append(time);
    inner.append(spanWithClass('misc', ' ago.'));
    return ns.container.append(inner);
  };
  ns.commitsURL = function commitsURL() {
    return "http://github.com/api/v2/json/commits/list/" + ns.user + "/" + ns.repository + "/master?callback=" + (ns.toNSName()) + ".showCommits";
  };
  ns.loadCommits = function loadCommits() {
    var _a, _b;
    if ((typeof (_a = ns.user) !== "undefined" && _a !== null) && (typeof (_b = ns.repository) !== "undefined" && _b !== null)) {
      return $.getScript(ns.commitsURL());
    }
  };
  ns.setup = function setup() {
    ns.user = $.metaAttr("github.user");
    ns.repository = $.metaAttr("github.repository");
    return ns.loadCommits();
  };
  return ns.setup;
});