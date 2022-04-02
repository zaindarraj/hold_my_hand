import 'package:bloc/bloc.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:meta/meta.dart';

part 'delivery_service_event.dart';
part 'delivery_service_state.dart';

class DeliveryServiceBloc
    extends Bloc<DeliveryServiceEvent, DeliveryServiceState> {
  DeliveryServiceBloc() : super(DeliveryServiceInitial()) {
    on<DeliveryServiceEvent>((event, emit) async {
      if (event is RequestDelivery) {
        dynamic response =
            await API.requestDelivery(event.userID, event.from, event.object);
        print(response);
        if (response.runtimeType == int) {
          emit(Done());
        } else {
          emit(Error(error: response));
        }
      }
    });
  }
}
