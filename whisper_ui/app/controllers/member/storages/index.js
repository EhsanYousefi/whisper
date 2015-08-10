import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {

    openNewModal: function() {
      this.send('openModal', 'member/storages/new');
    },

    manageStorage: function(storage) {
      this.transitionToRoute('member.storages.manage', storage);
    }

  }

});
