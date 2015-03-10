Package.describe({
  name: "practicalmeteor:loglevel",
  summary: "Simple logger with app and per-package log levels and line number preserving output.",
  version: "1.2.0_1",
  git: "https://github.com/practicalmeteor/meteor-loglevel.git"
});


Package.onUse(function (api) {
  api.versionsFrom('0.9.3');

  api.use(['meteor', 'coffeescript']);

  api.use(['practicalmeteor:chai@1.9.2_3']);

  api.addFiles('loglevel-1.2.0.js');
  api.addFiles('LoggerFactory.coffee');

  api.export('loglevel');
});


Package.onTest(function(api) {
  api.use(['coffeescript', 'practicalmeteor:loglevel', 'practicalmeteor:munit@2.1.2']);
  api.addFiles('tests/LoggerFactoryTest.coffee');
});
