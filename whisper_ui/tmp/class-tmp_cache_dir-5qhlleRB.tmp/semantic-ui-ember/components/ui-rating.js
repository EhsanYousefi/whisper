define('semantic-ui-ember/components/ui-rating', ['exports', 'ember', 'semantic-ui-ember/mixins/base'], function (exports, Ember, Base) {

  'use strict';

  var Rating = Ember['default'].Component.extend(Base['default'],{
    module: 'rating',
    classNames: ['ui', 'rating']
  });

  exports['default'] = Rating;

});