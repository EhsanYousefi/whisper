define('semantic-ui-ember/components/ui-dropdown', ['exports', 'ember', 'semantic-ui-ember/mixins/base', 'semantic-ui-ember/mixins/data-attributes', 'semantic-ui-ember/components/ui-dropdown-item'], function (exports, Ember, Base, DataAttributes, Item) {

  'use strict';

  exports['default'] = Ember['default'].Select.extend(Base['default'], DataAttributes['default'], {
    classNames: ['ui', 'dropdown'],
    module: 'dropdown',
    tagName: 'div',
    defaultTemplate: null,

    optionView: Item['default'],

    groupedView: null,
    groupedContent: null,

    onChildViewsChanged: function() {
      var length = this.get('childViews.length');
      if (length > 0) {
        Ember['default'].run.scheduleOnce('afterRender', this, this.initialize);
      }
    }.observes('childViews.@each.initialized'),

    initialize: function() {
      var value = this.get('value');
      if (typeof value !== "undefined" && value !== null) {
        this.execute('set selected', value);
      }
    },

    onChange: function(value) {
      return this.set('value', value);
    },

    onUpdate: function() {
      return Ember['default'].run.scheduleOnce('afterRender', this, this.set_value);
    }.observes('value'),

    set_value: function() {
      var dropdownValue, inputValue, _ref;
      inputValue = (_ref = this.get('value')) != null ? _ref.toString() : void 0;
      dropdownValue = this.execute("get value");
      if (inputValue == null) {
        return this.execute("restore defaults");
      } else if (inputValue !== dropdownValue) {
        return this.execute("set selected", this.get('value'));
      }
    }
  });

});