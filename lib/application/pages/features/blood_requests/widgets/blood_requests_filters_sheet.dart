import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/blood_requests_bloc.dart';
import '../bloc/blood_requests_event.dart';
import '../bloc/blood_requests_state.dart';
import 'blood_requests_header.dart';

const List<String> kBloodRequestUrgencies = [
  'All', 'CRITICAL', 'URGENT', 'NORMAL',
];

class BloodRequestsFiltersSheet extends StatelessWidget {
  const BloodRequestsFiltersSheet({super.key, required this.state});

  final BloodRequestsState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BloodRequestsBloc>();
    return Positioned.fill(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => bloc.add(const BloodRequestsEvent.filtersClosed()),
            child: Container(color: Colors.black.withValues(alpha: 0.4)),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Requests',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => bloc
                            .add(const BloodRequestsEvent.filtersClosed()),
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Blood Group',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: kBloodRequestBloodGroups.map((bg) {
                      final selected = state.selectedBloodGroup == bg;
                      return GestureDetector(
                        onTap: () => bloc
                            .add(BloodRequestsEvent.bloodGroupSelected(bg)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary
                                : AppColors.dividerLightest,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            bg,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Urgency',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: kBloodRequestUrgencies.map((u) {
                      final selected = state.selectedUrgency == u;
                      return GestureDetector(
                        onTap: () =>
                            bloc.add(BloodRequestsEvent.urgencySelected(u)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary
                                : AppColors.dividerLightest,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            u,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => bloc
                              .add(const BloodRequestsEvent.filtersReset()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.dividerLightest,
                            foregroundColor: AppColors.textSecondary,
                            padding:
                                const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => bloc.add(
                            const BloodRequestsEvent.filtersClosed(),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
