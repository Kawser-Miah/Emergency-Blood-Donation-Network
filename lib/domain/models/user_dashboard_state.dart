class UserDashboardState {
  final String fullName;
  final String bloodGroup;
  final String donorTier;
  final bool isActive;
  final int totalDonations;
  final int daysToNextDonation;

  const UserDashboardState({
    required this.fullName,
    required this.bloodGroup,
    required this.donorTier,
    required this.isActive,
    required this.totalDonations,
    required this.daysToNextDonation,
  });

  factory UserDashboardState.fromSources({
    required String fullName,
    required String bloodGroup,
    required String donorTier,
    required bool isActive,
    required int totalDonations,
    required int daysToNextDonation,
  }) {
    return UserDashboardState(
      fullName: fullName,
      bloodGroup: bloodGroup,
      donorTier: donorTier,
      isActive: isActive,
      totalDonations: totalDonations,
      daysToNextDonation: daysToNextDonation,
    );
  }

  UserDashboardState copyWith({
    String? fullName,
    String? bloodGroup,
    String? donorTier,
    bool? isActive,
    int? totalDonations,
    int? daysToNextDonation,
  }) {
    return UserDashboardState(
      fullName: fullName ?? this.fullName,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      donorTier: donorTier ?? this.donorTier,
      isActive: isActive ?? this.isActive,
      totalDonations: totalDonations ?? this.totalDonations,
      daysToNextDonation: daysToNextDonation ?? this.daysToNextDonation,
    );
  }
}
