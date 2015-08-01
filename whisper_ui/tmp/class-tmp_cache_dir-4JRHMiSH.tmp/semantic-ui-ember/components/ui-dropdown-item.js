define('semantic-ui-ember/components/ui-dropdown-item', ['exports', 'ember'], function (exports, Ember) {

  'use strict';

  exports['default'] = Ember['default'].SelectOption.extend({
    tagName: 'div',
    classNames: 'item',

    initialized: false,
    initialize: function() {
      Ember['default'].run.scheduleOnce('afterRender', this, this.set_value);
    }.on('init'),

    set_value: function() {
      var valuePath = this.get('parentView.optionValuePath');

      if (!valuePath) {
        return;
      }
      if (this.$() == null) {
        return;
      }

      this.$().data('value', this.get(valuePath));
      this.set('initialized',true);
    }
  });

});