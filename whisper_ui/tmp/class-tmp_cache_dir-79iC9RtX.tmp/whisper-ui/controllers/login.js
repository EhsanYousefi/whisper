define('whisper-ui/controllers/login', ['exports', 'ember'], function (exports, Ember) {

  'use strict';

  exports['default'] = Ember['default'].Controller.extend({
    actions: {
      authenticate: function authenticate() {
        var credentials = this.getProperties('identification', 'password'),
            authenticator = 'simple-auth-authenticator:jwt';
        window.cr = this;
        this.get('session').authenticate(authenticator, credentials).then(this.onSucc, this.onFail.bind(this));
      }
    },
    errors: Ember['default'].A([]),
    onSucc: function onSucc(rsp) {
      console.log('Login Success');
    },
    onFail: function onFail(rsp) {
      this.errors.addObject(rsp.error);
    }
  });

});