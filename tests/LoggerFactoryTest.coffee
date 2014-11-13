describe "loglevel", ->

  meteorSettings = Meteor.settings

  logAllLevels = (log)->
    log.trace("I'm log.trace");
    log.debug("I'm log.debug");
    log.info("I'm log.info");
    log.warn("I'm log.warn");
    log.error("I'm log.error");

  beforeEach ->
    Meteor.settings = {}

  afterEach ->
    spies.restoreAll()

  afterAll ->
    spies.restoreAll()
    Meteor.settings = meteorSettings

  describe "_getNamespaceLoglevel", ->

    it.client 'should return public loglevel client side', ->
      Meteor.settings =
        loglevel:
          'acct:pkg': 'trace'
        public:
          loglevel:
            'acct:pkg': 'debug'
      expect(loglevel._getNamespaceLoglevel('acct:pkg')).to.equal 'debug'

    it.server 'should return server loglevel server side', ->
      Meteor.settings =
        loglevel:
          'acct:pkg': 'trace'
        public:
          loglevel:
            'acct:pkg': 'debug'
      expect(loglevel._getNamespaceLoglevel('acct:pkg')).to.equal 'trace'

    it.server 'should return public loglevel server side, if no server loglevel', ->
      Meteor.settings =
        public:
          loglevel:
            'acct:pkg': 'debug'
      expect(loglevel._getNamespaceLoglevel('acct:pkg')).to.equal 'debug'

    it 'should return undefined, if no loglevel', ->
      Meteor.settings = {}
      expect(loglevel._getNamespaceLoglevel('acct:pkg')).to.be.undefined

  describe "_getSettingsLoglevel", ->

    it 'should return global loglevel, if set', ->
      Meteor.settings =
        loglevel:
          'global': 'info'
          'acct:pkg': 'trace'
        public:
          loglevel:
            'global': 'warn'
            'acct:pkg': 'debug'
      if Meteor.isServer
        expect(loglevel._getSettingsLoglevel('acct:pkg')).to.equal 'info'
      else
        expect(loglevel._getSettingsLoglevel('acct:pkg')).to.equal 'warn'

    it 'should return namespace loglevel, if set', ->
      Meteor.settings =
        loglevel:
          'acct:pkg': 'trace'
        public:
          loglevel:
            'acct:pkg': 'debug'
      if Meteor.isServer
        expect(loglevel._getSettingsLoglevel('acct:pkg')).to.equal 'trace'
      else
        expect(loglevel._getSettingsLoglevel('acct:pkg')).to.equal 'debug'

    it 'should return default loglevel from settings, if set', ->
      Meteor.settings =
        loglevel:
          'default': 'warn'
        public:
          loglevel:
            'default': 'error'
      if Meteor.isServer
        expect(loglevel._getSettingsLoglevel('acct:pkg')).to.equal 'warn'
      else
        expect(loglevel._getSettingsLoglevel('acct:pkg')).to.equal 'error'

    it 'should return default loglevel from input arg, if no settings loglevel', ->
      Meteor.settings = {}
      expect(loglevel._getSettingsLoglevel('acct:pkg', 'debug')).to.equal 'debug'

    it 'should deal with empty namespaces', ->
      Meteor.settings =
        loglevel:
          'default': 'warn'
        public:
          loglevel:
            'default': 'error'
      if Meteor.isServer
        expect(loglevel._getSettingsLoglevel()).to.equal 'warn'
      else
        expect(loglevel._getSettingsLoglevel()).to.equal 'error'

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

    it 'should output only log levels enabled by default', ->
      log = loglevel.createLogger()
      logAllLevels(log)

    it 'should output all log levels', ->
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

    it "should read level from Meteor.settings", ->
      Meteor.settings =
        loglevel:
          'acct:pkg': 'trace'
        public:
          loglevel:
            'acct:pkg': 'debug'
      log = loglevel.createLogger('acct:pkg')
      if Meteor.isServer
        expect(log.level).to.equal log.levels.TRACE
      else
        expect(log.level).to.equal log.levels.DEBUG

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
