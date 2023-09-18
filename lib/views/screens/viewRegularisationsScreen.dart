// import 'package:claimz/res/components/containerStyle.dart';
// import 'package:claimz/views/config/mediaQuery.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../../../viewModel/leaveListViewModel.dart';
// import '../../../data/response/status.dart';
// import 'package:lottie/lottie.dart';

// import '../../viewModel/allRegularisationViewModel.dart';
// import 'leaveScreenShimmer.dart';

// class ViewRegularisations extends StatefulWidget {
//   const ViewRegularisations({Key? key}) : super(key: key);

//   @override
//   State<ViewRegularisations> createState() => _ViewRegularisationsState();
// }

// class _ViewRegularisationsState extends State<ViewRegularisations> {
//   LeaveListViewModel leaveListViewModel = LeaveListViewModel();
//   bool isLoading = true;

//   @override
//   void initState() {
//     // TODO: implement initState
//     Provider.of<AllRegularisationViewModel>(context, listen: false).getAllRegularisations().then((value) {
//       setState(() {
//         isLoading = false;
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<AllRegularisationViewModel>(context).allRegularisation;

//     return Container(
//       width: double.infinity,
//       height: SizeVariables.getHeight(context) * 0.709,
//       // color: Colors.amber,
//       padding: EdgeInsets.only(
//           left: SizeVariables.getWidth(context) * 0.005,
//           top: SizeVariables.getHeight(context) * 0.005,
//           right: SizeVariables.getWidth(context) * 0.005),
//       child: isLoading ? const Center(
//         child: CircularProgressIndicator(),
//       ) : ListView.builder(
//               itemBuilder: (context, index) => provider['data'].isEmpty
//                   ? Center(
//                       child: Lottie.asset('assets/json/ToDo.json'),
//                     )
//                   : Column(
//                       children: [
//                         ContainerStyle(
//                           height: SizeVariables.getHeight(context) * 0.12,
//                           child: Container(
//                             width: double.infinity,
//                             height: double.infinity,
//                             // color: Colors.red,
//                             child: Row(
//                               children: [
//                                 Flexible(
//                                   flex: 1,
//                                   fit: FlexFit.tight,
//                                   child: Container(
//                                     height: double.infinity,
//                                     // color: Colors.red,
//                                     padding: EdgeInsets.only(
//                                         left:
//                                             SizeVariables.getWidth(context) *
//                                                 0.05),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           provider['data'][index]['name'],
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyText1!
//                                               .copyWith(
//                                                   color: Colors.grey,
//                                                   fontSize: 16),
//                                         ),
//                                         Column(
//                                           children: [
//                                             Text(
//                                               provider['data'][index]['attendance_date'],
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyText1!
//                                                   .copyWith(
//                                                       color: const Color
//                                                               .fromARGB(255,
//                                                           127, 182, 129)),
//                                             ),
//                                             // Text(
//                                             //   '-',
//                                             //   style: Theme.of(context).textTheme.bodyText1,
//                                             // ),
//                                             // Text(
//                                             //   value.leaveList.data!
//                                             //       .data![index].dates!.last,
//                                             //   style: Theme.of(context)
//                                             //       .textTheme
//                                             //       .bodyText1!
//                                             //       .copyWith(
//                                             //           color: const Color
//                                             //                   .fromARGB(
//                                             //               255, 248, 112, 78)),
//                                             // ),
//                                           ],
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Flexible(
//                                   flex: 1,
//                                   fit: FlexFit.loose,
//                                   child: Container(
//                                     height: double.infinity,
//                                     // color: Colors.green,
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               // Text('|',
//                                               //     style: Theme.of(context)
//                                               //         .textTheme
//                                               //         .bodyText2),
//                                               // SizedBox(
//                                               //     width:
//                                               //         SizeVariables.getWidth(context) *
//                                               //             0.005),
//                                               // Text(
//                                               //     // value
//                                               //     //     .leaveList
//                                               //     //     .data!
//                                               //     //     .data![index]
//                                               //     //     .dates!
//                                               //     //     .length
//                                               //     //     .toString(),
//                                               //     '${DateFormat('yyyy-MM-dd').parse(value.leaveList.data!.data![index].dates![1]).difference(DateFormat('yyyy-MM-dd').parse(value.leaveList.data!.data![index].dates![0])).inDays + 1}',
//                                               //     style: Theme.of(context)
//                                               //         .textTheme
//                                               //         .bodyText2!
//                                               //         .copyWith(
//                                               //             fontSize: 30,
//                                               //             fontWeight:
//                                               //                 FontWeight
//                                               //                     .normal)),
//                                               SizedBox(
//                                                   width:
//                                                       SizeVariables.getWidth(
//                                                               context) *
//                                                           0.01),
//                                               Column(
//                                                 children: [
//                                                   Text(
//                                                     'Day(s)',
//                                                     style: Theme.of(context)
//                                                         .textTheme
//                                                         .bodyText2!
//                                                         .copyWith(
//                                                             fontSize: 12),
//                                                   ),
//                                                 ],
//                                               )
//                                             ])
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Flexible(
//                                   flex: 1,
//                                   fit: FlexFit.tight,
//                                   child: Container(
//                                     height: double.infinity,
//                                     // color: Colors.blue,
//                                     child: Center(
//                                         child: 
//                                                                                       provider['data'][index]['status'] == 1 ?

//                                              const Icon(Icons.check,
//                                                 color: Colors.green)
//                                             : provider['data'][index]['status'] ==
//                                                     2
//                                                 ? const Icon(Icons.close,
//                                                     color: Colors.red)
//                                                 : const Icon(Icons.timer,
//                                                     color: Colors.amber)),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                             height: SizeVariables.getHeight(context) * 0.02)
//                       ],
//                     ),
//               itemCount: provider['data'].length,
//             )
//     );
//   }
// }
