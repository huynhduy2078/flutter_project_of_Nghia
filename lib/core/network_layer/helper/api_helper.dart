import 'dart:convert';
import 'dart:io';

import 'package:chat_messanger_ui/core/network_layer/base_network/base_network.dart';
import 'package:chat_messanger_ui/core/network_layer/exceptions/exceptions.dart';
import 'package:chat_messanger_ui/utils/log.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class ApiHelper with BaseNetwork {
  Future<Map<String, dynamic>> get({
    @required String url,
    Map<String, String> headers,
  }) async {
    var responseJson;
    try {
      final response = await getData(
        url: url,
        headers: headers ?? (await defaultHeaders()),
      );

      // Log().debug(response.body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      if (e is UnauthorisedException) Log().error(e.toString());
      throw e;
    }
    return json.decode(responseJson);
  }

  Future<Response> getRaw({
    @required String url,
    Map<String, String> headers,
  }) async {
    Response responseJson;
    try {
      final response = await getData(
        url: url,
        headers: headers ?? (await defaultHeaders()),
      );

      // Log().debug(response.body);
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      if (e is UnauthorisedException) Log().error(e.toString());
      throw e;
    }
    return responseJson;
  }

  Future<String> post({
    @required String url,
    Map<String, String> headers,
    @required Map<String, dynamic> body,
  }) async {
    var responseJson;
    try {
      final response = await postData(
        url: url,
        headers: headers ?? (await defaultHeaders()),
        body: body,
      );
      // Log().debug(response.body);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (e) {
      if (e is UnauthorisedException) Log().error(e.toString());
      throw e;
    }
    return responseJson;
  }

  String _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
