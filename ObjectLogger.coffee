class ObjectLogger

  constructor:(@className, @defaultLevel = 'info')->

    @log = loglevel.createLogger(@className, @defaultLevel)

    @callStack = []

    @log.enter = @bindMethod(@enter, 'debug')
    @log.fineEnter = @bindMethod(@enter, 'fine')
    @log.return = @bindMethod(@return, 'debug')
    @log.fineReturn = @bindMethod(@return, 'fine')

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


  bindMethod: (method, level) ->
    if typeof method.bind == 'function'
      return method.bind(@, level)
    else
      try
        return Function::bind.call(method, @, level)
      catch e
      # Missing bind shim or IE8 + Modernizr, fallback to wrapping
        return (args...)=>
          args.unshift(level)
          Function::apply.apply method, [
            @
            args
          ]
