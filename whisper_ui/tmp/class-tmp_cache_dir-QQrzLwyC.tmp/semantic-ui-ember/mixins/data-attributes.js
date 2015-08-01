define('semantic-ui-ember/mixins/data-attributes', ['exports', 'ember'], function (exports, Ember) {

  'use strict';

  exports['default'] = Ember['default'].Mixin.create({
    attributeBindings: ['data-test']
  });

});