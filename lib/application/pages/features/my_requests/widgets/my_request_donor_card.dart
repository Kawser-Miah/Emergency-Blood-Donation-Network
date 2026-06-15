import 'package:flutter/material.dart';

import '../../../../core/services/routing/chat_navigation.dart';
import '../../../../core/theme/colors.dart';
import '../../../../../domain/models/chat_source.dart';
import '../../../../../domain/models/chat_source_type.dart';
import '../../../../../domain/models/interested_donor.dart';

String _daysAgo(DateTime? date) {
  if (date == null) return '—';
  final days = DateTime.now().difference(date).inDays;
  if (days == 0) return 'today';
  if (days == 1) return '1 day ago';
  return '$days days ago';
}

class MyRequestDonorCard extends StatelessWidget {
  const MyRequestDonorCard({
    super.key,
    required this.donor,
    required this.requestId,
    required this.currentUid,
  });

  final InterestedDonor donor;
  final String requestId;
  final String currentUid;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primarySurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                donor.bloodGroup,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donor.name.isNotEmpty ? donor.name : 'Anonymous',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${donor.bloodGroup} • ${donor.totalDonations} donation${donor.totalDonations != 1 ? 's' : ''}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
                Text(
                  'Last donated: ${_daysAgo(donor.lastDonation)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () => navigateToChat(
              currentUid: currentUid,
              otherUid: donor.uid,
              otherName: donor.name,
              otherBloodGroup: donor.bloodGroup,
              chatSource: ChatSource(
                type: ChatSourceType.interestResponse,
                referenceId: requestId,
              ),
              otherPhotoUrl: null,
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              '💬 Message',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
