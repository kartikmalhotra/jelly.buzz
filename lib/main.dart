import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/config/application.dart';
import 'package:task_app/constants/const.dart';
import 'package:task_app/routes/routes.dart';
import 'package:task_app/services/rest_service.dart';
import 'package:task_app/shared/bloc/fetch_bloc/fetch_data_bloc.dart';

import 'package:task_app/shared/repository/repository.dart';

Future<void> main() async {
  /// Getting Instance of all the classes needed
  WidgetsFlutterBinding.ensureInitialized();
  Application.restAPIService = RestAPIService.getInstance();
  Application.routeSettings = AppRouteSetting.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchDataBloc>(
      create: (context) => FetchDataBloc(repository: FetchDataRepositoryImpl()),
      child: MaterialApp(
        title: 'Post App',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        onGenerateRoute: Application.routeSettings!.generateRoute,
      ),
    );
  }
}
