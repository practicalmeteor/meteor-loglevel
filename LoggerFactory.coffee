@practical ?= {}

class practical.LoggerFactory

  instance = null

  @get: ->
    instance ?= new practical.LoggerFactory()

  _getSettingsLoglevel: (namespace = '', defaultLevel = 'info')->
    expect(namespace).to.be.a('string')
    expect(defaultLevel).to.be.a('string').that.has.length.above(0)
    globalLevel = @_getNamespaceLoglevel('global')
    return globalLevel if globalLevel?
    level = @_getNamespaceLoglevel(namespace) if namespace.length > 0
    level ?= @_getNamespaceLoglevel('default')
    level ?= defaultLevel

  _getNamespaceLoglevel: (namespace)->
    expect(namespace).to.be.a('string').that.has.length.above(0)
    namespace = namespace.replace(':', '.')
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
    options.defaultLevel = @_getSettingsLoglevel(namespace, defaultLevel)
    return Loglevel(options)

  createPackageLogger: (packageName, defaultLevel = 'info')->
    return @createLogger(packageName, defaultLevel)

  createAppLogger: (appName = 'app', defaultLevel = 'info')->
    return @createLogger(appName, defaultLevel)

loglevel = practical.LoggerFactory.get()
