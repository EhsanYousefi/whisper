define('semantic-ui-ember/components/ui-progress', ['exports', 'ember', 'semantic-ui-ember/mixins/base'], function (exports, Ember, Base) {

  'use strict';

  var Progress = Ember['default'].Component.extend(Base['default'],{
    module: 'progress',
    classNames: ['ui', 'progress']
  });

  exports['default'] = Progress;

});