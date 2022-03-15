import 'package:flutter/material.dart';
import 'package:task_app/routes/routes_const.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/shared/bloc/fetch_bloc/fetch_data_bloc.dart';
import 'package:task_app/shared/repository/repository.dart';

class AppRouteSetting {
  static AppRouteSetting? _routeSetting;
  static FetchDataBloc? fetchDataBloc;

  AppRouteSetting._internal();

  static AppRouteSetting? getInstance() {
    fetchDataBloc = FetchDataBloc(repository: FetchDataRepositoryImpl());
    _routeSetting ??= AppRouteSetting._internal();
    return _routeSetting;
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.root:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Center(child: Text("Hi There")),
        );
    }
  }
}
