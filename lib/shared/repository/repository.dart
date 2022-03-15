import 'package:task_app/config/application.dart';
import 'package:task_app/constants/const.dart';
import 'package:task_app/shared/model/model.dart';

abstract class FetchDataRepository {
  PhotoesModel? photoesModel;

  PhotoesModel? get photoesData => null;
  set setPhotoesData(PhotoesModel? photoesModel);

  PostModel? postModel;

  PostModel? get postData => null;
  set setPostData(PostModel? photoesModel);

  // Fetch Data
  Future<dynamic> fetchData();

  // Fetch Photoes
  Future<dynamic> fetchPhotoes();

  /// Fetech Post
  Future<dynamic> fetchPosts();

  // Fetch Post Data
  Future<dynamic> fetchPostData(int id);
}

class FetchDataRepositoryImpl extends FetchDataRepository {
  PhotoesModel? _photoesModel;
  PostModel? _postModel;

  @override
  PhotoesModel? get photoesData => _photoesModel;

  @override
  set setPhotoesData(PhotoesModel? photoesModel) {
    _photoesModel = photoesModel;
  }

  @override
  PostModel? get postData => _postModel;

  @override
  set setPostData(PostModel? postModel) {
    _postModel = postModel;
  }

  @override
  Future<dynamic> fetchData() {
    var response = Future.wait([
      fetchPhotoes(),
      fetchPosts(),
    ]);

    return response;
  }

  @override
  Future<dynamic> fetchPhotoes() async {
    try {
      var response = await Application.restAPIService!.fetchData(
          "https://jsonplaceholder.typicode.com/photos", RestAPIEndPoint.get);
      return response;
    } catch (e) {
      return {"error": "Unexpected Error"};
    }
  }

  @override
  Future<dynamic> fetchPosts() async {
    try {
      var response = await Application.restAPIService!.fetchData(
          "https://jsonplaceholder.typicode.com/posts", RestAPIEndPoint.get);
      return response;
    } catch (e) {
      return {"error": "Unexpected Error"};
    }
  }

  // Fetch Post Data
  @override
  Future<dynamic> fetchPostData(int id) async {
    try {
      var response = await Application.restAPIService!.fetchData(
          "https://jsonplaceholder.typicode.com/posts/$id",
          RestAPIEndPoint.get);
      return response;
    } catch (e) {
      return {"error": "Unexpected Error"};
    }
  }
}
