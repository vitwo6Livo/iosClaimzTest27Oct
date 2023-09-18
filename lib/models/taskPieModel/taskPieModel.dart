// import 'package:flutter/material.dart';
// import '../../viewModel/toDoViewModel/todaysTask.dart';

// class TaskPieModel {
//   final String? name;
//   final int? percent;
//   final int? noOfTasks;
//   final Color? colors;

//   TaskPieModel({this.name, required this.percent, required this.noOfTasks, this.colors});
// }

// class PieTaskData {
//   TodaysTaskList tasks = TodaysTaskList();

//   PieTaskData() {
//     tasks.getTodaysTasks(1);
//   }

//   int _presentPercent = 0;
//   int _pastPercent = 0;
//   int _futurePercent = 0;

//   int _presentTasks = 0;
//   int _pastTasks = 0;
//   int _futureTasks = 0;

//   int get totalTasks {
//     return tasks.getToDoList['today'].length + tasks.getToDoList['upcoming'].length + tasks.getToDoList['previous'].length;
//   }

//   int get presentPercent {
//     _presentPercent = (tasks.getToDoList['today'].length / totalTasks) * 100;
//     return _presentPercent;
//   }

//   int get pastPercent {
//     _pastPercent = (tasks.getToDoList['today_length'] / totalTasks) * 100;
//     return _pastPercent;
//   }

//   int get futurePercent {
//     _futurePercent = (tasks.getToDoList['upcoming'].length / totalTasks) * 100;
//     return _futurePercent;
//   }

//   int get presentTasks {
//     _presentTasks = tasks.getToDoList['today'].length;
//     return _presentTasks;
//   }

//   int get pastTasks {
//     _pastTasks = tasks.getToDoList['previous'].length;
//     return _pastTasks;
//   }

//   int get futureTasks {
//     _futureTasks = tasks.getToDoList['upcoming'].length;
//     return _futureTasks;
//   }

//   // List<TaskPieModel> data = [
//   //   TaskPieModel(
//   //       name: 'Present', 
//   //       percent: presentPercent, 
//   //       noOfTasks: presentPercent, 
//   //       colors: Colors.amber),

//   //   TaskPieModel(
//   //     name: 'Past', 
//   //     percent: 0, 
//   //     noOfTasks: 0, 
//   //     colors: Colors.red),

//   //   TaskPieModel(
//   //     name: 'Future', 
//   //     percent: 0, 
//   //     noOfTasks: 0, 
//   //     colors: Colors.blue)
//   // ];
// }
