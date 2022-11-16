import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/Cubits/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_1/Cubits/auth_cubit/auth_state.dart';
import 'package:flutter_application_1/Screens/Verify_Scree.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignScreen extends StatelessWidget {
  TextEditingController phonController = TextEditingController();

  SignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sign in with phone',
          textAlign: TextAlign.center,
        ),
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
                  controller: phonController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone Number',
                      label: Text('Enter your phone number')),
                ),
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<AuthCubitt, AuthState>(listener: (context, state) {
                  if (state is AuthCodeSendState) {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => VerifyScreen()));
                  }
                }, builder: (context, state) {
                  if (state is AuthCodeSendState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                        color: Colors.blue,
                        child: Text('Send OTP'),
                        onPressed: () {
                          String phoneNumber = "+91" + phonController.text;
                          BlocProvider.of<AuthCubitt>(context)
                              .sendOTP(phoneNumber);
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
