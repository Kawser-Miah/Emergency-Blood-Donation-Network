import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/di.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/my_requests_bloc.dart';
import '../bloc/my_requests_event.dart';
import '../bloc/my_requests_state.dart';
import '../../../../../domain/models/blood_request.dart';
import '../widgets/my_request_card.dart';
import '../widgets/my_request_detail_sheet.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<MyRequestsBloc>()..add(const MyRequestsEvent.started()),
      child: const _MyRequestsView(),
    );
  }
}

class _MyRequestsView extends StatelessWidget {
  const _MyRequestsView();

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
        title: BlocBuilder<MyRequestsBloc, MyRequestsState>(
          buildWhen: (p, c) =>
              p.requests.length != c.requests.length ||
              p.isLoading != c.isLoading,
          builder: (context, state) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Requests',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              if (!state.isLoading)
                Text(
                  '${state.requests.length} request${state.requests.length == 1 ? '' : 's'}',
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
          BlocBuilder<MyRequestsBloc, MyRequestsState>(
            buildWhen: (p, c) => p.isLoading != c.isLoading,
            builder: (context, state) => IconButton(
              onPressed: state.isLoading
                  ? null
                  : () => context.read<MyRequestsBloc>().add(
                      const MyRequestsEvent.refreshed()),
              icon: const Icon(Icons.refresh,
                  color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
      body: BlocBuilder<MyRequestsBloc, MyRequestsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child:
                  CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.error != null && state.requests.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: AppColors.textMuted),
                  const SizedBox(height: 12),
                  Text(
                    state.error!,
                    style:
                        const TextStyle(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<MyRequestsBloc>()
                        .add(const MyRequestsEvent.refreshed()),
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

          if (state.requests.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.water_drop_outlined,
                    size: 56,
                    color: AppColors.primaryBorder,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "You haven't posted any requests yet.",
                    style: TextStyle(
                        fontSize: 15, color: AppColors.textMuted),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.requests.length,
            separatorBuilder: (_, _) =>
                const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final req = state.requests[index];
              return MyRequestCard(
                request: req,
                onTap: () => _openDetail(context, req),
              );
            },
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, BloodRequest request) {
    final bloc = context.read<MyRequestsBloc>();
    bloc.add(MyRequestsEvent.interestedDonorsRequested(request.id));

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: MyRequestDetailSheet(request: request),
      ),
    );
  }
}
