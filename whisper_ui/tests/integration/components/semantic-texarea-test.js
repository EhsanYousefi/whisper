import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';


moduleForComponent('semantic-texarea', 'Integration | Component | semantic texarea', {
  integration: true
});

test('it renders', function(assert) {
  assert.expect(2);

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{semantic-texarea}}`);

  assert.equal(this.$().text(), '');

  // Template block usage:
  this.render(hbs`
    {{#semantic-texarea}}
      template block text
    {{/semantic-texarea}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
