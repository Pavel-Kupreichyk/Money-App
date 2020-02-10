import 'package:money_app/models/customer.dart';
import 'package:money_app/support/route_generator.dart';

/// Helper class which safely creates page data
class NavigationInfo {
  final String route;
  final Object args;

  NavigationInfo.main()
      : route = RouteGenerator.mainRoute,
        args = null;

  NavigationInfo.createDeposit()
      : route = RouteGenerator.createDepositRoute,
        args = null;

  NavigationInfo.addCustomer()
      : route = RouteGenerator.addCustomerRoute,
        args = null;

  NavigationInfo.editCustomer(Customer customer)
      : route = RouteGenerator.editCustomerRoute,
        args = customer;
}
