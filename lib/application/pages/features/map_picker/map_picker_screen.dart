import 'dart:async';

import 'package:blood_setu/application/core/theme/colors.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/usecase/location_usecase.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

typedef MapPickResult = ({double lat, double lng, String address});

const _kDhaka = LatLng(23.8103, 90.4125);

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key, this.initialLat, this.initialLng});

  final double? initialLat;
  final double? initialLng;

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late final MapController _mapController;
  late LatLng _center;

  String _addressPreview = '';
  bool _isGeocoding = false;
  bool _isLocating = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _center = widget.initialLat != null && widget.initialLng != null
        ? LatLng(widget.initialLat!, widget.initialLng!)
        : _kDhaka;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scheduleGeocode(_center),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _mapController.dispose();
    super.dispose();
  }

  void _onMapEvent(MapEvent event) {
    if (event is MapEventMove) {
      _center = event.camera.center;
      _scheduleGeocode(_center);
    }
  }

  void _scheduleGeocode(LatLng center) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      _geocode(center);
    });
  }

  Future<void> _geocode(LatLng center) async {
    setState(() => _isGeocoding = true);
    final result = await getIt<LocationUseCase>()
        .getAddressFromCoordinates(center.latitude, center.longitude);
    if (!mounted) return;
    setState(() {
      _isGeocoding = false;
      _addressPreview = result.fold((_) => '', (data) => data.address);
    });
  }

  void _confirm() {
    context.pop<MapPickResult>(
      (lat: _center.latitude, lng: _center.longitude, address: _addressPreview),
    );
  }

  Future<void> _goToMyLocation() async {
    if (_isLocating) return;
    setState(() => _isLocating = true);

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showLocationError('Location services are disabled.');
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _showLocationError('Location permission denied.');
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );

      if (!mounted) return;
      _mapController.move(LatLng(position.latitude, position.longitude), 16);
    } catch (_) {
      _showLocationError('Could not get your location.');
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }

  void _showLocationError(String message) {
    if (!mounted) return;
    Utils.showSnackBar(context, content: message, color: AppColors.primary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Map ──────────────────────────────────────────────────────────
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 15,
              onMapEvent: _onMapEvent,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.blood_setu',
                maxZoom: 19,
              ),
            ],
          ),

          // ── Fixed centre pin ─────────────────────────────────────────────
          const Center(child: _CentrePin()),

          // ── Header ───────────────────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _Header(onBack: () => context.pop()),
          ),

          // ── My Location button ───────────────────────────────────────────
          Positioned(
            right: 16,
            bottom: 180,
            child: _MyLocationButton(
              isLocating: _isLocating,
              onTap: _goToMyLocation,
            ),
          ),

          // ── Bottom sheet ─────────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomSheet(
              addressPreview: _addressPreview,
              isGeocoding: _isGeocoding,
              onConfirm: _confirm,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Widgets ───────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
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
            icon: const Icon(Icons.arrow_back, size: 20),
            color: AppColors.textTertiary,
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pick Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Drag the map to move the pin',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CentrePin extends StatelessWidget {
  const _CentrePin();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.40),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.location_on,
            color: AppColors.white,
            size: 22,
          ),
        ),
        Container(width: 2, height: 10, color: AppColors.primary),
        Container(
          width: 6,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.textDisabled,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ],
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    required this.addressPreview,
    required this.isGeocoding,
    required this.onConfirm,
  });

  final String addressPreview;
  final bool isGeocoding;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        20 + MediaQuery.of(context).padding.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle — same style as other bottom sheets in the app
          Center(
            child: Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Address preview
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: AppColors.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: isGeocoding
                    ? const _GeocodingShimmer()
                    : Text(
                        addressPreview.isNotEmpty
                            ? addressPreview
                            : 'Move the map to select a location',
                        style: TextStyle(
                          fontSize: 13,
                          color: addressPreview.isNotEmpty
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                          height: 1.5,
                        ),
                      ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isGeocoding ? null : onConfirm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                disabledBackgroundColor: AppColors.primaryBorder,
                disabledForegroundColor: AppColors.textDisabled,
                elevation: 4,
                shadowColor: AppColors.primary.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Confirm Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyLocationButton extends StatelessWidget {
  const _MyLocationButton({required this.isLocating, required this.onTap});

  final bool isLocating;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocating ? null : onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isLocating
            ? const Padding(
                padding: EdgeInsets.all(13),
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.info,
                ),
              )
            : const Icon(Icons.my_location, size: 22, color: AppColors.info),
      ),
    );
  }
}

class _GeocodingShimmer extends StatefulWidget {
  const _GeocodingShimmer();

  @override
  State<_GeocodingShimmer> createState() => _GeocodingShimmerState();
}

class _GeocodingShimmerState extends State<_GeocodingShimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _opacity = Tween(begin: 0.3, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _opacity,
      builder: (_, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _bar(width: 200, opacity: _opacity.value),
          const SizedBox(height: 6),
          _bar(width: 130, opacity: _opacity.value * 0.7),
        ],
      ),
    );
  }

  Widget _bar({required double width, required double opacity}) => Container(
        width: width,
        height: 10,
        decoration: BoxDecoration(
          color: AppColors.dividerLight.withValues(alpha: opacity),
          borderRadius: BorderRadius.circular(5),
        ),
      );
}
