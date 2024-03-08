import 'package:firebase_remote_config/firebase_remote_config.dart';
class RemoteConfigService{
  final remoteConfig = FirebaseRemoteConfig.instance;

  Future initializeConfig() async {
    await remoteConfig.fetchAndActivate();
    var value=remoteConfig.getString('last_api_call_time');
    return value;
  }
}