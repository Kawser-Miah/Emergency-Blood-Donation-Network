import 'package:blood_setu/application/pages/features/donors/bloc/donors_bloc.dart';
import 'package:blood_setu/application/pages/features/donors/bloc/donors_event.dart';
import 'package:blood_setu/application/pages/features/donors/bloc/donors_state.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/models/nearby_donor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../../../../../widgets/avatar.dart';

const List<String> _bloodGroups = [
  'All',
  'A+',
  'A-',
  'B+',
  'B-',
  'O+',
  'O-',
  'AB+',
  'AB-',
];
const List<String> _distances = ['All', '10km', '50km', '100km', '500km'];

const List<String> _avatarColors = [
  '#1E88E5',
  '#43A047',
  '#E53935',
  '#FB8C00',
  '#9C27B0',
  '#00ACC1',
  '#F06292',
  '#26A69A',
];

String _colorFor(String uid) =>
    _avatarColors[uid.hashCode.abs() % _avatarColors.length];

class _StatusStyle {
  const _StatusStyle({required this.bg, required this.color});
  final Color bg;
  final Color color;
}

const Map<String, _StatusStyle> _statusColors = {
  'Available': _StatusStyle(
    bg: AppColors.successSurface,
    color: AppColors.success,
  ),
  'Unavailable': _StatusStyle(
    bg: AppColors.primarySurface,
    color: AppColors.primary,
  ),
};

class DonorsScreen extends StatelessWidget {
  const DonorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DonorsBloc>()..add(const DonorsEvent.started()),
      child: const _DonorsView(),
    );
  }
}

class _DonorsView extends StatefulWidget {
  const _DonorsView();

  @override
  State<_DonorsView> createState() => _DonorsViewState();
}

class _DonorsViewState extends State<_DonorsView> {
  final ScrollController _scrollController = ScrollController();
  static const double _loadMoreThreshold = 300;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - _loadMoreThreshold) {
      context.read<DonorsBloc>().add(const DonorsEvent.loadMoreRequested());
    }
  }

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
                    child: _Body(
                      state: state,
                      scrollController: _scrollController,
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

class _Body extends StatelessWidget {
  const _Body({required this.state, required this.scrollController});

  final DonorsState state;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (state.isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.location_off_outlined,
                size: 48,
                color: AppColors.textMuted,
              ),
              const SizedBox(height: 12),
              Text(
                state.errorMessage ?? 'Failed to load donors.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textTertiary),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    context.read<DonorsBloc>().add(const DonorsEvent.started()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      );
    }

    if (state.donors.isNotEmpty && state.filtered.isEmpty) {
      return _Empty(
        onReset: () =>
            context.read<DonorsBloc>().add(const DonorsEvent.filtersReset()),
      );
    }

    if (state.filtered.isEmpty && state.status == DonorsStatus.success) {
      return _Empty(
        onReset: () =>
            context.read<DonorsBloc>().add(const DonorsEvent.filtersReset()),
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async =>
          context.read<DonorsBloc>().add(const DonorsEvent.refreshed()),
      child: ListView.separated(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        itemCount: state.filtered.length + 1,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          if (i >= state.filtered.length) {
            return _ListFooter(state: state);
          }
          return _DonorCard(donor: state.filtered[i]);
        },
      ),
    );
  }
}

class _ListFooter extends StatelessWidget {
  const _ListFooter({required this.state});

  final DonorsState state;

  @override
  Widget build(BuildContext context) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ),
        ),
      );
    }
    if (state.hasReachedMax && state.donors.isNotEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            'No more donors found',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
        ),
      );
    }
    return const SizedBox(height: 24);
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
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        0,
        MediaQuery.of(context).padding.top + 4,
        0,
        8,
      ),
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
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.dividerLightest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider, width: 1.5),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    size: 16,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      initialValue: state.search,
                      onChanged: (v) => bloc.add(DonorsEvent.searchChanged(v)),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Search by name, area, or blood group...',
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (state.search.isNotEmpty)
                    GestureDetector(
                      onTap: () =>
                          bloc.add(const DonorsEvent.searchChanged('')),
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: AppColors.textMuted,
                      ),
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
                      onTap: () => bloc.add(DonorsEvent.bloodGroupSelected(bg)),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
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
                  onTap: () => bloc.add(const DonorsEvent.filtersOpened()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(99),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.tune,
                          size: 12,
                          color: AppColors.textSecondary,
                        ),
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

  final NearbyDonor donor;

  @override
  Widget build(BuildContext context) {
    final statusLabel = donor.isActive ? 'Available' : 'Unavailable';
    final statusStyle =
        _statusColors[statusLabel] ?? _statusColors['Available']!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
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
              _buildAvatar(),
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
                            horizontal: 8,
                            vertical: 2,
                          ),
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
                        const Icon(
                          Icons.location_on,
                          size: 11,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${donor.thana}, ${donor.district}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '${donor.distanceKm.toStringAsFixed(1)} km away',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // const Icon(Icons.bloodtype_outlined,
                        //     size: 11, color: AppColors.textMuted),
                        // const SizedBox(width: 2),
                        Text(
                          '🩸${donor.totalDonations} donations',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusStyle.bg,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  statusLabel,
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
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone, size: 14),
                  label: const Text('Call'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: const BorderSide(
                      color: AppColors.divider,
                      width: 1.5,
                    ),
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
                    side: const BorderSide(
                      color: AppColors.divider,
                      width: 1.5,
                    ),
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

  Widget _buildAvatar() {
    final photoUrl = donor.photoUrl;
    if (photoUrl != null && photoUrl.isNotEmpty) {
      return CircleAvatar(radius: 25, backgroundImage: NetworkImage(photoUrl));
    }
    return Avatar(
      initials: donor.initials,
      colorHex: _colorFor(donor.uid),
      size: 50,
      online: donor.isActive,
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
            child: Container(color: Colors.black.withValues(alpha: 0.4)),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                        child: const Icon(
                          Icons.close,
                          size: 20,
                          color: AppColors.textTertiary,
                        ),
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
                    alignment: WrapAlignment.center,
                    children: _bloodGroups.map((bg) {
                      final selected = state.selectedBloodGroup == bg;
                      return GestureDetector(
                        onTap: () =>
                            bloc.add(DonorsEvent.bloodGroupSelected(bg)),
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
                            horizontal: 12,
                            vertical: 6,
                          ),
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
