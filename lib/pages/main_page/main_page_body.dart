import 'package:flutter/material.dart';
import 'package:money_app/blocs/main_page_bloc.dart';
import 'package:money_app/models/customer.dart';

class MainPageBody extends StatelessWidget {
  final MainBloc _bloc;
  MainPageBody(this._bloc);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<List<Customer>>(
          stream: _bloc.customers,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var customers = snapshot.data;
            return RefreshIndicator(
              onRefresh: () => _bloc.updateCustomers(),
              child: ListView.separated(
                  itemBuilder: (_, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.delete_forever, size: 36),
                          ),
                        ),
                      ),
                      onDismissed: (_) => _bloc.deleteCustomer(index),
                      child: ListTile(
                        title: Text('${customers[index].combinedName}'),
                        subtitle: Text('Город: ${customers[index].city}\n'
                            'Адрес: ${customers[index].address}\n'
                            'Дата рождения: ${customers[index].formattedBirthDate}\n'),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.blue,
                          onPressed: () => _bloc.editCustomer(index),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return Divider(height: 0);
                  },
                  itemCount: customers.length),
            );
          }),
    );
  }
}
