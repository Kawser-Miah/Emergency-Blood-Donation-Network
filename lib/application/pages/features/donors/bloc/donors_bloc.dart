import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/mock_data.dart';
import '../../../../../domain/models/donor.dart';
import 'donors_event.dart';
import 'donors_state.dart';

class DonorsBloc extends Bloc<DonorsEvent, DonorsState> {
  DonorsBloc() : super(DonorsState.initial().copyWith(filtered: _apply(DonorsState.initial()))) {
    on<DonorsEvent>((event, emit) {
      event.when(
        searchChanged: (value) {
          final next = state.copyWith(search: value);
          emit(next.copyWith(filtered: _apply(next)));
        },
        bloodGroupSelected: (value) {
          final next = state.copyWith(selectedBloodGroup: value);
          emit(next.copyWith(filtered: _apply(next)));
        },
        distanceSelected: (value) {
          final next = state.copyWith(selectedDistance: value);
          emit(next.copyWith(filtered: _apply(next)));
        },
        ratingSelected: (value) {
          final next = state.copyWith(minRating: value);
          emit(next.copyWith(filtered: _apply(next)));
        },
        filtersOpened: () => emit(state.copyWith(showFilters: true)),
        filtersClosed: () => emit(state.copyWith(showFilters: false)),
        filtersReset: () {
          final next = state.copyWith(
            search: '',
            selectedBloodGroup: 'All',
            selectedDistance: 'All',
            minRating: 0,
          );
          emit(next.copyWith(filtered: _apply(next)));
        },
      );
    });
  }

  static List<Donor> _apply(DonorsState state) {
    final search = state.search.toLowerCase();
    return mockDonors.where((d) {
      final matchName = d.name.toLowerCase().contains(search) ||
          d.thana.toLowerCase().contains(search);
      final matchBlood =
          state.selectedBloodGroup == 'All' || d.bloodGroup == state.selectedBloodGroup;
      final matchRating = d.rating >= state.minRating;
      return matchName && matchBlood && matchRating;
    }).toList();
  }
}
