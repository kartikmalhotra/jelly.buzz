import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/config/screen_config.dart';
import 'package:task_app/screens/post_detail_screen.dart';
import 'package:task_app/shared/bloc/fetch_bloc/fetch_data_bloc.dart';
import 'package:task_app/widget/widget.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: AppScreenConfig.screenWidth,
      height: AppScreenConfig.screenHeight,
      child: BlocBuilder<FetchDataBloc, FetchDataState>(
        buildWhen: (previous, current) =>
            current is! PostDataLoaded && current is! PostDataLoader,
        builder: (context, state) {
          if (state is DataLoadedState) {
            if (state.error == null) {
              return _displayPostScreen(state);
            } else {
              return Center(
                child: Text(
                  "${state.error}",
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              );
            }
          }
          return const Center(child: AppCircularProgressLoader());
        },
      ),
    );
  }

  Widget _displayPostScreen(DataLoadedState state) {
    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: state.postModel?.data?.length ?? 0,
      itemBuilder: (context, index) {
        return PostAppCard(
          width: double.maxFinite,
          post: state.postModel!.data![index],
          callback: () {
            BlocProvider.of<FetchDataBloc>(context)
                .add(PostDetailEvent(id: state.postModel!.data![index].id!));
            showDialog(
              context: context,
              builder: (context) =>
                  PostDetailScreen(post: state.postModel!.data![index]),
            );
          },
        );
      },
    );
  }
}
