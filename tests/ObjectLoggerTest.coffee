class ObjectLoggerTest

  setup: ->

  tearDown: ->

  createObjectLogger = (className, defaultLevel)->
    logger = new ObjectLogger(className, defaultLevel)

  logAllLevels = (logger, msg)->
    for level in ['trace', 'fine', 'debug', 'info', 'warn', 'error']
      logger[level](level.toUpperCase(), '-', msg)

  tests:[
    {
      name:"should log all levels"
      func: (test)->
        logger = new ObjectLogger('Class1', 'trace')
        logAllLevels logger, 'loglevel is trace'
    }
    {
      name:"setLevel() - should work"
      func: (test)->
        logger = new ObjectLogger('Class2')
        logger.setLevel('debug')
        logAllLevels logger, 'loglevel is debug'
    }
    {
      name:"enter() - should work"
      func: (test)->
        logger = new ObjectLogger('Class3', 'debug')
        logger.enter 'method1', 'loglevel is debug'
        logAllLevels logger, 'loglevel is debug'
        logger.return()
    }
    {
      name:"enter() - should work recursively"
      func: (test)->
        logger = new ObjectLogger('Class4')
        logger.enter 'method1', 'loglevel is info'
        logger.info 'method1'
        logger.enter 'method2', 'loglevel is info'
        logger.info 'method2'
        logger.return()
        logger.info 'back to method1'
        logger.return()
    }
    {
      name:"fineEnter() - should work"
      func: (test)->
        logger = new ObjectLogger('Class5', 'fine')
        logger.enter 'method1', 'loglevel is fine'
        logAllLevels logger, 'loglevel is fine'
        logger.return()
    }
    {
      name:"fineEnter() - should work recursively"
      func: (test)->
        logger = new ObjectLogger('Class6')
        logger.fineEnter 'method1', 'loglevel is info'
        logger.info 'method1'
        logger.fineEnter 'method2', 'loglevel is info'
        logger.info 'method2'
        logger.fineReturn()
        logger.info 'back to method1'
        logger.fineReturn()
    }
  ]



Munit.run( new ObjectLoggerTest())
