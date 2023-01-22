import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:pingolearn_round/Api/Api/api_response.dart';
import 'package:pingolearn_round/Api/Repo/comment_data_repo.dart';
import 'package:pingolearn_round/model/response_model/comments_response_model.dart';

class CommentsDataViewModel extends GetxController {
  ApiResponse apiResponse = ApiResponse.initial('Initial');

  bool isHidden = false;

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> initConfig() async {
    await _remoteConfig.fetchAndActivate();
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 5),
        minimumFetchInterval: const Duration(seconds: 30),
      ),
    );

    isHidden = _remoteConfig.getBool('emailVerification');
    update();
  }

  /// register...
  Future<void> commentsDataViewModel() async {
    apiResponse = ApiResponse.loading('Loading');
    // update();
    try {
      List<CommentResponseModel> response =
          await CommentDataRepo().commentDataRepo();
      apiResponse = ApiResponse.complete(response);
      print("CommentResponseModel RES:$response");
    } catch (e) {
      print('CommentsDataViewModel.....$e');
      apiResponse = ApiResponse.error('error');
    }
    update();
  }
}
