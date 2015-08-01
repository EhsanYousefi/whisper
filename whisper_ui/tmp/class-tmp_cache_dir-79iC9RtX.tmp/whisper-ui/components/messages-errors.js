define('whisper-ui/components/messages-errors', ['exports', 'ember'], function (exports, Ember) {

  'use strict';

  exports['default'] = Ember['default'].Component.extend({

    actions: {
      loadSUErr: function loadSUErr(errors) {
        $('.message .close').closest('.message').transition('fade');
        errors.clear();
      }
    }

  });

});