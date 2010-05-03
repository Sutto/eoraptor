var __slice = Array.prototype.slice, __bind = function(func, obj, args) {
    return function() {
      return func.apply(obj || {}, args ? args.concat(__slice.call(arguments, 0)) : arguments);
    };
  };
Eoraptor.withNS('Twitter', function(ns) {
  ns.withNS('Util', function(utilNS) {
    utilNS.highlightUsers = function highlightUsers(t) {
      return t.replace(/(^|\s)@([_a-z0-9]+)/gi, '$1@<a href="http://twitter.com/$2" target="_blank">$2</a>');
    };
    utilNS.highlightTags = function highlightTags(t) {
      return t.replace(/(^|\s)#(\S+(\/|\b))/gi, '$1<a href="http://twitter.com/search?q=%23$2" target="_blank">#$2</a>');
    };
    utilNS.twitterize = function twitterize(t) {
      return utilNS.highlightTags(utilNS.highlightUsers(Eoraptor.Util.autolink(t)));
    };
    return utilNS.twitterize;
  });
  ns.processTweets = function processTweets(tweets) {
    var tweet;
    tweet = tweets[0];
    if ((typeof tweet !== "undefined" && tweet !== null)) {
      return ns.showTweet(tweet);
    }
  };
  ns.showTweet = function showTweet(tweet) {
    var container, formattedText;
    formattedText = ns.Util.twitterize(tweet.text);
    container = $("#tweet-container");
    container.find("span#tweet-text").html(formattedText);
    Eoraptor.Util.attachUpdatingTimeAgo(container.find("span#tweet-when"), tweet.created_at);
    return container.show();
  };
  ns.currentUser = function currentUser() {
    return $.metaAttr("twitter-user");
  };
  ns.urlFor = function urlFor(user) {
    return "http://api.twitter.com/1/statuses/user_timeline/" + (user) + ".json?callback=Eoraptor.Twitter.processTweets&count=1";
  };
  ns.load = function load() {
    var user;
    user = ns.currentUser();
    if ((typeof user !== "undefined" && user !== null)) {
      return $.getScript(ns.urlFor(user));
    }
  };
  ns.setup = function setup() {
    ns.load();
    // Set it to update every 5 minutes.
    return setInterval((__bind(function() {
        return ns.load();
      }, this)), 300000);
  };
  return ns.setup;
});