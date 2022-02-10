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
          emit(Done());
        } else {
          emit(Error(error: response));
        }
      } else if (event is DeleteUser) {
        String response = await API.deleteUser(event.email);
        if (response == oK) {
          emit(Done());
        } else {
          emit(Error(error: response));
        }
      } else if (event is GetUsersList) {
        dynamic response = await API.getUsersList();
        if (response == noUsers) {
          emit(NoUsers());
        } else if (response == serverError) {
          emit(Error(error: response));
        }
        emit(UserListReady(listOfUser: response));
      } else if (event is ApproveUser) {
        dynamic response = await API.approveUser(event.email);
        if (response == oK) {
          emit(Done());
        } else {
          emit(Error(error: response["message"]));
        }
      }else if(event is GetBenefectorList){
        dynamic response = await API.getUsersList();
      }
    });
  }
}
