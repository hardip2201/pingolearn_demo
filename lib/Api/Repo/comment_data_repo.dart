import 'dart:convert';
import 'dart:developer';

import 'package:pingolearn_round/Api/Api/api_services.dart';
import 'package:pingolearn_round/Api/Api/base_service.dart';
import 'package:pingolearn_round/model/response_model/comments_response_model.dart';

class CommentDataRepo extends BaseService {
  Future<List<CommentResponseModel>> commentDataRepo() async {
    var response = await ApiService().getResponse(
      apiType: APIType.aGet,
      url: commentsURL,
    );
    log("ClientPayment res :${response}");

    // List<CommentResponseModel>

    List<CommentResponseModel> commentResponseModel =
        commentResponseModelFromJson(jsonEncode(response));
    return commentResponseModel;
  }
}
