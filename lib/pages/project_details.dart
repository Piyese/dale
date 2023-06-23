import 'package:dale/objectbox.g.dart';
import 'package:dale/pages/new_activity.dart';
import 'package:dale/storeroom/models.dart';
import 'package:dale/widgets/activity_tile.dart';
import 'package:dale/widgets/test_formats.dart';
import 'package:flutter/material.dart';


class ProjectDetail extends StatefulWidget {
  final Project project;
  final Store store;
  
  const ProjectDetail({super.key, required this.project, required this.store});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  
  late Stream ac;
  bool initialized = false;

  @override
  void initState(){
    super.initState();
    setState(() {
      Box acBox = widget.store.box<Activity>();
      ac = acBox.query(Activity_.project.equals(widget.project.id)).watch(triggerImmediately: true).map((query) => query.find());
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top:35, right:12, left:12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AdjustableText(
                        text: widget.project.title, 
                        size: 15, 
                        bold: true,
                      ),
                      AdjustableText(
                        text: widget.project.location, 
                        size: 12, 
                        bold: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  AdjustableText(
                    text: widget.project.description,
                    size: 13, 
                    bold: false
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Activities", style: TextStyle(fontWeight: FontWeight.bold),),
                IconButton(
                    icon: const Icon(Icons.add_circle_rounded,), 
                    onPressed: () { 
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => NewActivity(store: widget.store, project: widget.project)),
                      );
                    },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(9),
                  topEnd: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: initialized ? StreamBuilder(
                    stream: ac, 
                    builder: (context, snapshot) {
                      if (snapshot.hasData){
                        return Column(
                          children: List.generate(snapshot.data!.length, (index) => ActivityTile(activity: widget.project.activities[index],),  )
                        ); 
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ) : const Center(child: Text("Nothing Yet!"))
                  // child: widget.project.activities.isNotEmpty ? Column(
                  //   children: List.generate(widget.project.activities.length, (index) => ActivityTile(activity: widget.project.activities[index],))           
                  // ) : const Center(child: Text("Nothing Yet!",style: TextStyle(color: Colors.white),)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}