library;

import '../../../config/environment_config.dart';
import '../local_secure_storage.dart';

part 'local_secure_get.dart';
part 'local_secure_set.dart';

class LocalSecureSource {

  static _LocalSecureSourceSet get set => _LocalSecureSourceSet();
  static _LocalSecureSourceGet get get => _LocalSecureSourceGet();
}

