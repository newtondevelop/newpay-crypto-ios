Pod::Spec.new do |s|
  s.name             = 'NewpayCrypto'
  s.version          = '0.1.0'
  s.summary          = 'Heavily optimized cryptography algorithms for iOS.'

  s.homepage         = 'https://github.com/newtondevelop/newpay-crypto-ios'
  s.license          = { type: 'GPLv3', file: 'LICENSE' }
  s.authors          = { 'newtonproject' => 'newton-app@newtonproject.org' }
  s.source           = { git: 'https://github.com/yheng2/newpay-crypto-ios.git', tag: s.version, submodules: true }
  
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'

  s.prepare_command = <<-CMD
    sed -i '' -e 's:ed25519-donna/::g' ./**/*.c
    sed -i '' -e 's:ed25519-donna/::g' ./**/*.h
  CMD
  s.module_map = 'NewpayCrypto.modulemap'
  search_paths = [
    '"${PODS_ROOT}/newpay-crypto"',
    '"${PODS_ROOT}/newpay-crypto/aes"',
    '"${PODS_ROOT}/newpay-crypto/chacha20poly1305"',
    '"${PODS_ROOT}/newpay-crypto/ed25519-donna"'
  ]
  s.pod_target_xcconfig = {
      'SWIFT_INCLUDE_PATHS' => '${PODS_ROOT}',
      'OTHER_CFLAGS' => '-O3 -std=c99 -DRAND_PLATFORM_INDEPENDENT',
      'HEADER_SEARCH_PATHS' => search_paths.join(' ')
  }

  s.source_files = 
    'NewpayCrypto.h',
    'util/SecRandom.m',
    'newpay-crypto/*.{c,h,table}',
    'newpay-crypto/aes/*.{c,h}',
    'newpay-crypto/chacha20poly1305/*.{c,h}',
    'newpay-crypto/ed25519-donna/*.{c,h}'
  s.private_header_files = 
    'newpay-crypto/aes/aesopt.h',
    'newpay-crypto/aes/aestab.h',
    'newpay-crypto/ed25519-donna/curve25519-donna-scalarmult-base.h',
    'newpay-crypto/ed25519-donna/ed25519-hash-custom-keccak.h',
    'newpay-crypto/ed25519-donna/ed25519-hash-custom-sha3.h',
    'newpay-crypto/ed25519-donna/ed25519-hash-custom.h',
    'newpay-crypto/ed25519-donna/ed25519-keccak.h',
    'newpay-crypto/ed25519-donna/ed25519-sha3.h',
    'newpay-crypto/bip39_english.h',
    'newpay-crypto/blake2_common.h',
    'newpay-crypto/check_mem.h',
    'newpay-crypto/macros.h'
  s.exclude_files =
    'newpay-crypto/aes/aestst*.{c,h}',
    'newpay-crypto/gui/*.{c,h}',
    'newpay-crypto/rfc6979.c',
    'newpay-crypto/test*.{c,h}',
    'newpay-crypto/tools/*.{c,h}'
  s.libraries = 'c'
end
