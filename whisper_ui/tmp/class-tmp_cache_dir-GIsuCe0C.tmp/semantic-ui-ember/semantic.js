define('semantic-ui-ember/semantic', ['exports', 'ember'], function (exports, Ember) {

  'use strict';

  var Semantic = Ember['default'].Namespace.create({
    UI_DEBUG: false,
    UI_PERFORMANCE: false,
    UI_VERBOSE: false
  });

  exports['default'] = Semantic;

});