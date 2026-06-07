import 'package:blood_setu/application/core/theme/colors.dart';
import 'package:blood_setu/application/pages/features/blood_requests/bloc/blood_requests_bloc.dart';
import 'package:blood_setu/application/pages/features/blood_requests/bloc/blood_requests_event.dart';
import 'package:blood_setu/application/pages/features/blood_requests/bloc/blood_requests_state.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/application/core/widgets/blood_request_card.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
const List<String> _urgencies = ['All', 'CRITICAL', 'URGENT', 'NORMAL'];

class BloodRequestsScreen extends StatelessWidget {
  const BloodRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<BloodRequestsBloc>()..add(const BloodRequestsEvent.started()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<BloodRequestsBloc, BloodRequestsState>(
            listenWhen: (p, c) => p.imComingSuccess != c.imComingSuccess,
            listener: (context, _) => Utils.showSnackBar(
              context,
              content: "You're registered as coming!",
              color: AppColors.success,
            ),
          ),
          BlocListener<BloodRequestsBloc, BloodRequestsState>(
            listenWhen: (p, c) => p.imComingFailed != c.imComingFailed,
            listener: (context, _) => Utils.showSnackBar(
              context,
              content: 'Failed to register interest. Please try again.',
              color: AppColors.primary,
            ),
          ),
        ],
        child: const _BloodRequestsView(),
      ),
    );
  }
}

class _BloodRequestsView extends StatefulWidget {
  const _BloodRequestsView();

  @override
  State<_BloodRequestsView> createState() => _BloodRequestsViewState();
}

class _BloodRequestsViewState extends State<_BloodRequestsView> {
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
      context.read<BloodRequestsBloc>().add(
        const BloodRequestsEvent.loadMoreRequested(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BloodRequestsBloc, BloodRequestsState>(
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

class _Header extends StatelessWidget {
  const _Header({required this.state});

  final BloodRequestsState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BloodRequestsBloc>();
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
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Blood Requests',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${state.filtered.length} active requests',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
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
                      onChanged: (v) =>
                          bloc.add(BloodRequestsEvent.searchChanged(v)),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Search by patient, hospital, blood group...',
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
                          bloc.add(const BloodRequestsEvent.searchChanged('')),
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
                      onTap: () =>
                          bloc.add(BloodRequestsEvent.bloodGroupSelected(bg)),
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
                  onTap: () =>
                      bloc.add(const BloodRequestsEvent.filtersOpened()),
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

class _Body extends StatelessWidget {
  const _Body({required this.state, required this.scrollController});

  final BloodRequestsState state;
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
                Icons.bloodtype_outlined,
                size: 48,
                color: AppColors.textMuted,
              ),
              const SizedBox(height: 12),
              Text(
                state.error ?? 'Failed to load requests.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textTertiary),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<BloodRequestsBloc>().add(
                  const BloodRequestsEvent.started(),
                ),
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

    if (state.filtered.isEmpty) {
      return _Empty(
        onReset: () => context.read<BloodRequestsBloc>().add(
          const BloodRequestsEvent.filtersReset(),
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async => context.read<BloodRequestsBloc>().add(
        const BloodRequestsEvent.refreshed(),
      ),
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
          final req = state.filtered[i];
          return BloodRequestCard(
            request: req,
            userLat: state.userLat,
            userLng: state.userLng,
            onMessage: () {},
            onImComing: () => context
                .read<BloodRequestsBloc>()
                .add(BloodRequestsEvent.imComing(req.id)),
          );
        },
      ),
    );
  }

}

class _ListFooter extends StatelessWidget {
  const _ListFooter({required this.state});

  final BloodRequestsState state;

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
    if (!state.hasMore && state.requests.isNotEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            'No more requests found',
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
        ),
      );
    }
    return const SizedBox(height: 24);
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
            'No requests found',
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

class _FiltersSheet extends StatelessWidget {
  const _FiltersSheet({required this.state});

  final BloodRequestsState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BloodRequestsBloc>();
    return Positioned.fill(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => bloc.add(const BloodRequestsEvent.filtersClosed()),
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
                        'Filter Requests',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () =>
                            bloc.add(const BloodRequestsEvent.filtersClosed()),
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
                    children: _bloodGroups.map((bg) {
                      final selected = state.selectedBloodGroup == bg;
                      return GestureDetector(
                        onTap: () =>
                            bloc.add(BloodRequestsEvent.bloodGroupSelected(bg)),
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
                    'Urgency',
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
                    children: _urgencies.map((u) {
                      final selected = state.selectedUrgency == u;
                      return GestureDetector(
                        onTap: () =>
                            bloc.add(BloodRequestsEvent.urgencySelected(u)),
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
                            u,
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
                              bloc.add(const BloodRequestsEvent.filtersReset()),
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
                          onPressed: () => bloc.add(
                            const BloodRequestsEvent.filtersClosed(),
                          ),
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
