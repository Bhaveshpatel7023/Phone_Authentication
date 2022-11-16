import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/Cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_1/Cubits/auth_cubit/auth_state.dart';
import 'package:flutter_application_1/Screens/Sign_Screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScereen extends StatelessWidget {
  const HomeScereen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: BlocConsumer<AuthCubitt, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOutState) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => SignScreen(),
                ));
          }
        },
        builder: (context, state) {
          return CupertinoButton(
              child: Text('LogOut'),
              onPressed: () {
                BlocProvider.of<AuthCubitt>(context).logOut();
              });
        },
      )),
    );
  }
}
