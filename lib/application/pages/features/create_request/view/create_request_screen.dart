import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/di.dart';
import '../../../../../utils/utils.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/widgets/sparkle_loading_overlay.dart';
import '../bloc/create_request_bloc.dart';
import '../bloc/create_request_event.dart';
import '../bloc/create_request_state.dart';
import '../widgets/create_request_card_additional.dart';
import '../widgets/create_request_card_location.dart';
import '../widgets/create_request_card_patient.dart';
import '../widgets/create_request_card_urgency.dart';
import '../widgets/create_request_confirmations.dart';
import '../widgets/create_request_header.dart';

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
                  CreateRequestHeader(
                    onBack: () => Navigator.pop(context),
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
                              child:
                                  Container(color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding:
                          const EdgeInsets.fromLTRB(16, 16, 16, 96),
                      child: Column(
                        children: [
                          CreateRequestCardPatient(state: state),
                          const SizedBox(height: 16),
                          CreateRequestCardLocation(state: state),
                          const SizedBox(height: 16),
                          CreateRequestCardUrgency(state: state),
                          const SizedBox(height: 16),
                          CreateRequestCardAdditional(state: state),
                          const SizedBox(height: 16),
                          CreateRequestConfirmations(state: state),
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
                    border: Border(
                        top: BorderSide(color: AppColors.divider)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          state.status == CreateRequestStatus.loading
                              ? null
                              : () =>
                                  context.read<CreateRequestBloc>().add(
                                    const CreateRequestEvent
                                        .requestSubmitted(),
                                  ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        shadowColor:
                            AppColors.primary.withValues(alpha: 0.4),
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
