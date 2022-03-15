import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/config/screen_config.dart';
import 'package:task_app/shared/bloc/fetch_bloc/fetch_data_bloc.dart';
import 'package:task_app/widget/widget.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchDataBloc, FetchDataState>(
      buildWhen: (previous, current) =>
          current is! PostDataLoaded && current is! PostDataLoader,
      builder: (context, state) {
        if (state is DataLoadedState) {
          if (state.error == null) {
            return _displayPhotoScreen(state);
          } else {
            return Center(
              child: Text(
                "${state.error}",
                style: const TextStyle(color: Colors.black),
              ),
            );
          }
        }
        return const Center(child: AppCircularProgressLoader());
      },
    );
  }

  Widget _displayPhotoScreen(DataLoadedState state) {
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: state.photoesModel?.data?.length ?? 0,
      itemBuilder: (context, index) {
        return PhotoAppCard(
          height: AppScreenConfig.screenHeight! / 2,
          photoes: state.photoesModel!.data![index],
          callback: () {
            showDialog(
              context: context,
              builder: (context) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image:
                        NetworkImage("${state.photoesModel!.data![index].url}"),
                  ),
                ),
                height: AppScreenConfig.screenHeight,
                width: AppScreenConfig.screenWidth,
              ),
            );
          },
        );
      },
    );
  }
}
