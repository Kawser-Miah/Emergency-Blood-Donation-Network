import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/mock_data.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/registration_header_widget.dart';
import '../../../../core/widgets/registration_progress_widget.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart';

const List<String> _bloodGroups = [
  'A+',
  'A-',
  'B+',
  'B-',
  'O+',
  'O-',
  'AB+',
  'AB-',
];

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationBloc(),
      child: const _RegistrationView(),
    );
  }
}

class _RegistrationView extends StatelessWidget {
  const _RegistrationView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              Column(
                children: [
                  const RegistrationHeaderWidget(),
                  RegistrationProgressWidget(
                    step: state.step,
                    onStepTap: (_) => context.read<RegistrationBloc>().add(
                      const RegistrationEvent.previousStep(),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                      child: state.step == 1
                          ? _Step1(state: state)
                          : _Step2(state: state),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    border: Border(top: BorderSide(color: AppColors.divider)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.step == 1) {
                          context.read<RegistrationBloc>().add(
                            const RegistrationEvent.nextStep(),
                          );
                        } else {
                          getIt<AuthController>().onProfileCompleted();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        shadowColor: AppColors.primary.withOpacity(0.3),
                      ),
                      child: Text(
                        state.step == 1
                            ? 'Continue →'
                            : 'Complete Registration',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CardWrapper extends StatelessWidget {
  const _CardWrapper({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.icon,
    required this.label,
    required this.child,
  });

  final IconData icon;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.dividerLightest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(icon, size: 18, color: AppColors.primary),
                const SizedBox(width: 12),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Step1 extends StatelessWidget {
  const _Step1({required this.state});
  final RegistrationState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();
    return _CardWrapper(
      title: 'Personal Information',
      children: [
        _FormField(
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
        _FormField(
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
        _FormField(
          icon: Icons.water_drop_outlined,
          label: 'Blood Group *',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _bloodGroups.map((bg) {
              final selected = state.bloodGroup == bg;
              return GestureDetector(
                onTap: () => bloc.add(RegistrationEvent.bloodGroupChanged(bg)),
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
                      color: selected ? Colors.white : AppColors.textTertiary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        _FormField(
          icon: Icons.calendar_today_outlined,
          label: 'Age (18-60) *',
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
        _FormField(
          icon: Icons.calendar_today_outlined,
          label: 'Last Donation Date',
          child: TextFormField(
            initialValue: state.lastDonation,
            onChanged: (v) =>
                bloc.add(RegistrationEvent.lastDonationChanged(v)),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: 'Optional if first time',
            ),
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}

class _Step2 extends StatelessWidget {
  const _Step2({required this.state});
  final RegistrationState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegistrationBloc>();
    final availableThanas = state.district.isNotEmpty
        ? (thanasByDistrict[state.district] ?? const <String>[])
        : const <String>[];

    return _CardWrapper(
      title: 'Location & Contact',
      children: [
        _FormField(
          icon: Icons.location_on_outlined,
          label: 'District *',
          child: DropdownButton<String>(
            value: state.district.isEmpty ? null : state.district,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            hint: const Text(
              'Select district',
              style: TextStyle(fontSize: 14, color: AppColors.textMuted),
            ),
            items: bangladeshDistricts
                .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                .toList(),
            onChanged: (v) {
              if (v != null) bloc.add(RegistrationEvent.districtChanged(v));
            },
          ),
        ),
        _FormField(
          icon: Icons.location_on_outlined,
          label: 'Thana/Upazila *',
          child: DropdownButton<String>(
            value: state.thana.isEmpty ? null : state.thana,
            isExpanded: true,
            underline: const SizedBox.shrink(),
            hint: const Text(
              'Select thana',
              style: TextStyle(fontSize: 14, color: AppColors.textMuted),
            ),
            items: availableThanas
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: state.district.isEmpty
                ? null
                : (v) {
                    if (v != null) bloc.add(RegistrationEvent.thanaChanged(v));
                  },
          ),
        ),
        _FormField(
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
        InkWell(
          onTap: () => bloc.add(const RegistrationEvent.confirmedToggled()),
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
                    color: state.confirmed ? AppColors.primary : Colors.white,
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
