import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/layout/shop_app/shop_layout.dart';
import 'package:shop/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop/modules/shop_app/login/cubit/states.dart';
import 'package:shop/modules/shop_app/register/register_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constains.dart';
import 'package:shop/shared/network/local/cache_helper.dart';


class ShopLoginScreen extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.data.token);
              print(state.loginModel.message);
              CacheHelper.saveData(key: 'token',
                value: state.loginModel.data.token,
              ).then((value){
                showToast(
                  text: state.loginModel.message,
                  state: ToastState.SUCCESS,
                );
                token = state.loginModel.data.token;
                navigateAndFinish(context,ShopLayout());
              });

            }
            else {
              print(state.loginModel.message);
              showToast(
                text: state.loginModel.message,
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline3.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.blueGrey,
                              ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: email,
                          type: TextInputType.emailAddress,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your email";
                            }
                          },
                          labelText: "Email Address",
                          prefix: Icons.email_outlined,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: password,
                          type: TextInputType.visiblePassword,
                          validation: (String value) {
                            if (value.isEmpty) {
                              return "Please enter your password";
                            }
                          },
                          suffixIcon: Icons.visibility,
                          onSubmit: (value) {
                            if (formKey.currentState.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: email.text,
                                password: password.text,
                              );
                            }
                          },
                          obscureText:
                              ShopLoginCubit.get(context).isPasswordShown,
                          suffixIconPress: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          labelText: "Password",
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            text: "Login",
                            function: () {
                              if (formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: email.text,
                                  password: password.text,
                                );
                              }
                            },
                            isUpperCase: true,
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'Sign Up',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
