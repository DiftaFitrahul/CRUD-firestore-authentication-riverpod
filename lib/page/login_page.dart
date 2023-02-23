import 'package:firestore_auth_riverpod/provider/auth/authentication_provider.dart';
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
    bool loginState = ref.watch(authStateProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                const SizedBox(
                  height: 200,
                ),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
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
                        return "Password is not same";
                      }
                    },
                  ),
                (loginState == true)
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          (authType == Type.signIn)
                              ? ref
                                  .read(authStateProvider.notifier)
                                  .signIn(_email.text, _password.text)
                                  .catchError((err) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(err.toString())));
                                })
                              : ref
                                  .read(authStateProvider.notifier)
                                  .signUp(_email.text, _confirmPassword.text)
                                  .catchError((err) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(err.toString())));
                                });
                        },
                        child: (authType == Type.signIn)
                            ? const Text('SignIn')
                            : const Text('SignUp')),
                const SizedBox(
                  height: 100,
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        if (authType == Type.signIn) {
                          authType = Type.signUp;
                        } else {
                          authType = Type.signIn;
                        }
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
