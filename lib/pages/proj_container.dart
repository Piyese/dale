import 'package:dale/objectbox.g.dart';
import 'package:flutter/material.dart';

import '../storeroom/models.dart';
import '../widgets/project_view.dart';


class ProjectsContainer extends StatefulWidget {
  final Store store;

  const ProjectsContainer({super.key, required this.store});

  @override
  State<ProjectsContainer> createState() => _ProjectsContainerState();
}

class _ProjectsContainerState extends State<ProjectsContainer> {
  bool hasInitialized = false;

  late Stream<List<Project>> projListStream;

  @override
  void initState() {
    super.initState();
    setState(() {
      projListStream = widget.store.box<Project>().query().watch(triggerImmediately: true).map((query) => query.find());
      hasInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(8),
          topEnd: Radius.circular(8),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: hasInitialized ? StreamBuilder(
          stream: projListStream, 
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: List.generate(snapshot.data!.length, (index) => ProjectView(project: snapshot.data![index]))
              ); 
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ) : const Center(child: Text("Nothing Yet!"))
      ),
    );
  }
}