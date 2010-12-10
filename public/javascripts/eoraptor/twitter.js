/* DO NOT MODIFY. This file was compiled Fri, 10 Dec 2010 18:27:33 GMT from
 * /Users/sutto/Code/OSS/eoraptor/app/coffeescripts/eoraptor/twitter.coffee
 */

var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
Eoraptor.withNS('Twitter', function(ns) {
  ns.withNS('Util', function(utilNS) {
    utilNS.highlightUsers = function(t) {
      return t.replace(/(^|\s)@([_a-z0-9]+)/gi, '$1@<a href="http://twitter.com/$2" target="_blank">$2</a>');
    };
    utilNS.highlightTags = function(t) {
      return t.replace(/(^|\s)#(\S+(\/|\b))/gi, '$1<a href="http://twitter.com/search?q=%23$2" target="_blank">#$2</a>');
    };
    return utilNS.twitterize = function(t) {
      return utilNS.highlightTags(utilNS.highlightUsers(Eoraptor.Util.autolink(t)));
    };
  });
  ns.processTweets = function(tweets) {
    var tweet;
    tweet = tweets[0];
    if (tweet != null) {
      return ns.showTweet(tweet);
    }
  };
  ns.showTweet = function(tweet) {
    var container, formattedText;
    formattedText = ns.Util.twitterize(tweet.text);
    container = $("#tweet-container");
    container.find("span#tweet-text").html(formattedText);
    Eoraptor.Util.attachUpdatingTimeAgo(container.find("span#tweet-when"), tweet.created_at);
    return container.show();
  };
  ns.currentUser = function() {
    return $.metaAttr("twitter-user");
  };
  ns.urlFor = function(user) {
    return "http://api.twitter.com/1/statuses/user_timeline/" + user + ".json?callback=Eoraptor.Twitter.processTweets&count=1";
  };
  ns.load = function() {
    var user;
    user = ns.currentUser();
    if (user != null) {
      return $.getScript(ns.urlFor(user));
    }
  };
  return ns.setup = function() {
    ns.load();
    return setInterval((__bind(function() {
      return ns.load();
    }, this)), 300000);
  };
});