define('semantic-ui-ember/components/ui-accordion', ['exports', 'ember', 'semantic-ui-ember/mixins/base'], function (exports, Ember, Base) {

  'use strict';

  var Accordion = Ember['default'].Component.extend(Base['default'],{
    module: 'accordion',
    classNames: ['ui', 'accordion']
  });

  exports['default'] = Accordion;

});