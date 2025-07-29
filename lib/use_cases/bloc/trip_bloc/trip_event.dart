part of 'trip_bloc.dart';

sealed class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object> get props => [];
}

final class StartTripEvent extends TripEvent {
  final String name;
  final String description;
  final String personStatusValue;

  const StartTripEvent({
    required this.name,
    required this.description,
    required this.personStatusValue,
  });
}
