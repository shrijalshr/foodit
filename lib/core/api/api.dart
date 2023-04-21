import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:foodit/core/api/api_endpoints.dart';
import 'package:foodit/core/api/api_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = ApiEndPoints.BASE_URL;
  static const int TIME_OUT_DURATION = 20;
  final timeOutDuration = const Duration(seconds: TIME_OUT_DURATION);

  var accessToken;
  var refreshToken;

  getAccessToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    accessToken = localStorage.getString('accessToken');
    print("accessToken from getAccessToken: \t $accessToken");
  }

  Future<http.Response> postAuthData(data, apiUrl) async {
    var url = baseUrl + apiUrl;
    await getAccessToken();
    try {
      var response = await http
          .post(Uri.parse(url),
              body: jsonEncode(data), headers: setAuthHeaders())
          .timeout(timeOutDuration);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', url.toString());
    }
  }

  Future<http.Response?> postFile(images, datas, apiUrl) async {
    var url = baseUrl + apiUrl;
    await getAccessToken();
    try {
      var req = http.MultipartRequest('POST', Uri.parse(url));
      for (var i = 0; i < images.length; i++) {
        var image = images[i];
        // ignore: unused_local_variable, prefer_interpolation_to_compose_strings
        var pic = await http.MultipartFile.fromPath("image$i", image.path);
        req.files.add(pic);
      }
      datas.forEach((data) {
        req.fields[data[0]] = data[1];
      });

      req.headers.addAll(_setPostAuthHeaders());
      var res = await req.send();
      return await http.Response.fromStream(res);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<http.Response> getData(apiUrl) async {
    var url = baseUrl + apiUrl;
    try {
      var response = await http
          .get(Uri.parse(url), headers: _setHeaders())
          .timeout(timeOutDuration);
      return (response);
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', url.toString());
    }
  }

  // getWithParams(data, apiUrl) async {
  //   var url = baseURLNOHTTP + apiUrl;
  //   var uri = Uri.http(baseURLNOHTTP, apiUrl, data);
  //   await getAccessToken();
  //   try {
  //     var response = await http.get(uri, headers: setAuthHeaders());
  //     return response;
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection', url.toString());
  //   } on TimeoutException {
  //     throw ApiNotRespondingException(
  //         'API not responded in time', url.toString());
  //   }
  // }

  Future<http.Response?> getAuthData(apiUrl) async {
    var url = baseUrl + apiUrl;
    await getAccessToken();
    try {
      var response = await http.get(Uri.parse(url), headers: setAuthHeaders());
      return response;
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', url.toString());
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    }
  }

  Future<http.Response?> postData(data, apiUrl) async {
    var url = baseUrl + apiUrl;
    await getAccessToken();
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: _setHeaders(),
        body: jsonEncode(data),
      );
      return response;
    } on SocketException {
      throw FetchDataException('No Internet connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', url.toString());
    }
  }

  _setPostAuthHeaders() => {
        'xpsu': '12345678',
        'Authorization': 'Bearer $accessToken',
        'Vary': 'Accept',
        'Allow': 'GET, POST, OPTIONS',
        'X-Frame-Options': 'DENY',
        'X-Content-Type-Options': 'nosniff',
        'Referrer-Policy': 'same-origin',
        'Cross-Origin-Opener-Policy': 'same-origin',
      };

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/vnd.api+json',
        // 'xpsu': '12345678'
      };

  setAuthHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/vnd.api+json',
        'xpsu': '12345678',
        'Authorization': 'Bearer $accessToken',
        'Charset': 'utf-8'
      };

  // _returnResponse(http.Response response) {
  //   switch (response.statusCode) {
  //     case 200:
  //       var responseJson = utf8.decode(response.bodyBytes);
  //       return responseJson;
  //     case 201:
  //       var responseJson = utf8.decode(response.bodyBytes);
  //       return responseJson;
  //     case 400:
  //       throw BadRequestException(
  //           utf8.decode(response.bodyBytes), response.request!.url.toString());
  //     case 401:
  //     case 403:
  //       throw UnAuthorizedException(
  //           utf8.decode(response.bodyBytes), response.request!.url.toString());
  //     case 422:
  //       throw BadRequestException(
  //           utf8.decode(response.bodyBytes), response.request!.url.toString());
  //     case 500:
  //     default:
  //       throw FetchDataException(
  //           'Error occured with code : ${response.statusCode}',
  //           response.request!.url.toString());
  //   }
  // }
}
