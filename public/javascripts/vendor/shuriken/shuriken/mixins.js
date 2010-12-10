/* DO NOT MODIFY. This file was compiled Sat, 04 Dec 2010 18:59:41 GMT from
 * /Users/sutto/.rvm/gems/ree-1.8.7-2010.02@eoraptor/gems/shuriken-0.2.1/coffeescripts/shuriken/mixins.coffee
 */

Shuriken.defineExtension(function(baseNS) {
  return baseNS.withNS('Mixins', function(ns) {
    var defineMixin, root;
    root = this.getRootNS();
    ns.mixins = {};
    root.mixins = {};
    root.withBase(function(base) {
      return base.mixin = function(mixins) {
        return ns.mixin(this, mixins);
      };
    });
    defineMixin = function(key, mixin) {
      return this.mixins[key] = mixin;
    };
    root.defineMixin = defineMixin;
    ns.define = defineMixin;
    ns.lookupMixin = function(mixin) {
      switch (typeof mixin) {
        case "string":
          if (ns.mixins[mixin] != null) {
            return ns.mixins[mixin];
          } else if (root.mixins[mixin] != null) {
            return root.mixins[mixin];
          } else {
            return {};
          }
          break;
        default:
          return mixin;
      }
    };
    ns.invokeMixin = function(scope, mixin) {
      switch (typeof mixin) {
        case "string":
          return ns.invokeMixin(scope, ns.lookupMixin(mixin));
        case "function":
          return mixin.call(scope, scope);
        case "object":
          return $.extend(scope, mixin);
      }
    };
    return ns.mixin = function(scope, mixins) {
      var mixin, _i, _len;
      if (!$.isArray(mixins)) {
        mixins = [mixins];
      }
      for (_i = 0, _len = mixins.length; _i < _len; _i++) {
        mixin = mixins[_i];
        ns.invokeMixin(scope, ns.lookupMixin(mixin));
      }
      return true;
    };
  });
});