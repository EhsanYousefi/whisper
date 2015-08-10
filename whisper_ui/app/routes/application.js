import Ember from 'ember';
import ApplicationRouteMixin from 'simple-auth/mixins/application-route-mixin';


import SemanticRouteMixin from 'semantic-ui-ember/mixins/application-route';

export default Ember.Route.extend(ApplicationRouteMixin,SemanticRouteMixin, {

  actions: {
    invalidateSession: function() {
      this.get('session').invalidate();
    },
    sessionAuthenticationSucceeded: function() {
      this.transitionTo('member.dashboard');
    }
  }

});
