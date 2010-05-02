Eoraptor.withNS 'Disqus', ->
  
  @currentIdentifier: ->
    @getMeta "disqus-identifier"
  
  @currentSite: ->
    @getMeta "disqus-site"
  
  @isDebug: ->
    @getMeta("disqus-developer") is "true"
  
  @configureDisqus: ->
    window.disqus_identifier: @currentIdentifier()
    window.disqus_developer:  1 if @isDebug()
  
  @addScripts: ->
    @configureDisqus()
    script: $ "<script />", {type: "text/javascript", async: true}
    script.attr "src", "http://${@currentSite()}.disqus.com/embed.js"
    script.appendTo $ "head"
    
  @setup: -> @addScripts()