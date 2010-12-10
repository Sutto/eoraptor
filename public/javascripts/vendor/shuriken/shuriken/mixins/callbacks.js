/* DO NOT MODIFY. This file was compiled Sat, 04 Dec 2010 18:59:42 GMT from
 * /Users/sutto/.rvm/gems/ree-1.8.7-2010.02@eoraptor/gems/shuriken-0.2.1/coffeescripts/shuriken/mixins/callbacks.coffee
 */

var __slice = Array.prototype.slice;
Shuriken.defineExtension(function(baseNS) {
  return baseNS.defineMixin('Callbacks', function(mixin) {
    mixin.callbacks = {};
    mixin.defineCallback = function(key) {
      this["on" + key] = function(callback) {
        return this.hasCallback(key, callback);
      };
      this["invoke" + key] = function() {
        var args;
        args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        return this.invokeCallbacks.apply(this, [key].concat(__slice.call(args)));
      };
      return true;
    };
    mixin.hasCallback = function(name, callback) {
      var callbacks, _base, _ref;
      callbacks = (_ref = (_base = mixin.callbacks)[name]) != null ? _ref : _base[name] = [];
      callbacks.push(callback);
      return true;
    };
    mixin.callbacksFor = function(name) {
      var existing;
      existing = mixin.callbacks[name];
      if (existing != null) {
        return existing;
      } else {
        return [];
      }
    };
    return mixin.invokeCallbacks = function() {
      var args, callback, name, _i, _len, _ref;
      name = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      _ref = mixin.callbacksFor(name);
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        callback = _ref[_i];
        if (callback.apply(callback, args) === false) {
          return false;
        }
      }
      return true;
    };
  });
});