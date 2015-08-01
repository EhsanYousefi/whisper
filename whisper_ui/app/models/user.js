import DS from 'ember-data';

export default DS.Model.extend({
  userName: DS.attr('string'),
  email: DS.attr('string'),
  authToken: DS.attr('string'),
  password: DS.attr('string'),
  passwordConfirmation: DS.attr('string'),
  firstName: DS.attr('string'),
  lastName: DS.attr('string')
});
