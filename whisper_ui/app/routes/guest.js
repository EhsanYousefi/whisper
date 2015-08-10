import Ember from 'ember';

export default Ember.Route.extend({

  beforeModel() {

      if(this.router.router.hasRoute('guest.login') || this.router.router.hasRoute('guest.signup')) {

        if(this.session.isAuthenticated) {
          this.transitionTo('member.dashboard');
        }

      }
  }

});
