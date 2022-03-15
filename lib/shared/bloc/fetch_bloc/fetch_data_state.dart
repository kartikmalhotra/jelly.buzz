part of 'fetch_data_bloc.dart';

abstract class FetchDataState extends Equatable {
  const FetchDataState();
}

class FetchDataInitial extends FetchDataState {
  const FetchDataInitial();

  @override
  List<Object> get props => [];
}

class FetchingDataLoader extends FetchDataState {
  const FetchingDataLoader();

  @override
  List<Object> get props => [];
}

class PostDataLoader extends FetchDataState {
  const PostDataLoader();

  @override
  List<Object> get props => [];
}

class DataLoadedState extends FetchDataState {
  final PhotoesModel? photoesModel;
  final PostModel? postModel;
  final String? error;

  const DataLoadedState({
    this.photoesModel,
    this.postModel,
    this.error,
  });

  @override
  List<Object?> get props => [photoesModel, postModel, error];
}

class PostDataLoaded extends FetchDataState {
  final Post? post;

  const PostDataLoaded({this.post});

  @override
  List<Object?> get props => [post];
}
