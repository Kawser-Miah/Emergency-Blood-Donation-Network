import 'package:blood_setu/application/core/theme/colors.dart';
import 'package:blood_setu/application/core/widgets/blood_request_card.dart';
import 'package:blood_setu/domain/models/blood_request.dart';
import 'package:blood_setu/domain/models/blood_request_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/my_interests_bloc.dart';
import '../bloc/my_interests_event.dart';
import '../bloc/my_interests_state.dart';

class MyInterestDetailSheet extends StatelessWidget {
  const MyInterestDetailSheet({super.key, required this.request});

  final BloodRequest request;

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final urg =
        bloodRequestUrgencyConfig[request.urgency] ??
        bloodRequestUrgencyConfig['NORMAL']!;

    return BlocListener<MyInterestsBloc, MyInterestsState>(
      listenWhen: (p, c) => p.withdrawSuccess != c.withdrawSuccess,
      listener: (context, _) => Navigator.of(context).pop(),
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
                                'Blood Request',
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
                    const SizedBox(height: 8),
                    const Divider(height: 1),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.successSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 18,
                            color: AppColors.success,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "You've marked yourself as coming for this request.",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.success,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<MyInterestsBloc, MyInterestsState>(
                      buildWhen: (p, c) => p.withdrawingId != c.withdrawingId,
                      builder: (context, state) {
                        final isWithdrawing =
                            state.withdrawingId == request.id;
                        return SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: isWithdrawing
                                ? null
                                : () => _confirmWithdraw(context),
                            icon: isWithdrawing
                                ? const SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.textMuted,
                                    ),
                                  )
                                : const Icon(Icons.cancel_outlined, size: 16),
                            label: Text(
                              isWithdrawing
                                  ? 'Withdrawing...'
                                  : 'Withdraw Interest',
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(
                                color: Colors.red,
                                width: 1.5,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
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

  void _confirmWithdraw(BuildContext context) {
    final bloc = context.read<MyInterestsBloc>();
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Withdraw Interest?'),
        content: const Text(
          'Your name will be removed from the donor list for this request. You can always show interest again later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              bloc.add(MyInterestsEvent.withdrawRequested(request.id));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Withdraw'),
          ),
        ],
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
