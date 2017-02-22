node default {
  $test = lookup('test', Hash, 'deep')

  class {
    '::nagios':
      ;
  }

}