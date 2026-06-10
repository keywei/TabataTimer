import '../entities/provisioning_profile.dart';

abstract class ProvisioningProfileInfo {
  Future<ProvisioningProfile?> read();
}

class NoopProvisioningProfileInfo implements ProvisioningProfileInfo {
  const NoopProvisioningProfileInfo();

  @override
  Future<ProvisioningProfile?> read() async => null;
}
