import 'package:flutter/material.dart';
import 'package:money_app/services/navigation_service.dart';
import 'package:money_app/support/navigation_info.dart';
import 'package:provider/provider.dart';

enum MainDrawerButtonType { add, showGroup, deposit, bills }

class MainDrawer extends StatelessWidget {
  final MainDrawerButtonType ignoredButton;
  MainDrawer({this.ignoredButton});

  @override
  Widget build(BuildContext context) {
    var navService = Provider.of<NavigationService>(context);

    return Drawer(
        child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 0, 8),
              child: Text(
                'Главное Меню',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text('Добавить Клиента'),
              leading: Icon(Icons.add),
              onTap: () => ignoredButton != MainDrawerButtonType.add
                  ? navService
                      .pushReplacementWithNavInfo(NavigationInfo.addCustomer())
                  : navService.pop(),
            ),
            ListTile(
              title: Text('Управление Клиентами'),
              leading: Icon(Icons.group),
              onTap: () => ignoredButton != MainDrawerButtonType.showGroup
                  ? navService.pushReplacementWithNavInfo(NavigationInfo.main())
                  : navService.pop(),
            ),
            ListTile(
              title: Text('Открыть Депозит'),
              leading: Icon(Icons.monetization_on),
              onTap: () => ignoredButton != MainDrawerButtonType.deposit
                  ? navService.pushReplacementWithNavInfo(
                      NavigationInfo.createDeposit())
                  : navService.pop(),
            ),
            ListTile(
              title: Text('Закрытие банковского дня'),
              leading: Icon(Icons.access_time),
              onTap: () => ignoredButton != MainDrawerButtonType.bills
                  ? navService
                      .pushReplacementWithNavInfo(NavigationInfo.bills())
                  : navService.pop(),
            ),
          ],
        ),
      ),
    ));
  }
}
