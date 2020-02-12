import 'package:flutter/material.dart';
import 'package:money_app/blocs/deposit_page_bloc.dart';
import 'package:money_app/pages/deposit_page/deposit_page_body.dart';
import 'package:money_app/pages/main_drawer.dart';
import 'package:money_app/services/db_service.dart';
import 'package:provider/provider.dart';

class DepositPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProxyProvider<DbService, DepositBloc>(
      update: (_, db, bloc) => bloc ?? DepositBloc(db),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<DepositBloc>(
        builder: (_, bloc, __) => Scaffold(
          appBar: AppBar(
            title: Text('Money App'),
            actions: <Widget>[
              StreamBuilder<bool>(
                stream: bloc.isAdding,
                builder: (_, snapshot) {
                  if (snapshot.hasData && snapshot.data) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
          body: DepositPageBody(bloc),
          drawer: MainDrawer(
            ignoredButton: MainDrawerButtonType.deposit,
          ),
        ),
      ),
    );
  }
}
