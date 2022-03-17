import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'analytics_firebase_service.dart';

const String _ShowMainBanner = "show_pop_up";
final defaults = <String, dynamic>{
  "title": "",
  "body": "",
  "activate": false,
  "urlImage": "",
  "urlLink": ""
};

class RemoteConfigService {
  RemoteConfigService._privateConstructor();
  static final RemoteConfigService instance =
      RemoteConfigService._privateConstructor();

  final RemoteConfig remoteConfig = RemoteConfig.instance;

  Future<void> initConfig() async {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: Duration(minutes: 1),
          minimumFetchInterval: Duration(hours: 1),
        ),
      );
      await remoteConfig.setDefaults({_ShowMainBanner: json.encode(defaults)});
      await remoteConfig.fetchAndActivate();
    } catch (exception) {
      AnalyticsService.instance.logErrorRemoteConfig(
          'Unable to fetch remote config. Cached or default values will be used');
    }
  }

  String getPopUp() {
    return remoteConfig.getString(_ShowMainBanner);
  }
}
