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
                    var formattedDate = customers[index].dateOfBirth != null
                        ? '${customers[index].dateOfBirth.day}.'
                            '${customers[index].dateOfBirth.month}.'
                            '${customers[index].dateOfBirth.year}'
                        : 'Нет данных';
                    return ListTile(
                      title: Text('${customers[index].lastName} '
                          '${customers[index].firstName} '
                          '${customers[index].middleName}'),
                      subtitle: Text('Город: ${customers[index].city}\n'
                          'Адрес: ${customers[index].address}\n'
                          'Дата рождения: $formattedDate\n'),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () => _bloc.editCustomer(index),
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
