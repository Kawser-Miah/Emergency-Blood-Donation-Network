import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/di.dart';
import '../../../../../utils/utils.dart';
import '../../../../core/theme/colors.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/routing/routing_utils.dart';
import '../../../../core/widgets/sparkle_loading_overlay.dart';
import '../../map_picker/map_picker_screen.dart' show MapPickResult;
import '../bloc/create_request_bloc.dart';
import '../bloc/create_request_event.dart';
import '../bloc/create_request_state.dart';

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

class _UrgencyOption {
  const _UrgencyOption({
    required this.id,
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.gradient,
    required this.textColor,
  });

  final String id;
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
  final List<Color>? gradient;
  final Color textColor;
}

const List<_UrgencyOption> _urgencyOptions = [
  _UrgencyOption(
    id: 'CRITICAL',
    emoji: '🔴',
    title: 'CRITICAL',
    subtitle: 'ICU, life-threatening',
    color: AppColors.primary,
    gradient: [AppColors.primaryDarker, AppColors.primary],
    textColor: Colors.white,
  ),
  _UrgencyOption(
    id: 'URGENT',
    emoji: '🟠',
    title: 'URGENT',
    subtitle: 'Emergency surgery',
    color: AppColors.warning,
    gradient: [AppColors.warningDark, AppColors.warning],
    textColor: Colors.white,
  ),
  _UrgencyOption(
    id: 'NORMAL',
    emoji: '🔵',
    title: 'NORMAL',
    subtitle: 'Elective / planned',
    color: AppColors.info,
    gradient: null,
    textColor: AppColors.info,
  ),
];

class CreateRequestScreen extends StatelessWidget {
  const CreateRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateRequestBloc>(),
      child: const _CreateRequestView(),
    );
  }
}

class _CreateRequestView extends StatelessWidget {
  const _CreateRequestView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateRequestBloc, CreateRequestState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == CreateRequestStatus.failure) {
          Utils.showSnackBar(
            context,
            content: state.errorMessage.isNotEmpty
                ? state.errorMessage
                : 'Please fix the errors and try again.',
            color: Colors.red.shade600,
          );
        } else if (state.status == CreateRequestStatus.success) {
          Utils.showSnackBar(
            context,
            content: 'Blood request posted successfully!',
            color: Colors.green.shade600,
          );
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              Column(
                children: [
                  _Header(
                    onBack: () {
                      Navigator.pop(context);
                    },
                    // context.read<AppNavigationBloc>().add(
                    //   const AppNavigationEvent.navigated(AppScreen.home),
                    // ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: SizedBox(
                        height: 4,
                        child: Stack(
                          children: [
                            Container(color: AppColors.primaryBorder),
                            FractionallySizedBox(
                              widthFactor: 0.6,
                              child: Container(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                      child: Column(
                        children: [
                          _CardPatientInfo(state: state),
                          const SizedBox(height: 16),
                          _CardLocation(state: state),
                          const SizedBox(height: 16),
                          _CardUrgency(state: state),
                          const SizedBox(height: 16),
                          _CardAdditional(state: state),
                          const SizedBox(height: 16),
                          _Confirmations(state: state),
                        ],
                      ),
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
                      onPressed: state.status == CreateRequestStatus.loading
                          ? null
                          : () => context.read<CreateRequestBloc>().add(
                              const CreateRequestEvent.requestSubmitted(),
                            ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        shadowColor: AppColors.primary.withOpacity(0.4),
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        '🩸 Post Blood Request',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (state.status == CreateRequestStatus.loading)
                const SparkleLoadingOverlay(),
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        16,
        MediaQuery.of(context).padding.top + 4,
        16,
        16,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            color: AppColors.textTertiary,
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Post Blood Request',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Help reach the right donors fast',
                  style: TextStyle(fontSize: 12, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.children});

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
            color: Colors.black.withOpacity(0.07),
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
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _DateTimePickerField extends StatelessWidget {
  const _DateTimePickerField({required this.value, required this.onPicked});

  final DateTime? value;
  final ValueChanged<DateTime> onPicked;

  String _format(DateTime dt) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour < 12 ? 'AM' : 'PM';
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}, $hour:$minute $period';
  }

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: value != null && value!.isAfter(now) ? value! : now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: Theme.of(
            ctx,
          ).colorScheme.copyWith(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (date == null || !context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: value != null
          ? TimeOfDay.fromDateTime(value!)
          : TimeOfDay.now(),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: Theme.of(
            ctx,
          ).colorScheme.copyWith(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (time == null) return;

    final picked = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    onPicked(picked);
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Need by (Date & Time) *',
            style: TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () => _pick(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.dividerLightest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.dividerLight, width: 1.5),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 16,
                    color: hasValue ? AppColors.primary : AppColors.textMuted,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      hasValue ? _format(value!) : 'Select date and time',
                      style: TextStyle(
                        fontSize: 14,
                        color: hasValue
                            ? AppColors.textPrimary
                            : AppColors.textMuted,
                      ),
                    ),
                  ),
                  if (hasValue)
                    const Icon(
                      Icons.edit_outlined,
                      size: 14,
                      color: AppColors.textMuted,
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

class _InputField extends StatelessWidget {
  const _InputField({
    required this.icon,
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged,
    this.keyboardType,
  });

  final IconData icon;
  final String label;
  final String hint;
  final String value;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.dividerLightest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.dividerLight, width: 1.5),
            ),
            child: Row(
              children: [
                Icon(icon, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    initialValue: value,
                    onChanged: onChanged,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: hint,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
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

class _InputFieldWithController extends StatelessWidget {
  const _InputFieldWithController({
    required this.controller,
    required this.icon,
    required this.label,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final IconData icon;
  final String label;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.dividerLightest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.dividerLight, width: 1.5),
            ),
            child: Row(
              children: [
                Icon(icon, size: 16, color: AppColors.textMuted),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    onChanged: onChanged,
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      hintText: hint,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
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

class _CardPatientInfo extends StatelessWidget {
  const _CardPatientInfo({required this.state});

  final CreateRequestState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateRequestBloc>();
    return _Card(
      title: '🏥 Patient Information',
      children: [
        _InputField(
          icon: Icons.person_outline,
          label: 'Patient Name *',
          hint: "Patient's full name",
          value: state.patientName,
          onChanged: (v) => bloc.add(CreateRequestEvent.patientNameChanged(v)),
        ),
        const Text(
          'Blood Group Needed *',
          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _bloodGroups.map((bg) {
            final selected = state.bloodGroup == bg;
            return GestureDetector(
              onTap: () => bloc.add(CreateRequestEvent.bloodGroupChanged(bg)),
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
                    color: selected ? AppColors.primary : AppColors.divider,
                    width: 2,
                  ),
                ),
                child: Text(
                  bg,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: selected ? Colors.white : AppColors.textTertiary,
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
                child: const Icon(Icons.add, size: 16, color: Colors.white),
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

class _CardLocation extends StatefulWidget {
  const _CardLocation({required this.state});

  final CreateRequestState state;

  @override
  State<_CardLocation> createState() => _CardLocationState();
}

class _CardLocationState extends State<_CardLocation> {
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.state.address);
  }

  @override
  void didUpdateWidget(_CardLocation oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Sync controller when GPS fills in the address from outside the field.
    if (widget.state.address != oldWidget.state.address &&
        _addressController.text != widget.state.address) {
      _addressController.value = TextEditingValue(
        text: widget.state.address,
        selection: TextSelection.collapsed(offset: widget.state.address.length),
      );
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _openMapPicker(
    BuildContext context,
    CreateRequestBloc bloc,
  ) async {
    final result = await context.pushNamed<MapPickResult>(
      PAGES.mapPicker.screenName,
      extra: (
        initialLat: widget.state.latitude,
        initialLng: widget.state.longitude,
      ),
    );
    if (result != null) {
      bloc.add(
        CreateRequestEvent.mapLocationPicked(
          lat: result.lat,
          lng: result.lng,
          address: result.address,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateRequestBloc>();
    final state = widget.state;
    return _Card(
      title: '📍 Location Details',
      children: [
        _InputField(
          icon: Icons.location_on_outlined,
          label: 'Hospital / Clinic Name *',
          hint: 'e.g. Dhaka Medical College Hospital',
          value: state.hospital,
          onChanged: (v) => bloc.add(CreateRequestEvent.hospitalChanged(v)),
        ),
        _InputFieldWithController(
          controller: _addressController,
          icon: Icons.location_on_outlined,
          label: 'Full Address',
          hint: 'Street, Area, City',
          onChanged: (v) => bloc.add(CreateRequestEvent.addressChanged(v)),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: state.isGpsLoading
                    ? null
                    : () => bloc.add(
                        const CreateRequestEvent.gpsLocationRequested(),
                      ),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: state.isGpsLoading
                        ? AppColors.primaryBorder
                        : AppColors.dividerLightest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider, width: 1.5),
                  ),
                  child: state.isGpsLoading
                      ? const Center(
                          child: SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.near_me,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Use my GPS',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => _openMapPicker(context, bloc),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.dividerLightest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_on, size: 14, color: AppColors.info),
                      SizedBox(width: 8),
                      Text(
                        'Pick on map',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CardUrgency extends StatelessWidget {
  const _CardUrgency({required this.state});

  final CreateRequestState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateRequestBloc>();
    return _Card(
      title: '⚡ Urgency & Timing',
      children: [
        const Text(
          'Urgency Level *',
          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
        const SizedBox(height: 10),
        Column(
          children: _urgencyOptions.map((opt) {
            final selected = state.urgency == opt.id;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () =>
                    bloc.add(CreateRequestEvent.urgencyChanged(opt.id)),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? (opt.gradient == null ? Colors.transparent : null)
                        : AppColors.dividerLightest,
                    gradient: selected && opt.gradient != null
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: opt.gradient!,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(16),
                    border: !selected
                        ? Border.all(
                            color: opt.color.withOpacity(0.13),
                            width: 2,
                          )
                        : null,
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: opt.color.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Text(opt.emoji, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              opt.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: selected ? opt.textColor : opt.color,
                              ),
                            ),
                            Text(
                              opt.subtitle,
                              style: TextStyle(
                                fontSize: 11,
                                color: selected
                                    ? opt.textColor.withOpacity(0.8)
                                    : AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (selected)
                        Icon(Icons.check, size: 18, color: opt.textColor),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        _DateTimePickerField(
          value: state.needBy,
          onPicked: (dt) => bloc.add(CreateRequestEvent.needByChanged(dt)),
        ),
        _InputField(
          icon: Icons.phone_outlined,
          label: 'Contact Number *',
          hint: '01X-XXXXXXXX',
          value: state.contact,
          keyboardType: TextInputType.phone,
          onChanged: (v) => bloc.add(CreateRequestEvent.contactChanged(v)),
        ),
      ],
    );
  }
}

class _CardAdditional extends StatelessWidget {
  const _CardAdditional({required this.state});

  final CreateRequestState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateRequestBloc>();
    return _Card(
      title: '📝 Additional Information',
      children: [
        const Text(
          'Notes (Optional)',
          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.dividerLightest,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.dividerLight, width: 1.5),
          ),
          child: TextFormField(
            initialValue: state.notes,
            onChanged: (v) => bloc.add(CreateRequestEvent.notesChanged(v)),
            maxLines: 3,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText:
                  'e.g. Patient on 3rd floor, ICU, Room 305. Please bring ID.',
            ),
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _Confirmations extends StatelessWidget {
  const _Confirmations({required this.state});

  final CreateRequestState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateRequestBloc>();
    final items = [
      _ConfirmItem(
        text: 'I confirm this is a genuine blood request',
        value: state.confirmed1,
        onTap: () => bloc.add(const CreateRequestEvent.confirmed1Toggled()),
      ),
      _ConfirmItem(
        text: 'I have permission to receive blood for this patient',
        value: state.confirmed2,
        onTap: () => bloc.add(const CreateRequestEvent.confirmed2Toggled()),
      ),
    ];
    return Column(
      children: items.map((it) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: it.onTap,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(top: 2, right: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: it.value ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: it.value
                            ? AppColors.primary
                            : AppColors.textDisabled,
                        width: 2,
                      ),
                    ),
                    child: it.value
                        ? const Icon(Icons.check, size: 12, color: Colors.white)
                        : null,
                  ),
                  Expanded(
                    child: Text(
                      it.text,
                      style: const TextStyle(
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
        );
      }).toList(),
    );
  }
}

class _ConfirmItem {
  const _ConfirmItem({
    required this.text,
    required this.value,
    required this.onTap,
  });

  final String text;
  final bool value;
  final VoidCallback onTap;
}
