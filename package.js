Package.describe({
  name: "practicalmeteor:loglevel",
  summary: "Simple logger with app and per-package log levels and line number preserving output.",
  version: "1.1.0_2",
  git: "https://github.com/practicalmeteor/meteor-loglevel.git"
});


Package.onUse(function (api) {
  api.versionsFrom('0.9.3');

  api.use(['meteor', 'coffeescript']);

  api.use(['spacejamio:chai']);

  api.addFiles('loglevel.js');
  api.addFiles('LoggerFactory.coffee');

  api.export('loglevel');
});


Package.onTest(function(api) {
  api.use(['coffeescript', 'practicalmeteor:loglevel', 'spacejamio:munit']);
  api.addFiles('tests/LoggerFactoryTest.coffee');
});
