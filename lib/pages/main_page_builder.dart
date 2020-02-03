import 'package:flutter/material.dart';
import 'package:money_app/blocs/main_page_bloc.dart';
import 'package:money_app/pages/main_page_body.dart';
import 'package:provider/provider.dart';

class MainPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<MainBloc>(
      create: (_) => MainBloc(),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<MainBloc>(
        builder: (_, bloc, __) => Scaffold(
          appBar: AppBar(
            title: Text(''),
          ),
          body: MainPageBody(bloc),
        ),
      ),
    );
  }
}