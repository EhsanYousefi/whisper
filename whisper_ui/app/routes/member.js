import Ember from 'ember';

export default Ember.Route.extend({

  beforeModel() {

      if(!this.session.isAuthenticated) {
        this.transitionTo('guest.login');
      }

  }

});
