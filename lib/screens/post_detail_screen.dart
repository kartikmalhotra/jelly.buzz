import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/config/screen_config.dart';
import 'package:task_app/shared/bloc/fetch_bloc/fetch_data_bloc.dart';
import 'package:task_app/shared/model/model.dart';
import 'package:task_app/widget/widget.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.white,
        height: AppScreenConfig.screenHeight,
        width: AppScreenConfig.screenWidth,
        child: BlocBuilder<FetchDataBloc, FetchDataState>(
          buildWhen: (previous, current) =>
              current is PostDataLoaded || current is PostDataLoader,
          builder: (context, state) {
            if (state is PostDataLoaded) {
              return _displayPostDetail(state, context);
            }
            return const Center(child: AppCircularProgressLoader());
          },
        ),
      ),
    );
  }

  Widget _displayPostDetail(PostDataLoaded state, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          post.title ?? "",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        if (post.body?.isNotEmpty ?? false) ...[
          const SizedBox(height: 20.0),
          Text(
            post.body ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.grey[600]),
          )
        ]
      ],
    );
  }
}
