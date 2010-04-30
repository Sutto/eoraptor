Eoraptor.withNS('Disqus', function() {
  this.currentIdentifier = function currentIdentifier() {
    return this.getMeta("disqus-identifier");
  };
  this.currentSite = function currentSite() {
    return this.getMeta("disqus-site");
  };
  this.isDebug = function isDebug() {
    return this.getMeta("disqus-developer") === "true";
  };
  this.configureDisqus = function configureDisqus() {
    window.disqus_identifier = this.currentIdentifier();
    if (this.isDebug()) {
      window.disqus_developer = 1;
      return window.disqus_developer;
    }
  };
  this.addScripts = function addScripts() {
    var script;
    this.configureDisqus();
    script = $("<script />", {
      type: "text/javascript",
      async: true
    });
    script.attr("src", ("http://" + (this.currentSite()) + ".disqus.com/embed.js"));
    return script.appendTo($("head"));
  };
  this.setup = function setup() {
    return this.addScripts();
  };
  return this.setup;
});