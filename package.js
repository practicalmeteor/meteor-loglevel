Package.describe({
  name: "spacejamio:loglevel",
  summary: "Minimal lightweight logging library with output that preserves line numbers.",
  version: "1.1.0_2",
  git: "https://github.com/spacejamio/meteor-loglevel.git"
});


Package.onUse(function (api) {
  api.versionsFrom('0.9.3');

  api.use(['meteor', 'application-configuration', 'coffeescript']);

  api.use(['spacejamio:chai']);

  api.addFiles('loglevel.js');
  api.addFiles('LoggerFactory.coffee');
  api.addFiles('set-loglevel.js');

  api.export('loglevel');
});


Package.onTest(function(api) {
  api.use(['coffeescript', 'spacejamio:loglevel', 'tinytest', 'spacejamio:munit']);
  api.addFiles('tests/loglevel-test.coffee');
  api.addFiles('tests/LoggerFactoryTest.coffee');
});
