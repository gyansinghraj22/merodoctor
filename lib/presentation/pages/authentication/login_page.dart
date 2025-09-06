
import 'package:flutter/material.dart';
import 'package:merodoctor/service_locator.dart';

import 'package:merodoctor/common/widgets/appbar/app_bar.dart';
import 'package:merodoctor/common/widgets/button/basic_app_button.dart';
import 'package:merodoctor/data/model/login_user_model.dart';
import 'package:merodoctor/domain/usecases/auth/login.dart';
import 'package:merodoctor/presentation/pages/authentication/signup_page.dart';
import 'package:merodoctor/presentation/pages/home_page.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        // title: Image.network(
        //   "data:image/jpeg;base64,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",
        // ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _signinText(),
              const SizedBox(height: 50),
              _emailField(context),
              const SizedBox(height: 20),
              _passwordField(context),
              const SizedBox(height: 20),
              BasicAppButton(
                onPressed: () async {
                  var result = await sl<LoginUseCase>().call(
                    params: LoginUserReq(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString(),
                    ),
                  );
                  result.fold(
                    (l) {
                      var snackBar = SnackBar(
                        content: Text(l.message),
                        behavior: SnackBarBehavior.floating,
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
                title: "Sign In",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _signupText(context),
    );
  }

  Widget _signinText() {
    return const Text(
      "Sign In",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
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

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Dont have an account?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SignupPage(),
                ),
              );
            },
            child: Text("Register Now"),
          ),
        ],
      ),
    );
  }
}
