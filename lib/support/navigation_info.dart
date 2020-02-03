import 'package:money_app/support/route_generator.dart';

/// Helper class which safely creates page data
class NavigationInfo {
  final String route;
  final Object args;

  NavigationInfo.main()
      : route = RouteGenerator.mainRoute,
        args = null;

  NavigationInfo.editCustomer()
      : route = RouteGenerator.editCustomerRoute,
        args = null;
}
