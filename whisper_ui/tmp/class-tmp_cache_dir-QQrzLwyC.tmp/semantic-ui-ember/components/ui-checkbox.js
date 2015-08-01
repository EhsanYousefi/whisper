define('semantic-ui-ember/components/ui-checkbox', ['exports', 'ember', 'semantic-ui-ember/mixins/checkbox-mixin'], function (exports, Ember, CheckboxMixin) {

  'use strict';

  exports['default'] = Ember['default'].Component.extend(CheckboxMixin['default'], {
    type: 'checkbox',
    checked: false,

    onChange: function() {
      this.set('checked', this.$('input').prop('checked'));
      this.sendAction("action", {
        checked: this.get('checked'),
        value: this.get('value')
      });
    }
  });

});