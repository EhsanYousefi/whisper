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

});