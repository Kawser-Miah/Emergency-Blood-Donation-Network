import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart';
import 'registration_card_wrapper.dart';
import 'registration_form_field.dart';

const List<String> kRegistrationGenders = ['Male', 'Female', 'Other'];

const List<String> kRegistrationBloodGroups = [
  'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-',
];

class RegistrationStep1 extends StatelessWidget {
  const RegistrationStep1({super.key, required this.state});

  final RegistrationState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();
    return RegistrationCardWrapper(
      title: 'Personal Information',
      children: [
        RegistrationFormField(
          icon: Icons.person_outline,
          label: 'Full Name',
          child: TextFormField(
            initialValue: state.fullName,
            onChanged: (v) => bloc.add(RegistrationEvent.fullNameChanged(v)),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: 'Your full name',
            ),
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ),
        RegistrationFormField(
          icon: Icons.wc_outlined,
          label: 'Gender *',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: state.gender.isEmpty ? null : state.gender,
              isDense: true,
              isExpanded: true,
              hint: const Text(
                'Select gender',
                style: TextStyle(fontSize: 14, color: AppColors.textMuted),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: AppColors.textMuted,
              ),
              items: kRegistrationGenders
                  .map(
                    (g) => DropdownMenuItem(value: g, child: Text(g)),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) bloc.add(RegistrationEvent.genderChanged(v));
              },
            ),
          ),
        ),
        RegistrationFormField(
          icon: Icons.phone_outlined,
          label: 'Phone Number *',
          child: TextFormField(
            initialValue: state.phone,
            onChanged: (v) => bloc.add(RegistrationEvent.phoneChanged(v)),
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: '01X-XXXXXXXX',
            ),
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ),
        RegistrationFormField(
          icon: Icons.water_drop_outlined,
          label: 'Blood Group *',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: kRegistrationBloodGroups.map((bg) {
              final selected = state.bloodGroup == bg;
              return GestureDetector(
                onTap: () =>
                    bloc.add(RegistrationEvent.bloodGroupChanged(bg)),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.primary
                        : AppColors.dividerLightest,
                    borderRadius: BorderRadius.circular(99),
                    border: selected
                        ? null
                        : Border.all(color: AppColors.divider),
                  ),
                  child: Text(
                    bg,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color:
                          selected ? Colors.white : AppColors.textTertiary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        RegistrationFormField(
          icon: Icons.calendar_today_outlined,
          label: 'Age (14-65) *',
          child: TextFormField(
            initialValue: state.age,
            onChanged: (v) => bloc.add(RegistrationEvent.ageChanged(v)),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: 'Your age',
            ),
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ),
        RegistrationFormField(
          icon: Icons.calendar_today_outlined,
          label: 'Last Donation Date',
          child: GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                builder: (context, child) => Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.primary,
                      onPrimary: Colors.white,
                      surface: Colors.white,
                      onSurface: AppColors.textPrimary,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
                    ),
                    textTheme: const TextTheme().apply(
                      fontFamily: AppColors.fontFamily,
                    ),
                  ),
                  child: child!,
                ),
              );
              if (picked != null) {
                bloc.add(RegistrationEvent.lastDonationChanged(picked));
              }
            },
            child: Text(
              state.lastDonation == null
                  ? 'Optional if first time'
                  : '${state.lastDonation!.day.toString().padLeft(2, '0')}/${state.lastDonation!.month.toString().padLeft(2, '0')}/${state.lastDonation!.year}',
              style: TextStyle(
                fontSize: 14,
                color: state.lastDonation == null
                    ? AppColors.textMuted
                    : AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
