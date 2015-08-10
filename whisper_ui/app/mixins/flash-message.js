import Ember from 'ember';

export default Ember.Mixin.create({

  flashMessages: function() {
    var fm = this.store.get('flashMessages');
    this.removeFlashMessages();
    return fm;
  }.property('flashMessagesChanged'),

  setFlashMessage: function(obj) {
    var className = null;
    if(obj.type === 'success') {
      className = "ui success message";
    } else if(obj.type === 'warning') {
      className = "ui warning message";
    } else {
      className = "ui info message";
    }
    this.store.flashMessages.push({ className: className, header: obj.header, message: obj.message });

    this.cFO(obj.controller);
    // this.set('flashMessages', this.store.get('flashMessages'));
  },

  removeFlashMessages: function() {
    this.store.set('flashMessages', []);
  },

  // Change Flash Message State from outside
  cFO: function(controllerName) {
    var controller = this.controllerFor(controllerName);
    controller.set('flashMessagesChanged', Date.now());
  },

  changeFlashMessageState: function() {
    window.wa = this;
    this.set('flashMessagesChanged', Date.now());
  },

  flashMessagesChanged: 0,

});
