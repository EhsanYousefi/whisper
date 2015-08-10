import DS from 'ember-data';

export default DS.ActiveModelAdapter.extend({
  namespace: 'api/v1',
  host: 'http://localhost:3000',
  handleResponse: function(status, headers, payload) {
    if (this.isInvalid(status, headers, payload)) {
      return payload.errors;
    } else {
      return this._super(...arguments);
    }
  },
});
