import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/blood_request_card.dart';
import '../../../../../di/di.dart';
import '../../../../../domain/models/blood_request.dart';
import '../../../../../domain/models/blood_request_enums.dart';
import '../../../../../utils/utils.dart';
import '../../../../core/auth/auth_controller.dart';
import '../bloc/my_requests_bloc.dart';
import '../bloc/my_requests_event.dart';
import '../bloc/my_requests_state.dart';
import 'my_request_detail_row.dart';
import 'my_request_donor_card.dart';
import 'my_request_edit_sheet.dart';
import 'my_request_status_badge.dart';

class MyRequestDetailSheet extends StatelessWidget {
  const MyRequestDetailSheet({super.key, required this.request});

  final BloodRequest request;

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final urg = bloodRequestUrgencyConfig[request.urgency] ??
        bloodRequestUrgencyConfig['NORMAL']!;
    final isActive = request.status == RequestStatus.active;
    final isExpired = request.status == RequestStatus.expired;

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
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(24)),
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
                padding:
                    EdgeInsets.fromLTRB(24, 20, 24, bottomPad + 24),
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
                            mainAxisAlignment:
                                MainAxisAlignment.center,
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
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
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
                                  MyRequestStatusBadge(
                                      status: request.status),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: urg.bg,
                                      borderRadius:
                                          BorderRadius.circular(8),
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
                    MyRequestDetailRow(
                      icon: Icons.person_outline,
                      label: 'Patient',
                      value: request.patientName,
                    ),
                    MyRequestDetailRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Needed By',
                      value: formatNeedBy(request.needBy),
                      valueColor: urg.color,
                      valueBold: true,
                    ),
                    MyRequestDetailRow(
                      icon: Icons.local_hospital_outlined,
                      label: 'Hospital',
                      value: request.hospital,
                    ),
                    MyRequestDetailRow(
                      icon: Icons.location_on_outlined,
                      label: 'Location',
                      value: request.address,
                    ),
                    MyRequestDetailRow(
                      icon: Icons.water_drop_outlined,
                      label: 'Units',
                      value:
                          '${request.units} unit${request.units > 1 ? 's' : ''}',
                    ),
                    MyRequestDetailRow(
                      icon: Icons.phone_outlined,
                      label: 'Contact',
                      value: request.contact,
                    ),
                    if (request.notes.isNotEmpty)
                      MyRequestDetailRow(
                        icon: Icons.notes_outlined,
                        label: 'Notes',
                        value: request.notes,
                      ),
                    MyRequestDetailRow(
                      icon: Icons.access_time_outlined,
                      label: 'Posted',
                      value: formatPosted(request.createdAt),
                    ),

                    if (isActive || isExpired) ...[
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          if (isActive) ...[
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    _openEditSheet(context),
                                icon: const Icon(
                                    Icons.edit_outlined,
                                    size: 16),
                                label:
                                    const Text('Edit Request'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding:
                                      const EdgeInsets.symmetric(
                                          vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(14),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () =>
                                  _confirmFulfilled(context),
                              icon: const Icon(
                                Icons.check_circle_outline,
                                size: 16,
                              ),
                              label:
                                  const Text('Mark Fulfilled'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.success,
                                side: const BorderSide(
                                  color: AppColors.success,
                                  width: 1.5,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(
                                        vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    if (request.status != RequestStatus.fulfilled) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => _confirmDelete(context),
                          icon: const Icon(Icons.delete_outline,
                              size: 16),
                          label: const Text('Delete Request'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(
                                color: Colors.red, width: 1.5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),
                    const Divider(height: 1),
                    const SizedBox(height: 20),
                    BlocBuilder<MyRequestsBloc, MyRequestsState>(
                      buildWhen: (p, c) =>
                          p.interestedDonors !=
                              c.interestedDonors ||
                          p.isLoadingDonors != c.isLoadingDonors,
                      builder: (context, state) => Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
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
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primarySurface,
                                borderRadius:
                                    BorderRadius.circular(99),
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
                          p.isLoadingDonors !=
                              c.isLoadingDonors ||
                          p.interestedDonors !=
                              c.interestedDonors ||
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
                              borderRadius:
                                  BorderRadius.circular(12),
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
                              .map(
                                (d) => MyRequestDonorCard(
                                  donor: d,
                                  requestId: request.id,
                                  currentUid: getIt<AuthController>()
                                          .user
                                          ?.uid ??
                                      '',
                                ),
                              )
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
        child: MyRequestEditSheet(request: request),
      ),
    );
  }

  void _confirmFulfilled(BuildContext context) {
    final bloc = context.read<MyRequestsBloc>();
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
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
              bloc.add(
                  MyRequestsEvent.requestFulfilled(request.id));
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
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
              bloc.add(
                  MyRequestsEvent.requestDeleted(request.id));
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
