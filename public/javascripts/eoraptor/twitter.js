var __slice = Array.prototype.slice, __bind = function(func, obj, args) {
    return function() {
      return func.apply(obj || {}, args ? args.concat(__slice.call(arguments, 0)) : arguments);
    };
  };
Eoraptor.withNS('Twitter', function() {
  this.withNS('Util', function() {
    this.highlightTags = function highlightTags(t) {
      return t.replace(/(^|\s)@([_a-z0-9]+)/gi, '$1@<a href="http://twitter.com/$2" target="_blank">$2</a>');
    };
    this.highlightUsers = function highlightUsers(t) {
      return t.replace(/(^|\s)#(\S+(\/|\b))/gi, '$1<a href="http://twitter.com/search?q=%23$2" target="_blank">#$2</a>');
    };
    this.twitterize = function twitterize(t) {
      return this.highlightTags(this.highlightUsers(Eoraptor.Util.autolink(t)));
    };
    return this.twitterize;
  });
  this.processTweets = function processTweets(tweets) {
    var tweet;
    tweet = tweets[0];
    if ((typeof tweet !== "undefined" && tweet !== null)) {
      return this.showTweet(tweet);
    }
  };
  this.showTweet = function showTweet(tweet) {
    var container, formattedText;
    formattedText = this.Util.twitterize(tweet.text);
    container = $("#tweet-container");
    container.find("span#tweet-text").html(formattedText);
    Eoraptor.Util.attachUpdatingTimeAgo(container.find("span#tweet-when"), tweet.created_at);
    return container.show();
  };
  this.currentUser = function currentUser() {
    return this.getMeta("twitter-user");
  };
  this.urlFor = function urlFor(user) {
    return "http://api.twitter.com/1/statuses/user_timeline/" + (user) + ".json?callback=" + (this.toNSName()) + ".processTweets&count=1";
  };
  this.load = function load() {
    var user;
    user = this.currentUser();
    if ((typeof user !== "undefined" && user !== null)) {
      return $.getScript(this.urlFor(user));
    }
  };
  this.setup = function setup() {
    this.load();
    // Set it to update every 5 minutes.
    return setInterval((__bind(function() {
        return this.load();
      }, this)), 300000);
  };
  return this.setup;
});