import 'package:dale/pages/homepage.dart';
import 'package:dale/widgets/activity_tile.dart';
import 'package:dale/widgets/test_formats.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: Mapper()//const HomePage(),
    );
  }
}

class Mapper extends StatefulWidget {
  const Mapper({super.key});

  @override
  State<Mapper> createState() => _MapperState();
}

class _MapperState extends State<Mapper> {
  
  List whats = [];
  List howMuchs = [];

  final _formKey = GlobalKey<FormState>();
  
  List<TextEditingController> whatControllers = [TextEditingController()];
  List<TextEditingController> howMuchControllers = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            const SmallHeader(text: "Cost Breakdown"),
            Form(
              key: _formKey,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: whatControllers.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // color: Color.fromARGB(255, 231, 229, 203),
                          width: 150,
                          padding: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            controller: whatControllers[index],
                            decoration: const InputDecoration(
                              hintText: "dale",
                              labelText: "What",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Empty!!";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              whats.add(newValue);
                            },
                          ),
                        ),
                        Container(
                          color: Colors.lightBlue[100],
                          width: 150,
                          child: TextFormField(
                            controller: howMuchControllers[index],
                            decoration: const InputDecoration(
                              hintText: "10000",
                              labelText: "How much",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Empty!!";
                              }
                              if (int.tryParse(value) == null) {
                                return "Numbers only!!!";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              howMuchs.add(newValue);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: () {
              setState(() {
                whatControllers.add(TextEditingController());
                howMuchControllers.add(TextEditingController());
              });
            }, child: const Text("add more")),
            ElevatedButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print(whats);
                print(howMuchs);
              }
            }, child: const Text("save")),
          ],
        ),
      ),
    );

  }
}