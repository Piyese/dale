import 'package:dale/objectbox.g.dart';
import 'package:dale/pages/new_project.dart';
import 'package:dale/pages/proj_container.dart';
import 'package:dale/storeroom/models.dart';
import 'package:dale/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Store? _store;
  bool storeInitialized = false;
  late Box<Project> projBox;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((dir) {
      _store = Store(
        getObjectBoxModel(),
        directory: join(dir.path , 'objectbox')
      );
    }).then((value) {
      setState(() {
        storeInitialized = true;
        print(storeInitialized);
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    
    print("in build: $storeInitialized");

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context, 
            // TODO: deal with this store null check, might be a problem somewhere.
            MaterialPageRoute(builder: (context) => NewProjectForm(store: _store!,)),
          );
        },
        backgroundColor: const Color.fromARGB(255, 4, 88, 99),
        tooltip: "new project",
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Projects", style: TextStyle(fontWeight: FontWeight.bold),),
                IconButton(
                   icon: const Icon(Icons.filter_alt,), 
                   onPressed: () { },
                ),
              ],
            ),
          ),
          Expanded(
            child: _store != null ? ProjectsContainer(store: _store!) : const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _store?.close();
  }
}