define('whisper-ui/router', ['exports', 'ember', 'whisper-ui/config/environment'], function (exports, Ember, config) {

  'use strict';

  var Router = Ember['default'].Router.extend({
    location: config['default'].locationType,
    rootURL: '/'
  });

  Router.map(function () {
    this.route('login');
    this.route('signup');
  });

  exports['default'] = Router;

});