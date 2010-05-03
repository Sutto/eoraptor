Eoraptor.withNS('Disqus', function(ns) {
  ns.currentIdentifier = function currentIdentifier() {
    return $.metaAttr("disqus-identifier");
  };
  ns.currentSite = function currentSite() {
    return $.metaAttr("disqus-site");
  };
  ns.isDebug = function isDebug() {
    return $.metaAttr("disqus-developer") === "true";
  };
  ns.configureDisqus = function configureDisqus() {
    window.disqus_identifier = ns.currentIdentifier();
    if (ns.isDebug()) {
      window.disqus_developer = 1;
      return window.disqus_developer;
    }
  };
  ns.addScripts = function addScripts() {
    var script;
    ns.configureDisqus();
    script = $("<script />", {
      type: "text/javascript",
      async: true
    });
    script.attr("src", ("http://" + (ns.currentSite()) + ".disqus.com/embed.js"));
    return script.appendTo($("head"));
  };
  ns.setup = function setup() {
    return ns.addScripts();
  };
  return ns.setup;
});