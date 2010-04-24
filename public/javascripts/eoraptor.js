var Eoraptor;
var __slice = Array.prototype.slice, __bind = function(func, obj, args) {
    return function() {
      return func.apply(obj || {}, args ? args.concat(__slice.call(arguments, 0)) : arguments);
    };
  };
// If not already setup, make Eoraptor an empty object.
Eoraptor = (typeof Eoraptor !== "undefined" && Eoraptor !== null) ? Eoraptor : {};
// Now, use a nested closure with the namespace object and jquery.
(function(ns, $) {
  var base, makeNS;
  // Base is the default mixin for namespaces.
  base = {};
  // Configurable options for require
  ns.baseJSPath = '/javascripts/';
  ns.baseJSSuffix = '';
  // Simplified method of setting up a namespace.
  makeNS = function makeNS(o, name, parent) {
    var obj;
    obj = $.extend(o, base);
    obj.currentNamespaceKey = name;
    obj.parentNamespace = parent;
    return obj;
  };
  // Converts a string to the associated underscored representation.
  // Moslty used for converting namespaces (e.g. Eoraptor.A.B) to a file
  // path ("eoraptor/a/b").
  ns.underscoreString = function underscoreString(s) {
    return s.replace(/\./g, '/').replace(/([A-Z]+)([A-Z][a-z])/g, '$1_$2').replace(/([a-z\d])([A-Z])/g, '$1_$2').replace(/-/g, '_').toLowerCase();
  };
  // Returns the nested name for this namespace.
  base.toNSName = function toNSName() {
    var current, parts;
    parts = [];
    current = this;
    while (current) {
      parts.unshift(current.currentNamespaceKey);
      current = current.parentNamespace;
    }
    return parts.join('.');
  };
  // Defines / retrieves a namespace, relative to this.
  // e.g. Eoraptor.withNS('Awesome', function(ns) { // ... })
  // will define Eoraptor.Awesome as a new namespace and
  // if given, will invoke the given closure with it as
  // an argument
  base.withNS = function withNS(key, closure) {
    var _a, _b, _c, _d, currentNS, hadSetup, name, parts;
    parts = key.split(".");
    currentNS = this;
    _b = parts;
    for (_a = 0, _c = _b.length; _a < _c; _a++) {
      name = _b[_a];
      if (!(typeof (_d = currentNS[name]) !== "undefined" && _d !== null)) {
        currentNS[name] = makeNS({}, name, currentNS);
      }
      currentNS = currentNS[name];
    }
    hadSetup = $.isFunction(currentNS.setup);
    if ($.isFunction(closure)) {
      closure(currentNS);
    }
    !hadSetup && $.isFunction(currentNS.setup) ? ns.setupVia(currentNS.setup) : null;
    return currentNS;
  };
  // Get, if defined, the given namespace.
  base.getNS = function getNS(key) {
    var _a, _b, _c, _d, currentNS, name, parts;
    parts = key.split(".");
    currentNS = this;
    _b = parts;
    for (_a = 0, _c = _b.length; _a < _c; _a++) {
      name = _b[_a];
      if (!((typeof (_d = currentNS[name]) !== "undefined" && _d !== null))) {
        return null;
      }
      currentNS = currentNS[name];
    }
    return currentNS;
  };
  // Checks whether a sub-namespace is defined for this object.
  base.isNSDefined = function isNSDefined(key) {
    var _a;
    return (typeof (_a = this.getNS(key)) !== "undefined" && _a !== null);
  };
  // Require a namespace. If it already present, it will invoke
  // the callback block with it as an argument otherwise it will
  // first load the file and then it will invoke the block, passing
  // the namespace as an argument. Useful for dynamic requires.
  base.require = function require(name, callback) {
    var path, script, url;
    if (!this.isNSDefined(name)) {
      path = ns.underscoreString(("" + (this.toNSName()) + "." + name));
      url = ("" + (ns.baseJSPath) + (path) + ".js" + (ns.baseJSSuffix));
      script = $("<script />", {
        type: "text/javascript",
        src: url
      });
      $.isFunction(callback) ? script.load(function() {
        return callback(this.getNS(name));
      }) : null;
      return script.appendTo($("head"));
    } else if ($.isFunction(callback)) {
      return callback(this.getNS(name));
    }
  };
  // Automatically call the given function on document ready if
  // autosetup is enabled and it is a function. Will apply in the
  // scope of it's caller.
  base.setupVia = function setupVia(f) {
    return $(document).ready(__bind(function() {
        var _a;
        if ((typeof (_a = this.autosetup) !== "undefined" && _a !== null) && $.isFunction(f)) {
          return f.apply(this);
        }
      }, this));
  };
  // Define a class under the current namespace.
  base.defineClass = function defineClass(name, closure) {
    var klass;
    klass = function klass() {
      if ($.isFunction(this.initialize)) {
        return this.initialize.apply(this, arguments);
      }
    };
    if ($.isFunction(closure)) {
      closure.call(klass.prototype, klass.prototype);
    }
    this[name] = klass;
    return klass;
  };
  // If set to false, the setup blocks in namespaces wont be
  // automatically called on document ready.
  base.autosetup = true;
  // Setup the default namespace, in this case eoraptor.
  return makeNS(ns, 'Eoraptor');
})(Eoraptor, jQuery);