import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: '/'
});

Router.map(function() {

  this.route('guest', { path: '/' }, function() {

    this.route('login');
    this.route('signup');

  });

  this.route('member', { path: '/console'}, function() {

    this.route('dashboard', { path: '/'});
    this.route('account');
    this.route('storages', function() {
      this.route('new');
      this.route('manage', { path: '/manage/:storage_list_id'});
    });

  });

});

export default Router;
