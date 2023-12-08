import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:congle/app/data/data.dart';
import 'package:get/get.dart';

// const baseUrl = 'https://congle-india.herokuapp.com/api/v1';
const baseUrl = 'http://192.168.29.157:3000/api/v1';

class Api extends GetConnect {
  final auth = Get.find<PhoneAuthService>();
  final fcm = Get.find<FCMService>();
  static const int timeOutDuration = 15;
  String accessToken = '';
  String refreshToken = '';

  Future<Api> init() async {
    Get.log('$runtimeType ready');
    return this;
  }

  Map<String, String> headers() => {"Authorization": "Bearer $accessToken"};

  /// Logging in and getting bearer token
  ///
  Future<bool> login() async {
    const extUrl = '/auth/getToken';
    Map<String, String> body = {"phno": "${auth.fireUser!.phoneNumber}"};
    // Get.log("Sent Body: ${jsonEncode(body)}\nUrl: ${baseUrl + _extUrl}");

    await postReq(extUrl, body, (resp) {
      Get.log("Response for login : $resp");
      if (resp == null) return false;
      if (resp['success']??false) {
        accessToken = resp['accessToken'];
        refreshToken = resp['refreshToken'];
        Get.log("Bearer Token: $accessToken");
        Get.log("Refresh Token: $refreshToken");
      } else {
        KToast("Error logging in");
      }
    });
    Get.log(accessToken);
    Get.log(refreshToken);
    return (accessToken != '');
  }

  /// GLobal Functions
  Future<void> getReq(String extUrl, Function(dynamic resp) handleResp) async {
    final uri = Uri.parse(baseUrl + extUrl);
    Get.log(uri.toString());

    try {
      var resp = await get(
        uri.toString(),
        headers: headers(),
      ).timeout(
        const Duration(seconds: timeOutDuration),
      );

      if (resp.body != null) {
        Get.log("response of get request: ${resp.statusText}");
        var value = _processResponse(resp);
        Get.log("processed response of get request: $value");
        handleResp(value);
      } else {
        // Handle null response
        Get.log("Responses is null");
        // throw FetchDataException('Null Response', uri.toString());
      }
      return;
    } on SocketException {
      throw FetchDataException('Connection Error', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not responded in time', uri.toString());
    }
  }

  Future<void> postReq(
    String extUrl,
    Map<String, dynamic> body,
    Function(dynamic resp) handleResp,
  ) async {
    // return;
    final uri = Uri.parse(baseUrl + extUrl);
    Get.log("URL: $uri");
    Get.log('Sent Body: ${body.toString()}');

    try {
      var resp = await post(
        uri.toString(),
        body,
        headers: headers(),
      ).timeout(
        const Duration(seconds: timeOutDuration),
      );
      Get.log("response: ${resp.body}");

      var value = _processResponse(resp);
      Get.log(value.toString());

      handleResp(value);
      return;
    } on SocketException {
      throw FetchDataException('Connection Error', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not responded in time', uri.toString());
    }
  }

  Future uploadImage(String extUrl, String title, File file) async {
    // return;
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(baseUrl + extUrl),
    );

    request.headers.addAll(headers());

    var picture = http.MultipartFile(
        'avatar', file.readAsBytes().asStream(), file.lengthSync(),
        filename: file.path.split("/").last);

    request.files.add(picture);
    Get.log(request.toString());

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);

    Get.log(result.toString());
  }

  uploadMultipleImages(String extUrl, List<File> images) async {
    // return;

    var request = http.MultipartRequest("POST", Uri.parse(baseUrl + extUrl));
    request.headers.addAll(headers());

    for (var file in images) {
      var picture = http.MultipartFile(
          'pics', file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split("/").last);

      request.files.add(picture);
    }
    Get.log(request.toString());

    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var result = String.fromCharCodes(responseData);

    Get.log(result.toString());
  }

  dynamic _processResponse(Response response) {
    var respJson = response.body;
    switch (response.statusCode) {
      case 200:
        return respJson;

      case 400: // bad request
        Get.printError(
            info:
                "Bad Request Exception  ${response.body}  ${response.request!.url}");
        return respJson;

      case 401: // unautherised
        Get.printError(info: "Un-Authorized Exception");
        throw UnAuthorizedException(
            response.body.toString(), response.request?.url.toString() ?? "");

      case 500: // internal server error
        Get.printError(info: "Internal Server Error");
        return;

      default:
        Get.printError(info: response.statusCode.toString());
      // throw FetchDataException(
      //     'Error occured with code: ${response.statusCode}',
      //     response.request.toString());
    }
  }
}
