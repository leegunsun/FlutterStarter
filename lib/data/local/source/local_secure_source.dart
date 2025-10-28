library;

import '../../../app/config/environment_config.dart';
import '../local_secure_storage.dart';

part 'local_secure_get.dart';
part 'local_secure_set.dart';

class LocalSecureSource {
  static final _LocalSecureSourceSet _set = _LocalSecureSourceSet();
  static final _LocalSecureSourceGet _get = _LocalSecureSourceGet();

  static _LocalSecureSourceSet get set => _set;
  static _LocalSecureSourceGet get get => _get;
}
