class LoggerFactory

  instance = null
  @get: ->
    instance ?= new LoggerFactory

  createLogger: (namespace, defaultLevel = 'info')->
    log.debug 'LoggerFactory.createLogger()', arguments
    expect(namespace).to.be.a('string').that.is.ok
    prefix = namespace + ':'
    expect(Loglevel).to.be.a 'function'
    logger = Loglevel(prefix)
    logger.setLevel(defaultLevel)
    return logger

  createPackageLogger: (packageName, defaultLevel)->
    return @createLogger(packageName, defaultLevel)

  createAppLogger: (appName, defaultLevel)->
    return @createLogger(appName, defaultLevel)

loglevel = LoggerFactory.get()
