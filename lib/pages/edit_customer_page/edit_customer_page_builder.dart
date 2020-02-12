import 'package:flutter/material.dart';
import 'package:money_app/blocs/edit_customer_page_bloc.dart';
import 'package:money_app/models/customer.dart';
import 'package:money_app/pages/edit_customer_page/edit_customer_page_body.dart';
import 'package:money_app/pages/main_drawer.dart';
import 'package:money_app/services/db_service.dart';
import 'package:provider/provider.dart';

class EditCustomerPageBuilder extends StatelessWidget {
  final Customer _customer;
  EditCustomerPageBuilder.edit(this._customer);
  EditCustomerPageBuilder.add() : _customer = null;

  @override
  Widget build(BuildContext context) {
    return ProxyProvider<DbService, EditCustomerBloc>(
      update: (_, db, prevBloc) => prevBloc ?? EditCustomerBloc(db, _customer),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<EditCustomerBloc>(
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
          body: EditCustomerPageBody(bloc),
          drawer: MainDrawer(
            ignoredButton: MainDrawerButtonType.add,
          ),
        ),
      ),
    );
  }
}
