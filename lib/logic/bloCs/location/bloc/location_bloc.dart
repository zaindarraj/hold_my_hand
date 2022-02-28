import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hold_my_hand/classes/api.dart';
import 'package:hold_my_hand/classes/location.dart';
import 'package:meta/meta.dart';

import '../../../../consts.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  late Position position;
  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) async {
      if (event is EnableLocation) {
        if (await LocationClass.requestPermission() ==
            LocationPermission.whileInUse) {
          position = await LocationClass.getLocation();
          if (await API.enableLocation(1, event.userID, position) == oK) {
            emit(Enabled());
          }
        } else {
          emit(Disabled());
        }
      } else if (event is DisableLocation) {
        if (await API.enableLocation(0, event.userID, null) == oK) {
          emit(Disabled());
        } else {
          emit(Enabled());
        }
      }
    });
  }
}
