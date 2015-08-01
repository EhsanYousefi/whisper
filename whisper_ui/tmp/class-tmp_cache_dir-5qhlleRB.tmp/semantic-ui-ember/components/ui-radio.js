define('semantic-ui-ember/components/ui-radio', ['exports', 'ember', 'semantic-ui-ember/mixins/checkbox-mixin'], function (exports, Ember, CheckboxMixin) {

  'use strict';

  exports['default'] = Ember['default'].Component.extend(CheckboxMixin['default'], {
    classNames: ['radio'],
    type: 'radio',
    name: 'default',

    init: function() {
      this._super();
      if (!(this.get('name') && this.get('name') !== 'default')) {
        console.warn('Name was not passed into semantic radio component');
      }
    },

    checked: function() {
      return this.get('current') === this.get('value');
    }.property('current', 'value'),

    onChange: function() {
      this.set('current', this.get('value'));
      this.sendAction("action", {
        checked: this.get('checked'),
        value: this.get('value')
      });
    }
  });

});