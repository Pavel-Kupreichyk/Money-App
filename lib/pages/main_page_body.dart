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
                    return ListTile(
                      title: Text(
                          '${customers[index].middleName} ${customers[index].firstName} ${customers[index].lastName}'),
                      subtitle: Text('Город: ${customers[index].city}\n'
                          'Адрес: ${customers[index].address}\n'
                          'Дата рождения: ${customers[index].dateOfBirth}\n'),
                      trailing: IconButton(icon: Icon(Icons.edit)),
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
