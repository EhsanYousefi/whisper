define('ember-cli-content-security-policy', ['ember-cli-content-security-policy/index', 'ember', 'exports'], function(__index__, __Ember__, __exports__) {
  'use strict';
  var keys = Object.keys || __Ember__['default'].keys;
  var forEach = Array.prototype.forEach && function(array, cb) {
    array.forEach(cb);
  } || __Ember__['default'].EnumerableUtils.forEach;

  forEach(keys(__index__), (function(key) {
    __exports__[key] = __index__[key];
  }));
});

define('semantic-ui-ember', ['semantic-ui-ember/index', 'ember', 'exports'], function(__index__, __Ember__, __exports__) {
  'use strict';
  var keys = Object.keys || __Ember__['default'].keys;
  var forEach = Array.prototype.forEach && function(array, cb) {
    array.forEach(cb);
  } || __Ember__['default'].EnumerableUtils.forEach;

  forEach(keys(__index__), (function(key) {
    __exports__[key] = __index__[key];
  }));
});

define('semantic-ui-ember/components/ui-accordion', ['exports', 'ember', 'semantic-ui-ember/mixins/base'], function (exports, Ember, Base) {

  'use strict';

  var Accordion = Ember['default'].Component.extend(Base['default'],{
    module: 'accordion',
    classNames: ['ui', 'accordion']
  });

  exports['default'] = Accordion;

});
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
define('semantic-ui-ember/components/ui-progress', ['exports', 'ember', 'semantic-ui-ember/mixins/base'], function (exports, Ember, Base) {

  'use strict';

  var Progress = Ember['default'].Component.extend(Base['default'],{
    module: 'progress',
    classNames: ['ui', 'progress']
  });

  exports['default'] = Progress;

});
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
define('semantic-ui-ember/components/ui-rating', ['exports', 'ember', 'semantic-ui-ember/mixins/base'], function (exports, Ember, Base) {

  'use strict';

  var Rating = Ember['default'].Component.extend(Base['default'],{
    module: 'rating',
    classNames: ['ui', 'rating']
  });

  exports['default'] = Rating;

});
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
define('semantic-ui-ember/mixins/data-attributes', ['exports', 'ember'], function (exports, Ember) {

  'use strict';

  exports['default'] = Ember['default'].Mixin.create({
    attributeBindings: ['data-test']
  });

});
define('semantic-ui-ember/mixins/modal', ['exports', 'ember'], function (exports, Ember) {

  'use strict';

  exports['default'] = Ember['default'].Mixin.create({
    actions: {
      openModal: function(name, model, properties) {
        var container,
            controller,
            key,
            prop,
            result,
            view,
            viewName;

        try {
          container = this.get('container');
          try {
            controller = this.controllerFor(name);
          } catch (e) {
            controller = Em.generateController(container, name, model);
          }

          controller.set('model', model);
          if ($.isPlainObject(properties)) {
            for (key in properties) {
              prop = properties[key];
              controller.set(key, prop);
            }
          }

          view = container.lookup('view:' + name);
          if (view) {
            viewName = name;
          } else {
            viewName = 'ui-modal';
          }

          return result = this.render(name, {
            into: 'application',
            outlet: 'modal',
            controller: controller,
            view: viewName
          });
        } catch (e) {
          return Ember['default'].Logger.log(e);
        }
      },

      closeModal: function() {
        return this.disconnectOutlet({
          outlet: 'modal',
          parentView: 'application'
        });
      }
    }
  });

});
define('semantic-ui-ember/semantic', ['exports', 'ember'], function (exports, Ember) {

  'use strict';

  var Semantic = Ember['default'].Namespace.create({
    UI_DEBUG: false,
    UI_PERFORMANCE: false,
    UI_VERBOSE: false
  });

  exports['default'] = Semantic;

});
define('semantic-ui-ember/views/ui-modal', ['exports', 'ember', 'semantic-ui-ember/mixins/base'], function (exports, Ember, Base) {

  'use strict';

  exports['default'] = Ember['default'].View.extend(Base['default'], {
    module: 'modal',
    classNames: [ 'ui', 'modal' ],

    setup: function() {
      this.set('hiding', false);
    }.on('init'),

    showOnInsert: function() {
      this.execute('show');
    }.on('didInsertElement'),

    hideOnDestroy: function() {
      if (!this.get('hiding')) {
        this.execute('hide');
      }
    }.on('willDestroyElement'),

    onHide: function() {
      this.set('hiding', true);
      this.get('controller').send('closeModal');
    },

    onDeny: function() {
      if (this.get('controller')._actions['cancel'] !== null &&
          this.get('controller')._actions['cancel'] !== undefined) {
        this.get('controller').send('cancel');
      }
      return true;
    },

    onApprove: function() {
      if (this.get('controller')._actions['approve'] !== null &&
          this.get('controller')._actions['approve'] !== undefined) {
        this.get('controller').send('approve');
      }
      return false;
    },

    closable: false,
    transition: 'horizontal flip'
  })

});//# sourceMappingURL=addons.map