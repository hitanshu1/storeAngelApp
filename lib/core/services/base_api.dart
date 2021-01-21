import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:storeangelApp/core/models/api_error.dart';

GetIt getIt = GetIt.instance;

abstract class BaseApi {
  // TODO: Move the endpoint to some settings file?
  static const _ENDPOINT = 'https://api.stripe.com/';
  final client = http.Client();



  @protected
  Future<dynamic> getRequest(String path, Function(Response) success) async {
    return _processResponse(await client.get(_ENDPOINT+'$path',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer sk_test_51HJc2FJuvB7YSQ3Zp9pInaKIC7sy55EE8NnQiecXDjgOwQRcTbub7pN3SHB2SLZNQlBSFQlqpgcR3WNdac0dGw3e00DGV2fCfb'
        }), success);
  }

  @protected
  Future<dynamic> postRequest(String path, Function(Response) success, [var body]) async {

    var uri =
    Uri.https('api.stripe.com', path, body);

    return _processResponse(

        await client.post(
            uri,
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': 'Bearer sk_test_51HJc2FJuvB7YSQ3Zp9pInaKIC7sy55EE8NnQiecXDjgOwQRcTbub7pN3SHB2SLZNQlBSFQlqpgcR3WNdac0dGw3e00DGV2fCfb'
            },

//            body: body != null ? jsonEncode(body) : null

        ), success
    );
  }
  @protected
  Future<dynamic> postRequestWithoutToken(String path, Function(Response) success, [Map body]) async {

    return _processResponse(

        await client.post(
            path,
            headers: {
              'Content-Type': 'application/json',
//              'Authorization': 'Bearer ${loggedInUser.token}'
            },

            body: body != null ? jsonEncode(body) : null

        ), success
    );
  }

  @protected
  Future<dynamic> putRequest(String path, Function(Response) success, [Map body]) async {
    return _processResponse(
        await client.put(
            '${BaseApi._ENDPOINT}/$path',

            body: body != null ? jsonEncode(body) : null
        ), success
    );
  }

  @protected
  Future<dynamic> deleteRequest(String path, Function(Response) success) async {
    return _processResponse(await client.delete('${BaseApi._ENDPOINT}/$path'), success);
  }

  dynamic _processResponse(Response response, Function(Response) success) {
    if (200 >= response.statusCode && response.statusCode < 300) {
      return success(response);
    } else {
      print(response.body);
      return ApiError.fromJson(json.decode(response.body));
    }
  }

}
