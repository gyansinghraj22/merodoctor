import 'package:flutter/material.dart';
import 'package:merodoctor/presentation/pages/authentication/login_page.dart';
import 'package:merodoctor/presentation/pages/authentication/signup_page.dart';
import 'package:merodoctor/register_option_page.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mero Doctor'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Book Appointments with Trusted Doctors",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Easily find and consult with certified doctors from anywhere.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RoleSelectionPage()),
                      );
                    },
                    child: const Text("Register"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SigninPage()),
                      );
                    },
                    child: const Text("Sign In"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
