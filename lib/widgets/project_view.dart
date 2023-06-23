import "dart:math";

import "package:dale/objectbox.g.dart";
import "package:dale/pages/project_details.dart";
import "package:dale/storeroom/models.dart";
import "package:flutter/material.dart";

class ProjectView extends StatelessWidget {
  final Project project;
  final Store store;

  const ProjectView({super.key, required this.project, required this.store});

  @override
  Widget build(BuildContext context) {

    final List images = [
      'lib/assets/images/bg1.png',
      'lib/assets/images/bg2.png',
      'lib/assets/images/bg3.png',
      'lib/assets/images/bg4.png',
      'lib/assets/images/bg5.png',
      'lib/assets/images/bg6.png',
      'lib/assets/images/bg8.jpg',
    ];

    return InkWell(
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => ProjectDetail(project: project, store: store,)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(images[Random().nextInt(7)]),
            opacity: 0.9,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.only(top:8, left: 8, right: 8, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  project.location,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        offset: Offset(1, 1),
                        blurRadius: 20,
                      )
                    ]
                  ),
                ),
                Icon( 
                  Icons.circle,
                  size: 16,
                  color: project.complete ? Colors.green : const Color.fromARGB(255, 241, 237, 0),
                ),
              ],
            ),
            Text(
              project.title,
              textAlign: TextAlign.center,
              // overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.7,
                shadows: [
                  Shadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                    offset: Offset(1, 1),
                    blurRadius: 20,
                  )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

