part of 'location_bloc.dart';

abstract class LocationEvent {}


class EnableLocation extends LocationEvent {
  String userID;
  EnableLocation({required this.userID});
}

class DisableLocation extends LocationEvent {
  String userID;
  DisableLocation({required this.userID});
}
