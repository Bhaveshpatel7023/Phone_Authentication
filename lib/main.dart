import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/Cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_1/Cubits/auth_cubit/auth_state.dart';
import 'package:flutter_application_1/Screens/HomeScreen.dart';
import 'package:flutter_application_1/Screens/Sign_Screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubitt(),
        child: MaterialApp(
          home: BlocBuilder<AuthCubitt, AuthState>(
              buildWhen: (oldState, newState) {
            return oldState is AuthInitialState;
          }, builder: (context, state) {
            if (state is AuthLoggedInState) {
              return HomeScereen();
            } else if (state is AuthLoggedOutState) {
              return SignScreen();
            } else {
              return Scaffold();
            }
          }),
        ));
  }
}
