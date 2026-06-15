import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/bangladesh_locations.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart';
import 'registration_card_wrapper.dart';
import 'registration_form_field.dart';
import 'registration_selection_sheet.dart';

class RegistrationStep2 extends StatelessWidget {
  const RegistrationStep2({
    super.key,
    required this.state,
    this.isEditMode = false,
  });

  final RegistrationState state;
  final bool isEditMode;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();
    final availableThanas = state.district.isNotEmpty
        ? (thanasByDistrict[state.district] ?? const <String>[])
        : const <String>[];

    return RegistrationCardWrapper(
      title: 'Location & Contact',
      children: [
        RegistrationFormField(
          icon: Icons.location_on_outlined,
          label: 'District *',
          child: GestureDetector(
            onTap: () async {
              final picked = await showRegistrationSelectionSheet(
                context,
                title: 'Select District',
                items: bangladeshDistricts,
              );
              if (picked != null) {
                bloc.add(RegistrationEvent.districtChanged(picked));
              }
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    state.district.isEmpty
                        ? 'Select district'
                        : state.district,
                    style: TextStyle(
                      fontSize: 14,
                      color: state.district.isEmpty
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
        RegistrationFormField(
          icon: Icons.location_on_outlined,
          label: 'Thana/Upazila *',
          child: GestureDetector(
            onTap: state.district.isEmpty
                ? null
                : () async {
                    final picked = await showRegistrationSelectionSheet(
                      context,
                      title: 'Select Thana',
                      items: availableThanas,
                    );
                    if (picked != null) {
                      bloc.add(RegistrationEvent.thanaChanged(picked));
                    }
                  },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    state.thana.isEmpty ? 'Select thana' : state.thana,
                    style: TextStyle(
                      fontSize: 14,
                      color: state.thana.isEmpty
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
        RegistrationFormField(
          icon: Icons.chat_bubble_outline,
          label: 'Facebook Messenger ID (Optional)',
          child: TextFormField(
            initialValue: state.fbId,
            onChanged: (v) => bloc.add(RegistrationEvent.fbIdChanged(v)),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: '@your.messenger.id',
            ),
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ),
        if (!isEditMode)
          InkWell(
            onTap: () =>
                bloc.add(const RegistrationEvent.confirmedToggled()),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(top: 2, right: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color:
                          state.confirmed ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: state.confirmed
                            ? AppColors.primary
                            : AppColors.textDisabled,
                        width: 2,
                      ),
                    ),
                    child: state.confirmed
                        ? const Icon(Icons.check, size: 12, color: Colors.white)
                        : null,
                  ),
                  const Expanded(
                    child: Text(
                      'I confirm I have no medical restrictions that prevent blood donation',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
