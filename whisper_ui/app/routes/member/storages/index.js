import Member from '../../member';

export default Member.extend({
  model() {
    return this.store.find('storageList');
  }
});
