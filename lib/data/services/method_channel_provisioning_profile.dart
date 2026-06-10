import 'package:flutter/services.dart';

import '../../domain/entities/provisioning_profile.dart';
import '../../domain/services/provisioning_profile_info.dart';

class MethodChannelProvisioningProfile implements ProvisioningProfileInfo {
  static const MethodChannel _channel =
      MethodChannel('app/provisioning_profile');

  @override
  Future<ProvisioningProfile?> read() async {
    try {
      final map = await _channel.invokeMapMethod<String, dynamic>('get');
      if (map == null) return null;
      final exp = map['expirationDate'];
      final cre = map['creationDate'];
      if (exp is! String || cre is! String) return null;
      return ProvisioningProfile(
        creationDate: DateTime.parse(cre),
        expirationDate: DateTime.parse(exp),
        name: map['name'] is String ? map['name'] as String : null,
      );
    } on MissingPluginException {
      return null;
    } on PlatformException {
      return null;
    } on FormatException {
      return null;
    }
  }
}
