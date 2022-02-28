import 'package:bloc/bloc.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:meta/meta.dart';

part 'order_food_event.dart';
part 'order_food_state.dart';

class OrderFoodBloc extends Bloc<OrderFoodEvent, OrderFoodState> {
  OrderFoodBloc() : super(OrderFoodInitial()) {
    on<OrderFoodEvent>((event, emit) async {
      if (event is OrderFood) {
        dynamic response =await API.orderFood(
            event.email, event.password, event.cardID, event.order);
        if (response == 1) {
          emit(Done());
        } else {
          emit(Error(errorMessage: response));
        }
      }
    });
  }
}
