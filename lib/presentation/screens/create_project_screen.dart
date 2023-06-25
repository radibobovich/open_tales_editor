import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  TextEditingController nameCtrl = TextEditingController();
  final nameKey = GlobalKey<FormState>();

  TextEditingController identifierCtrl = TextEditingController();
  final identifierKey = GlobalKey<FormState>();

  TextEditingController indicatorsListCtrl = TextEditingController();
  final indicatorsKey = GlobalKey<FormState>();

  TextEditingController descriptionCtrl = TextEditingController();
  final descriptionKey = GlobalKey<FormState>();

  TextEditingController authorCtrl = TextEditingController();
  final authorKey = GlobalKey<FormState>();

  TextEditingController versionCtrl = TextEditingController();
  final versionKey = GlobalKey<FormState>();

  TextEditingController initialCardCtrl = TextEditingController();
  final initialCardKey = GlobalKey<FormState>();

  List<String> indicators = [];
  String difficulty = "medium";
  bool noLoses = false;
  Color cardColor = const Color.fromARGB(255, 255, 212, 112);
  Color backgroundColor = const Color.fromARGB(255, 41, 19, 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Project'),
          actions: [
            IconButton(onPressed: confirmCreation, icon: const Icon(Icons.done))
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // input field for name:
              Form(
                key: nameKey,
                child: TextFormField(
                  controller: nameCtrl,
                  validator: validateField,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
              ),
              Form(
                key: identifierKey,
                child: TextFormField(
                  controller: identifierCtrl,
                  validator: validateField,
                  decoration: const InputDecoration(
                    labelText: 'Identifier',
                  ),
                ),
              ),
              Form(
                key: descriptionKey,
                child: TextFormField(
                  controller: descriptionCtrl,
                  validator: validateField,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
              ),
              Form(
                key: authorKey,
                child: TextFormField(
                  controller: authorCtrl,
                  validator: validateField,
                  decoration: const InputDecoration(
                    labelText: 'Author',
                  ),
                ),
              ),
              Form(
                key: versionKey,
                child: TextFormField(
                  controller: versionCtrl,
                  validator: validateField,
                  decoration: const InputDecoration(
                    labelText: 'Version',
                  ),
                ),
              ),
              Form(
                key: indicatorsKey,
                child: Indicators(
                  indicatorsListController: indicatorsListCtrl,
                  indicators: indicators,
                ),
              ),
              Row(
                children: [
                  const Text("Difficulty: "),
                  DropdownButton<String>(
                    items: const [
                      DropdownMenuItem(value: "easy", child: Text("Easy")),
                      DropdownMenuItem(value: "medium", child: Text("Medium")),
                      DropdownMenuItem(value: "hard", child: Text("Hard")),
                    ],
                    value: difficulty,
                    onChanged: (value) {
                      setState(() {
                        difficulty = value!;
                      });
                    },
                  )
                ],
              ),
              Row(
                children: [
                  const Text("Can't lose: "),
                  Checkbox(
                      value: noLoses,
                      onChanged: (value) {
                        setState(() {
                          noLoses = value!;
                        });
                      })
                ],
              ),
              Form(
                key: initialCardKey,
                child: TextFormField(
                  validator: validateField,
                  decoration: const InputDecoration(
                    labelText: 'Initial card',
                  ),
                ),
              ),
              Row(
                children: [
                  const Text("Card color:"),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return pickColor(context, "card");
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: cardColor),
                    child: Container(),
                  )
                ],
              ),
              Row(
                children: [
                  const Text("Background color:"),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return pickColor(context, "background");
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor),
                    child: Container(),
                  )
                ],
              ),
            ],
          ),
        )));
  }

  String? validateField(value) {
    if (value == null || value.isEmpty) {
      return ("Cannot be empty");
    }
    return null;
  }

  void confirmCreation() {
    bool validated = true;
    List<GlobalKey<FormState>> keys = [
      nameKey,
      identifierKey,
      descriptionKey,
      authorKey,
      versionKey,
      initialCardKey,
      indicatorsKey
    ];
    for (var key in keys) {
      if (!key.currentState!.validate()) {
        validated = false;
        continue;
      }
    }
    if (validated) {}
  }

  AlertDialog pickColor(BuildContext context, String changedColor) {
    return AlertDialog(
      title: const Text("Pick a color"),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: changedColor == "card" ? cardColor : backgroundColor,
          hexInputBar: true,
          onColorChanged: (color) {
            setState(() {
              changedColor == "card"
                  ? cardColor = color
                  : backgroundColor = color;
            });
          },
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"))
      ],
    );
  }
}

class Indicators extends StatefulWidget {
  final List<String> indicators;

  final TextEditingController indicatorsListController;

  const Indicators(
      {super.key,
      required this.indicatorsListController,
      required this.indicators});

  @override
  State<Indicators> createState() => _IndicatorsState();
}

class _IndicatorsState extends State<Indicators> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (widget.indicators.isEmpty) {
                    return "Indicators list cannot be empty";
                  }
                  return null;
                },
                controller: widget.indicatorsListController,
                decoration: const InputDecoration(
                  labelText: 'Add indicator',
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  if (widget.indicatorsListController.text.isEmpty) return;
                  widget.indicators.add(widget.indicatorsListController.text);
                  setState(() {});
                },
                icon: const Icon(Icons.add))
          ],
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.indicators.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.indicators[index]),
                onTap: () {
                  widget.indicators.removeAt(index);
                  setState(() {});
                },
              );
            }),
      ],
    );
  }
}
