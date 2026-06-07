import 'package:blood_setu/application/core/theme/colors.dart';
import 'package:blood_setu/domain/models/blood_request.dart';
import 'package:blood_setu/utils/geo_query_util.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BloodRequestUrgencyStyle {
  const BloodRequestUrgencyStyle({
    required this.color,
    required this.bg,
    required this.label,
    required this.emoji,
  });
  final Color color;
  final Color bg;
  final String label;
  final String emoji;
}

const Map<String, BloodRequestUrgencyStyle> bloodRequestUrgencyConfig = {
  'CRITICAL': BloodRequestUrgencyStyle(
    color: AppColors.primary,
    bg: AppColors.primarySurface,
    label: 'CRITICAL',
    emoji: '🔴',
  ),
  'URGENT': BloodRequestUrgencyStyle(
    color: AppColors.warning,
    bg: AppColors.warningSurface,
    label: 'URGENT',
    emoji: '🟠',
  ),
  'NORMAL': BloodRequestUrgencyStyle(
    color: AppColors.info,
    bg: AppColors.infoSurface,
    label: 'NORMAL',
    emoji: '🔵',
  ),
};

String formatRequestDate(DateTime? date) {
  if (date == null) return '';
  final diff = DateTime.now().difference(date);
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  return '${diff.inDays}d ago';
}

const _months = [
  '',
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String formatNeedBy(DateTime date) =>
    '${date.day} ${_months[date.month]} ${date.year}';

String formatPosted(DateTime? date) {
  if (date == null) return '—';
  final diff = DateTime.now().difference(date);
  if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  return '${diff.inDays}d ago';
}

class BloodRequestCard extends StatelessWidget {
  const BloodRequestCard({
    super.key,
    required this.request,
    this.userLat,
    this.userLng,
    this.onMessage,
    this.onImComing,
  });

  final BloodRequest request;
  final double? userLat;
  final double? userLng;
  final VoidCallback? onMessage;
  final VoidCallback? onImComing;

  String? get _distanceText {
    final rLat = request.latitude;
    final rLng = request.longitude;
    if (rLat == null || rLng == null || userLat == null || userLng == null) {
      return null;
    }
    final km = GeoQueryUtil.distanceKm(userLat!, userLng!, rLat, rLng);
    return '${km.toStringAsFixed(1)} km away';
  }

  void _openDetails(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BloodRequestDetailsSheet(
        request: request,
        userLat: userLat,
        userLng: userLng,
        onImComing: onImComing,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final urg =
        bloodRequestUrgencyConfig[request.urgency] ??
        bloodRequestUrgencyConfig['NORMAL']!;
    return GestureDetector(
      onTap: () => _openDetails(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border(left: BorderSide(color: urg.color, width: 4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: urg.bg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(urg.emoji, style: const TextStyle(fontSize: 10)),
                      const SizedBox(width: 6),
                      Text(
                        urg.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: urg.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  formatRequestDate(request.createdAt),
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.bloodGroup,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        height: 1,
                      ),
                    ),
                    const Text(
                      'Blood Needed',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        request.hospital,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 10,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Text(
                              _distanceText ?? request.address,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '🩸 ${request.units} units  •  👤 ${request.patientName}',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '📅 Needed by: ${formatNeedBy(request.needBy)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: urg.color,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      '💬 Message',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onImComing,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      side: const BorderSide(color: AppColors.primary, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "🤲 I'm Coming",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BloodRequestDetailsSheet extends StatelessWidget {
  const BloodRequestDetailsSheet({
    super.key,
    required this.request,
    this.userLat,
    this.userLng,
    this.onImComing,
  });

  final BloodRequest request;
  final double? userLat;
  final double? userLng;
  final VoidCallback? onImComing;

  String? get _distanceText {
    final rLat = request.latitude;
    final rLng = request.longitude;
    if (rLat == null || rLng == null || userLat == null || userLng == null) {
      return null;
    }
    final km = GeoQueryUtil.distanceKm(userLat!, userLng!, rLat, rLng);
    return '${km.toStringAsFixed(1)} km away';
  }

  @override
  Widget build(BuildContext context) {
    final urg =
        bloodRequestUrgencyConfig[request.urgency] ??
        bloodRequestUrgencyConfig['NORMAL']!;
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Container(
      margin: const EdgeInsets.only(top: 60),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
              padding: EdgeInsets.fromLTRB(24, 20, 24, bottomPad + 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SheetHeader(request: request, urg: urg),
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 20),
                  _DetailRow(
                    icon: Icons.person_outline,
                    label: 'Patient',
                    value: request.patientName,
                  ),
                  _DetailRow(
                    icon: Icons.calendar_today_outlined,
                    label: 'Needed By',
                    value: formatNeedBy(request.needBy),
                    valueColor: urg.color,
                    valueBold: true,
                  ),
                  _DetailRow(
                    icon: Icons.local_hospital_outlined,
                    label: 'Hospital',
                    value: request.hospital,
                  ),
                  _DetailRow(
                    icon: Icons.location_on_outlined,
                    label: 'Location',
                    value: request.address,
                    trailing: _distanceText != null
                        ? _DistanceBadge(text: _distanceText!)
                        : null,
                    onCopy: () {
                      Clipboard.setData(ClipboardData(text: request.address));
                      Utils.showSnackBar(
                        context,
                        content: 'Address copied to clipboard',
                        color: AppColors.primary,
                      );
                    },
                  ),
                  _DetailRow(
                    icon: Icons.water_drop_outlined,
                    label: 'Units Required',
                    value:
                        '${request.units} unit${request.units > 1 ? 's' : ''}',
                  ),
                  _DetailRow(
                    icon: Icons.phone_outlined,
                    label: 'Contact',
                    value: request.contact,
                    onCopy: () {
                      Clipboard.setData(ClipboardData(text: request.contact));
                      Utils.showSnackBar(
                        context,
                        content: 'Number copied to clipboard',
                        color: AppColors.primary,
                      );
                    },
                  ),
                  if (request.notes.isNotEmpty)
                    _DetailRow(
                      icon: Icons.notes_outlined,
                      label: 'Notes',
                      value: request.notes,
                    ),
                  _DetailRow(
                    icon: Icons.access_time_outlined,
                    label: 'Posted',
                    value: formatPosted(request.createdAt),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            '💬 Message',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: onImComing == null
                              ? null
                              : () {
                                  Navigator.of(context).pop();
                                  onImComing!();
                                },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "🤲 I'm Coming",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
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

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.request, required this.urg});

  final BloodRequest request;
  final BloodRequestUrgencyStyle urg;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primaryBorder, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                request.bloodGroup,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  height: 1,
                ),
              ),
              const Text(
                'BLOOD',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: urg.bg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(urg.emoji, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 6),
                    Text(
                      urg.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: urg.color,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Blood Request',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.valueBold = false,
    this.trailing,
    this.onCopy,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final bool valueBold;
  final Widget? trailing;
  final VoidCallback? onCopy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.dividerLightest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: AppColors.textSecondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              valueBold ? FontWeight.w700 : FontWeight.w500,
                          color: valueColor ?? AppColors.textPrimary,
                        ),
                      ),
                    ),
                    if (trailing != null) ...[
                      const SizedBox(width: 8),
                      trailing!,
                    ],
                    if (onCopy != null)
                      GestureDetector(
                        onTap: onCopy,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.copy_outlined,
                            size: 16,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DistanceBadge extends StatelessWidget {
  const _DistanceBadge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.successSurface,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.near_me, size: 10, color: AppColors.success),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}
