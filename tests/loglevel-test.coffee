describe 'loglevel', ->

  logAllLevels = (log)->
    log.trace("I'm log.trace");
    log.debug("I'm log.debug");
    log.info("I'm log.info");
    log.warn("I'm log.warn");
    log.error("I'm log.error");

  it 'output only log levels enabled by default', ->
    console.log('output only log levels enabled by default')
    log = loglevel.createLogger()
    logAllLevels(log)

  it 'output all log levels', ->
    console.log('output all log levels')
    log = loglevel.createLogger()
    log.enableAll()
    logAllLevels(log)

  it 'setPrefix - it should output with the set prefix', ->
    console.log 'setPrefix - it should output with the set prefix'
    log = loglevel.createLogger('loglevel:setPrefix')
    log.enableAll()
    logAllLevels(log)
