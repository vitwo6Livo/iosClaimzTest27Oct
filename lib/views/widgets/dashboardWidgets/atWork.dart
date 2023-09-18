// import 'package:claimz/data/response/status.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../utils/routes/routeNames.dart';
// import '../../config/mediaQuery.dart';
// import '../../../res/components/containerStyle.dart';
// import '../../../res/components/buttonStyle.dart';
// import '../../../viewModel/attendanceViewModel.dart';
// class AtWork extends StatefulWidget {
//   AtWorkState createState() => AtWorkState();
// }

// class AtWorkState extends State<AtWork> {
//   AttendanceViewModel attendaceViewModel = AttendanceViewModel();

//   @override
//   void initState() {
//     // TODO: implement initState
//     attendaceViewModel.getAttendanceList(context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return ContainerStyle(
//       height: SizeVariables.getHeight(context) * 0.8,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//                 top: SizeVariables.getHeight(context) * 0.015,
//                 left: SizeVariables.getWidth(context) * 0.04),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   'Who\'s at work today?',
//                   // style: TextStyle(
//                   //   color: Colors.white,
//                   //   fontSize: 30,
//                   // ),
//                   style: Theme.of(context).textTheme.caption,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: SizeVariables.getHeight(context) * 0.01),
//           Expanded(
//               child: Padding(
//             padding: EdgeInsets.only(
//                 left: SizeVariables.getWidth(context) * 0.02,
//                 right: SizeVariables.getWidth(context) * 0.02),
//             child: Container(
//               width: double.infinity,
//               // color: Colors.red,
//               child: ChangeNotifierProvider<AttendanceViewModel>(
//                 create: (BuildContext context) => attendaceViewModel,
//                 child: Consumer<AttendanceViewModel>(
//                   builder: (context, value, child) {
//                     switch (value.attendance.status) {
//                       // case Status.LOADING:
//                       //   return const Center(
//                       //     child: CircularProgressIndicator(),
//                       //   );
//                       case Status.ERROR:
//                         return Center(
//                           child: Text(value.attendance.message.toString()),
//                         );
//                       case Status.COMPLETED:
//                         return ListView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemBuilder:
//                               (context, index) =>
//                                   value.attendance.data!.attendance![index]
//                                               .status ==
//                                           'absent'
//                                       ? Container()
//                                       : Column(
//                                           children: [
//                                             Container(
//                                               width: double.infinity,
//                                               height: SizeVariables.getHeight(
//                                                       context) *
//                                                   0.12,
//                                               // color: Colors.red,
//                                               child: Row(
//                                                 children: [
//                                                   Flexible(
//                                                     flex: 5,
//                                                     fit: FlexFit.tight,
//                                                     child: Container(
//                                                       height: double.infinity,
//                                                       // color: Colors.green,
//                                                       child: Row(
//                                                         children: [
//                                                           Padding(
//                                                             padding: EdgeInsets.only(
//                                                                 left: SizeVariables
//                                                                         .getWidth(
//                                                                             context) *
//                                                                     0.02,
//                                                                 right: SizeVariables
//                                                                         .getWidth(
//                                                                             context) *
//                                                                     0.02),
//                                                             child: 
//                                                             // value
//                                                             //             .attendance
//                                                             //             .data!
//                                                             //             .attendance![
//                                                             //                 index]
//                                                             //             .user!
//                                                             //             .profilePhoto ==
//                                                             //         null
//                                                             //     ? 
//                                                                 CircleAvatar(
//                                                                     radius: SizeVariables.getWidth(
//                                                                             context) *
//                                                                         0.08,
//                                                                     backgroundColor:
//                                                                         Colors
//                                                                             .green,
//                                                                     backgroundImage:
//                                                                         const AssetImage(
//                                                                             'assets/img/profilePic.jpg'),
//                                                                     // child: const Icon(Icons.account_box, color: Colors.white),
//                                                                   )
//                                                                 // : CircleAvatar(
//                                                                 //     radius: SizeVariables.getWidth(
//                                                                 //             context) *
//                                                                 //         0.08,
//                                                                 //     backgroundColor:
//                                                                 //         Colors
//                                                                 //             .red,
//                                                                 //     backgroundImage:
//                                                                 //         NetworkImage(
//                                                                 //             '${AppUrl.baseUrl}/${value.attendance.data!.attendance![index].user!.profilePhoto}'),
//                                                                 //   ),
//                                                           ),
//                                                           Expanded(
//                                                             child: Container(
//                                                               height: double
//                                                                   .infinity,
//                                                               // color: Colors.orange,
//                                                               child: Column(
//                                                                 // mainAxisAlignment: MainAxisAlignment.start,
//                                                                 // crossAxisAlignment: CrossAxisAlignment.start,
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .center,
//                                                                 children: [
//                                                                   Container(
//                                                                     width: SizeVariables.getWidth(
//                                                                             context) *
//                                                                         0.5,
//                                                                     height: SizeVariables.getHeight(
//                                                                             context) *
//                                                                         0.04,
//                                                                     // color: Colors.amber,
//                                                                     child: Row(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .start,
//                                                                       children: [
//                                                                         FittedBox(
//                                                                           fit: BoxFit
//                                                                               .contain,
//                                                                           child:
//                                                                               Text(
//                                                                             value.attendance.data!.attendance![index].user!.empName.toString(),
//                                                                             style:
//                                                                                 Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Container(
//                                                                     width: SizeVariables.getWidth(
//                                                                             context) *
//                                                                         0.5,
//                                                                     height: SizeVariables.getHeight(
//                                                                             context) *
//                                                                         0.04,
//                                                                     // color: Colors.amber,
//                                                                     child: Row(
//                                                                       mainAxisAlignment:
//                                                                           MainAxisAlignment
//                                                                               .start,
//                                                                       children: [
//                                                                         FittedBox(
//                                                                           fit: BoxFit
//                                                                               .contain,
//                                                                           child:
//                                                                               Text(
//                                                                             // value.attendance.data!.attendance![index].user!.empName.toString(),
//                                                                             'Department',
//                                                                             style:
//                                                                                 Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   )
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Flexible(
//                                                     flex: 1,
//                                                     fit: FlexFit.tight,
//                                                     child: Container(
//                                                       height: double.infinity,
//                                                       // color: Colors.blue,
//                                                       child: const Center(
//                                                         child: CircleAvatar(
//                                                           radius: 10,
//                                                           backgroundColor:
//                                                               Colors.green,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                             SizedBox(
//                                                 height: SizeVariables.getHeight(
//                                                         context) *
//                                                     0.04)
//                                           ],
//                                         ),
//                           itemCount: value.attendance.data!.attendance!
//                                           .length ==
//                                       4 ||
//                                   value.attendance.data!.attendance!.length > 4
//                               ? 4
//                               : value.attendance.data!.attendance!.length,
//                         );
//                       default:
//                     }
//                     return Container();
//                   },
//                 ),
//               ),
//             ),
//           )),
//           AppButtonStyle(label: 'View All', onPressed: () => Navigator.pushNamed(context, RouteNames.atWorkList)),
//           SizedBox(height: SizeVariables.getHeight(context) * 0.02)
//         ],
//       ),
//     );
//   }
// }
