import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:pingolearn_round/Api/Api/api_response.dart';
import 'package:pingolearn_round/Api/Repo/comment_data_repo.dart';
import 'package:pingolearn_round/model/response_model/comments_response_model.dart';

class CommentsDataViewModel extends GetxController {
  ApiResponse apiResponse = ApiResponse.initial('Initial');

  bool isHidden = true;

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> initConfig() async {
    // // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    // await _remoteConfig.setConfigSettings(RemoteConfigSettings(
    //   fetchTimeout: const Duration(seconds: 10),
    //   minimumFetchInterval: const Duration(hours: 1),
    // ));
    // // await _remoteConfig.setDefaults(<String, dynamic>{
    // //   'welcome': 'default welcome',
    // //   'hello': 'default hello',
    // // });
    // // RemoteConfigValue(null, ValueSource.valueStatic);
    //
    // _fetchConfig();
    FirebaseRemoteConfig firebaseRemoteConfig = FirebaseRemoteConfig.instance;
    // var isUpdated = await firebaseRemoteConfig.fetchAndActivate();

    await firebaseRemoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 5),
        minimumFetchInterval: const Duration(seconds: 30),
      ),
    );

    var emailVerifcation = firebaseRemoteConfig.getBool('emailVerification');
    var newtest = firebaseRemoteConfig.getString('newTest');
    print('--emailVerifcationemailVerifcation--${emailVerifcation}');
    print('--newtestnewtest-BOol-${newtest}');
  }

  // Fetching, caching, and activating remote config
  void _fetchConfig() async {
    _remoteConfig.addListener(() {
      print(
          'LISTEN--_remoteConfig--${_remoteConfig.getBool('emailVerification')}');
      print('--_remoteConfig-String-${_remoteConfig.getString('newTest')}');
    });

    // await _remoteConfig.fetchAndActivate();
    print('--_remoteConfig--${_remoteConfig.getAll()}');
    print('--_remoteConfig-BOol-${_remoteConfig.getBool('emailVerification')}');
    print('--_remoteConfig-String-${_remoteConfig.getString('newTest')}');
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
