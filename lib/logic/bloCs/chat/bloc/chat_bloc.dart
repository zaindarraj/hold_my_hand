import 'package:bloc/bloc.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:hold_my_hand/consts.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  String userID;
  ChatBloc({required this.userID}) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      if (event is ReadMessages) {
        dynamic response =
            await API.readMessages(event.senderID, event.receiverID);
        if (response.runtimeType == String) {
          emit(Error(errorMessage: response));
        } else {
          emit(Messages(list: response["messages"]));
        }
      } else if (event is SendMessage) {
        dynamic response = await API.sendMessege(
            event.senderID, event.receiverID, event.message);

        if (response == serverError) {
          emit(Error(
              errorMessage: serverError));
        } else {
          emit(Messages(
            list: response["messages"],
          ));
        }
      }
    });
  }
}
