import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loudly/widgets/shared/card_secret.dart';
import 'package:loudly/widgets/screens/create_secret.dart';
import 'package:provider/provider.dart';

import '../providers/secret_provider.dart';

class SecretListScreen extends StatefulWidget {
  const SecretListScreen({Key? key}) : super(key: key);

  @override
  State<SecretListScreen> createState() => _SecretListScreenState();
}

class _SecretListScreenState extends State<SecretListScreen> {
  late ScrollController _hideButtonController;
  late bool _isVisible;
  late Future<void> _dataFuture;

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
    _dataFuture = context.read<SecretProvider>().syncData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<void>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<SecretProvider>().syncData();
                },
                child: GridView.count(
                  controller: _hideButtonController,
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  children: List.generate(
                      context.watch<SecretProvider>().secrets.length, (index) {
                    return CardSecret(
                        secret: context.watch<SecretProvider>().secrets[index]);
                  }),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
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
