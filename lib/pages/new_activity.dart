import 'package:dale/objectbox.g.dart';
import 'package:dale/storeroom/models.dart';
import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class NewActivity extends StatefulWidget {
  final Store store;
  final Project project;
  const NewActivity({super.key, required this.store, required this.project});

  @override
  State<NewActivity> createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
  int currentStep = 0;

  DateTime _selectedDate = DateTime.now();
  
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String desc;
  late int duration;
  late String remarks;
  late int cost;
  late DateTime date;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  
  late Box<Project> projectBox;
  late Box<Activity> activityBox;

  @override
  void initState(){
    super.initState();
    setState(() {
      projectBox = widget.store.box<Project>();
      activityBox = widget.store.box<Activity>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepCancel: () => currentStep == 0 ? null : setState((){ currentStep -= 1; }),
            onStepContinue: (){
              bool validation() {
                if (currentStep == 0) {
                  return _formKey.currentState!.validate();
                } else if(currentStep == 1) {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Activity activity = Activity(
                      title: title, 
                      description: desc, 
                      startDate: _selectedDate,
                    );

                    if (remarks.isNotEmpty) {
                      activity.addRemarks(remarks);
                    }
                    if (duration != 0) {
                      activity.addDuration(duration);
                    }
                    if (cost != 0) {
                      activity.addCost(cost);
                    }

                    widget.project.activities.add(activity);
                    projectBox.put(widget.project);

                    Navigator.pop(context);
                  }
                }
                return false;
              }
              validation() ? setState(() { currentStep += 1; }) : null ;
            },
            steps: [
              Step(
                state: currentStep > 0 ? StepState.complete : StepState.indexed,
                isActive: currentStep == 0,
                title: const Text("Main Info"), 
                content: Column(
                  children: [
                    const Text("Date",style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: 100,
                      child: ScrollDatePicker(
                        minimumDate: DateTime(2019),
                        maximumDate: DateTime(2045),
                        selectedDate: _selectedDate,
                        locale: const Locale('en'),
                        onDateTimeChanged: (DateTime value) {
                          setState(() {
                            _selectedDate = value;
                          });
                        },
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.length < 3) {
                          return "Minimum 3 characters required";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        title = value!;
                      },
                      controller: _titleController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        labelText: "Title",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        hintText: "Land leasing",
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        validator: (value) {
                          if (value!.length < 3) {
                            return "Minimum 3 characters required";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          desc = value!;
                        },
                        controller: _descController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: "Description",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                          border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Step(
                state: currentStep > 1 ? StepState.complete : StepState.indexed,
                title: const Text("Optionals"), 
                isActive: currentStep == 1,
                content: Column(
                  children: [
                    TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return null;
                          }
                          if (int.tryParse(value) == null) {
                            return "Not a valid number";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          cost = value!.isEmpty ? 0 : int.tryParse(value)!;
                        },
                        controller: _costController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          labelText: "Cost",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          hintText: "20000",
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return null;
                          }
                          if (int.tryParse(value) == null) {
                            return "Not a valid number";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          duration = value!.isEmpty ? 0 : int.tryParse(value)!;
                        },
                        controller: _durationController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          labelText: "Duration",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          helperText: "leave blank if, day = 1",
                          hintText: "2",
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return null;
                          }
                          if (value.length < 3) {
                            return "Minimum 3 characters required";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          remarks = value!;
                        },
                        controller: _remarksController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: "Remarks",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                      ),
                    ),
                  ],
                )
              ),
            ]
          ),
        ),
      ),
    );
  }
}