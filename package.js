Package.describe({
  name: "spacejamio:loglevel",
  summary: "Minimal lightweight logging library with output that preserves line numbers.",
  version: "1.1.0_2",
  git: "https://github.com/spacejamio/meteor-loglevel.git"
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
  api.use(['coffeescript', 'spacejamio:loglevel', 'spacejamio:munit']);
  api.addFiles('tests/LoggerFactoryTest.coffee');
});
