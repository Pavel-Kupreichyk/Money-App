import 'package:flutter/material.dart';
import 'package:money_app/services/db_service.dart';
import 'package:money_app/services/navigation_service.dart';
import 'package:money_app/support/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  var navKey = GlobalKey<NavigatorState>();
  var navService = NavigationService(navKey);

  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        Provider<NavigationService>.value(value: navService),
        Provider<DbService>.value(value: DbService())
      ],
      child: App(RouteGenerator(), navKey),
    ),
  );
}

class App extends StatelessWidget {
  final GlobalKey<NavigatorState> _navKey;
  final RouteGenerator _routeGenerator;
  App(this._routeGenerator, this._navKey);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navKey,
      title: 'Mpney App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _routeGenerator.generateRoute,
      home: _routeGenerator.initPage,
    );
  }
}
