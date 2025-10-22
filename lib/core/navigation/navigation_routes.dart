part of '../../config/environment_config.dart';

enum AppRoutes {
  home('home', '/'),
  search('search', '/search'),
  setting('setting', '/settings'),
  serverDown('serverDown', '/server-down'),
  notFound('notFound', '/404');

  final String name;
  final String path;

  const AppRoutes(this.name, this.path);
}