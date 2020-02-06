import 'package:flutter/material.dart';
import 'package:money_app/blocs/main_page_bloc.dart';
import 'package:money_app/pages/main_drawer.dart';
import 'package:money_app/pages/main_page_body.dart';
import 'package:money_app/services/db_service.dart';
import 'package:money_app/services/navigation_service.dart';
import 'package:provider/provider.dart';

class MainPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProxyProvider2<DbService, NavigationService, MainBloc>(
      update: (_, db, nav, prevBloc) => prevBloc ?? MainBloc(db, nav),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<MainBloc>(
        builder: (_, bloc, __) => Scaffold(
          appBar: AppBar(
            title: Text('Money App'),
          ),
          body: MainPageBody(bloc),
          drawer: MainDrawer(
            ignoredButton: MainDrawerButtonType.showGroup,
          ),
        ),
      ),
    );
  }
}
