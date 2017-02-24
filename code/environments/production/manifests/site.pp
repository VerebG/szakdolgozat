node default {
  $test = lookup('test', Hash, 'deep')

  include ::nagios
  /*class {
    '::nagios':
      ;
  }*/

}