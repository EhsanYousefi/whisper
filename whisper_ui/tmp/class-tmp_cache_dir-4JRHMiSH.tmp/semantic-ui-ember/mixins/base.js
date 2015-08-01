define('semantic-ui-ember/mixins/base', ['exports', 'ember', 'semantic-ui-ember/semantic'], function (exports, Ember, Semantic) {

  'use strict';

  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  Semantic['default'].BaseMixin = Ember['default'].Mixin.create({
    init: function() {
      this._super();
      if (!this.get('module')) {
        return Ember['default'].Logger.error('Module was not declared on semantic extended type');
      }
    },
    settings: function(module) {
      var component, custom, key, prop, value, _ref;
      component = $.fn[module];
      if (!component) {
        throw "Unable to find semantic module: " + module;
      }
      custom = {
        debug: Semantic['default'].UI_DEBUG,
        performance: Semantic['default'].UI_PERFORMANCE,
        verbose: Semantic['default'].UI_VERBOSE
      };
      _ref = component.settings;
      for (key in _ref) {
        prop = _ref[key];
        if (__indexOf.call(Semantic['default'].BaseMixin.DEBUG, key) >= 0) {
          continue;
        }
        if (__indexOf.call(Semantic['default'].BaseMixin.STANDARD, key) >= 0) {
          continue;
        }
        if (typeof prop === 'function' && typeof this.get(key) !== 'function') {
          continue;
        }
        if (__indexOf.call(Semantic['default'].BaseMixin.EMBER, key) >= 0) {
          value = this.get("ui_" + key);
        } else {
          value = this.get(key);
        }
        if (value != null) {
          if (typeof value === 'function') {
            custom[key] = Ember['default'].run.bind(this, value);
          } else {
            custom[key] = value;
          }
        }
      }
      return custom;
    },
    didInsertElement: function() {
      return this.$()[this.get("module")](this.settings(this.get("module")));
    },
    willDestroyElement: function() {
      var _name, _ref;
      return (_ref = this.$()) != null ? typeof _ref[_name = this.get("module")] === "function" ? _ref[_name]('destroy') : void 0 : void 0;
    },
    execute: function() {
      var _ref, _ref1;
      return (_ref = this.$()) != null ? (_ref1 = _ref[this.get('module')]) != null ? _ref1.apply(this.$(), arguments) : void 0 : void 0;
    }
  });

  // Static properties to ignore
  Semantic['default'].BaseMixin.DEBUG = ['debug', 'performance', 'verbose'];
  Semantic['default'].BaseMixin.STANDARD = ['name', 'namespace', 'className', 'error', 'metadata', 'selector'];
  Semantic['default'].BaseMixin.EMBER = ['context', 'on', 'template', 'execute'];

  exports['default'] = Semantic['default'].BaseMixin;

});