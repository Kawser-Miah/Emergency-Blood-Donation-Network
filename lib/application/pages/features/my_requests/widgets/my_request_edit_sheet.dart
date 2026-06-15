import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/blood_request_card.dart';
import '../../../../../domain/models/blood_request.dart';
import '../../../../../utils/utils.dart';
import '../bloc/my_requests_bloc.dart';
import '../bloc/my_requests_event.dart';
import '../bloc/my_requests_state.dart';

const List<String> kRequestUrgencies = ['CRITICAL', 'URGENT', 'NORMAL'];

class MyRequestEditSheet extends StatefulWidget {
  const MyRequestEditSheet({super.key, required this.request});

  final BloodRequest request;

  @override
  State<MyRequestEditSheet> createState() => _MyRequestEditSheetState();
}

class _MyRequestEditSheetState extends State<MyRequestEditSheet> {
  late final TextEditingController _patientCtrl;
  late final TextEditingController _contactCtrl;
  late final TextEditingController _hospitalCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _notesCtrl;
  late String _urgency;
  late String _bloodGroup;
  late int _units;
  late DateTime _needBy;

  static const _bloodGroups = [
    'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-',
  ];

  @override
  void initState() {
    super.initState();
    _patientCtrl =
        TextEditingController(text: widget.request.patientName);
    _contactCtrl =
        TextEditingController(text: widget.request.contact);
    _hospitalCtrl =
        TextEditingController(text: widget.request.hospital);
    _addressCtrl =
        TextEditingController(text: widget.request.address);
    _notesCtrl = TextEditingController(text: widget.request.notes);
    _urgency = widget.request.urgency;
    _bloodGroup = widget.request.bloodGroup;
    _units = widget.request.units;
    _needBy = widget.request.needBy;
  }

  @override
  void dispose() {
    _patientCtrl.dispose();
    _contactCtrl.dispose();
    _hospitalCtrl.dispose();
    _addressCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return BlocConsumer<MyRequestsBloc, MyRequestsState>(
      listenWhen: (p, c) =>
          p.updateSuccess != c.updateSuccess && c.updateSuccess,
      listener: (context, _) => Navigator.of(context).pop(),
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(top: 60),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
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
                      EdgeInsets.fromLTRB(24, 20, 24, bottomPad + 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Edit Request',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildLabel('Patient Name'),
                      _buildTextField(
                          _patientCtrl, 'e.g. Rahim Ahmed'),
                      const SizedBox(height: 14),
                      _buildLabel('Blood Group'),
                      _buildBloodGroupSelector(),
                      const SizedBox(height: 14),
                      _buildLabel('Contact Number'),
                      _buildTextField(
                        _contactCtrl,
                        'e.g. 01XXXXXXXXX',
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 14),
                      _buildLabel('Hospital / Clinic'),
                      _buildTextField(
                          _hospitalCtrl, 'e.g. Dhaka Medical College'),
                      const SizedBox(height: 14),
                      _buildLabel('Address'),
                      _buildTextField(_addressCtrl, 'Full address'),
                      const SizedBox(height: 14),
                      _buildLabel('Units Required'),
                      _buildUnitsStepper(),
                      const SizedBox(height: 14),
                      _buildLabel('Urgency'),
                      _buildUrgencySelector(),
                      const SizedBox(height: 14),
                      _buildLabel('Needed By'),
                      _buildDatePicker(context),
                      const SizedBox(height: 14),
                      _buildLabel('Notes (optional)'),
                      _buildTextField(
                        _notesCtrl,
                        'Any additional info',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),
                      if (state.updateError != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            state.updateError!,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ElevatedButton(
                        onPressed: state.isUpdating
                            ? null
                            : () => _submit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: state.isUpdating
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      );

  Widget _buildTextField(
    TextEditingController ctrl,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) =>
      TextField(
        controller: ctrl,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
              color: AppColors.textMuted, fontSize: 14),
          filled: true,
          fillColor: AppColors.dividerLightest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 12),
        ),
      );

  Widget _buildUnitsStepper() => Row(
        children: [
          MyRequestStepperButton(
            icon: Icons.remove,
            onTap: () =>
                setState(() => _units = math.max(1, _units - 1)),
          ),
          const SizedBox(width: 16),
          Text(
            '$_units unit${_units > 1 ? 's' : ''}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 16),
          MyRequestStepperButton(
            icon: Icons.add,
            onTap: () =>
                setState(() => _units = math.min(10, _units + 1)),
          ),
        ],
      );

  Widget _buildBloodGroupSelector() => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: _bloodGroups.map((bg) {
          final selected = _bloodGroup == bg;
          return GestureDetector(
            onTap: () => setState(() => _bloodGroup = bg),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                  color: selected
                      ? AppColors.primary
                      : AppColors.divider,
                ),
              ),
              child: Text(
                bg,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: selected
                      ? Colors.white
                      : AppColors.textSecondary,
                ),
              ),
            ),
          );
        }).toList(),
      );

  Widget _buildUrgencySelector() => Wrap(
        spacing: 8,
        children: kRequestUrgencies.map((u) {
          final urg = bloodRequestUrgencyConfig[u]!;
          final selected = _urgency == u;
          return ChoiceChip(
            label: Text('${urg.emoji} ${urg.label}'),
            selected: selected,
            onSelected: (_) => setState(() => _urgency = u),
            selectedColor: urg.bg,
            labelStyle: TextStyle(
              color:
                  selected ? urg.color : AppColors.textSecondary,
              fontWeight:
                  selected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 13,
            ),
            side: BorderSide(
                color:
                    selected ? urg.color : AppColors.divider),
            backgroundColor: Colors.white,
          );
        }).toList(),
      );

  Widget _buildDatePicker(BuildContext context) => GestureDetector(
        onTap: () async {
          final picked = await showDatePicker(
            context: context,
            initialDate: _needBy.isAfter(DateTime.now())
                ? _needBy
                : DateTime.now().add(const Duration(days: 1)),
            firstDate: DateTime.now(),
            lastDate:
                DateTime.now().add(const Duration(days: 365)),
          );
          if (picked != null) setState(() => _needBy = picked);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.dividerLightest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today_outlined,
                  size: 18, color: AppColors.textSecondary),
              const SizedBox(width: 10),
              Text(
                formatNeedBy(_needBy),
                style: const TextStyle(
                    fontSize: 14, color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      );

  void _submit(BuildContext context) {
    final patientName = _patientCtrl.text.trim();
    final contact = _contactCtrl.text.trim();
    final hospital = _hospitalCtrl.text.trim();
    final address = _addressCtrl.text.trim();

    if (patientName.isEmpty ||
        contact.isEmpty ||
        hospital.isEmpty) {
      Utils.showSnackBar(
        context,
        content:
            'Patient name, contact, and hospital are required.',
        color: AppColors.primary,
      );
      return;
    }

    context.read<MyRequestsBloc>().add(
          MyRequestsEvent.requestUpdated(
            id: widget.request.id,
            patientName: patientName,
            bloodGroup: _bloodGroup,
            contact: contact,
            hospital: hospital,
            address: address,
            urgency: _urgency,
            units: _units,
            needBy: _needBy,
            notes: _notesCtrl.text.trim(),
            latitude: widget.request.latitude,
            longitude: widget.request.longitude,
          ),
        );
  }
}

class MyRequestStepperButton extends StatelessWidget {
  const MyRequestStepperButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primaryBorder),
        ),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}
