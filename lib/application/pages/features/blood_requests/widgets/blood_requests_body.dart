import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/auth/auth_controller.dart';
import '../../../../core/services/routing/chat_navigation.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/blood_request_card.dart';
import '../../../../../di/di.dart';
import '../../../../../domain/models/chat_source.dart';
import '../../../../../domain/models/chat_source_type.dart';
import '../../../../../utils/blood_compat_util.dart';
import '../bloc/blood_requests_bloc.dart';
import '../bloc/blood_requests_event.dart';
import '../bloc/blood_requests_state.dart';
import 'blood_requests_empty.dart';

class BloodRequestsBody extends StatelessWidget {
  const BloodRequestsBody({
    super.key,
    required this.state,
    required this.scrollController,
  });

  final BloodRequestsState state;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (state.isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.bloodtype_outlined,
                size: 48,
                color: AppColors.textMuted,
              ),
              const SizedBox(height: 12),
              Text(
                state.error ?? 'Failed to load requests.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textTertiary),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<BloodRequestsBloc>().add(
                      const BloodRequestsEvent.started(),
                    ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.filtered.isEmpty) {
      return BloodRequestsEmpty(
        onReset: () => context.read<BloodRequestsBloc>().add(
              const BloodRequestsEvent.filtersReset(),
            ),
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async => context.read<BloodRequestsBloc>().add(
            const BloodRequestsEvent.refreshed(),
          ),
      child: ListView.separated(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        itemCount: state.filtered.length + 1,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          if (i >= state.filtered.length) {
            return BloodRequestsListFooter(state: state);
          }
          final req = state.filtered[i];
          final compatible = isBloodGroupCompatible(
            state.userBloodGroup,
            req.bloodGroup,
          );
          return BloodRequestCard(
            request: req,
            userLat: state.userLat,
            userLng: state.userLng,
            onMessage: () {
              final uid = getIt<AuthController>().user?.uid;
              if (uid == null) return;
              navigateToChat(
                currentUid: uid,
                otherUid: req.uid,
                otherName: 'Blood Requester',
                otherBloodGroup: req.bloodGroup,
                chatSource: ChatSource(
                  type: ChatSourceType.bloodRequest,
                  referenceId: req.id,
                ),
                otherPhotoUrl: null,
              );
            },
            isInterested: state.interestedRequestIds.contains(req.id),
            isCompatible: compatible,
            userIsActive: state.userIsActive,
            onImComing: state.userIsActive &&
                    !state.interestedRequestIds.contains(req.id) &&
                    compatible
                ? () => context
                    .read<BloodRequestsBloc>()
                    .add(BloodRequestsEvent.imComing(req.id))
                : null,
          );
        },
      ),
    );
  }
}

class BloodRequestsListFooter extends StatelessWidget {
  const BloodRequestsListFooter({super.key, required this.state});

  final BloodRequestsState state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
        ),
      );
    }
    if (!state.hasMore && state.requests.isNotEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            'No more requests found',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
        ),
      );
    }
    return const SizedBox(height: 24);
  }
}
