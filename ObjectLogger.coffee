class @ObjectLogger

  loggerMethods:[
    'debug'
#    'enter'
    'error'
    'fatal'
    'fine'
#    'fineEnter'
#    'fineReturn'
#    'return'
    'info'
    'trace'
    'warn'
  ]

  methodStack = []


  constructor:(@className = "Object")->
    if lv.Settings.getSetting("USE_CONSOLE_LOGGER",false)
      return loglevel

    self = @
    @enter = @_createEnterMethod()
    @fineEnter = @_createEnterMethod("fineEnter")
    @['return'] = @_createReturnMethod()
    @['fineReturn'] = @_createReturnMethod("fineReturn")
    for method in @loggerMethods # Add all methods from global log
      self[method] = @reflectionLog(method)

  reflectionLog:(method)->
    self = @
    ->
      if (methodStack.length > 0)
        msg =  @_createMethodMessage methodStack[ methodStack.length - 1]
      else # if there is no methodStack the method was called from a unknown method
        msg = self.className+".unknownMethod():"

      args = Array.prototype.slice.call(arguments) #convert the arguments obj to an array
      if typeof args[0] is 'string'
        args[0] =  msg + args[0]
      else
        args.unshift(msg) # put the msg on the top of the arguments

      log[method].apply(log,args) # call the original method


  _createEnterMethod:(_methodName = "enter")->
    return ->
      if arguments.length > 2
        id = arguments[0]
        name = arguments[1]
        args = arguments[2]
      else
        name = arguments[0]
        args = arguments[1]

      method = id:id,name:name
      methodStack.push(method)
      msg = @_createMethodMessage method
      msg += capitalize(_methodName)
      log[_methodName].call(log,msg,args)


  _createReturnMethod:(_methodName = "return")->
    return ->
      msg = @_createMethodMessage methodStack.pop()
      msg += capitalize(_methodName)
      log[_methodName].call(log,msg)


  _createMethodMessage:(method)->
    if not method
      return ""
    if method.id # prototype methods
      return "#{@className}[#{method.id}].#{method.name}():" # i.e Object[id].method: 'customMessage'
    "#{@className}.#{method?.name}():" # i.e Object.method: 'customMessage'

  capitalize = (s)->
    s.charAt(0).toUpperCase() + s.slice(1)
