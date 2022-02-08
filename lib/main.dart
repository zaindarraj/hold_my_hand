import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hold_my_hand/logic/bloCs/registeration/bloc/registeration_bloc.dart';
import 'package:hold_my_hand/presentation/registerScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterationBloc()..add(CheckBio())
          ..add(CheckFlutterStorage())
          ,
      child: MaterialApp(
        theme: ThemeData(
              primaryColor: Colors.blue[800] as Color,
              iconTheme: const IconThemeData(color: Colors.white)),
        home: BlocProvider(
            create: (context) => RegisterationBloc()
              ..add(CheckFlutterStorage())
              ..add(CheckBio()),
            child: const RegisterScreen(),
          ),
      ),
    );
  }
}
