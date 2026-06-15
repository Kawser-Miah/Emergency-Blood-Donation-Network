import 'package:flutter/material.dart';

import '../../../../core/auth/auth_controller.dart';
import '../../../../core/services/routing/chat_navigation.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../../di/di.dart';
import '../../../../../domain/models/chat_source.dart';
import '../../../../../domain/models/chat_source_type.dart';
import '../../../../../domain/models/nearby_donor.dart';
import '../../../../../utils/utils.dart';

const List<String> _avatarColors = [
  '#1E88E5', '#43A047', '#E53935', '#FB8C00',
  '#9C27B0', '#00ACC1', '#F06292', '#26A69A',
];

String _colorFor(String uid) =>
    _avatarColors[uid.hashCode.abs() % _avatarColors.length];

class HomeNearbyDonors extends StatelessWidget {
  const HomeNearbyDonors({
    super.key,
    required this.donors,
    required this.isLoading,
    required this.onSeeAll,
  });

  final List<NearbyDonor> donors;
  final bool isLoading;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nearby Donors',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: onSeeAll,
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  ),
                )
              : donors.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('🩸',
                              style: TextStyle(fontSize: 32)),
                          const SizedBox(height: 8),
                          const Text(
                            'No donors found nearby',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          TextButton(
                            onPressed: onSeeAll,
                            child: const Text(
                              'Search wider area',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: donors.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: 12),
                      itemBuilder: (context, i) =>
                          _HomeDonorCard(donor: donors[i]),
                    ),
        ),
      ],
    );
  }
}

class _HomeDonorCard extends StatelessWidget {
  const _HomeDonorCard({required this.donor});

  final NearbyDonor donor;

  @override
  Widget build(BuildContext context) {
    final firstName = donor.name.split(' ').first;
    final photoUrl = donor.photoUrl;
    return Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          photoUrl != null && photoUrl.isNotEmpty
              ? CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(photoUrl),
                )
              : Avatar(
                  initials: donor.initials,
                  colorHex: _colorFor(donor.uid),
                  size: 44,
                  online: donor.isActive,
                ),
          const SizedBox(height: 8),
          Text(
            firstName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              donor.bloodGroup,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on,
                  size: 10, color: AppColors.textTertiary),
              const SizedBox(width: 2),
              Text(
                '${donor.distanceKm.toStringAsFixed(1)} km',
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🩸', style: TextStyle(fontSize: 10)),
              const SizedBox(width: 2),
              Text(
                '${donor.totalDonations} donations',
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: donor.phone != null && donor.phone!.isNotEmpty
                      ? () => Utils.launchUrl('tel:${donor.phone}')
                      : null,
                  child: Container(
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.dividerLightest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.phone,
                        size: 12, color: AppColors.textSecondary),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    final uid = getIt<AuthController>().user?.uid;
                    if (uid == null) return;
                    navigateToChat(
                      currentUid: uid,
                      otherUid: donor.uid,
                      otherName: donor.name,
                      otherBloodGroup: donor.bloodGroup,
                      chatSource: const ChatSource(
                        type: ChatSourceType.donorCard,
                      ),
                      otherPhotoUrl: donor.photoUrl,
                    );
                  },
                  child: Container(
                    height: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.chat_bubble_outline,
                        size: 12, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
