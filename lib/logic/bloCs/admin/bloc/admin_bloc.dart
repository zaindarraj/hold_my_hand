import 'package:bloc/bloc.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:hold_my_hand/consts.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<AdminEvent>((event, emit) async {
      if (event is AddUser) {
        emit(Loading());
        String response = await API.signUpUser(event.email, event.password,
            event.fname, event.lnamel, event.disablity);
        if (response == oK) {
          emit(Done(message: oK));
        } else {
          emit(Error(error: response));
        }
      }  else if (event is AddCenter) {
        dynamic response = await API.addCenter(event.name);
        emit(Done(message: response));
      } else if (event is DeleteCenter) {
        dynamic response = await API.deleteCener(event.centerID);
        emit(Done(message: response));
      }
    });
  }
}
