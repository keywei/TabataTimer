class ProvisioningProfile {
  const ProvisioningProfile({
    required this.creationDate,
    required this.expirationDate,
    this.name,
  });

  final DateTime creationDate;
  final DateTime expirationDate;
  final String? name;

  Duration remainingFrom(DateTime now) => expirationDate.difference(now);
  bool isExpired(DateTime now) => !now.isBefore(expirationDate);
}
