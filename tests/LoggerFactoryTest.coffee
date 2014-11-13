describe "loglevel", ->

  logAllLevels = (log)->
    log.trace("I'm log.trace");
    log.debug("I'm log.debug");
    log.info("I'm log.info");
    log.warn("I'm log.warn");
    log.error("I'm log.error");

  afterEach ->
    spies.restoreAll()

  describe "createLogger", ->

    it "should set prefix to an empty string, if not specified", ->
      log = loglevel.createLogger()
      expect(log.prefix).to.equal ''

    it "should set prefix to namespace + ':'", ->
      log = loglevel.createLogger('loglevel:namespace')
      expect(log.prefix).to.equal 'loglevel:namespace:'
      log.enableAll()
      logAllLevels(log)

    it "should set level to info, if not specified", ->
      log = loglevel.createLogger()
      expect(log.level).to.equal log.levels.INFO

    it "should set level to debug, if specified", ->
      log = loglevel.createLogger('', 'debug')
      expect(log.level).to.equal log.levels.DEBUG

    it 'output only log levels enabled by default', ->
      log = loglevel.createLogger()
      logAllLevels(log)

    it 'output all log levels', ->
      log = loglevel.createLogger()
      log.enableAll()
      logAllLevels(log)

  describe "createPackageLogger", ->
    it "should set prefix to package name", ->
      log = loglevel.createPackageLogger('loglevel:mypackage')
      expect(log.prefix).to.equal('loglevel:mypackage:')
      log.enableAll()
      log.trace("I'm log.trace")
      log.debug("I'm log.debug")
      log.info("I'm log.info")
      log.warn("I'm log.warn")
      log.error("I'm log.error")

  describe "createAppLogger", ->
    it "should set prefix to app name", ->
      log = loglevel.createAppLogger('myapp')
      expect(log.prefix).to.equal('myapp:')
      log.enableAll()
      log.trace("I'm log.trace")
      log.debug("I'm log.debug")
      log.info("I'm log.info")
      log.warn("I'm log.warn")
      log.error("I'm log.error")
