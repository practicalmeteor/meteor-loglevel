Package.describe({
  name: "spacejamio:loglevel",
  summary: "Minimal lightweight logging for JavaScript, adding reliable log level methods to wrap any available console.log methods",
  version: "1.1.0_1",
  git: "https://github.com/spacejamio/meteor-loglevel.git"
});


Package.onUse(function (api) {
  api.versionsFrom('0.9.3');

  api.use(['meteor', 'application-configuration']);

  api.addFiles('loglevel_root.js');
  api.addFiles('loglevel.js');
  api.addFiles('set-loglevel.js');
});


Package.onTest(function(api) {
  api.use(['spacejamio:loglevel', 'tinytest']);
  api.addFiles('loglevel-test.js');
});
