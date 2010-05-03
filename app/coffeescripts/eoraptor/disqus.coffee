Eoraptor.withNS 'Disqus', (ns) ->
  
  ns.currentIdentifier: ->
    $.metaAttr "disqus-identifier"
  
  ns.currentSite: ->
    $.metaAttr "disqus-site"
  
  ns.isDebug: ->
    $.metaAttr("disqus-developer") is "true"
  
  ns.configureDisqus: ->
    window.disqus_identifier: ns.currentIdentifier()
    window.disqus_developer:  1 if ns.isDebug()
  
  ns.addScripts: ->
    ns.configureDisqus()
    script: $ "<script />", {type: "text/javascript", async: true}
    script.attr "src", "http://${ns.currentSite()}.disqus.com/embed.js"
    script.appendTo $ "head"
    
  ns.setup: -> ns.addScripts()