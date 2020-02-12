import 'package:flutter/material.dart';
import 'package:money_app/pages/bills_page/bills_page_builder.dart';
import 'package:money_app/pages/deposit_page/deposit_page_builder.dart';
import 'package:money_app/pages/edit_customer_page/edit_customer_page_builder.dart';
import 'package:money_app/pages/main_page/main_page_builder.dart';

/// Helper class which binds route names with page widgets and creates [Route]s
class RouteGenerator {
  static const mainRoute = '/main';
  static const editCustomerRoute = '/editCustomer';
  static const addCustomerRoute = '/addCustomer';
  static const createDepositRoute = '/createDeposit';
  static const billsPageRoute = '/billsPage';

  Widget get initPage => MainPageBuilder();

  Route generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    Widget newScreen;

    switch (settings.name) {
      case mainRoute:
        newScreen = MainPageBuilder();
        break;
      case addCustomerRoute:
        newScreen = EditCustomerPageBuilder.add();
        break;
      case editCustomerRoute:
        newScreen = EditCustomerPageBuilder.edit(args);
        break;
      case createDepositRoute:
        newScreen = DepositPageBuilder();
        break;
      case billsPageRoute:
        newScreen = BillsPageBuilder();
        break;
      default:
        newScreen = Text('ERROR');
    }

    return MaterialPageRoute(builder: (_) => newScreen);
  }
}
