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
      } else if (event is DeleteUser) {
        emit(Loading());
        String response = await API.deleteUser(event.email);
        if (response == oK) {
          emit(Done(message: oK));
        } else {
          emit(Error(error: response));
        }
      } else if (event is GetUsersList) {
        emit(Loading());
        dynamic response = await API.getUsersList();
        if (response == noUsers) {
          emit(NoUsers());
        } else if (response == serverError) {
          emit(Error(error: response));
        } else {
          emit(UserListReady(listOfUser: response));
        }
      } else if (event is GetBenefactorList) {
        emit(Loading());
        dynamic response = await API.getBenefactorsList();
        if (response == noUsers) {
          emit(NoUsers());
        } else if (response == serverError) {
          emit(Error(error: response));
        } else if (response.runtimeType == List<Map<dynamic, dynamic>>) {
          emit(BenefactorListReady(list: response));
        }
      } else if (event is DeleteBenefector) {
        String response = await API.deleteBenefactor(event.email);
        if (response == oK) {
          emit(Done(message: oK));
        } else {
          emit(Error(error: response));
        }
      } else if (event is Approve) {
        emit(Loading());
        dynamic response = await API.approve(event.userID, event.order);
        if (response == oK) {
          emit(Done(message: oK));
        } else {
          emit(Error(error: response));
        }
      } else if (event is AddCenter) {
        dynamic response = await API.addCenter(event.name);
        emit(Done(message:  response));

//api
      } else if (event is DeleteCenter) {
//api
      }
    });
  }
}
