import 'package:flutter/material.dart';
import 'package:dale/widgets/test_formats.dart';




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
      child: Column(
        children: [
          // const SmallHeader(text: "Cost Breakdown"),
          Form(
            key: _formKey,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: whatControllers.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(2),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: const Color.fromARGB(255, 241, 241, 232),
                        width: 150,
                        child: TextFormField(
                          controller: whatControllers[index],
                          decoration: const InputDecoration(
                            hintText: "labour",
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
                        color: const Color.fromARGB(255, 213, 228, 235),
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
          Padding(
            padding: const EdgeInsets.only(right: 38.0 , left: 38),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: () {
                  if (whatControllers.length < 6) {
                    setState(() {
                    whatControllers.add(TextEditingController());
                    howMuchControllers.add(TextEditingController());
                  });
                  } 
                }, child: const Text("add cell")),
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
        ],
      ),
    );

  }
}