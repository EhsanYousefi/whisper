import Ember from 'ember';
import SemanticModalMixin from 'semantic-ui-ember/mixins/modal';

export default Ember.View.extend(SemanticModalMixin, {
  // templateName: 'shared/modal'
  classNames: [ 'very-small' ],

  didInsertElement: function () {
    this.get('controller').on('closeModal', this, this.closeModal);
    this._super();
  },

  closeModal: function() {
    this.execute('hide');
  }

});
