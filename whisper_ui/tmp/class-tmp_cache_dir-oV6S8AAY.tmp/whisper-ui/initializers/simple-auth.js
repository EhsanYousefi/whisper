define('whisper-ui/initializers/simple-auth', ['exports', 'simple-auth/configuration', 'simple-auth/setup', 'whisper-ui/config/environment'], function (exports, Configuration, setup, ENV) {

  'use strict';

  exports['default'] = {
    name: 'simple-auth',
    initialize: function initialize(container, application) {
      Configuration['default'].load(container, ENV['default']['simple-auth'] || {});
      setup['default'](container, application);
    }
  };

});