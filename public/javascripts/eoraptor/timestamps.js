/* DO NOT MODIFY. This file was compiled Sat, 04 Dec 2010 18:59:41 GMT from
 * /Users/sutto/Code/OSS/eoraptor/app/coffeescripts/eoraptor/timestamps.coffee
 */

Eoraptor.withNS('Timestamps', function(ns) {
  return ns.setup = function() {
    return $("abbr.timestamp").timeago();
  };
});