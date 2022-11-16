import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/Cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_1/Cubits/auth_cubit/auth_state.dart';
import 'package:flutter_application_1/Screens/HomeScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyScreen extends StatelessWidget {
  TextEditingController otpController = TextEditingController();

  VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Verify Phone'),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: otpController,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '6-Digit OTP',
                      label: Text('Enter OTP')),
                ),
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<AuthCubitt, AuthState>(listener: (context, state) {
                  if (state is AuthLoggedInState) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => HomeScereen()));
                  } else if (state is AuthErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(state.error),
                      duration: Duration(microseconds: 6000),
                    ));
                  }
                }, builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                        color: Colors.blue,
                        child: Text('Sign In'),
                        onPressed: () {
                          BlocProvider.of<AuthCubitt>(context)
                              .verifyOTP(otpController.text);
                        }),
                  );
                })
              ],
            ),
          )
        ],
      )),
    );
  }
}
