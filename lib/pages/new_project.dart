
import 'package:dale/objectbox.g.dart';
import 'package:dale/storeroom/models.dart';
import 'package:dale/widgets/header.dart';
import 'package:flutter/material.dart';

class NewProjectForm extends StatefulWidget {
  final Store store;

  const NewProjectForm({super.key, required this.store});

  @override
  State<NewProjectForm> createState() => _NewProjectFormState();
}

class _NewProjectFormState extends State<NewProjectForm> {
  final _formKey = GlobalKey<FormState>();
  bool initialized = false;

  late Box<Project> projectBox;
  
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _locController = TextEditingController();

  String? title;
  String? desc;
  String? size;
  String? location;

  @override
  void initState(){
    super.initState();
    setState(() {
      projectBox = widget.store.box<Project>();
      initialized = true;
    });
  }

  

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const Header(
          text: "New Project",
          height: 100,
          fontSize: 15,
          padding: 8,
          radius: 0,
        ),
        Expanded(
          child: Material(
            color: Colors.grey[300],
            child: Form(
              key: _formKey,
              child: Container(
                // color: Colors.blue,
                width: double.maxFinite,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 3) {
                          return "Minimum 3 characters required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        title = value;
                      },
                      controller: _titleController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        hintText: "Maize farm in Maai Mahiu",
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 15) {
                          return "Minimum 15 characters required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        desc = value;
                      },
                      controller: _descController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        hintText: "What, where, when, how, size of operation",
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "can't leave field empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        size = value;
                      },
                      controller: _sizeController,
                      maxLines: 1,
                      maxLength: 48,
                      decoration: const InputDecoration(
                        labelText: "Size",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        hintText: "2 greenhouses/2 acres/2 kgs",
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "can't leave field empty";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        location = value;
                      },
                      controller: _locController,
                      maxLines: 1,
                      maxLength: 96,
                      decoration: const InputDecoration(
                        labelText: "Location",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        hintText: "Matuu",
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8,right: 20.0),
                          child: ElevatedButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()){
                                _formKey.currentState!.save();
                                Project project = Project(
                                  title: title!, 
                                  description: desc!, 
                                  size: size!, 
                                  location: location!
                                );
                                // TODO: 'remove below print function'
                                print(project);
                                projectBox.put(project);
                                Navigator.pop(context);
                              }
                            }, 
                            child: const Icon (Icons.add_task_outlined, size: 25,),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ),
        ),
      ],
    );
  }
}