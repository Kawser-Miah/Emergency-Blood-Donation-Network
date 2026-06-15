import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/blood_requests_bloc.dart';
import '../bloc/blood_requests_event.dart';
import '../bloc/blood_requests_state.dart';

const List<String> kBloodRequestBloodGroups = [
  'All', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-',
];

class BloodRequestsHeader extends StatelessWidget {
  const BloodRequestsHeader({super.key, required this.state});

  final BloodRequestsState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BloodRequestsBloc>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        0,
        MediaQuery.of(context).padding.top + 4,
        0,
        8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Blood Requests',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${state.filtered.length} active requests',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.dividerLightest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider, width: 1.5),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      initialValue: state.search,
                      onChanged: (v) =>
                          bloc.add(BloodRequestsEvent.searchChanged(v)),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText:
                            'Search by patient, hospital, blood group...',
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (state.search.isNotEmpty)
                    GestureDetector(
                      onTap: () => bloc
                          .add(const BloodRequestsEvent.searchChanged('')),
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: AppColors.textMuted,
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ...kBloodRequestBloodGroups.take(5).map((bg) {
                  final selected = state.selectedBloodGroup == bg;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () => bloc
                          .add(BloodRequestsEvent.bloodGroupSelected(bg)),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              selected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(99),
                          border: selected
                              ? null
                              : Border.all(color: AppColors.divider),
                        ),
                        child: Text(
                          bg,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: selected
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                GestureDetector(
                  onTap: () =>
                      bloc.add(const BloodRequestsEvent.filtersOpened()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.tune,
                          size: 12,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
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
