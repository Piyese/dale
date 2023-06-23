import 'dart:io';

import 'package:objectbox/objectbox.dart';


@Entity()
class Activity {
  int id = 0;
  String title;
  DateTime startDate;
  String description;
  int? daysTaken;
  String? remarks;
  int? cost;
  // File? costBreakdownImage;
  

  final project = ToOne<Project>();

  Activity({
    required this.title,
    required this.description,
    required this.startDate,
    this.remarks,
    this.cost,
    this.daysTaken
  });

  void addCost(int cost) {
    this.cost = cost;
  }

  void addDuration(int tt) {
    daysTaken = tt;
  }
  
  void addRemarks(String rmks) {
    remarks = rmks;
  }
}

@Entity()
class Project {
  int id = 0;
  String title;
  String size;
  String location;
  String description;
  bool complete = false;
  int? totalCost;
  int? costSoFar;
  
  @Backlink()
  final activities = ToMany<Activity>();

  Project({
    required this.title,
    required this.description,
    required this.size,
    required this.location,
  });

  @override
  String toString() {
    return 'title: $title,\n description: $description,\n size: $size,\n location: $location'; 
  }
}

// recon missions
// prospect projects
// prospect activities