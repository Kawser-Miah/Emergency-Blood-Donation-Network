import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/models/donor.dart';
import '../../../../../widgets/avatar.dart';
import '../../../../core/theme/colors.dart';
import '../bloc/donors_bloc.dart';
import '../bloc/donors_event.dart';
import '../bloc/donors_state.dart';

const List<String> _bloodGroups = [
  'All',
  'A+',
  'A-',
  'B+',
  'B-',
  'O+',
  'O-',
  'AB+',
  'AB-'
];
const List<String> _distances = ['All', '2km', '5km', '10km', '20km'];

class _StatusStyle {
  const _StatusStyle({required this.bg, required this.color});
  final Color bg;
  final Color color;
}

const Map<String, _StatusStyle> _statusColors = {
  'Available': _StatusStyle(bg: AppColors.successSurface, color: AppColors.success),
  'Recently Donated':
      _StatusStyle(bg: AppColors.warningSurface, color: AppColors.warning),
  'Busy': _StatusStyle(bg: AppColors.primarySurface, color: AppColors.primary),
};

class DonorsScreen extends StatelessWidget {
  const DonorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DonorsBloc(),
      child: const _DonorsView(),
    );
  }
}

class _DonorsView extends StatelessWidget {
  const _DonorsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DonorsBloc, DonorsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              Column(
                children: [
                  _Header(state: state),
                  Expanded(
                    child: state.filtered.isEmpty
                        ? _Empty(
                            onReset: () => context
                                .read<DonorsBloc>()
                                .add(const DonorsEvent.filtersReset()),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                            itemCount: state.filtered.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, i) {
                              final donor = state.filtered[i];
                              return _DonorCard(donor: donor);
                            },
                          ),
                  ),
                ],
              ),
              if (state.showFilters) _FiltersSheet(state: state),
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.state});

  final DonorsState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DonorsBloc>();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + 4, 0, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Find Donors',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${state.filtered.length} donors available near you',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textTertiary),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.dividerLightest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider, width: 1.5),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 16, color: AppColors.textMuted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      initialValue: state.search,
                      onChanged: (v) =>
                          bloc.add(DonorsEvent.searchChanged(v)),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Search by name, area, or blood group...',
                      ),
                      style: const TextStyle(
                          fontSize: 14, color: AppColors.textPrimary),
                    ),
                  ),
                  if (state.search.isNotEmpty)
                    GestureDetector(
                      onTap: () =>
                          bloc.add(const DonorsEvent.searchChanged('')),
                      child: const Icon(Icons.close,
                          size: 14, color: AppColors.textMuted),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 36,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                ..._bloodGroups.take(5).map((bg) {
                  final selected = state.selectedBloodGroup == bg;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () =>
                          bloc.add(DonorsEvent.bloodGroupSelected(bg)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(99),
                          border: selected
                              ? null
                              : Border.all(color: AppColors.divider),
                        ),
                        child: Text(
                          bg,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: selected
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                GestureDetector(
                  onTap: () =>
                      bloc.add(const DonorsEvent.filtersOpened()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.tune,
                            size: 12, color: AppColors.textSecondary),
                        SizedBox(width: 6),
                        Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
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

class _Empty extends StatelessWidget {
  const _Empty({required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🩸', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          const Text(
            'No donors found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try adjusting your filters or search terms',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: AppColors.textTertiary),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onReset,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Reset Filters',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _DonorCard extends StatelessWidget {
  const _DonorCard({required this.donor});

  final Donor donor;

  @override
  Widget build(BuildContext context) {
    final statusStyle =
        _statusColors[donor.status] ?? _statusColors['Available']!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Avatar(
                initials: donor.initials,
                colorHex: donor.avatarColor,
                size: 50,
                online: donor.online,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          donor.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primarySurface,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            donor.bloodGroup,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 11, color: AppColors.textMuted),
                        const SizedBox(width: 2),
                        Text(
                          '${donor.thana}, ${donor.district}',
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.textTertiary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '${donor.distance} km away',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.star,
                            size: 11, color: AppColors.warning),
                        const SizedBox(width: 2),
                        Text(
                          '${donor.rating} (${donor.reviews})',
                          style: const TextStyle(
                              fontSize: 11, color: AppColors.textTertiary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusStyle.bg,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  donor.status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: statusStyle.color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '🩸 ${donor.donations} donations',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '📅 ${donor.lastDonation}',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone, size: 14),
                  label: const Text('Call'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: const BorderSide(color: AppColors.divider, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                      // context.read<AppNavigationBloc>().add(
                      //   AppNavigationEvent.navigated(
                      //     AppScreen.chat,
                      //     contact: ChatContact(
                      //       name: donor.name,
                      //       bloodGroup: donor.bloodGroup,
                      //       id: donor.id,
                      //       initials: donor.initials,
                      //       avatarColor: donor.avatarColor,
                      //       online: donor.online,
                      //     ),
                      //   ),
                      // ),
                  icon: const Icon(Icons.chat_bubble_outline, size: 14),
                  label: const Text('Message'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: const BorderSide(color: AppColors.divider, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'View Profile',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FiltersSheet extends StatelessWidget {
  const _FiltersSheet({required this.state});

  final DonorsState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DonorsBloc>();
    return Positioned.fill(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => bloc.add(const DonorsEvent.filtersClosed()),
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Donors',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            bloc.add(const DonorsEvent.filtersClosed()),
                        child: const Icon(Icons.close,
                            size: 20, color: AppColors.textTertiary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Blood Group',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _bloodGroups.map((bg) {
                      final selected = state.selectedBloodGroup == bg;
                      return GestureDetector(
                        onTap: () =>
                            bloc.add(DonorsEvent.bloodGroupSelected(bg)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary
                                : AppColors.dividerLightest,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            bg,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Distance',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _distances.map((d) {
                      final selected = state.selectedDistance == d;
                      return GestureDetector(
                        onTap: () => bloc.add(DonorsEvent.distanceSelected(d)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary
                                : AppColors.dividerLightest,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            d,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Minimum Rating',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [0.0, 3.0, 4.0, 4.5].map((r) {
                      final selected = state.minRating == r;
                      return GestureDetector(
                        onTap: () => bloc.add(DonorsEvent.ratingSelected(r)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primary
                                : AppColors.dividerLightest,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Text(
                            r == 0 ? 'Any' : '$r+ ⭐',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              bloc.add(const DonorsEvent.filtersReset()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.dividerLightest,
                            foregroundColor: AppColors.textSecondary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              bloc.add(const DonorsEvent.filtersClosed()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text('Apply'),
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
