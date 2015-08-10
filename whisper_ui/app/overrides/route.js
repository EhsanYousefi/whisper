import Ember from 'ember';

export default Ember.Route.reopen({
  removeFlashMessages: function() {
    this.controller.changeFlashMessageState();
  }.on('deactivate'),
});
