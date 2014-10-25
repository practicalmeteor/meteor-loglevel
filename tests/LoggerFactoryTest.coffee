describe "LoggerFactory", ->

  afterEach ->
    spies.restoreAll()

  describe "createPackageLogger", ->
    it "should create a logger which logs with the package name as a prefix", ->
      log = loglevel.createPackageLogger('LoggerFactoryTest:createPackageLogger')
      expect(log).to.be.an('object')
      expect(log.error).to.be.a('function')
      expect(log.prefix).to.equal('LoggerFactoryTest:createPackageLogger:')
      log.enableAll()
      log.trace("I'm log.trace")
      log.debug("I'm log.debug")
      log.info("I'm log.info")
      log.warn("I'm log.warn")
      log.error("I'm log.error")

  describe "createAppLogger", ->
    it "should create a logger which logs with the app name as a prefix", ->
      log = loglevel.createPackageLogger('createAppLogger')
      expect(log).to.be.an('object')
      expect(log.error).to.be.a('function')
      expect(log.prefix).to.equal('createAppLogger:')
      log.enableAll()
      log.trace("I'm log.trace")
      log.debug("I'm log.debug")
      log.info("I'm log.info")
      log.warn("I'm log.warn")
      log.error("I'm log.error")
