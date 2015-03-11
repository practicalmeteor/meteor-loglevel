[![Build Status](https://travis-ci.org/practicalmeteor/meteor-loglevel.svg?branch=master)](https://travis-ci.org/practicalmeteor/meteor-loglevel)

## Overview

A minimal lightweight console logger that preserves line numbers and supports per-package and app specific prefixes and log levels that are read from Meteor.settings. Based on the [loglevel.js](https://github.com/pimterry/loglevel) logging library.

## API summary

```javascript

// Creating loggers
log = loglevel.createPackageLogger(packageName, defaultLevel = 'info');
log = loglevel.createAppLogger(appName, defaultLevel = 'info');
log = loglevel.createLogger(namespace = '', defaultLevel = 'info');

// Logging
log.trace(msg);
log.fine(obj);
log.debug(obj);
log.info(msg1 + msg2);
log.warn('obj=\n', obj);
log.error(err);

// Set the log level
log.setLevel(level); // Any of the levels above.
log.enableAll();
log.disableAll();
```

Logging methods will use the same console method or fallback to console.log, if not defined.

# Creating a package scoped logger

Add to your package a log.js file that is loaded before any other source files with the following line:

```javascript

log = loglevel.createPackageLogger('myacct:mypkg', 'debug');
```

Note: It must be a .js file, not a .coffee file.

Then, use it in any other source file, js or coffee:

```javascript

log.debug('Hello world');
// Output:
// myacct:mypkg: Hello world
```

All log messages will be prefixed with the package name and a colon, so package authors and users can easily identify the source of the log message.

## Creating an app logger

Add to your app's lib folder a .js file that is loaded before any other source files in your app with the following line:

```javascript

log = loglevel.createAppLogger('myapp', 'warn');
```

Then, use it in any other source file, js or coffee:

```javascript

log.warn('Hello world!');
// Output:
// myapp: Hello world!
```

Here too, all log messages will be prefixed with the app name and a colon. If you prefer not to have app log messages prefixed, just set appName to an empty string.

## Creating a namespaced logger

If you'd like to create additional loggers, such as for javascript objects or coffeescript classes, just create a logger at the top of your source file:

```javascript

log = loglevel.createLogger('myacct:mypkg:myobject', 'trace');
// Or
log = loglevel.createLogger('myapp.myclass', 'trace');
```

## Setting log levels in Meteor.settings

Just create a key under Meteor.settings.loglevel (server side) or Meteor.settings.public.loglevel (client side) with your package, app or namespace name:

```javascript

Meteor.settings.loglevel['myacct:mypkg']
Meteor.settings.public.loglevel['myyapp']
Meteor.settings.public.loglevel['myyapp.myclass']
```

Note that server side, if a key will not be found under Meteor.settings.loglevel, the client side log level will be used. This allows you to control the log level both server side and client side by setting it only under Meteor.settings.public.loglevel.

## Forcing a global log level

Meteor.settings.loglevel.global - server side. 

Meteor.settings.public.loglevel.global - client side (or if server side global isn't set, server side too).

This will overwrite all log levels for all loggers.

## Specifying a default log level

Meteor.settings.loglevel.default - server side. 

Meteor.settings.public.loglevel.default - client side (or if server side default isn't set, server side too).

This will be used, if no other log level was found in Meteor.settings.

## Coming soon / please contribute

1. Hierarchical namespace log levels - so package authors can control log levels for all their packages with one setting and app authors can control log levels for submodules / subsystems.

2. User specific log levels.

## Changelog

[CHANGELOG](https://github.com/practicalmeteor/meteor-loglevel/blob/master/CHANGELOG.md)

## License

practicalmeteor:loglevel - [MIT](https://github.com/practicalmeteor/meteor-loglevel/blob/master/LICENSE.txt)

loglevel.js - [MIT](https://github.com/pimterry/loglevel/blob/master/LICENSE-MIT)
