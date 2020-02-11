import 'package:flutter/material.dart';
import 'package:money_app/blocs/bills_page_bloc.dart';
import 'package:money_app/pages/bills_page/bills_page_body.dart';
import 'package:money_app/pages/main_drawer.dart';
import 'package:money_app/services/db_service.dart';
import 'package:provider/provider.dart';

class BillsPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProxyProvider<DbService, BillsBloc>(
      update: (_, db, bloc) => bloc ?? BillsBloc(db),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<BillsBloc>(
        builder: (_, bloc, __) => Scaffold(
          appBar: AppBar(
            title: Text('Money App'),
            actions: <Widget>[
              StreamBuilder<bool>(
                  stream: bloc.isLoading,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    return IconButton(
                      icon: Icon(Icons.access_time),
                      color: Colors.white,
                      onPressed: snapshot.data ? null : bloc.closeDay,
                    );
                  })
            ],
          ),
          body: BillsPageBody(bloc),
          drawer: MainDrawer(
            ignoredButton: MainDrawerButtonType.bills,
          ),
        ),
      ),
    );
  }
}
