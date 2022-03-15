import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/config/screen_config.dart';
import 'package:task_app/screens/photo_screen.dart';
import 'package:task_app/screens/post_screen.dart';
import 'package:task_app/shared/bloc/fetch_bloc/fetch_data_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    BlocProvider.of<FetchDataBloc>(context).add(const GetDataEvent());
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    AppScreenConfig.initializeScreenConfig(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Padding(
              child: Text("PHOTO",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              padding: const EdgeInsets.all(10.0),
            ),
            Padding(
              child: Text("POST",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              padding: const EdgeInsets.all(10.0),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PhotoScreen(),
          PostScreen(),
        ],
      ),
    );
  }
}
