import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/routing/app_router.dart';
import '../../../../core/services/routing/routing_utils.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/blood_request_card.dart';
import '../../../../../domain/models/blood_request.dart';
import '../../../../../utils/blood_compat_util.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

class HomeActiveRequests extends StatelessWidget {
  const HomeActiveRequests({
    super.key,
    required this.requests,
    required this.isLoading,
    required this.onMessage,
    required this.userIsActive,
    required this.userBloodGroup,
    required this.interestedRequestIds,
    this.userLat,
    this.userLng,
  });

  final List<BloodRequest> requests;
  final bool isLoading;
  final void Function(BloodRequest) onMessage;
  final bool userIsActive;
  final String userBloodGroup;
  final List<String> interestedRequestIds;
  final double? userLat;
  final double? userLng;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Blood Requests Near You',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () =>
                    AppRouter.router.push(PAGES.bloodRequests.screenPath),
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
          const SizedBox(height: 12),
          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              ),
            )
          else if (requests.isEmpty)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🩸', style: TextStyle(fontSize: 32)),
                  const SizedBox(height: 8),
                  const Text(
                    'No active blood requests',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textTertiary,
                    ),
                  ),
                  TextButton(
                    onPressed: () => AppRouter.router
                        .push(PAGES.bloodRequests.screenPath),
                    child: const Text(
                      'See all requests',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            for (final req in requests) ...[
              Builder(builder: (context) {
                final compatible = isBloodGroupCompatible(
                  userBloodGroup,
                  req.bloodGroup,
                );
                return BloodRequestCard(
                  request: req,
                  userLat: userLat,
                  userLng: userLng,
                  onMessage: () => onMessage(req),
                  isInterested: interestedRequestIds.contains(req.id),
                  isCompatible: compatible,
                  userIsActive: userIsActive,
                  onImComing: userIsActive &&
                          !interestedRequestIds.contains(req.id) &&
                          compatible
                      ? () => context
                          .read<HomeBloc>()
                          .add(HomeEvent.imComing(req.id))
                      : null,
                );
              }),
              const SizedBox(height: 12),
            ],
        ],
      ),
    );
  }
}
