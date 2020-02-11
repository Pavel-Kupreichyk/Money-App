import 'package:flutter/material.dart';
import 'package:money_app/blocs/bills_page_bloc.dart';
import 'package:money_app/models/bill.dart';

class BillsPageBody extends StatelessWidget {
  final BillsBloc _bloc;
  BillsPageBody(this._bloc);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<List<Bill>>(
          stream: _bloc.bills,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var main = snapshot.data.firstWhere((b) => b.owner == 'СФРБ');
            var cash = snapshot.data.firstWhere((b) => b.owner == 'Касса');
            var bills =
                snapshot.data.where((b) => b != main && b != cash).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 6),
                  child: Text(
                    'СФРБ: ${main.actualAmount} BYN',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: RefreshIndicator(
                    onRefresh: () => _bloc.fetchBills(),
                    child: ListView.separated(
                        itemBuilder: (_, index) {
                          return ListTile(
                            title:
                                Text('Основной счёт: ${bills[index].number}'),
                            subtitle: Text(
                                'Процентный счёт: ${bills[index].percentBill.number}\n'
                                'Сумма вклада: ${bills[index].amount} ${bills[index].currency}\n'
                                'Сумма процентов: ${bills[index].percentBill.amount} ${bills[index].currency}\n'
                                'Месяцев до завершения: ${bills[index].month >= 0 ? bills[index].month : '-'}'),
                            trailing: bills[index].isOpen
                                ? IconButton(
                                    icon: Icon(Icons.lock_open,
                                        color: Colors.green),
                                    onPressed: bills[index].month < 0
                                        ? () =>
                                            _bloc.closeBill(bills[index].number)
                                        : null,
                                  )
                                : IconButton(
                                    icon: Icon(Icons.lock_outline,
                                        color: Colors.red),
                                  ),
                          );
                        },
                        separatorBuilder: (_, index) {
                          return Divider(height: 0);
                        },
                        itemCount: bills.length),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
