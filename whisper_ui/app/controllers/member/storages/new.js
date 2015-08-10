import Ember from 'ember';

export default Ember.Controller.extend(Ember.Evented, {
  // needs: ['member.storages.index'],
  actions: {


    create: function () {
      var storage_list = this.store.createRecord('storageList', {
        key: this.getWithDefault('key'),
        description: this.getWithDefault('description')
      });

      window.sto = storage_list;

      storage_list.save().then(this.onSucc.bind(this), this.onFail.bind(this));
    }

  },

  onSucc: function(rsp) {
    // this.transitionToRoute('member.storages.index');
    this.trigger('closeModal');
    this.setFlashMessage({
      type: 'success',
      header: (rsp.get('key').classify() + " successfully added to your storages!"),
      message: 'Let\'s manage newly created storage!',
      controller: 'member.storages.index'
    });
    this.resetState();
  },

  onFail: function(err) {
    this.set('errors', err);
  },

  resetState: function() {
    this.set('errors', null);
    this.set('key', null);
    this.set('description', null);
  }

});
