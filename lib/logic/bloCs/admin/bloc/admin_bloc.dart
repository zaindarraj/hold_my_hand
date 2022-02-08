import 'package:bloc/bloc.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:hold_my_hand/consts.dart';
import 'package:meta/meta.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial()) {
    on<AdminEvent>((event, emit) async {
      if (event is AddUser) {
        emit(Loading());
        String response = await API.signUpUser(event.email, event.password,
            event.fname, event.lnamel, event.disablity);
        if (response == signedInResponse) {
          emit(Done());
        } else {
          emit(Error(error: response));
        }
      }
    });
  }
}
