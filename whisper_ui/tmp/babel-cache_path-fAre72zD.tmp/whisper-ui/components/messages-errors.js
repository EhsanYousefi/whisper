import Ember from 'ember';

export default Ember.Component.extend({

  actions: {
    loadSUErr: function loadSUErr(errors) {
      $('.message .close').closest('.message').transition('fade');
      errors.clear();
    }
  }

});