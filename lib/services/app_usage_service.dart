import 'package:parental_control/services/app_usage_local_service.dart';

abstract class AppService {
  void getAppUsageService();
}

class AppUsageService implements AppService {
  List<AppUsageInfo> _info = <AppUsageInfo>[];

  List<AppUsageInfo> get info => _info;

  @override
  Future<List<AppUsageInfo>> getAppUsageService() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(hours: 1));
      _info = await AppUsage().getAppUsage(startDate, endDate);
    } on AppUsageException catch (exception) {
      print(exception);
    }
    return [];
  }
}
