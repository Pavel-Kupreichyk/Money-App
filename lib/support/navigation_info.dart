import 'package:money_app/support/route_generator.dart';

/// Helper class which safely creates page data
class NavigationInfo {
  final String route;
  final Object args;

  NavigationInfo.login()
      : route = RouteGenerator.mainRoute,
        args = null;
}
