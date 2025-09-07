
import 'package:flutter/material.dart';
import 'package:merodoctor/service_locator.dart';

import 'package:merodoctor/common/widgets/appbar/app_bar.dart';
import 'package:merodoctor/common/widgets/button/basic_app_button.dart';
import 'package:merodoctor/data/model/create_user_model.dart';
import 'package:merodoctor/domain/usecases/user/sign_up.dart';
import 'package:merodoctor/presentation/pages/authentication/login_page.dart';
import 'package:merodoctor/presentation/pages/home_page.dart';


class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        // title: SvgPicture.asset(AppVectors.logo, height: 20, width: 20),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(height: 50),
              _fullNameField(context),
              const SizedBox(height: 20),
              _emailField(context),
              const SizedBox(height: 20),
              _passwordField(context),
              const SizedBox(height: 20),
              BasicAppButton(
                onPressed: () async {
                  var result = await sl<SignUpUseCase>().call(
                    params: CreateUserReq(
                      fullName: fullNameController.text.toString(),
                      email: emailController.text.toString(),
                      password: passwordController.text.toString(),
                    ),
                  );
                  result.fold(
                    (l) {
                      var snackBar = SnackBar(
                        content: Text(l.message),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    (r) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                  );
                },
                title: "Create Account",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _signinText(context),
    );
  }

  Widget _registerText() {
    return const Text(
      "Register",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: fullNameController,
      decoration: InputDecoration(
        hintText: "Full Name",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: "Email",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: passwordController,
      decoration: InputDecoration(
        hintText: "Password",
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signinText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Do you have an account ?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SigninPage(),
                ),
              );
            },
            child: Text("Sign In"),
          ),
        ],
      ),
    );
  }
}
