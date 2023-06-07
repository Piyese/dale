import 'package:dale/storeroom/models.dart';
import 'package:dale/widgets/activity_tile.dart';
import 'package:dale/widgets/test_formats.dart';
import 'package:flutter/material.dart';

class Item {
  String titletext;
  String expandedText;

  Item({required this.titletext, required this.expandedText});
}


class ProjectDetail extends StatefulWidget {
  final Project project;
  
  const ProjectDetail({super.key, required this.project});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  Activity one = Activity(
    title: "Land Leasing", 
    description: "Leasing of land from Mr. kaleke(10acres) and Mr. Ominde(5 acres). paid 30000 on site and will add the rest(20000) on friday. paid 5000/acre ", 
    startDate: DateTime(2023, 2, 5),
    cost: 10000,
    remarks: "leasing land during the kiangazi is a way better approach because the owner wako na more njaa so the lease it at a cheaper price than when the demand is high"
  );
  Activity two = Activity(
    title: "Land Tilling", 
    description: "tilling of the land in preparation for the rain and subsequent planting of crops.", 
    startDate: DateTime(2023, 7, 16),
    cost: 26000,
    daysTaken: 2,
  );

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
                    onPressed: () { },
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
                  child:Column(
                    children: [
                      ActivityTile(activity: one,),
                      ActivityTile(activity: two,),
                    ],
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}