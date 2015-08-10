export function initialize(/* container, application */) {
  // application.inject('route', 'foo', 'service:foo');
}

export default {
  name: 'flash-message',
  after: "store",
  initialize: function(container, application) {
    container.lookup('store:main').set('flashMessages', []);
  }
};
