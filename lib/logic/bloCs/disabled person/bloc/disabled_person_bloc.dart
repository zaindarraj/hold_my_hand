import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'disabled_person_event.dart';
part 'disabled_person_state.dart';

class DisabledPersonBloc
    extends Bloc<DisabledPersonEvent, DisabledPersonState> {
  Map<String, dynamic> data;
  DisabledPersonBloc({required this.data}) : super(DisabledPersonInitial()) {
    on<DisabledPersonEvent>((event, emit) {});
  }
}
