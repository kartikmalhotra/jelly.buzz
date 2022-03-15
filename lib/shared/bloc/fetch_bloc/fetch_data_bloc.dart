import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/shared/model/model.dart';
import 'package:task_app/shared/repository/repository.dart';

part 'fetch_data_event.dart';
part 'fetch_data_state.dart';

class FetchDataBloc extends Bloc<FetchDataEvent, FetchDataState> {
  final FetchDataRepositoryImpl repository;
  Map<String, dynamic>? selectedLocation;

  FetchDataBloc({required this.repository}) : super(const FetchDataInitial());

  @override
  Stream<FetchDataState> mapEventToState(FetchDataEvent event) async* {
    if (event is GetDataEvent) {
      yield* _mapGetDataEventToState(event);
    } else if (event is PostDetailEvent) {
      yield* _mapPostDetailEventToState(event);
    }
  }

  Stream<FetchDataState> _mapGetDataEventToState(GetDataEvent event) async* {
    yield const FetchingDataLoader();
    final response = await repository.fetchData();
    if (response[0]["data"] != null) {
      PhotoesModel photoesModel = PhotoesModel.fromJson(response[0]);
      repository.setPhotoesData = photoesModel;
    }
    if (response[1]["data"] != null) {
      PostModel postModel = PostModel.fromJson(response[1]);
      repository.setPostData = postModel;
    }

    if (response[0]["data"] == null) {
      yield DataLoadedState(error: response[0]["error"]);
      return;
    }
    if (response[1]["data"] == null) {
      yield DataLoadedState(error: response[1]["error"]);
      return;
    }

    if ((repository.photoesData != null &&
            (repository.photoesData?.data?.isNotEmpty ?? false)) ||
        (repository.postData != null &&
            (repository.postData?.data?.isNotEmpty ?? false))) {
      yield DataLoadedState(
          photoesModel: repository.photoesData, postModel: repository.postData);
      return;
    }
  }

  Stream<FetchDataState> _mapPostDetailEventToState(
      PostDetailEvent event) async* {
    yield const PostDataLoader();
    final response = await repository.fetchPostData(event.id);
    if (response != null) {
      Post post = Post.fromJson(response['data']);
      yield PostDataLoaded(post: post);
    }

    yield DataLoadedState(
        photoesModel: repository.photoesData, postModel: repository.postData);
    return;
  }
}
