console.log('Package in test:', Package);
console.log('Package.json in test:', Package.json);

function logAllLevels() {
  log.trace("I'm log.trace");
  log.debug("I'm log.debug");
  log.info("I'm log.info");
  log.warn("I'm log.warn");
  log.error("I'm log.error");
}

var test1Name = 'loglevel - output only log levels enabled by default or set in Meteor.settings';
Tinytest.add(test1Name, function() {
  console.log(test1Name);
  logAllLevels();
});

var test2Name = 'loglevel - output all log levels';
Tinytest.add(test2Name, function() {
  console.log(test2Name);
  log.enableAll();
  logAllLevels();
});

var test3Name = 'loglevel - setPrefix';
Tinytest.add(test3Name, function() {
  console.log(test3Name);
  log.setPrefix('spacejamio:loglevel:');
  log.enableAll();
  logAllLevels();
});

