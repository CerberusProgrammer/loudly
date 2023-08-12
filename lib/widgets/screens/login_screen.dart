import 'package:flutter/material.dart';
import 'package:loudly/widgets/providers/login_provider.dart';
import 'package:loudly/widgets/screens/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 64,
              vertical: 16,
            ),
            child: _InputFormField(
              emailController: emailController,
              passwordController: passwordController,
            ),
          ),
          Text(context.watch<LoginProvider>().status),
          FilledButton(
            onPressed: () {
              context.read<LoginProvider>().loginAccount(
                    emailController.text,
                    passwordController.text,
                  );

              if (context.read<LoginProvider>().successfulLogin) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

class _InputFormField extends StatelessWidget {
  const _InputFormField({
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    final textfieldEmailDecoration = InputDecoration(
      hintText: 'Email',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      filled: true,
    );
    final textfieldPasswordDecoration = InputDecoration(
      hintText: 'Password',
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
      ],
    );
  }
}
