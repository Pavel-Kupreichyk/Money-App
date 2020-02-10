import 'package:flutter/material.dart';
import 'package:money_app/blocs/deposit_page_bloc.dart';
import 'package:money_app/widgets/selectable_field.dart';

class DepositPageBody extends StatelessWidget {
  final DepositBloc _bloc;
  DepositPageBody(this._bloc);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<DepositValues>(
          stream: _bloc.values,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var values = snapshot.data;

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SelectableField(
                      label: 'Сберегательная программа',
                      values: values.programNames,
                      initVal: values.program.name,
                      onChanged: (val) => _bloc.selectProgram(val),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              SelectableField(
                                label: 'Валюта',
                                values: values.currencies,
                                initVal: values.currency,
                                onChanged: (val) => _bloc.selectCurrency(val),
                              ),
                              if (values.program.time.isNotEmpty)
                                SelectableField(
                                  label: 'Месячный срок',
                                  values: values.times,
                                  initVal: values.time.toString(),
                                  onChanged: _bloc.selectTime,
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(6, 8, 0, 6),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[600]),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Тип',
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 12),
                                  ),
                                  Text(
                                    '${values.program.type}',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Процент',
                                    style: TextStyle(
                                        color: Colors.grey[600], fontSize: 12),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '${values.percent}%',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  if (values.program.time.isNotEmpty)
                                    Column(
                                      children: <Widget>[
                                        SizedBox(height: 10),
                                        Text(
                                          'Истечёт',
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          values.dateOfExpire,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SelectableField(
                      label: 'Клиент',
                      values: values.customerNames,
                      initVal: values.customerName,
                      onChanged: _bloc.selectCustomer,
                    ),
                    Text(values.code),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
