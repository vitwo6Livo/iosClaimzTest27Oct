import 'package:claimz/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import '../../res/components/containerStyle.dart';
import '../../utils/routes/routeNames.dart';
import '../../viewModel/toDoViewModel/completedTaskList.dart';
import '../../viewModel/toDoViewModel/tasksViewModel.dart';
import '../config/mediaQuery.dart';
import '../../views/screens/taskCompleteScreen.dart';
import 'package:intl/intl.dart';

class TaskComplete extends StatefulWidget {
  // const TaskComplete({Key? key}) : super(key: key);
  @override
  State<TaskComplete> createState() => _TaskCompleteState();
}

class _TaskCompleteState extends State<TaskComplete> {
  CompletedTaskList taskList = CompletedTaskList();

  @override
  void initState() {
    // TODO: implement initState
    taskList.getCompletedList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              // image: DecorationImage(image: AssetImage(
              //   "assets/img/bg.png"),
              //   fit: BoxFit.cover,
              // ),
              ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: SizeVariables.getHeight(context) * 0.03,
                    left: SizeVariables.getWidth(context) * 0.025),
                child: Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/back button.svg",
                        ),
                      ),
                      // ProfilededarWidget(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeVariables.getHeight(context) * 0.01,
                            right: SizeVariables.getWidth(context) * 0.05),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Completed Tasks',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: SizeVariables.getHeight(context) * 0.02,
                    left: SizeVariables.getWidth(context) * 0.03,
                    right: SizeVariables.getWidth(context) * 0.03),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeVariables.getHeight(context) * 0.02,
                      ),
                      SizedBox(
                          height: SizeVariables.getHeight(context) * 0.8,
                          child: ChangeNotifierProvider<CompletedTaskList>(
                            create: (context) => taskList,
                            child: Consumer<CompletedTaskList>(
                              builder: (context, value, child) {
                                switch (value.completedModelList.status) {
                                  case Status.LOADING:
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  case Status.ERROR:
                                    return Center(
                                      child: Text(value
                                          .completedModelList.message
                                          .toString()),
                                    );
                                  case Status.COMPLETED:
                                    return ListView.builder(
                                      itemCount: value.completedModelList.data!
                                          .today!.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, RouteNames.taskedit);
                                          },
                                          child: ContainerStyle(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.09,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.019,
                                                  ),
                                                  child: Container(
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: RoundCheckBox(
                                                        onTap: (selected) {},
                                                        size: 23,
                                                        isChecked: true,
                                                        // uncheckedColor: Colors.yellow,
                                                        checkedColor:
                                                            Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.03,
                                                    top:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.03,
                                                  ),
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          child: FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: Text(
                                                              value
                                                                  .completedModelList
                                                                  .data!
                                                                  .today![index]
                                                                  .taskName
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: FittedBox(
                                                            fit: BoxFit.contain,
                                                            child: Text(
                                                              DateFormat(
                                                                      'yMMMMd')
                                                                  .format(DateTime.parse(value
                                                                      .completedModelList
                                                                      .data!
                                                                      .today![
                                                                          index]
                                                                      .taskDate
                                                                      .toString())),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: Colors
                                                                              .grey[
                                                                          200]),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  // return ListView.builder(
                                  //   itemBuilder: (context, index) => Container(
                                  //     margin: EdgeInsets.only(
                                  //         bottom:
                                  //             SizeVariables.getHeight(context) *
                                  //                 0.02),
                                  //     child: ContainerStyle(
                                  //       height:
                                  //           SizeVariables.getHeight(context) *
                                  //               0.09,
                                  //       child: Row(
                                  //         children: [
                                  //           Padding(
                                  //             padding: EdgeInsets.only(
                                  //               left: SizeVariables.getWidth(
                                  //                       context) *
                                  //                   0.03,
                                  //               // top: SizeVariables.getHeight(context)*0.03,
                                  //             ),
                                  //             child: RoundCheckBox(
                                  //               onTap: (selected) {},
                                  //               size: 23,
                                  //               isChecked: true,
                                  //               // uncheckedColor: Colors.yellow,
                                  //               checkedColor: Colors.grey,
                                  //             ),
                                  //           ),
                                  //           Padding(
                                  //             padding: EdgeInsets.only(
                                  //                 left: SizeVariables.getWidth(
                                  //                         context) *
                                  //                     0.03,
                                  //                 top: SizeVariables.getHeight(
                                  //                         context) *
                                  //                     0.02),
                                  //             child: Container(
                                  //               child: Column(
                                  //                 children: [
                                  //                   FittedBox(
                                  //                     fit: BoxFit.contain,
                                  //                     child: Container(
                                  //                       width: SizeVariables
                                  //                               .getWidth(
                                  //                                   context) *
                                  //                           0.6,
                                  //                       child: Flexible(
                                  //                         child: Text(
                                  //                           value.completedModelList.data!.today![index].taskName.toString(),
                                  //                           // value
                                  //                           //     .completedModelList
                                  //                           //     .data!
                                  //                           //     .today![index]
                                  //                           //     .taskName
                                  //                           //     .toString(),
                                  //                           overflow: TextOverflow
                                  //                               .ellipsis,
                                  //                           style: TextStyle(
                                  //                             color: Colors.grey,
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                   Padding(
                                  //                     padding: EdgeInsets.only(
                                  //                       right: SizeVariables
                                  //                               .getHeight(
                                  //                                   context) *
                                  //                           0.18,
                                  //                     ),
                                  //                     child: FittedBox(
                                  //                       fit: BoxFit.contain,
                                  //                       child: Text(
                                  //                         value.completedModelList.data!.today![index].taskDate.toString(),
                                  //                         // value
                                  //                         //     .completedModelList
                                  //                         //     .data!
                                  //                         //     .today![index]
                                  //                         //     .taskDate
                                  //                         //     .toString(),
                                  //                         style: const TextStyle(
                                  //                           color: Colors.grey,
                                  //                           fontSize: 12,
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   itemCount: value.completedModelList.data!.today!.length,
                                  //   // value
                                  //   //     .completedModelList.data!.today!.length,
                                  // );
                                  default:
                                }
                                return Container();
                              },
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:claimz/res/components/containerStyle.dart';
// import 'package:claimz/views/config/mediaQuery.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:roundcheckbox/roundcheckbox.dart';

// import '../../viewModel/toDoViewModel/completedTaskList.dart';

// class TaskComplete extends StatefulWidget {
//   // const TaskComplete({Key? key}) : super(key: key);

//   @override
//   State<TaskComplete> createState() => _TaskCompleteState();
// }

// class _TaskCompleteState extends State<TaskComplete> {

//   CompletedTaskList taskList = CompletedTaskList();

//   @override
//   void initState() {
//     // TODO: implement initState
//     taskList.getCompletedList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         padding: EdgeInsets.only(
//           left: SizeVariables.getWidth(context) * 0.025,
//           right: SizeVariables.getWidth(context) * 0.025,
//         ),
//         child: ListView(
//           children: [
//             Container(
//               height: SizeVariables.getHeight(context) * 0.07,
//               width: double.infinity,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: SizeVariables.getHeight(context) * 0.02),
//                     child: Row(
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: SvgPicture.asset(
//                             "assets/icons/back button.svg",
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         top: SizeVariables.getHeight(context) * 0.02,
//                         left: SizeVariables.getWidth(context) * 0.01),
//                     child: FittedBox(
//                       fit: BoxFit.contain,
//                       child: Text(
//                         'Completed Tasks',
//                         style: Theme.of(context).textTheme.caption,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: SizeVariables.getHeight(context) * 0.9,
//               child: ChangeNotifierProvider<CompletedTaskList>(
//                 child: ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, index) => Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: ContainerStyle(
//                       height: SizeVariables.getHeight(context) * 0.09,
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: SizeVariables.getWidth(context) * 0.019,
//                             ),
//                             child: Container(
//                               child: FittedBox(
//                                 fit: BoxFit.contain,
//                                 child: RoundCheckBox(
//                                   onTap: (selected) {},
//                                   size: 23,
//                                   isChecked: true,
//                                   // uncheckedColor: Colors.yellow,
//                                   checkedColor: Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
                          
//                           Padding(
//                             padding: EdgeInsets.only(
//                               left: SizeVariables.getWidth(context) * 0.03,
//                               top: SizeVariables.getHeight(context) * 0.03,
              
//                             ),
//                             child: Container(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     child: FittedBox(
//                                       fit: BoxFit.contain,
//                                       child: Text(
//                                         'CompletedTask',
//                                         style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     child: FittedBox(
//                                       fit: BoxFit.contain,
//                                       child: Text(
//                                         '2022-10-19',
//                                         style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }