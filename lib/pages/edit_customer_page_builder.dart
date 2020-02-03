import 'package:flutter/material.dart';
import 'package:money_app/blocs/edit_customer_page_bloc.dart';
import 'package:money_app/pages/edit_customer_page_body.dart';
import 'package:money_app/pages/main_drawer.dart';
import 'package:money_app/services/db_service.dart';
import 'package:provider/provider.dart';

class EditCustomerPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProxyProvider<DbService, EditCustomerBloc>(
      update: (_, db, prevBloc) => prevBloc ?? EditCustomerBloc(db),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<EditCustomerBloc>(
        builder: (_, bloc, __) => Scaffold(
          appBar: AppBar(
            title: Text('Money App'),
          ),
          body: EditCustomerPageBody(bloc),
          drawer: MainDrawer(ignoredButton: MainDrawerButtonType.add,),
        ),
      ),
    );
  }
}
