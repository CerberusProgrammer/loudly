import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loudly/widget/card_secret.dart';
import 'package:loudly/widget/create_secret.dart';

import '../model/secret.dart';

List<Secret> secrets = [
  Secret(content: 'ksjdd', fontSize: 50),
  Secret(content: 'ksjdd', backgroundColor: Colors.purple, fontSize: 40),
  Secret(content: 'ksjdd', backgroundColor: Colors.pink, fontSize: 40),
  Secret(content: 'ksjdd', backgroundColor: Colors.indigo, fontSize: 32)
];

class SecretScreen extends StatefulWidget {
  const SecretScreen({super.key});

  @override
  State<SecretScreen> createState() => _SecretScreenState();
}

class _SecretScreenState extends State<SecretScreen> with ChangeNotifier {
  late ScrollController _hideButtonController;

  late bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = true;
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          controller: _hideButtonController,
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          children: List.generate(secrets.length, (index) {
            return CardSecret(secret: secrets[index]);
          }),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return const CreateSecret();
            }));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
