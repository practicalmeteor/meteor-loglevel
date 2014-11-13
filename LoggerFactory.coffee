@practical ?= {}

class practical.LoggerFactory

  instance = null

  @get: ->
    instance ?= new practical.LoggerFactory()

  # The 'global' namespace is checked first, in order to allow people to enforce
  # a loglevel across the board.
  _getSettingsLoglevel: (namespace = '', defaultLevel = 'info')->
    expect(namespace).to.be.a('string')
    expect(defaultLevel).to.be.a('string').that.has.length.above(0)
    globalLevel = @_getNamespaceLoglevel('global')
    return globalLevel if globalLevel?
    level = @_getNamespaceLoglevel(namespace) if namespace.length > 0
    level ?= @_getNamespaceLoglevel('default')
    level ?= defaultLevel

  # @returns Meteor.settings.loglevel.namespace server side
  # or if called client side or it doesn't exist server side,
  # Meteor.settings.public.loglevel.namespace.
  # This allows to set only public loglevel for both client and server side.
  _getNamespaceLoglevel: (namespace)->
    expect(namespace).to.be.a('string').that.has.length.above(0)
    level = Meteor.settings?.public?.loglevel?[namespace]
    if Meteor.isServer
      serverLevel = Meteor.settings?.loglevel?[namespace]
      level = serverLevel if serverLevel?
    return level

  createLogger: (namespace = '', defaultLevel = 'info')->
    log.debug 'LoggerFactory.createLogger()', arguments
    expect(namespace).to.be.a('string')
    expect(defaultLevel).to.be.a('string').that.has.length.above(0)
    expect(Loglevel).to.be.a 'function'

    options = {}
    options.prefix = namespace + ':' if namespace.length > 0
    options.level = @_getSettingsLoglevel(namespace, defaultLevel)
    console.log "options=", options
    return Loglevel(options)

  createPackageLogger: (packageName, defaultLevel = 'info')->
    return @createLogger(packageName, defaultLevel)

  createAppLogger: (appName = 'app', defaultLevel = 'info')->
    return @createLogger(appName, defaultLevel)

loglevel = practical.LoggerFactory.get()
