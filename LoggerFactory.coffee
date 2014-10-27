class LoggerFactory

  instance = null
  @get: ->
    instance ?= new LoggerFactory

  createLogger: (namespace, defaultLevel)->
    log.debug 'LoggerFactory.createLogger()', arguments
    if namespace?
      expect(namespace).to.be.a('string').that.has.length.above(0)
      prefix = namespace + ':'
    expect(Loglevel).to.be.a 'function'
    logger = Loglevel(prefix)
    logger.setLevel(defaultLevel) if defaultLevel?
    return logger

  createPackageLogger: (packageName)->
    return @createLogger(packageName)

  createAppLogger: (appName)->
    return @createLogger(appName)

loglevel = LoggerFactory.get()
