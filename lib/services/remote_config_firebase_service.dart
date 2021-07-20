import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _ShowMainBanner = "show_main_pop_up";
final defaults = <String, dynamic>{
  _ShowMainBanner: {'activate': false}
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
      await remoteConfig.setDefaults(defaults);
      await remoteConfig.fetchAndActivate();
    } catch (exception) {
      print('Unable to fetch remote config. Cached or default values will be '
          'used');
    }
  }

  String getPopUp() {
    return remoteConfig.getString(_ShowMainBanner);
  }
}
