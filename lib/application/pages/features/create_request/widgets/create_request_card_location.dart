import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/routing/routing_utils.dart';
import '../../../../core/theme/colors.dart';
import '../../map_picker/map_picker_screen.dart' show MapPickResult;
import '../bloc/create_request_bloc.dart';
import '../bloc/create_request_event.dart';
import '../bloc/create_request_state.dart';
import 'create_request_card.dart';
import 'create_request_input_field.dart';

class CreateRequestCardLocation extends StatefulWidget {
  const CreateRequestCardLocation({super.key, required this.state});

  final CreateRequestState state;

  @override
  State<CreateRequestCardLocation> createState() =>
      _CreateRequestCardLocationState();
}

class _CreateRequestCardLocationState
    extends State<CreateRequestCardLocation> {
  late final TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _addressController =
        TextEditingController(text: widget.state.address);
  }

  @override
  void didUpdateWidget(CreateRequestCardLocation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.address != oldWidget.state.address &&
        _addressController.text != widget.state.address) {
      _addressController.value = TextEditingValue(
        text: widget.state.address,
        selection: TextSelection.collapsed(
            offset: widget.state.address.length),
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
    return CreateRequestCard(
      title: '📍 Location Details',
      children: [
        CreateRequestInputField(
          icon: Icons.location_on_outlined,
          label: 'Hospital / Clinic Name *',
          hint: 'e.g. Dhaka Medical College Hospital',
          value: state.hospital,
          onChanged: (v) =>
              bloc.add(CreateRequestEvent.hospitalChanged(v)),
        ),
        CreateRequestInputFieldWithController(
          controller: _addressController,
          icon: Icons.location_on_outlined,
          label: 'Full Address',
          hint: 'Street, Area, City',
          onChanged: (v) =>
              bloc.add(CreateRequestEvent.addressChanged(v)),
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: state.isGpsLoading
                    ? null
                    : () => bloc.add(
                        const CreateRequestEvent.gpsLocationRequested()),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: state.isGpsLoading
                        ? AppColors.primaryBorder
                        : AppColors.dividerLightest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: AppColors.divider, width: 1.5),
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
                            Icon(Icons.near_me,
                                size: 14, color: AppColors.primary),
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
                    border: Border.all(
                        color: AppColors.divider, width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_on,
                          size: 14, color: AppColors.info),
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
