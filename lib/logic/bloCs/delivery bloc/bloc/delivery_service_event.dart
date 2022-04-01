part of 'delivery_service_bloc.dart';

abstract class DeliveryServiceEvent {}

class RequestDelivery extends DeliveryServiceEvent {
  String userID;
  String from;
  String object;
  RequestDelivery(
      {required this.from, required this.object, required this.userID});
}
