class ObjectLogger

  constructor:(@className, @defaultLevel = 'info')->

    @log = loglevel.createLogger(@className, @defaultLevel)

    @callStack = []

    @log.enter = @enter.bind(@, 'debug')
    @log.fineEnter = @enter.bind(@, 'fine')
    @log.return = @return.bind(@, 'debug')
    @log.fineReturn = @return.bind(@, 'fine')

    return @log

  enter: (level, args...)->
    throw new Error ('ObjectLogger: No method name provided to enter') if args.length is 0
    methodName = args.shift()
    @callStack.unshift methodName
    @log.setPrefix "#{@className}.#{methodName}:"
    args.unshift 'ENTER'
    @log[level].apply @log, args

  return: (level)->
    @log[level].call @log, 'RETURN'
    @callStack.shift()
    if @callStack.length > 0
      methodName = @callStack[0]
      @log.setPrefix "#{@className}.#{methodName}:"
