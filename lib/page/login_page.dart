import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Type {
  signIn,
  signUp,
}

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  Type authType = Type.signIn;

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _email,
                      decoration:
                          const InputDecoration(hintText: "example@gmail.com"),
                      validator: (value) {
                        if (value!.length > 9 && value.contains("@")) {
                          return null;
                        } else {
                          return "input email is invalid";
                        }
                      },
                    ),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: "password"),
                      validator: (value) {
                        if (value!.length > 8) {
                          return null;
                        } else {
                          return "password at least 9 character";
                        }
                      },
                    ),
                    if (authType == Type.signUp)
                      TextFormField(
                        controller: _confirmPassword,
                        obscureText: true,
                        decoration: const InputDecoration(hintText: "password"),
                        validator: (value) {
                          if (_password.text == _confirmPassword.text) {
                            return null;
                          } else {
                            return "Pasword is not same";
                          }
                        },
                      ),
                    ElevatedButton(
                        onPressed: () {},
                        child: (authType == Type.signIn)
                            ? const Text('SignIn')
                            : const Text('SignUp')),
                    const SizedBox(
                      height: 100,
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            authType = Type.signUp;
                          });
                        },
                        child: (authType == Type.signIn)
                            ? const Text("Signup")
                            : const Text("SignIn")),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
