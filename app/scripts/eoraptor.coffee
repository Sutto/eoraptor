# If not already setup, make Eoraptor an empty object.
Eoraptor ?= {}

# Now, use a nested closure with the namespace object and jquery.
((ns, $) ->
  
  # Base is the default mixin for namespaces.
  base:  {}
  
  # Configurable options for require
  ns.baseJSPath:   '/javascripts/';
  ns.baseJSSuffix: ''
  
  # Simplified method of setting up a namespace.
  makeNS: (o, name, parent) ->
    obj: $.extend o, base
    obj.currentNamespaceKey: name
    obj.parentNamespace:     parent
    obj
  
  # Converts a string to the associated underscored representation.
  # Moslty used for converting namespaces (e.g. Eoraptor.A.B) to a file
  # path ("eoraptor/a/b").
  ns.underscoreString: (s) ->
    s.replace(/\./g, '/').replace(/([A-Z]+)([A-Z][a-z])/g, '$1_$2').replace(/([a-z\d])([A-Z])/g, '$1_$2').replace(/-/g, '_').toLowerCase()
  
  # Returns the nested name for this namespace.
  base.toNSName: ->
    parts: []
    current: @
    while current
      parts.unshift current.currentNamespaceKey
      current: current.parentNamespace
    parts.join '.'
    
  # Defines / retrieves a namespace, relative to this.
  # e.g. Eoraptor.withNS('Awesome', function(ns) { // ... })
  # will define Eoraptor.Awesome as a new namespace and
  # if given, will invoke the given closure with it as
  # an argument
  base.withNS: (key, closure) ->
    parts: key.split "."
    currentNS: @
    for name in parts
      currentNS[name] = makeNS({}, name, currentNS) if not currentNS[name]?
      currentNS: currentNS[name]
    hadSetup: $.isFunction currentNS.setup
    closure(currentNS) if $.isFunction closure
    if not hadSetup and $.isFunction currentNS.setup
      ns.setupVia currentNS.setup
    currentNS
    
  # Get, if defined, the given namespace.
  base.getNS: (key) ->
    parts: key.split "."
    currentNS: @
    for name in parts
      return unless currentNS[name]?
      currentNS = currentNS[name]
    currentNS
    
  
  # Checks whether a sub-namespace is defined for this object.
  base.isNSDefined: (key) ->
    @getNS(key)?
    
  
  # Require a namespace. If it already present, it will invoke
  # the callback block with it as an argument otherwise it will
  # first load the file and then it will invoke the block, passing
  # the namespace as an argument. Useful for dynamic requires.
  base.require: (name, callback) ->
    if not @isNSDefined(name)
      path: ns.underscoreString("${@toNSName()}.$name")
      url: "${ns.baseJSPath}${path}.js${ns.baseJSSuffix}"
      script: $ "<script />", {type: "text/javascript", src: url}
      if $.isFunction callback
        script.load ->
          callback @getNS(name)
      script.appendTo $ "head"
    else
      callback @getNS(name) if $.isFunction callback
      
  # Automatically call the given function on document ready if
  # autosetup is enabled and it is a function. Will apply in the
  # scope of it's caller.
  base.setupVia: (f) ->
    $(document).ready =>
      if @autosetup? and $.isFunction f
        f.apply @
  
  # Define a class under the current namespace.
  base.defineClass: (name, closure) ->
    klass: ->
      @initialize.apply @, arguments if $.isFunction @initialize
    closure.call klass.prototype, klass.prototype if $.isFunction closure
    @[name] = klass
    klass

  # If set to false, the setup blocks in namespaces wont be
  # automatically called on document ready.
  base.autosetup: true
  
  # Setup the default namespace, in this case eoraptor.
  makeNS ns, 'Eoraptor'
  
)(Eoraptor, jQuery)