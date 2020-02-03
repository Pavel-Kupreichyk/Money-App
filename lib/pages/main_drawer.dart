import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            ),
            ListTile(
              title: Text('Управление Клиентами'),
              leading: Icon(Icons.group),
            ),
            ListTile(
              title: Text('Открыть Депозит'),
              leading: Icon(Icons.monetization_on),
            ),
            ListTile(
              title: Text('Открыть Кредит'),
              leading: Icon(Icons.attach_money),
            ),
          ],
        ),
      ),
    ));
  }
}
