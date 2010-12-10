/* DO NOT MODIFY. This file was compiled Fri, 10 Dec 2010 18:27:33 GMT from
 * /Users/sutto/Code/OSS/eoraptor/app/coffeescripts/eoraptor/disqus.coffee
 */

Eoraptor.withNS('Disqus', function(ns) {
  ns.currentIdentifier = function() {
    return $.metaAttr("disqus-identifier");
  };
  ns.currentSite = function() {
    return $.metaAttr("disqus-site");
  };
  ns.isDebug = function() {
    return $.metaAttr("disqus-developer") === "true";
  };
  ns.configureDisqus = function() {
    window.disqus_identifier = ns.currentIdentifier();
    if (ns.isDebug()) {
      return window.disqus_developer = 1;
    }
  };
  ns.addScripts = function() {
    var script;
    ns.configureDisqus();
    script = $("<script />", {
      type: "text/javascript",
      async: true
    });
    script.attr("src", "http://${ns.currentSite()}.disqus.com/embed.js");
    return script.appendTo($("head"));
  };
  return ns.setup = function() {
    return ns.addScripts();
  };
});