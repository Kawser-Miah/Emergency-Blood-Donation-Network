import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/create_request_bloc.dart';
import '../bloc/create_request_event.dart';
import '../bloc/create_request_state.dart';
import 'create_request_card.dart';
import 'create_request_input_field.dart';
import 'create_request_options.dart';

class CreateRequestCardPatient extends StatelessWidget {
  const CreateRequestCardPatient({super.key, required this.state});

  final CreateRequestState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateRequestBloc>();
    return CreateRequestCard(
      title: '🏥 Patient Information',
      children: [
        CreateRequestInputField(
          icon: Icons.person_outline,
          label: 'Patient Name *',
          hint: "Patient's full name",
          value: state.patientName,
          onChanged: (v) =>
              bloc.add(CreateRequestEvent.patientNameChanged(v)),
        ),
        const Text(
          'Blood Group Needed *',
          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: kBloodGroups.map((bg) {
            final selected = state.bloodGroup == bg;
            return GestureDetector(
              onTap: () =>
                  bloc.add(CreateRequestEvent.bloodGroupChanged(bg)),
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
                  border: Border.all(
                    color:
                        selected ? AppColors.primary : AppColors.divider,
                    width: 2,
                  ),
                ),
                child: Text(
                  bg,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color:
                        selected ? Colors.white : AppColors.textTertiary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        const Text(
          'Units Needed *',
          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            GestureDetector(
              onTap: () =>
                  bloc.add(const CreateRequestEvent.unitsDecremented()),
              child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.dividerLightest,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.divider, width: 1.5),
                ),
                child: const Icon(
                  Icons.remove,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 32,
              child: Text(
                '${state.units}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () =>
                  bloc.add(const CreateRequestEvent.unitsIncremented()),
              child: Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child:
                    const Icon(Icons.add, size: 16, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'unit${state.units > 1 ? 's' : ''}',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
