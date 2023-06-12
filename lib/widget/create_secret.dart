import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateSecret extends StatefulWidget {
  const CreateSecret({super.key});

  @override
  State<CreateSecret> createState() => _CreateSecretState();
}

class _CreateSecretState extends State<CreateSecret> {
  double cardX = 0;
  double cardY = 0;

  double dx = 0;
  double dy = 0;

  Color background = Colors.orange;
  double sizeText = 24;
  Color colorText = Colors.white;

  bool actionTextSizer = false;
  bool actionColorSelector = false;
  bool actionColorChanger = false;
  bool isAction = false;

  List<Color> colorList = [
    Colors.pink,
    Colors.blueGrey,
    Colors.indigo,
    Colors.orange,
    Colors.red,
    Colors.green,
  ];

  List<TextStyle> fontList = [
    GoogleFonts.roboto(),
    GoogleFonts.anton(),
    GoogleFonts.andika(),
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();

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
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: background,
              child: Column(
                children: [
                  Row(
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
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            focusNode: focusNode,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
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
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Transform.translate(
                            offset: Offset(cardX, cardY),
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
                                        SingleChildScrollView(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: widgetColorsSelector,
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
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.format_color_text,
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
                                        GestureDetector(
                                          onPanStart: (details) {
                                            dx = details.localPosition.dx -
                                                cardX;
                                            dy = details.localPosition.dy -
                                                cardY;
                                          },
                                          onPanUpdate: (details) {
                                            double limitX =
                                                MediaQuery.of(context)
                                                    .size
                                                    .width;
                                            double limitY =
                                                MediaQuery.of(context)
                                                    .size
                                                    .height;

                                            if ((details.globalPosition.dx <
                                                        limitX - 60 &&
                                                    details.globalPosition.dy <
                                                        limitY - 70) &&
                                                (details.globalPosition.dx >
                                                        260 &&
                                                    details.globalPosition.dy >
                                                        200)) {
                                              setState(() {
                                                cardX =
                                                    details.localPosition.dx -
                                                        dx;
                                                cardY =
                                                    details.localPosition.dy -
                                                        dy;
                                              });
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.menu,
                                              color:
                                                  Colors.white.withAlpha(100),
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
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
