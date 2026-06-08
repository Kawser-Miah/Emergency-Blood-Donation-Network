import 'dart:math' as math;

import 'package:blood_setu/application/core/theme/colors.dart';
import 'package:blood_setu/application/core/widgets/blood_request_card.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/models/blood_request.dart';
import 'package:blood_setu/domain/models/blood_request_enums.dart';
import 'package:blood_setu/domain/models/interested_donor.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_requests_bloc.dart';
import '../bloc/my_requests_event.dart';
import '../bloc/my_requests_state.dart';

const List<String> _urgencies = ['CRITICAL', 'URGENT', 'NORMAL'];

String _daysAgo(DateTime? date) {
  if (date == null) return '—';
  final days = DateTime.now().difference(date).inDays;
  if (days == 0) return 'today';
  if (days == 1) return '1 day ago';
  return '$days days ago';
}

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
                      const MyRequestsEvent.refreshed(),
                    ),
              icon: const Icon(Icons.refresh, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
      body: BlocBuilder<MyRequestsBloc, MyRequestsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.error != null && state.requests.isEmpty) {
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
                    onPressed: () => context.read<MyRequestsBloc>().add(
                      const MyRequestsEvent.refreshed(),
                    ),
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
                    style: TextStyle(fontSize: 15, color: AppColors.textMuted),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.requests.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final req = state.requests[index];
              return _MyRequestCard(
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
        child: _MyRequestDetailSheet(request: request),
      ),
    );
  }
}

// ─── My Request Card ────────────────────────────────────────────────────────

class _MyRequestCard extends StatelessWidget {
  const _MyRequestCard({required this.request, required this.onTap});

  final BloodRequest request;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final urg =
        bloodRequestUrgencyConfig[request.urgency] ??
        bloodRequestUrgencyConfig['NORMAL']!;
    final isActive = request.status == RequestStatus.active;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border(left: BorderSide(color: urg.color, width: 4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: urg.bg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(urg.emoji, style: const TextStyle(fontSize: 10)),
                      const SizedBox(width: 6),
                      Text(
                        urg.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: urg.color,
                        ),
                      ),
                    ],
                  ),
                ),
                _StatusBadge(status: request.status),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.bloodGroup,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        height: 1,
                      ),
                    ),
                    const Text(
                      'Blood Needed',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        request.hospital,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 10,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Text(
                              request.address,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '🩸 ${request.units} units  •  👤 ${request.patientName}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '📅 Needed by: ${formatNeedBy(request.needBy)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: urg.color,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.touch_app_outlined,
                  size: 13,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  isActive
                      ? 'Tap to edit or see who\'s coming'
                      : 'Tap for details',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                const Spacer(),
                Text(
                  formatRequestDate(request.createdAt),
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    Color color;
    Color bg;
    String label;
    switch (status) {
      case RequestStatus.active:
        color = AppColors.success;
        bg = AppColors.successSurface;
        label = '● Active';
      case RequestStatus.fulfilled:
        color = AppColors.info;
        bg = AppColors.infoSurface;
        label = '✓ Fulfilled';
      case RequestStatus.cancelled:
        color = AppColors.textMuted;
        bg = AppColors.dividerLightest;
        label = '✗ Cancelled';
      case RequestStatus.expired:
        color = AppColors.warning;
        bg = AppColors.warningSurface;
        label = '⚠ Expired';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }
}

// ─── Detail Sheet ────────────────────────────────────────────────────────────

class _MyRequestDetailSheet extends StatelessWidget {
  const _MyRequestDetailSheet({required this.request});
  final BloodRequest request;

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final urg =
        bloodRequestUrgencyConfig[request.urgency] ??
        bloodRequestUrgencyConfig['NORMAL']!;
    final isActive = request.status == RequestStatus.active;

    return MultiBlocListener(
      listeners: [
        BlocListener<MyRequestsBloc, MyRequestsState>(
          listenWhen: (p, c) =>
              p.updateSuccess != c.updateSuccess && c.updateSuccess,
          listener: (context, state) {
            Navigator.of(context).pop();
            Utils.showSnackBar(
              context,
              content: 'Request updated successfully',
              color: AppColors.success,
            );
          },
        ),
        BlocListener<MyRequestsBloc, MyRequestsState>(
          listenWhen: (p, c) => p.deleteSuccess != c.deleteSuccess,
          listener: (context, _) {
            Navigator.of(context).pop();
            Utils.showSnackBar(
              context,
              content: 'Request deleted successfully',
              color: AppColors.success,
            );
          },
        ),
        BlocListener<MyRequestsBloc, MyRequestsState>(
          listenWhen: (p, c) => p.deleteFailed != c.deleteFailed,
          listener: (context, _) => Utils.showSnackBar(
            context,
            content: 'Failed to delete request. Please try again.',
            color: AppColors.primary,
          ),
        ),
      ],
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(24, 20, 24, bottomPad + 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.primarySurface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: AppColors.primaryBorder,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                request.bloodGroup,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primary,
                                  height: 1,
                                ),
                              ),
                              const Text(
                                'BLOOD',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textMuted,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'My Blood Request',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  _StatusBadge(status: request.status),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: urg.bg,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${urg.emoji} ${urg.label}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: urg.color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 1),
                    const SizedBox(height: 20),
                    _DetailRow(
                      icon: Icons.person_outline,
                      label: 'Patient',
                      value: request.patientName,
                    ),
                    _DetailRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Needed By',
                      value: formatNeedBy(request.needBy),
                      valueColor: urg.color,
                      valueBold: true,
                    ),
                    _DetailRow(
                      icon: Icons.local_hospital_outlined,
                      label: 'Hospital',
                      value: request.hospital,
                    ),
                    _DetailRow(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      value: request.address,
                    ),
                    _DetailRow(
                      icon: Icons.water_drop_outlined,
                      label: 'Units',
                      value:
                          '${request.units} unit${request.units > 1 ? 's' : ''}',
                    ),
                    _DetailRow(
                      icon: Icons.phone_outlined,
                      label: 'Contact',
                      value: request.contact,
                    ),
                    if (request.notes.isNotEmpty)
                      _DetailRow(
                        icon: Icons.notes_outlined,
                        label: 'Notes',
                        value: request.notes,
                      ),
                    _DetailRow(
                      icon: Icons.access_time_outlined,
                      label: 'Posted',
                      value: formatPosted(request.createdAt),
                    ),

                    // Owner actions
                    if (isActive) ...[
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _openEditSheet(context),
                              icon: const Icon(Icons.edit_outlined, size: 16),
                              label: const Text('Edit Request'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                elevation: 0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _confirmFulfilled(context),
                              icon: const Icon(
                                Icons.check_circle_outline,
                                size: 16,
                              ),
                              label: const Text('Mark Fulfilled'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.success,
                                side: const BorderSide(
                                  color: AppColors.success,
                                  width: 1.5,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    // Delete button (hidden when fulfilled)
                    if (request.status != RequestStatus.fulfilled) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _confirmDelete(context),
                          icon: const Icon(Icons.delete_outline, size: 16),
                          label: const Text('Delete Request'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side:
                                const BorderSide(color: Colors.red, width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],

                    // Who's Coming section
                    const SizedBox(height: 24),
                    const Divider(height: 1),
                    const SizedBox(height: 20),
                    BlocBuilder<MyRequestsBloc, MyRequestsState>(
                      buildWhen: (p, c) =>
                          p.interestedDonors != c.interestedDonors ||
                          p.isLoadingDonors != c.isLoadingDonors,
                      builder: (context, state) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Who's Coming",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (!state.isLoadingDonors)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primarySurface,
                                borderRadius: BorderRadius.circular(99),
                                border: Border.all(
                                  color: AppColors.primaryBorder,
                                ),
                              ),
                              child: Text(
                                '${state.interestedDonors.length} donor${state.interestedDonors.length != 1 ? 's' : ''}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<MyRequestsBloc, MyRequestsState>(
                      buildWhen: (p, c) =>
                          p.isLoadingDonors != c.isLoadingDonors ||
                          p.interestedDonors != c.interestedDonors ||
                          p.activeRequestId != c.activeRequestId,
                      builder: (context, state) {
                        if (state.activeRequestId != request.id) {
                          return const SizedBox.shrink();
                        }
                        if (state.isLoadingDonors) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        }
                        if (state.interestedDonors.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.dividerLightest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'No donors have responded yet.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: state.interestedDonors
                              .map((d) => _DonorCard(donor: d))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openEditSheet(BuildContext context) {
    final bloc = context.read<MyRequestsBloc>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: _EditRequestSheet(request: request),
      ),
    );
  }

  void _confirmFulfilled(BuildContext context) {
    final bloc = context.read<MyRequestsBloc>();
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Mark as Fulfilled?'),
        content: const Text(
          'This will close the request and remove it from the public list. You found your donor!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              Navigator.of(context).pop();
              bloc.add(MyRequestsEvent.requestFulfilled(request.id));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
            ),
            child: const Text('Yes, Fulfilled'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    final bloc = context.read<MyRequestsBloc>();
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Request?'),
        content: const Text(
          'This will permanently delete the request. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              bloc.add(MyRequestsEvent.requestDeleted(request.id));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ─── Donor Card (Who's Coming) ────────────────────────────────────────────────

class _DonorCard extends StatelessWidget {
  const _DonorCard({required this.donor});
  final InterestedDonor donor;

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
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              '💬 Message',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Detail Row ───────────────────────────────────────────────────────────────

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.valueBold = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final bool valueBold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.dividerLightest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 17, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: valueBold ? FontWeight.w700 : FontWeight.w500,
                    color: valueColor ?? AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Edit Request Sheet ───────────────────────────────────────────────────────

class _EditRequestSheet extends StatefulWidget {
  const _EditRequestSheet({required this.request});
  final BloodRequest request;

  @override
  State<_EditRequestSheet> createState() => _EditRequestSheetState();
}

class _EditRequestSheetState extends State<_EditRequestSheet> {
  late final TextEditingController _patientCtrl;
  late final TextEditingController _contactCtrl;
  late final TextEditingController _hospitalCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _notesCtrl;
  late String _urgency;
  late String _bloodGroup;
  late int _units;
  late DateTime _needBy;

  static const _bloodGroups = [
    'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-',
  ];

  @override
  void initState() {
    super.initState();
    _patientCtrl = TextEditingController(text: widget.request.patientName);
    _contactCtrl = TextEditingController(text: widget.request.contact);
    _hospitalCtrl = TextEditingController(text: widget.request.hospital);
    _addressCtrl = TextEditingController(text: widget.request.address);
    _notesCtrl = TextEditingController(text: widget.request.notes);
    _urgency = widget.request.urgency;
    _bloodGroup = widget.request.bloodGroup;
    _units = widget.request.units;
    _needBy = widget.request.needBy;
  }

  @override
  void dispose() {
    _patientCtrl.dispose();
    _contactCtrl.dispose();
    _hospitalCtrl.dispose();
    _addressCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return BlocConsumer<MyRequestsBloc, MyRequestsState>(
      listenWhen: (p, c) =>
          p.updateSuccess != c.updateSuccess && c.updateSuccess,
      listener: (context, state) => Navigator.of(context).pop(),
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 60),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24, 20, 24, bottomPad + 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Edit Request',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildLabel('Patient Name'),
                      _buildTextField(_patientCtrl, 'e.g. Rahim Ahmed'),
                      const SizedBox(height: 14),

                      _buildLabel('Blood Group'),
                      _buildBloodGroupSelector(),
                      const SizedBox(height: 14),

                      _buildLabel('Contact Number'),
                      _buildTextField(
                        _contactCtrl,
                        'e.g. 01XXXXXXXXX',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 14),

                      _buildLabel('Hospital / Clinic'),
                      _buildTextField(
                        _hospitalCtrl,
                        'e.g. Dhaka Medical College',
                      ),
                      const SizedBox(height: 14),

                      _buildLabel('Address'),
                      _buildTextField(_addressCtrl, 'Full address'),
                      const SizedBox(height: 14),

                      _buildLabel('Units Required'),
                      _buildUnitsStepper(),
                      const SizedBox(height: 14),

                      _buildLabel('Urgency'),
                      _buildUrgencySelector(),
                      const SizedBox(height: 14),

                      _buildLabel('Needed By'),
                      _buildDatePicker(context),
                      const SizedBox(height: 14),

                      _buildLabel('Notes (optional)'),
                      _buildTextField(
                        _notesCtrl,
                        'Any additional info',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),

                      if (state.updateError != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            state.updateError!,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 13,
                            ),
                          ),
                        ),

                      ElevatedButton(
                        onPressed: state.isUpdating
                            ? null
                            : () => _submit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: state.isUpdating
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      ),
    ),
  );

  Widget _buildTextField(
    TextEditingController ctrl,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) => TextField(
    controller: ctrl,
    keyboardType: keyboardType,
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
      filled: true,
      fillColor: AppColors.dividerLightest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    ),
  );

  Widget _buildUnitsStepper() => Row(
    children: [
      _StepperButton(
        icon: Icons.remove,
        onTap: () => setState(() => _units = math.max(1, _units - 1)),
      ),
      const SizedBox(width: 16),
      Text(
        '$_units unit${_units > 1 ? 's' : ''}',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      const SizedBox(width: 16),
      _StepperButton(
        icon: Icons.add,
        onTap: () => setState(() => _units = math.min(10, _units + 1)),
      ),
    ],
  );

  Widget _buildBloodGroupSelector() => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: _bloodGroups.map((bg) {
      final selected = _bloodGroup == bg;
      return GestureDetector(
        onTap: () => setState(() => _bloodGroup = bg),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(99),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.divider,
            ),
          ),
          child: Text(
            bg,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ),
      );
    }).toList(),
  );

  Widget _buildUrgencySelector() => Wrap(
    spacing: 8,
    children: _urgencies.map((u) {
      final urg = bloodRequestUrgencyConfig[u]!;
      final selected = _urgency == u;
      return ChoiceChip(
        label: Text('${urg.emoji} ${urg.label}'),
        selected: selected,
        onSelected: (_) => setState(() => _urgency = u),
        selectedColor: urg.bg,
        labelStyle: TextStyle(
          color: selected ? urg.color : AppColors.textSecondary,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          fontSize: 13,
        ),
        side: BorderSide(color: selected ? urg.color : AppColors.divider),
        backgroundColor: Colors.white,
      );
    }).toList(),
  );

  Widget _buildDatePicker(BuildContext context) => GestureDetector(
    onTap: () async {
      final picked = await showDatePicker(
        context: context,
        initialDate: _needBy.isAfter(DateTime.now())
            ? _needBy
            : DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );
      if (picked != null) setState(() => _needBy = picked);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.dividerLightest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_today_outlined,
            size: 18,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 10),
          Text(
            formatNeedBy(_needBy),
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ],
      ),
    ),
  );

  void _submit(BuildContext context) {
    final patientName = _patientCtrl.text.trim();
    final contact = _contactCtrl.text.trim();
    final hospital = _hospitalCtrl.text.trim();
    final address = _addressCtrl.text.trim();

    if (patientName.isEmpty || contact.isEmpty || hospital.isEmpty) {
      Utils.showSnackBar(
        context,
        content: 'Patient name, contact, and hospital are required.',
        color: AppColors.primary,
      );
      return;
    }

    context.read<MyRequestsBloc>().add(
      MyRequestsEvent.requestUpdated(
        id: widget.request.id,
        patientName: patientName,
        bloodGroup: _bloodGroup,
        contact: contact,
        hospital: hospital,
        address: address,
        urgency: _urgency,
        units: _units,
        needBy: _needBy,
        notes: _notesCtrl.text.trim(),
        latitude: widget.request.latitude,
        longitude: widget.request.longitude,
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryBorder),
        ),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}
