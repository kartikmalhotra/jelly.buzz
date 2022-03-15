part of 'fetch_data_bloc.dart';

abstract class FetchDataEvent extends Equatable {
  const FetchDataEvent();

  @override
  List<Object> get props => [];
}

class GetDataEvent extends FetchDataEvent {
  const GetDataEvent();

  @override
  List<Object> get props => [];
}

class PostDetailEvent extends FetchDataEvent {
  final int id;
  const PostDetailEvent({required this.id});

  @override
  List<Object> get props => [];
}
