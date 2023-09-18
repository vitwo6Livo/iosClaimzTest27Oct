// import 'package:accordion/accordion.dart';
// import 'package:claimz/data/response/status.dart';
// import 'package:claimz/res/components/alert_dialog.dart';
// import 'package:accordion/controllers.dart';
// import 'package:claimz/res/components/containerStyle.dart';
// import 'package:claimz/utils/routes/routeNames.dart';
// import 'package:claimz/viewModel/toDoViewModel/todaysTask.dart';
// import 'package:claimz/views/config/mediaQuery.dart';
// // import 'package:accordion/controllers.dart';
// // import 'package:claimz/res/components/alert_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:roundcheckbox/roundcheckbox.dart';
// import 'package:provider/provider.dart';
// import '../../../viewModel/toDoViewModel.dart';
// import '../../../viewModel/toDoViewModel/completedTaskList.dart';
// import '../../../viewModel/toDoViewModel/previousTaskList.dart';
// import '../../../viewModel/toDoViewModel/tasksViewModel.dart';
// import '../../../viewModel/toDoViewModel/upcomingTaskList.dart';
// import '../../screens/taskCompleteScreen.dart';
// // import 'package:provider/provider.dart';t';

// class TaskContainer extends StatefulWidget {
//   // const TaskContainer({Key? key}) : super(key: key);
//   @override
//   State<TaskContainer> createState() => _TaskContainerState();
// }

// class _TaskContainerState extends State<TaskContainer> {
//   TasksViewModel tasksViewModel = TasksViewModel();

//   @override
//   void initState() {
//     // TODO: implement initState.
//     tasksViewModel.getPreviousTask();
//     tasksViewModel.getTodaysTask();
//     tasksViewModel.getUpcomingTask();
//     tasksViewModel.getCompletedTask();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           // height: SizeVariables.getHeight(context)*0.7,
//           // color: Colors.red,
//           child: Accordion(
//             // maxOpenSections: 2,
//             headerBackgroundColorOpened: Colors.black54,
//             scaleWhenAnimating: true,
//             openAndCloseAnimation: true,
//             headerPadding:
//                 const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//             sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
//             sectionClosingHapticFeedback: SectionHapticFeedback.light,
//             // ignore: sort_child_properties_last
//             children: [
//               AccordionSection(
//                 isOpen: true,
//                 // leftIcon: const Icon(Icons.compare_rounded, color: Colors.white),
//                 header: Text('Previous',
//                     style: Theme.of(context).textTheme.bodyText2),
//                 // contentBorderColor:Colors.amber,
//                 // headerBackgroundColorOpened: Colors.amber,
//                 content: Container(
//                     height: SizeVariables.getHeight(context) * 0.4,
//                     // color: Colors.green,
//                     child: ChangeNotifierProvider<TasksViewModel>(
//                       create: (context) => tasksViewModel,
//                       child: Consumer<TasksViewModel>(
//                           builder: (context, value, child) {
//                         switch (value.previousModelList.status) {
//                           case Status.LOADING:
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           case Status.ERROR:
//                             return Center(
//                               child: Text(
//                                   value.previousModelList.message.toString()),
//                             );
//                           case Status.COMPLETED:
//                             return ListView.builder(
//                               itemBuilder: (context, index) => Container(
//                                 margin: EdgeInsets.only(
//                                     bottom: SizeVariables.getHeight(context) *
//                                         0.02),
//                                 child: ContainerStyle(
//                                   height:
//                                       SizeVariables.getHeight(context) * 0.08,
//                                   child: Row(
//                                     children: [
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                           left:
//                                               SizeVariables.getWidth(context) *
//                                                   0.03,
//                                           // top: SizeVariables.getHeight(context)*0.03,
//                                         ),
//                                         child: RoundCheckBox(
//                                           onTap: (selected) {
//                                             Map<String, dynamic> _data = {
//                                               'id': value.previousModelList
//                                                   .data!.today![index].taskId
//                                                   .toString(),
//                                             };
//                                             Provider.of<TasksViewModel>(context,
//                                                     listen: false)
//                                                 .changeTaskStatus(
//                                                     _data, context);
//                                             // ChangeNotifierProvider<
//                                             //     PreviousTaskList>(
//                                             //   create: (context) =>
//                                             //       previousTaskList,
//                                             // );
//                                             // previousTaskList.getPreviousList();
//                                           },
//                                           size: 23,
//                                           // uncheckedColor: Colors.yellow,
//                                           checkedColor: Colors.grey,
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: EdgeInsets.only(
//                                             left: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.025,
//                                             top: SizeVariables.getHeight(
//                                                     context) *
//                                                 0.02),
//                                         child: Column(
//                                           children: [
//                                             FittedBox(
//                                               fit: BoxFit.contain,
//                                               child: Text(
//                                                 value.previousModelList.data!
//                                                     .today![index].taskName
//                                                     .toString(),
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1,
//                                               ),
//                                             ),
//                                             FittedBox(
//                                               fit: BoxFit.contain,
//                                               child: Text(
//                                                 value.previousModelList.data!
//                                                     .today![index].taskDate
//                                                     .toString(),
//                                                 style: const TextStyle(
//                                                     color: Colors.red),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               itemCount:
//                                   value.previousModelList.data!.today!.length,
//                             );
//                           default:
//                         }
//                         return Container();
//                       }),
//                     )),
//               ),
//               AccordionSection(
//                 isOpen: false,
//                 // leftIcon: const Icon(Icons.food_bank, color: Colors.white),
//                 header:
//                     Text('Today', style: Theme.of(context).textTheme.bodyText2),
//                 content: Container(
//                     margin: EdgeInsets.only(
//                         bottom: SizeVariables.getHeight(context) * 0.02),
//                     height: SizeVariables.getHeight(context) * 0.4,
//                     child: ChangeNotifierProvider<TasksViewModel>(
//                       create: (context) => tasksViewModel,
//                       child: Consumer<TasksViewModel>(
//                         builder: (context, value, child) {
//                           switch (value.todayModelList.status) {
//                             case Status.LOADING:
//                               return const Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             case Status.ERROR:
//                               return Center(
//                                 child: Text(
//                                     value.todayModelList.message.toString()),
//                               );
//                             case Status.COMPLETED:
//                               return ListView.builder(
//                                   itemBuilder: (context, index) => Container(
//                                         margin: EdgeInsets.only(
//                                             bottom: SizeVariables.getHeight(
//                                                     context) *
//                                                 0.02),
//                                         child: ContainerStyle(
//                                           height:
//                                               SizeVariables.getHeight(context) *
//                                                   0.08,
//                                           child: Row(
//                                             children: [
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                   left: SizeVariables.getWidth(
//                                                           context) *
//                                                       0.03,
//                                                   // top: SizeVariables.getHeight(context)*0.03,
//                                                 ),
//                                                 child: RoundCheckBox(
//                                                   onTap: (selected) {
//                                                     Map<String, dynamic> _data =
//                                                         {
//                                                       'id': value
//                                                           .todayModelList
//                                                           .data!
//                                                           .today![index]
//                                                           .taskId
//                                                           .toString()
//                                                     };
//                                                     Provider.of<TasksViewModel>(
//                                                             context,
//                                                             listen: false)
//                                                         .changeTaskStatus(
//                                                             _data, context);

//                                                     // Provider.of<ToDoViewModel>(
//                                                     //         context,
//                                                     //         listen: false)
//                                                     //     .postToDoList(_data);
//                                                     // todaysTaskList.getTodayList();
//                                                   },
//                                                   size: 23,
//                                                   // uncheckedColor: Colors.yellow,
//                                                   checkedColor: Colors.grey,
//                                                 ),
//                                               ),
//                                               Column(
//                                                 children: [
//                                                   Padding(
//                                                     padding: EdgeInsets.only(
//                                                         left: SizeVariables
//                                                                 .getHeight(
//                                                                     context) *
//                                                             0.02,
//                                                         top: SizeVariables
//                                                                 .getHeight(
//                                                                     context) *
//                                                             0.028),
//                                                     child: FittedBox(
//                                                       fit: BoxFit.contain,
//                                                       child: Text(
//                                                         value
//                                                             .todayModelList
//                                                             .data!
//                                                             .today![index]
//                                                             .taskName
//                                                             .toString(),
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .bodyText1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                   itemCount:
//                                       value.todayModelList.data!.today!.length);
//                             default:
//                           }
//                           return Container();
//                         },
//                       ),
//                     )),
//               ),
//               AccordionSection(
//                 isOpen: false,
//                 // leftIcon: const Icon(Icons.contact_page, color: Colors.white),
//                 header: Text('Future',
//                     style: Theme.of(context).textTheme.bodyText2),
//                 content: Container(
//                     height: SizeVariables.getHeight(context) * 0.4,
//                     child: ChangeNotifierProvider<TasksViewModel>(
//                       create: (context) => tasksViewModel,
//                       child: Consumer<TasksViewModel>(
//                         builder: (context, value, child) {
//                           switch (value.nextModelList.status) {
//                             case Status.LOADING:
//                               return const Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             case Status.ERROR:
//                               return Center(
//                                 child: Text(
//                                     value.nextModelList.message.toString()),
//                               );
//                             case Status.COMPLETED:
//                               return ListView.builder(
//                                 itemBuilder: (context, index) => Container(
//                                   margin: EdgeInsets.only(
//                                       bottom: SizeVariables.getHeight(context) *
//                                           0.02),
//                                   child: ContainerStyle(
//                                     height:
//                                         SizeVariables.getHeight(context) * 0.08,
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                             left: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.03,
//                                             // top: SizeVariables.getHeight(context)*0.03,
//                                           ),
//                                           child: RoundCheckBox(
//                                             onTap: (selected) {
//                                               Map<String, dynamic> _data = {
//                                                 'id': value.nextModelList.data!
//                                                     .today![index].taskId
//                                                     .toString()
//                                               };
//                                               Provider.of<TasksViewModel>(
//                                                       context,
//                                                       listen: false)
//                                                   .changeTaskStatus(
//                                                       _data, context);

//                                               // Provider.of<ToDoViewModel>(context,
//                                               //         listen: false)
//                                               //     .postToDoList(_data);
//                                             },
//                                             size: 23,
//                                             // uncheckedColor: Colors.yellow,
//                                             checkedColor: Colors.grey,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(
//                                               left: SizeVariables.getWidth(
//                                                       context) *
//                                                   0.02,
//                                               top: SizeVariables.getHeight(
//                                                       context) *
//                                                   0.02),
//                                           child: Column(
//                                             children: [
//                                               FittedBox(
//                                                 fit: BoxFit.contain,
//                                                 child: Text(
//                                                   value.nextModelList.data!
//                                                       .today![index].taskName
//                                                       .toString(),
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyText1,
//                                                 ),
//                                               ),
//                                               FittedBox(
//                                                 fit: BoxFit.contain,
//                                                 child: Text(
//                                                   value.nextModelList.data!
//                                                       .today![index].taskDate
//                                                       .toString(),
//                                                   style: const TextStyle(
//                                                       color: Colors.amber),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 itemCount:
//                                     value.nextModelList.data!.today!.length,
//                               );
//                             default:
//                           }
//                           return Container();
//                         },
//                       ),
//                     )),
//               ),
//             ],
//             contentBackgroundColor: Colors.black,
//             headerBackgroundColor: Colors.black,
//             contentBorderColor: Colors.black,
//           ),
//         ),
//         Padding(
//           padding:
//               EdgeInsets.only(right: SizeVariables.getWidth(context) * 0.6),
//           child: TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.blue,
//               primary: Colors.white,
//             ),
//             onPressed: () {
//               // Navigator.pushNamed(context, RouteNames.taskcomplete,);
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => TaskComplete()));
//             },
//             child: const Text(
//               "Completed List",
//               style: TextStyle(
//                 //color: Colors.blue,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
