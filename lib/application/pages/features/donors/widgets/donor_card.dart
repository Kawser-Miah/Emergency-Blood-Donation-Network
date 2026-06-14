import 'package:blood_setu/domain/models/nearby_donor.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/avatar.dart';
import 'donor_details_sheet.dart';

const List<String> _avatarColors = [
  '#1E88E5',
  '#43A047',
  '#E53935',
  '#FB8C00',
  '#9C27B0',
  '#00ACC1',
  '#F06292',
  '#26A69A',
];

String _colorFor(String uid) =>
    _avatarColors[uid.hashCode.abs() % _avatarColors.length];

class _StatusStyle {
  const _StatusStyle({required this.bg, required this.color});
  final Color bg;
  final Color color;
}

const Map<String, _StatusStyle> _statusColors = {
  'Available': _StatusStyle(
    bg: AppColors.successSurface,
    color: AppColors.success,
  ),
  'Unavailable': _StatusStyle(
    bg: AppColors.primarySurface,
    color: AppColors.primary,
  ),
};

class DonorCard extends StatelessWidget {
  const DonorCard({super.key, required this.donor, this.onMessage});

  final NearbyDonor donor;
  final VoidCallback? onMessage;

  void _openDetails(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DonorDetailsSheet(donor: donor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusLabel = donor.isActive ? 'Available' : 'Unavailable';
    final statusStyle =
        _statusColors[statusLabel] ?? _statusColors['Available']!;

    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          donor.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
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
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 11,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${donor.thana}, ${donor.district}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '${donor.distanceKm.toStringAsFixed(1)} km away',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '🩸${donor.totalDonations} donations',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusStyle.bg,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: statusStyle.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: donor.phone != null && donor.phone!.isNotEmpty
                      ? () => Utils.launchUrl('tel:${donor.phone}')
                      : null,
                  icon: const Icon(Icons.phone, size: 14),
                  label: const Text('Call'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: const BorderSide(
                      color: AppColors.divider,
                      width: 1.5,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onMessage,
                  icon: const Icon(Icons.chat_bubble_outline, size: 14),
                  label: const Text('Message'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _openDetails(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(
                      color: AppColors.primary,
                      width: 1.5,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'View Profile',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final photoUrl = donor.photoUrl;
    if (photoUrl != null && photoUrl.isNotEmpty) {
      return CircleAvatar(radius: 25, backgroundImage: NetworkImage(photoUrl));
    }
    return Avatar(
      initials: donor.initials,
      colorHex: _colorFor(donor.uid),
      size: 50,
      online: donor.isActive,
    );
  }
}
