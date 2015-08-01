define('whisper-ui/adapters/application', ['exports'], function (exports) {

  'use strict';

  exports['default'] = DS.ActiveModelAdapter.extend({
    namespace: 'api/v1',
    host: 'http://localhost:3000'
  });

});