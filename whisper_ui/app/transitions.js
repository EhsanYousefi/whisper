export default function(){

  // guest.index - guest.login
  this.transition(
    this.fromRoute('guest.index'),
    this.toRoute('guest.login'),
    this.use('toLeft'),
    this.reverse('toRight')
  );

  // guest.index - guest.signup
  this.transition(
    this.fromRoute('guest.index'),
    this.toRoute('guest.signup'),
    this.use('toLeft'),
    this.reverse('toRight')
  );

  // guest.login - guest.signup
  this.transition(
    this.fromRoute('guest.login'),
    this.toRoute('guest.signup'),
    this.use('toLeft'),
    this.reverse('toRight')
  );


  // member.dashboard - member.storages
  this.transition(
    this.fromRoute('member.dashboard'),
    this.toRoute('member.storages'),
    this.use('toLeft'),
    this.reverse('toRight')
  );

  // member.dashboard - member.storages
  this.transition(
    this.fromRoute('member.dashboard'),
    this.toRoute('member.account'),
    this.use('toLeft'),
    this.reverse('toRight')
  );

  // member.dashboard - member.storages
  this.transition(
    this.fromRoute('member.storages'),
    this.toRoute('member.account'),
    this.use('toLeft'),
    this.reverse('toRight')
  );



};
