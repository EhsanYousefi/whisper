define('semantic-ui-ember/mixins/checkbox-mixin', ['exports', 'ember', 'semantic-ui-ember/mixins/base'], function (exports, Ember, Base) {

  'use strict';

  var CheckboxMixin = Ember['default'].Mixin.create(Base['default'], {
    module: 'checkbox',
    classNames: ['ui', 'checkbox'],

    layout: Ember['default'].Handlebars.compile([
      '<input {{bind-attr type=type name=name checked=checked disabled=readonly data-id=data-id}} />',
      '<label>{{label}}</label>'
    ].join('\n')),

    didInsertElement: function() {
      if (this.get("disabled")) {
        return;
      }
      this._super();
    },

    willDestroyElement: function() {
      if (this.get("disabled")) {
        return;
      }
      this._super();
    }
  });

  exports['default'] = CheckboxMixin;

});