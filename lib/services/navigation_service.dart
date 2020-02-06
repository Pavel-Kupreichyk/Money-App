import 'package:money_app/support/navigation_info.dart';
import 'package:flutter/widgets.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navKey;
  NavigatorState get navState => navKey.currentState;
  NavigationService(this.navKey);

  void pushWithNavigationInfo(NavigationInfo navInfo) =>
      navState.pushNamed(navInfo.route, arguments: navInfo.args);

  void pop() => navState.pop();

  void pushReplacementWithNavInfo(NavigationInfo navInfo) =>
      navState.pushReplacementNamed(navInfo.route, arguments: navInfo.args);
}
