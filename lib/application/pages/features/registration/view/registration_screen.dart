import 'package:blood_setu/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../utils/utils.dart';
import '../../../../core/constants/bangladesh_locations.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/registration_header_widget.dart';
import '../../../../core/widgets/registration_progress_widget.dart';
import '../../../../core/widgets/sparkle_loading_overlay.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_event.dart';
import '../bloc/registration_state.dart';

const List<String> _genders = ['Male', 'Female', 'Other'];

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
      create: (_) => getIt<RegistrationBloc>(),
      child: const _RegistrationView(),
    );
  }
}

class _RegistrationView extends StatelessWidget {
  const _RegistrationView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == RegistrationStatus.failure) {
          Utils.showSnackBar(
            context,
            content: state.errorMessage.isNotEmpty
                ? state.errorMessage
                : 'Registration failed. Please try again.',
            color: Colors.red.shade600,
          );
        } else if (state.status == RegistrationStatus.success) {
          Utils.showSnackBar(
            context,
            content: 'Registration successful!',
            color: Colors.green,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state.status == RegistrationStatus.loading;
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
                      onPressed: isLoading
                          ? null
                          : () {
                              if (state.step == 1) {
                                context.read<RegistrationBloc>().add(
                                  const RegistrationEvent.nextStep(),
                                );
                              } else {
                                context.read<RegistrationBloc>().add(
                                  const RegistrationEvent.registrationSubmitted(),
                                );
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
                        shadowColor: AppColors.primary.withValues(alpha: 0.3),
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
              if (isLoading) const SparkleLoadingOverlay(),
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
            color: Colors.black.withValues(alpha: 0.06),
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
              items: _genders
                  .map(
                    (g) => DropdownMenuItem(
                      value: g,
                      child: Text(g),
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  bloc.add(RegistrationEvent.genderChanged(v));
                }
              },
            ),
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
        _FormField(
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
          child: GestureDetector(
            onTap: () async {
              final picked = await _showSelectionSheet(
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
                    state.district.isEmpty ? 'Select district' : state.district,
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
        _FormField(
          icon: Icons.location_on_outlined,
          label: 'Thana/Upazila *',
          child: GestureDetector(
            onTap: state.district.isEmpty
                ? null
                : () async {
                    final picked = await _showSelectionSheet(
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

Future<String?> _showSelectionSheet(
  BuildContext context, {
  required String title,
  required List<String> items,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _SelectionSheet(title: title, items: items),
  );
}

class _SelectionSheet extends StatefulWidget {
  const _SelectionSheet({required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  State<_SelectionSheet> createState() => _SelectionSheetState();
}

class _SelectionSheetState extends State<_SelectionSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = _query.isEmpty
        ? widget.items
        : widget.items
              .where((e) => e.toLowerCase().contains(_query.toLowerCase()))
              .toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Drag handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Title row
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primary,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.items.length} options',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            // Search field
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: AppColors.dividerLightest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: AppColors.textMuted,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (v) => setState(() => _query = v),
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search option...',
                          hintStyle: TextStyle(color: AppColors.textMuted),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // List
            Expanded(
              child: ListView.separated(
                controller: controller,
                itemCount: filtered.length,
                separatorBuilder: (context, i) => const Divider(
                  height: 1,
                  indent: 20,
                  endIndent: 20,
                  color: AppColors.dividerLight,
                ),
                itemBuilder: (_, i) => InkWell(
                  onTap: () => Navigator.pop(context, filtered[i]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            filtered[i],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right,
                          color: AppColors.primary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
