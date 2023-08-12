import 'package:flutter/material.dart';
import 'package:loudly/widgets/providers/login_provider.dart';
import 'package:loudly/widgets/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 64,
              vertical: 16,
            ),
            child: _InputFormField(),
          ),
          Spacer(),
          _Register()
        ],
      ),
    );
  }
}

class _Register extends StatelessWidget {
  const _Register();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Don’t have an account?'),
        TextButton(
          onPressed: () {},
          child: const Text('Register'),
        ),
      ],
    );
  }
}

class _InputFormField extends StatelessWidget {
  const _InputFormField();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final textfieldEmailDecoration = InputDecoration(
      hintText: 'Email',
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      filled: true,
    );
    final textfieldPasswordDecoration = InputDecoration(
      hintText: 'Password',
      hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      filled: true,
    );

    return Column(
      children: [
        TextField(
          controller: emailController,
          decoration: textfieldEmailDecoration,
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: textfieldPasswordDecoration,
        ),
        const SizedBox(
          height: 32,
        ),
        FilledButton(
          onPressed: () {
            context
                .read<LoginProvider>()
                .loginAccount(
                  emailController.text,
                  passwordController.text,
                )
                .then((value) {
              if (value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              }
            });
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
