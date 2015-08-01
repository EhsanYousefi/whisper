/* jshint ignore:start */

define('whisper-ui/config/environment', ['ember'], function(Ember) {
  var prefix = 'whisper-ui';
/* jshint ignore:start */

try {
  var metaName = prefix + '/config/environment';
  var rawConfig = Ember['default'].$('meta[name="' + metaName + '"]').attr('content');
  var config = JSON.parse(unescape(rawConfig));

  return { 'default': config };
}
catch(err) {
  throw new Error('Could not read config from meta tag with name "' + metaName + '".');
}

/* jshint ignore:end */

});

if (runningTests) {
  require("whisper-ui/tests/test-helper");
} else {
  require("whisper-ui/app")["default"].create({"name":"whisper-ui","version":"0.0.0+3e90dae9"});
}

/* jshint ignore:end */
