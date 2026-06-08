import 'package:blood_setu/application/core/theme/colors.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_interests_bloc.dart';
import '../bloc/my_interests_event.dart';
import '../bloc/my_interests_state.dart';
import '../widgets/my_interest_card.dart';
import '../widgets/my_interest_detail_sheet.dart';
import '../widgets/my_interests_empty.dart';

class MyInterestsScreen extends StatelessWidget {
  const MyInterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<MyInterestsBloc>()..add(const MyInterestsEvent.started()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<MyInterestsBloc, MyInterestsState>(
            listenWhen: (p, c) => p.withdrawSuccess != c.withdrawSuccess,
            listener: (context, _) => Utils.showSnackBar(
              context,
              content: 'Interest withdrawn successfully.',
              color: AppColors.success,
            ),
          ),
          BlocListener<MyInterestsBloc, MyInterestsState>(
            listenWhen: (p, c) => p.withdrawFailed != c.withdrawFailed,
            listener: (context, _) => Utils.showSnackBar(
              context,
              content: 'Failed to withdraw. Please try again.',
              color: AppColors.primary,
            ),
          ),
          BlocListener<MyInterestsBloc, MyInterestsState>(
            listenWhen: (p, c) => p.bloodGivenSuccess != c.bloodGivenSuccess,
            listener: (context, _) => Utils.showSnackBar(
              context,
              content: 'Thank you! Blood donation recorded.',
              color: AppColors.info,
            ),
          ),
          BlocListener<MyInterestsBloc, MyInterestsState>(
            listenWhen: (p, c) => p.bloodGivenFailed != c.bloodGivenFailed,
            listener: (context, _) => Utils.showSnackBar(
              context,
              content: 'Failed to record donation. Please try again.',
              color: AppColors.primary,
            ),
          ),
          BlocListener<MyInterestsBloc, MyInterestsState>(
            listenWhen: (p, c) =>
                p.donationRecordFailed != c.donationRecordFailed,
            listener: (context, _) => Utils.showSnackBar(
              context,
              content:
                  'Blood given saved, but donation history failed to update. Please add it manually from your profile.',
              color: AppColors.warning,
            ),
          ),
        ],
        child: const _MyInterestsView(),
      ),
    );
  }
}

class _MyInterestsView extends StatelessWidget {
  const _MyInterestsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 18,
            color: AppColors.textSecondary,
          ),
        ),
        title: BlocBuilder<MyInterestsBloc, MyInterestsState>(
          buildWhen: (p, c) =>
              p.interests.length != c.interests.length ||
              p.isLoading != c.isLoading,
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Interests',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              if (!state.isLoading)
                Text(
                  '${state.interests.length} request${state.interests.length == 1 ? '' : 's'}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
        ),
        centerTitle: false,
        actions: [
          BlocBuilder<MyInterestsBloc, MyInterestsState>(
            buildWhen: (p, c) => p.isLoading != c.isLoading,
            builder: (context, state) => IconButton(
              onPressed: state.isLoading
                  ? null
                  : () => context
                      .read<MyInterestsBloc>()
                      .add(const MyInterestsEvent.refreshed()),
              icon: const Icon(Icons.refresh, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
      body: BlocBuilder<MyInterestsBloc, MyInterestsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.error != null && state.interests.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.error!,
                    style: const TextStyle(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<MyInterestsBloc>()
                        .add(const MyInterestsEvent.refreshed()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state.interests.isEmpty) {
            return const MyInterestsEmpty();
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async => context
                .read<MyInterestsBloc>()
                .add(const MyInterestsEvent.refreshed()),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: state.interests.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final entry = state.interests[index];
                return MyInterestCard(
                  entry: entry,
                  isWithdrawing: state.withdrawingId == entry.request.id,
                  onTap: () => _openDetail(context, entry.request.id),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, String requestId) {
    final bloc = context.read<MyInterestsBloc>();
    final entry = bloc.state.interests.firstWhere(
      (e) => e.request.id == requestId,
    );
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: MyInterestDetailSheet(entry: entry),
      ),
    );
  }
}
