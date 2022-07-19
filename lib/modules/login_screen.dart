import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_states.dart';
import '../layout/shopLayout.dart';
import '../network/local/cache_helper.dart';
import '../shared/methods.dart';
import '../shared/widgets/reusable_button.dart';
import '../shared/widgets/reusable_text_button.dart';
import '../shared/widgets/reusable_text_field.dart';
import '../shared/widgets/reusable_toast.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer< LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then(
                (value) {
                  navigateToAndFinish(
                      widget: const ShopLayout(), context: context);
                },
              );
            } else {
              showToast(
                msg: state.loginModel.message!,
                toastStates: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          'Login now to browse our offers',
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ReusableTextField(
                          controller: emailController,
                          prefixIcon: Icons.email,
                          textLabel: 'Email Address',
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                          },
                          type: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ReusableTextField(
                          controller: passwordController,
                          prefixIcon: Icons.lock,
                          textLabel: 'Password',
                          suffixIcon: cubit.passwordIcon,
                          isPassword: cubit.isPassword,
                          onSubmit: (val) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          suffixPressed: () {
                            cubit.changePasswordState();
                          },
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          type: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        state is LoginLoadingState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : reusableButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'login',
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account ?',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            reusableTextButton(
                              text: 'sign up',
                              function: () {},
                            ),
                          ],
                        ),
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
