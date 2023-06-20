import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login'), centerTitle: true,),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller:_email,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Please Enter Your Email',
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Please Enter Your password',
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('Login'),),
              TextButton(onPressed: () {},
                child: const Text("Don't have an account? Register Now!"),),
            ],
          ),
        )

    );
  }
}
