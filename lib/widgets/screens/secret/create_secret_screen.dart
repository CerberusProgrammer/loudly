import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loudly/widgets/providers/login_provider.dart';
import 'package:loudly/widgets/providers/secret_provider.dart';
import 'package:provider/provider.dart';

class CreateSecretScreen extends StatefulWidget {
  const CreateSecretScreen({super.key});

  @override
  State<CreateSecretScreen> createState() => _CreateSecretScreenState();
}

class _CreateSecretScreenState extends State<CreateSecretScreen> {
  Color background = Colors.deepPurple;
  double sizeText = 24;

  bool actionTextSizer = false;
  bool actionColorChanger = false;
  bool isAction = false;

  List<Color> colorList = [
    Colors.pink,
    Colors.deepPurple,
    Colors.indigo,
    Colors.orange,
    Colors.red,
    Colors.green,
  ];

  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetColorsSelector =
        List.generate(colorList.length, (index) {
      return IconButton(
          onPressed: () {
            setState(() {
              background = colorList[index];
            });
          },
          icon: Icon(
            Icons.circle,
            color: colorList[index],
          ));
    });

    widgetColorsSelector.add(
      IconButton(
        onPressed: () {
          setState(() {
            actionColorChanger = false;
            isAction = false;
          });
        },
        icon: const Icon(
          Icons.done,
          color: Colors.white,
          size: 30,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height / 1.04,
          color: Theme.of(context).colorScheme.background,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: background,
              child: Column(
                children: [
                  const _AppBar(),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            maxLines: null,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: 'Tell us your secret',
                              hintStyle: TextStyle(
                                color: Colors.white.withAlpha(150),
                                fontSize: sizeText,
                              ),
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: sizeText,
                            ),
                            onEditingComplete: () {
                              focusNode.unfocus();
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
                              color: Colors.white.withAlpha(1),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (actionColorChanger)
                                      SizedBox(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: widgetColorsSelector,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (actionTextSizer)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                            child: Slider(
                                              activeColor: background,
                                              value: sizeText,
                                              min: 20,
                                              max: 72,
                                              onChanged: (onChanged) {
                                                setState(() {
                                                  sizeText = onChanged;
                                                });
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                actionTextSizer = false;
                                                isAction = false;
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.done,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (!isAction)
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            actionColorChanger = true;
                                            isAction = true;
                                          });
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.palette,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    if (!isAction)
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isAction = true;
                                            actionTextSizer = true;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.format_size,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    if (!isAction)
                                      const SizedBox(
                                          height: 20, child: VerticalDivider()),
                                    if (!isAction)
                                      _UploadSecret(
                                        background: background,
                                        textEditingController:
                                            textEditingController,
                                        sizeText: sizeText,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UploadSecret extends StatelessWidget {
  const _UploadSecret({
    required this.background,
    required this.textEditingController,
    required this.sizeText,
  });

  final Color background;
  final TextEditingController textEditingController;
  final double sizeText;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<SecretProvider>().uploadSecret(
              user: context.read<LoginProvider>().userNow,
              color: background,
              content: textEditingController.text,
              fontSize: sizeText,
            );
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.upload,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
