import 'package:givt_mobile_apps/services/local_storage_service.dart';
import 'package:givt_mobile_apps/utils/locator.dart';

class Donation {
  late final LocalStorageProxy storageProxy = locator<LocalStorageProxy>();
  final String wepayToken;

  Donation({
    required this.wepayToken,
  });
}
