import Ember from 'ember';

export default Ember.Component.extend({

  actions: {

    closeFlashMessage: function(errors) {
      $('.message .close').closest('.message').transition('fade');
      errors.clear();
    }

  }

});
