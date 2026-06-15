import 'package:blood_setu/application/core/theme/colors.dart';
import 'package:blood_setu/application/pages/features/blood_requests/bloc/blood_requests_bloc.dart';
import 'package:blood_setu/application/pages/features/blood_requests/bloc/blood_requests_event.dart';
import 'package:blood_setu/application/pages/features/blood_requests/bloc/blood_requests_state.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/blood_requests_body.dart';
import '../widgets/blood_requests_filters_sheet.dart';
import '../widgets/blood_requests_header.dart';

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
                  BloodRequestsHeader(state: state),
                  Expanded(
                    child: BloodRequestsBody(
                      state: state,
                      scrollController: _scrollController,
                    ),
                  ),
                ],
              ),
              if (state.showFilters) BloodRequestsFiltersSheet(state: state),
            ],
          ),
        );
      },
    );
  }
}
