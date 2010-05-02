Eoraptor.withNS 'Twitter', ->

  @withNS 'Util', ->
    
    @highlightTags: (t) ->
      t.replace /(^|\s)@([_a-z0-9]+)/gi, '$1@<a href="http://twitter.com/$2" target="_blank">$2</a>'
    
    @highlightUsers: (t) ->
      t.replace /(^|\s)#(\S+(\/|\b))/gi, '$1<a href="http://twitter.com/search?q=%23$2" target="_blank">#$2</a>'
    
    @twitterize: (t) ->
      @highlightTags @highlightUsers Eoraptor.Util.autolink(t)

  @processTweets: (tweets) ->
    tweet: tweets[0]
    @showTweet tweet if tweet?
      
  @showTweet: (tweet) ->
    formattedText: @Util.twitterize tweet.text
    container: $("#tweet-container")
    container.find("span#tweet-text").html formattedText
    Eoraptor.Util.attachUpdatingTimeAgo container.find("span#tweet-when"), tweet.created_at
    container.show()
    

  @currentUser: -> @getMeta "twitter-user"

  @urlFor: (user) ->
    "http://api.twitter.com/1/statuses/user_timeline/${user}.json?callback=${@toNSName()}.processTweets&count=1"
  
  @load: ->
    user: @currentUser()
    $.getScript @urlFor(user) if user?
    
  @setup: ->
    @load()
    # Set it to update every 5 minutes.
    setInterval (=> @load()), 300000
      