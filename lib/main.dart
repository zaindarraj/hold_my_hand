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
      create: (context) => RegisterationBloc()
        ..add(CheckBio())
        ..add(CheckFlutterStorage()),
      child: MaterialApp(
        theme: ThemeData(
            colorScheme:  ColorScheme(
              brightness: Brightness.light,
              surface: Colors.blue[800] as Color,
              onSurface:  Colors.grey[850] as Color,
              primary:  Colors.blue[800] as Color,
              onPrimary: Colors.white,
              primaryVariant: Colors.white,
              secondary: Colors.white,
              secondaryVariant: Colors.white,
              onSecondary: Colors.white,
              background: Colors.white,
              onBackground:Colors.white,
              error: Colors.red,
              onError: Colors.white,
            ),
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
