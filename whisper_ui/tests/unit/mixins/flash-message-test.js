import Ember from 'ember';
import FlashMessageMixin from '../../../mixins/flash-message';
import { module, test } from 'qunit';

module('Unit | Mixin | flash message');

// Replace this with your real tests.
test('it works', function(assert) {
  var FlashMessageObject = Ember.Object.extend(FlashMessageMixin);
  var subject = FlashMessageObject.create();
  assert.ok(subject);
});
