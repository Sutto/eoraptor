/* DO NOT MODIFY. This file was compiled Sat, 04 Dec 2010 18:59:41 GMT from
 * /Users/sutto/.rvm/gems/ree-1.8.7-2010.02@eoraptor/gems/shuriken-0.2.1/coffeescripts/shuriken.coffee
 */

var __slice = Array.prototype.slice, __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
(function() {
  var Shuriken, base, makeNS, scopedClosure;
  if (typeof jQuery != "undefined" && jQuery !== null) {
    (function($) {
      var stringToDataKey;
      stringToDataKey = function(key) {
        return ("data-" + key).replace(/_/g, '-');
      };
      $.fn.dataAttr = function(key, value) {
        return this.attr(stringToDataKey(key), value);
      };
      $.fn.removeDataAttr = function(key) {
        return this.removeAttr(stringToDataKey(key));
      };
      $.fn.hasDataAttr = function(key) {
        return this.is("[" + (stringToDataKey(key)) + "]");
      };
      return $.metaAttr = function(key) {
        return $("meta[name='" + key + "']").attr("content");
      };
    })(jQuery);
  }
  Shuriken = {
    Base: {},
    Util: {},
    jsPathPrefix: "/javascripts/",
    jsPathSuffix: "",
    namespaces: {},
    extensions: []
  };
  Shuriken.Util.underscoreize = function(s) {
    return s.replace(/\./g, '/').replace(/([A-Z]+)([A-Z][a-z])/g, '$1_$2').replace(/([a-z\d])([A-Z])/g, '$1_$2').replace(/-/g, '_').toLowerCase();
  };
  scopedClosure = function(closure, scope) {
    if ($.isFunction(closure)) {
      return closure.call(scope, scope);
    }
  };
  base = Shuriken.Base;
  base.hasChildNamespace = function(child) {
    return this.children.push(child);
  };
  base.toNSName = function() {
    var children, current, parts;
    children = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    parts = children;
    current = this;
    while (current != null) {
      parts.unshift(current.name);
      current = current.parent;
    }
    return parts.join(".");
  };
  base.getNS = function(namespace) {
    var currentNS, name, parts, _i, _len;
    parts = namespace.split(".");
    currentNS = this;
    for (_i = 0, _len = parts.length; _i < _len; _i++) {
      name = parts[_i];
      if (currentNS[name] == null) {
        return;
      }
      currentNS = currentNS[name];
    }
    return currentNS;
  };
  base.getRootNS = function() {
    var current;
    current = this;
    while (current.parent != null) {
      current = current.parent;
    }
    return current;
  };
  base.hasNS = function(namespace) {
    return this.getNS(namespace) != null;
  };
  base.withNS = function(key, initializer) {
    var currentNS, hadSetup, name, parts, _i, _len;
    parts = key.split(".");
    currentNS = this;
    for (_i = 0, _len = parts.length; _i < _len; _i++) {
      name = parts[_i];
      if (!(currentNS[name] != null)) {
        currentNS[name] = makeNS(name, currentNS, this.baseNS);
      }
      currentNS = currentNS[name];
    }
    hadSetup = $.isFunction(currentNS.setup);
    scopedClosure(initializer, currentNS);
    if (!hadSetup && $.isFunction(currentNS.setup)) {
      currentNS.setupVia(currentNS.setup);
    }
    return currentNS;
  };
  base.withBase = function(closure) {
    return scopedClosure(closure, this.baseNS);
  };
  base.extend = function(closure) {
    return scopedClosure(closure, this);
  };
  base.isRoot = function() {
    return !(this.parent != null);
  };
  base.log = function() {
    var args;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return console.log.apply(console, ["[" + (this.toNSName()) + "]"].concat(__slice.call(args)));
  };
  base.debug = function() {
    var args;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return console.log.apply(console, ["[Debug: " + (this.toNSName()) + "]"].concat(__slice.call(args)));
  };
  base.setupVia = function(f) {
    return $(document).ready(__bind(function() {
      if (this.autosetup != null) {
        return scopedClosure(f, this);
      }
    }, this));
  };
  base.require = function(key, callback) {
    var ns, path, script, url;
    ns = this.getNS(key);
    if (ns != null) {
      return scopedClosure(callback, ns);
    } else {
      path = Shuriken.Util.underscoreize("" + (this.toNSName()) + "." + key);
      url = "" + Shuriken.jsPathPrefix + path + ".js" + Shuriken.jsPathSuffix;
      script = $("<script />", {
        type: "text/javascript",
        src: url
      });
      script.load(function() {
        return scopedClosure(callback, this.getNS(key));
      });
      return script.appendTo($("head"));
    }
  };
  base.autosetup = true;
  Shuriken.Namespace = function() {};
  Shuriken.Namespace.prototype = Shuriken.Base;
  makeNS = function(name, parent, sharedPrototype) {
    var namespace;
    sharedPrototype != null ? sharedPrototype : sharedPrototype = new Shuriken.Namespace();
    namespace = function() {
      this.name = name;
      this.parent = parent;
      this.baseNS = sharedPrototype;
      this.children = [];
      if (parent != null) {
        parent.hasChildNamespace(this);
      }
      return this;
    };
    namespace.prototype = sharedPrototype;
    return new namespace(name, parent);
  };
  Shuriken.defineExtension = function(closure) {
    var namespace, _i, _len, _ref;
    _ref = Shuriken.namespaces;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      namespace = _ref[_i];
      scopedClosure(closure, namespace);
    }
    return Shuriken.extensions.push(closure);
  };
  Shuriken.as = function(name) {
    var extension, ns, _i, _len, _ref;
    ns = makeNS(name);
    Shuriken.namespaces[name] = ns;
    Shuriken.root[name] = ns;
    _ref = Shuriken.extensions;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      extension = _ref[_i];
      scopedClosure(extension, ns);
    }
    return ns;
  };
  Shuriken.root = this;
  return this['Shuriken'] = Shuriken;
})();