import 'package:flutter/material.dart';
import 'package:search_in_pharmacy/screens/home_page.dart';
import 'package:search_in_pharmacy/services/locator.dart';
import 'package:search_in_pharmacy/services/pharmacy_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogging = false;
  TextEditingController usernameField = TextEditingController();
  TextEditingController passwordField = TextEditingController();

  tryLogin() async {
    if (mounted) {
      setState(() {
        isLogging = true;
      });
    }
    bool authenticated = await locator<Pharmacy>().login(
      username: usernameField.text,
      password: passwordField.text,
    );
    if (authenticated) {
      if (mounted) {
        setState(() {
          isLogging = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      }
    } else {
      if (mounted) {
        setState(() {
          isLogging = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "Pharmacy App",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 30),
              TextField(
                controller: usernameField,
                decoration: const InputDecoration(
                  labelText: "Username",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordField,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () {
                  if (usernameField.text.isNotEmpty &&
                      passwordField.text.isNotEmpty &&
                      !isLogging) {
                    tryLogin();
                  }
                },
                icon: isLogging
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeCap: StrokeCap.round,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.login),
                label: const Text("Login"),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
