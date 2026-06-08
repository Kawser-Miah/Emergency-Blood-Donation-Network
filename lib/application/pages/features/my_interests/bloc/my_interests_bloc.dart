import 'package:blood_setu/application/core/auth/auth_controller.dart';
import 'package:blood_setu/di/di.dart';
import 'package:blood_setu/domain/models/donation_history_entry.dart';
import 'package:blood_setu/domain/usecase/donation_usecase.dart';
import 'package:blood_setu/utils/blood_compat_util.dart';
import 'package:blood_setu/domain/usecase/get_my_interests_usecase.dart';
import 'package:blood_setu/domain/usecase/mark_blood_given_usecase.dart';
import 'package:blood_setu/domain/usecase/withdraw_interest_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'my_interests_event.dart';
import 'my_interests_state.dart';

@injectable
class MyInterestsBloc extends Bloc<MyInterestsEvent, MyInterestsState> {
  final GetMyInterestsUseCase _getMyInterestsUseCase;
  final WithdrawInterestUseCase _withdrawInterestUseCase;
  final MarkBloodGivenUseCase _markBloodGivenUseCase;
  final DonationUseCase _donationUseCase;

  MyInterestsBloc(
    this._getMyInterestsUseCase,
    this._withdrawInterestUseCase,
    this._markBloodGivenUseCase,
    this._donationUseCase,
  ) : super(MyInterestsState.initial()) {
    on<MyInterestsEvent>((event, emit) async {
      await event.when(
        started: () => _load(emit),
        refreshed: () => _load(emit),
        withdrawRequested: (requestId) => _withdraw(emit, requestId),
        bloodGivenMarked: (requestId) => _markBloodGiven(emit, requestId),
      );
    });
  }

  Future<void> _load(Emitter<MyInterestsState> emit) async {
    final uid = getIt<AuthController>().user?.uid;
    if (uid == null) return;

    emit(state.copyWith(isLoading: true, error: null));
    final result = await _getMyInterestsUseCase(uid);
    result.fold(
      (_) => emit(
        state.copyWith(
          isLoading: false,
          error: 'Failed to load your interests.',
        ),
      ),
      (interests) =>
          emit(state.copyWith(interests: interests, isLoading: false)),
    );
  }

  Future<void> _withdraw(
    Emitter<MyInterestsState> emit,
    String requestId,
  ) async {
    final uid = getIt<AuthController>().user?.uid;
    if (uid == null) return;

    emit(state.copyWith(withdrawingId: requestId));
    final result = await _withdrawInterestUseCase(
      requestId: requestId,
      donorUid: uid,
    );
    result.fold(
      (_) => emit(
        state.copyWith(
          withdrawingId: null,
          withdrawFailed: !state.withdrawFailed,
        ),
      ),
      (_) {
        final updated = state.interests
            .where((e) => e.request.id != requestId)
            .toList();
        emit(
          state.copyWith(
            withdrawingId: null,
            interests: updated,
            withdrawSuccess: !state.withdrawSuccess,
          ),
        );
      },
    );
  }

  Future<void> _markBloodGiven(
    Emitter<MyInterestsState> emit,
    String requestId,
  ) async {
    final auth = getIt<AuthController>();
    final uid = auth.user?.uid;
    if (uid == null) return;

    // Guard: donor's blood group must be compatible with the request.
    final entry = state.interests.firstWhere((e) => e.request.id == requestId);
    if (!isBloodGroupCompatible(
      auth.profile?.bloodGroup ?? '',
      entry.request.bloodGroup,
    )) {
      emit(state.copyWith(
        bloodGroupIncompatible: !state.bloodGroupIncompatible,
      ));
      return;
    }

    emit(state.copyWith(markingBloodGivenId: requestId));

    final givenResult = await _markBloodGivenUseCase(
      requestId: requestId,
      donorUid: uid,
    );

    if (givenResult.isLeft()) {
      emit(
        state.copyWith(
          markingBloodGivenId: null,
          bloodGivenFailed: !state.bloodGivenFailed,
        ),
      );
      return;
    }

    // bloodGiven flag saved — update UI immediately.
    final updated = state.interests.map((e) {
      if (e.request.id == requestId) return e.copyWith(bloodGiven: true);
      return e;
    }).toList();
    emit(
      state.copyWith(
        markingBloodGivenId: null,
        interests: updated,
        bloodGivenSuccess: !state.bloodGivenSuccess,
      ),
    );

    // Now await the donation record — updates totalDonations, lastDonation,
    // donorTier, and isActive in both profile and user_locations.
    final donationResult = await _donationUseCase.addDonation(
      uid,
      DonationHistoryEntry(
        id: '',
        date: DateTime.now(),
        hospital: entry.request.hospital,
        bloodGroup: auth.profile?.bloodGroup ?? '',
        status: 'Confirmed',
      ),
    );
    donationResult.fold(
      (_) => emit(
        state.copyWith(donationRecordFailed: !state.donationRecordFailed),
      ),
      (_) {},
    );
  }
}
