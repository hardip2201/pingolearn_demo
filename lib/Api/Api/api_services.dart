import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pingolearn_round/Api/Api/api_extention.dart';

import 'base_service.dart';

enum APIType { aPost, aGet }

class ApiService extends BaseService {
  var response;

  Future<dynamic> getResponse(
      {@required APIType? apiType,
      @required String? url,
      Map<String, dynamic>? body,
      Map<String, String>? header,
      bool fileUpload = false}) async {
    try {
      if (apiType == APIType.aGet) {
        var result = await http.get(Uri.parse(url ?? ''));
        response = returnResponse(
          result.statusCode,
          result.body,
        );
        log("response......${response}");
      } else if (apiType == APIType.aPost) {
        var encodeBody = json.encode(body); // jsonEncode(body);
        log("REQUEST ENCODE BODY $encodeBody");
        log("REQUEST  BODY $body");

        var result = await http.post(Uri.parse(url ?? ''),
            headers: header, body: encodeBody);
        log('resultresult : ${result.body}');
        print('resultresult : ${result.body}');
        response = returnResponse(
          result.statusCode,
          result.body,
        );
        log("response......${response}");
      }
      return response;
    } catch (e) {
      log('Error=>.. $e');
    }
  }

  returnResponse(int status, String result) {
    print("status$status");
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 256:
        return jsonDecode(result);

      case 400:
        throw BadRequestException('Bad Request');
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
