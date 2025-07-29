import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:itrip/data/db/db_helper.dart';
import 'package:itrip/data/db/table/trip_dao.dart';
import 'package:itrip/data/model/trip.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc() : super(TripInitial()) {
    on<TripEvent>((event, emit) {});
    on<StartTripEvent>(_startTrip);
  }

  Future<void> _startTrip(StartTripEvent event, Emitter<TripState> emit) async {
    emit(TripLoadingState());
    try {
      Trip trip = Trip(
        name: event.name,
        description: event.description,
        companied: event.personStatusValue,
      );
      int idResult = await TripDao.insert(await DbHelper.getDb(), trip);
      if (idResult > 0) {
        trip.id = idResult;
        emit(TripStartedState(trip: trip));
      } else {
        emit(
          TripErrorState(
            reason: "No pudo iniciarse tu paseo, intenta más tarde.",
          ),
        );
      }
    } catch (e) {
      emit(
        TripErrorState(
          reason: 'Ocurrio un error inesperado, intenta más tarde.',
        ),
      );
    }
  }
}
