import 'dart:convert';
import 'dart:io';

import 'package:task_app/constants/const.dart';
import 'package:http/http.dart' as http;

class RestAPIService {
  static RestAPIService? instance;

  static RestAPIService getInstance() {
    instance ??= RestAPIService.internal();
    return instance!;
  }

  RestAPIService.internal();

  Future<dynamic> fetchData(String url, RestAPIEndPoint endPoint) async {
    switch (endPoint) {
      case RestAPIEndPoint.get:
        try {
          final response = await http.read(Uri.parse(url));
          return {"data": json.decode(response)};
        } on SocketException {
          return {"error": 'No internet connection'};
        } on FormatException {
          return {
            "error":
                'Unable to process your request due to some failure, Please try again later!'
          };
        } on http.ClientException {
          return {
            "error":
                'Oh No! Unable to process your request. Possible cases may be server is not reachable or if server runs on VPN then VPN should be connected on mobile device!'
          };
        } catch (exe) {
          return {"error": "Unexpected Error"};
        }
      default:
    }
  }

  // dynamic _response(http.Response response) {
  //   switch (response.statusCode) {
  //     case 200:
  //       var responseJson = json.decode(response.body.toString());
  //       print(responseJson);
  //       return responseJson;
  //     case 400:
  //       throw BadRequestException(response.body.toString());
  //     case 401:

  //     case 403:
  //       throw UnauthorisedException(response.body.toString());
  //     case 500:

  //     default:
  //       throw FetchDataException(
  //           'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  //   }

  Map<String, dynamic> parseRequest(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return {'data': response.body};
      default:
        return {'error': "Unexpected error"};
    }
  }
}
