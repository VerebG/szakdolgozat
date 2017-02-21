node default {
  $test = lookup('test', Hash, 'deep')

  notify {
    'Test':
      message => $test
  }
}