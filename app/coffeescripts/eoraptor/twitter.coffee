Eoraptor.withNS 'Twitter', (ns) ->

  ns.withNS 'Util', (utilNS) ->
    
    utilNS.highlightUsers = (t) ->
      t.replace /(^|\s)@([_a-z0-9]+)/gi, '$1@<a href="http://twitter.com/$2" target="_blank">$2</a>'
    
    utilNS.highlightTags = (t) ->
      t.replace /(^|\s)#(\S+(\/|\b))/gi, '$1<a href="http://twitter.com/search?q=%23$2" target="_blank">#$2</a>'
    
    utilNS.twitterize = (t) ->
      utilNS.highlightTags utilNS.highlightUsers Eoraptor.Util.autolink t

  ns.processTweets = (tweets) ->
    tweet = tweets[0]
    if tweet?
      ns.setupAuthorDetails()
      ns.showTweet tweet
      
  ns.showTweet = (tweet) ->
    formattedText = ns.Util.twitterize tweet.text
    container = $("#tweet-container")
    container.find("span#tweet-text").html formattedText
    Eoraptor.Util.attachUpdatingTimeAgo container.find("span#tweet-when"), tweet.created_at
    container.show()

  ns.currentUser = -> $.metaAttr "twitter-user"

  ns.urlFor = (user) ->
    "http://api.twitter.com/1/statuses/user_timeline/#{user}.json?callback=Eoraptor.Twitter.processTweets&count=1"
  
  ns.load = ->
    user = ns.currentUser()
    $.getScript ns.urlFor(user) if user?
    
  ns.setupAuthorDetails = ->
    parent = $ "#tweet-author"
    user = ns.currentUser()
    parent.find('.twitter-author-name').text("@#{user}").attr('href', "http://twitter.com/#{user}")
    parent.show()
    
  ns.setup = ->
    ns.load()
    # Set it to update every 5 minutes.
    setInterval (=> ns.load()), 300000
      