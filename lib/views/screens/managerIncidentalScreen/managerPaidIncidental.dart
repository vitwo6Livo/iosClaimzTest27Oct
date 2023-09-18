// import 'package:claimz/res/components/containerStyle.dart';
// import 'package:claimz/viewModel/managerIncidentalViewModel.dart';
// import 'package:claimz/views/config/mediaQuery.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
// import '../editIncidentalExpenseForm.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// import 'editManagerIncidental.dart';

// class PaymentPaidManagerIncidental extends StatefulWidget {
//   PaymentPaidManagerIncidentalState createState() => PaymentPaidManagerIncidentalState();
// }

// class PaymentPaidManagerIncidentalState extends State<PaymentPaidManagerIncidental> {
//   bool pendingIncidental = true;
//   bool approved = false;
//   bool rejected = false;

//   void approveClaimAlert(int docNo, Map<String, dynamic> data) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               backgroundColor: const Color.fromARGB(255, 137, 131, 131),
//               content: Text('Are you sure you want to Approve this claim?',
//                   style: Theme.of(context).textTheme.bodyText1),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       Provider.of<ManagerIncidentalViewModel>(context,
//                               listen: false)
//                           .postactionIncidental(docNo, "1", data, context);

//                       Navigator.of(context).pop();
//                     },
//                     child: Text('Yes',
//                         style: Theme.of(context).textTheme.bodyText1)),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text('No',
//                         style: Theme.of(context).textTheme.bodyText1))
//               ],
//             ));
//   }

//   void rejectClaimAlert(int docNo, Map<String, dynamic> data) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               backgroundColor: const Color.fromARGB(255, 137, 131, 131),
//               content: Text('Are you sure you want to Reject this claim?',
//                   style: Theme.of(context).textTheme.bodyText1),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       Provider.of<ManagerIncidentalViewModel>(context,
//                               listen: false)
//                           .postactionIncidental(docNo, "2", data, context);

//                       Navigator.of(context).pop();
//                     },
//                     child: Text('Yes',
//                         style: Theme.of(context).textTheme.bodyText1)),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: Text('No',
//                         style: Theme.of(context).textTheme.bodyText1))
//               ],
//             ));
//   }

//   void approveAlert(bool value, int docNo, Map<String, dynamic> data) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               backgroundColor: const Color.fromARGB(255, 137, 131, 131),
//               content: Text('Are you sure you want to Approve this claim?',
//                   style: Theme.of(context).textTheme.bodyText1),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       setState(() {
//                         approved = true;
//                       });
//                       Provider.of<ManagerIncidentalViewModel>(context,
//                               listen: false)
//                           .postactionIncidental(docNo, "1", data, context);

//                       Navigator.of(context).pop();
//                     },
//                     child: Text('Yes',
//                         style: Theme.of(context).textTheme.bodyText1)),
//                 TextButton(
//                     onPressed: () {
//                       setState(() {
//                         approved = false;
//                       });
//                       Navigator.of(context).pop();
//                     },
//                     child: Text('No',
//                         style: Theme.of(context).textTheme.bodyText1))
//               ],
//             ));
//   }

//   void rejectAlert(bool value, int docNo, Map<String, dynamic> data) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               backgroundColor: const Color.fromARGB(255, 137, 131, 131),
//               content: Text('Are you sure you want to Reject this claim?',
//                   style: Theme.of(context).textTheme.bodyText1),
//               actions: [
//                 TextButton(
//                     onPressed: () {
//                       setState(() {
//                         rejected = true;
//                       });
//                       Navigator.of(context).pop();
//                     },
//                     child: Text('Yes',
//                         style: Theme.of(context).textTheme.bodyText1)),
//                 TextButton(
//                     onPressed: () {
//                       setState(() {
//                         rejected = false;
//                       });
//                       Provider.of<ManagerIncidentalViewModel>(context,
//                               listen: false)
//                           .postactionIncidental(docNo, "2", data, context);

//                       Navigator.of(context).pop();
//                     },
//                     child: Text('No',
//                         style: Theme.of(context).textTheme.bodyText1))
//               ],
//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ManagerIncidentalViewModel>(context).pending;

//     // TODO: implement build
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       padding: EdgeInsets.only(
//           left: SizeVariables.getWidth(context) * 0.02,
//           top: SizeVariables.getHeight(context) * 0.02,
//           right: SizeVariables.getWidth(context) * 0.02),
//       // color: Colors.red,
//       child: provider.isEmpty
//           ? Center(
//               child: Text('No Pending Incidental Claims',
//                   style: Theme.of(context).textTheme.bodyText1),
//             )
//           : ListView.builder(
//               itemBuilder: (context, index) => InkWell(
//                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                         builder: (context) => ManagerIncidentalClaimsEditScreen(
//                             pendingIncidental,
//                             provider[index]['incedental_form_id'],
//                             provider[index]['emp_id'],
//                             provider[index]['claim_no'],
//                             provider[index]['doc_no'],
//                             provider[index]['service_provider'],
//                             provider[index]['bill_no'],
//                             provider[index]['GST_no'],
//                             provider[index]['basic_amount'],
//                             provider[index]['GST_amount'],
//                             provider[index]['total_amount'],
//                             provider[index]['purpose'],
//                             provider[index]['attachment']))),
//                     child: Container(
//                       margin: EdgeInsets.only(
//                           bottom: SizeVariables.getHeight(context) * 0.02),
//                       child: ContainerStyle(
//                         height: SizeVariables.getHeight(context) * 0.32,
//                         child: Column(
//                           children: [
//                             Flexible(
//                               flex: 1,
//                               fit: FlexFit.tight,
//                               child: Container(
//                                 width: double.infinity,
//                                 // color: Colors.red,
//                                 child: Row(
//                                   children: [
//                                     Flexible(
//                                       flex: 1,
//                                       fit: FlexFit.tight,
//                                       child: Container(
//                                         height: double.infinity,
//                                         // decoration: BoxDecoration(
//                                         //   color: Colors.green,
//                                         // ),
//                                         padding: EdgeInsets.only(
//                                             left: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.02,
//                                             right: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.02),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 const Icon(Icons.receipt,
//                                                     color: Colors.amber),
//                                                 Text(
//                                                   'Doc No:',
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyText1,
//                                                 ),
//                                               ],
//                                             ),
//                                             FittedBox(
//                                               fit: BoxFit.contain,
//                                               child: Text(
//                                                 provider[index]['doc_no']
//                                                     .toString(),
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1!
//                                                     .copyWith(fontSize: 12),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Flexible(
//                                       flex: 1,
//                                       fit: FlexFit.tight,
//                                       child: Container(
//                                         height: double.infinity,
//                                         // color: Colors.blue,
//                                         padding: EdgeInsets.only(
//                                             right: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.02),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             // const Text('Date: '),
//                                             Text(
//                                                 DateFormat('dd-MMM-yyyy')
//                                                     .format(DateTime.parse(
//                                                         provider[index]
//                                                             ['date'])),
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Flexible(
//                               flex: 2,
//                               fit: FlexFit.tight,
//                               child: Container(
//                                 width: double.infinity,
//                                 // color: Colors.yellow,
//                                 child: Row(
//                                   children: [
//                                     Flexible(
//                                       flex: 2,
//                                       fit: FlexFit.tight,
//                                       child: Container(
//                                         height: double.infinity,
//                                         // color: Colors.pink,
//                                         padding: EdgeInsets.only(
//                                           left:
//                                               SizeVariables.getWidth(context) *
//                                                   0.02,
//                                           top:
//                                               SizeVariables.getHeight(context) *
//                                                   0.005,
//                                           right:
//                                               SizeVariables.getWidth(context) *
//                                                   0.02,
//                                           // bottom: SizeVariables.getHeight(context) * 0.00
//                                         ),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text('Purpose:',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1),
//                                             SizedBox(
//                                                 height: SizeVariables.getHeight(
//                                                         context) *
//                                                     0.005),
//                                             Container(
//                                               height: SizeVariables.getHeight(
//                                                       context) *
//                                                   0.06,
//                                               // width: SizeVariables.getWidth(context) * 0.4,
//                                               padding: const EdgeInsets.all(5),
//                                               decoration: BoxDecoration(
//                                                   // color: Colors.blue,
//                                                   border: Border.all(
//                                                       color: Colors.white),
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           10)),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.start,
//                                                 children: [
//                                                   Expanded(
//                                                       child: Text(
//                                                           provider[index]
//                                                               ['purpose'],
//                                                           style:
//                                                               Theme.of(context)
//                                                                   .textTheme
//                                                                   .bodyText1)),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Flexible(
//                                       flex: 1,
//                                       fit: FlexFit.tight,
//                                       child: Container(
//                                         height: double.infinity,
//                                         // color: Colors.red,
//                                         padding: EdgeInsets.only(
//                                             right: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.02),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                                 '₹${provider[index]['total_amount']}'),
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                                 height:
//                                     SizeVariables.getHeight(context) * 0.05),
//                             Flexible(
//                               flex: 1,
//                               fit: FlexFit.tight,
//                               child: Container(
//                                 width: double.infinity,
//                                 // color: Colors.red,
//                                 child: Row(
//                                   children: [
//                                     Flexible(
//                                       flex: 1,
//                                       fit: FlexFit.tight,
//                                       child: Container(
//                                         height: double.infinity,
//                                         // color: Colors.green,
//                                         padding: EdgeInsets.only(
//                                             left: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.02),
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 const Icon(Icons.info,
//                                                     color: Colors.amber),
//                                                 SizedBox(
//                                                     width:
//                                                         SizeVariables.getWidth(
//                                                                 context) *
//                                                             0.01),
//                                                 InkWell(
//                                                     onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                                                         builder: (context) => ManagerIncidentalClaimsEditScreen(
//                                                             pendingIncidental,
//                                                             provider[index][
//                                                                 'incedental_form_id'],
//                                                             provider[index]
//                                                                 ['emp_id'],
//                                                             provider[index]
//                                                                 ['claim_no'],
//                                                             provider[index]
//                                                                 ['doc_no'],
//                                                             provider[index][
//                                                                 'service_provider'],
//                                                             provider[index]
//                                                                 ['bill_no'],
//                                                             provider[index]
//                                                                 ['GST_no'],
//                                                             provider[index][
//                                                                 'basic_amount'],
//                                                             provider[index]
//                                                                 ['GST_amount'],
//                                                             provider[index]
//                                                                 ['total_amount'],
//                                                             provider[index]['purpose'],
//                                                             provider[index]['attachment']))),
//                                                     child: Text('View/Edit Claim', style: Theme.of(context).textTheme.bodyText1))
//                                               ],
//                                             ),
//                                             // Row(
//                                             //   mainAxisAlignment: MainAxisAlignment.end,
//                                             //   crossAxisAlignment: CrossAxisAlignment.end,
//                                             //   children: [
//                                             //     Column(
//                                             //       mainAxisAlignment: MainAxisAlignment.end,
//                                             //       children: [
//                                             //         Transform.scale(
//                                             //           scale: 1,
//                                             //           child: Switch.adaptive(
//                                             //               thumbColor:
//                                             //                   MaterialStateProperty.all(
//                                             //                       Colors.red),
//                                             //               trackColor:
//                                             //                   MaterialStateProperty.all(
//                                             //                       Colors.orange),
//                                             //               value: approved,
//                                             //               onChanged: (value) {
//                                             //                 setState(() {
//                                             //                   approved = value;
//                                             //                 });
//                                             //               }),
//                                             //         ),
//                                             //       ],
//                                             //     ),
//                                             //     SizedBox(width: SizeVariables.getWidth(context) * 0.006),
//                                             //     const Text('Approve')
//                                             //   ],
//                                             // ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     // Flexible(
//                                     //   flex: 1,
//                                     //   fit: FlexFit.tight,
//                                     //   child: Container(
//                                     //     height: double.infinity,
//                                     //     // color: Colors.blue,
//                                     //   ),
//                                     // )
//                                     Flexible(
//                                       flex: 1,
//                                       fit: FlexFit.tight,
//                                       child: Container(
//                                         height: double.infinity,
//                                         // color: Colors.red,
//                                         padding: EdgeInsets.only(
//                                             right: SizeVariables.getWidth(
//                                                     context) *
//                                                 0.02),
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.end,
//                                               children: [
//                                                 Column(
//                                                   children: [
//                                                     Text(provider[index]
//                                                             ['emp_name']
//                                                         .split(' ')[0]),
//                                                     Text(provider[index]['emp_code'])    
//                                                   ],
//                                                 ),
//                                                 SizedBox(
//                                                     width:
//                                                         SizeVariables.getWidth(
//                                                                 context) *
//                                                             0.02),
//                                                 provider[index]
//                                                             ['profile_photo'] ==
//                                                         null
//                                                     ? CircleAvatar(
//                                                         radius: SizeVariables
//                                                                 .getWidth(
//                                                                     context) *
//                                                             0.05,
//                                                         backgroundColor:
//                                                             Colors.green,
//                                                         backgroundImage:
//                                                             const AssetImage(
//                                                                 'assets/img/profilePic.jpg'))
//                                                     : CachedNetworkImage(
//                                                         imageUrl:
//                                                             'https://claimz.vitwo.in/profile_photo/${provider[index]['profile_photo']}',
//                                                         imageBuilder: (context,
//                                                                 imageProvider) =>
//                                                             CircleAvatar(
//                                                           backgroundImage:
//                                                               imageProvider,
//                                                         ),
//                                                         placeholder: (context,
//                                                                 url) =>
//                                                             Shimmer.fromColors(
//                                                           baseColor:
//                                                               Colors.grey[400]!,
//                                                           highlightColor:
//                                                               const Color
//                                                                       .fromARGB(
//                                                                   255,
//                                                                   120,
//                                                                   120,
//                                                                   120),
//                                                           child:
//                                                               const CircleAvatar(),
//                                                         ),
//                                                       )
//                                               ],
//                                             ),
//                                             // Row(
//                                             //   mainAxisAlignment: MainAxisAlignment.start,
//                                             //   children: [
//                                             //     Transform.scale(
//                                             //       scale: 1,
//                                             //       child: Switch.adaptive(
//                                             //           thumbColor:
//                                             //               MaterialStateProperty.all(
//                                             //                   Colors.red),
//                                             //           trackColor:
//                                             //               MaterialStateProperty.all(
//                                             //                   Colors.orange),
//                                             //           value: approved,
//                                             //           onChanged: (value) {
//                                             //             setState(() {
//                                             //               approved = value;
//                                             //             });
//                                             //           }),
//                                             //     ),
//                                             //     SizedBox(width: SizeVariables.getWidth(context) * 0.006),
//                                             //     const Text('Reject')
//                                             //   ],
//                                             // )
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Flexible(
//                                 flex: 1,
//                                 fit: FlexFit.tight,
//                                 child: Container(
//                                   width: double.infinity,
//                                   // color: Colors.yellow,
//                                   child: Row(
//                                     children: [
//                                       // Flexible(
//                                       //   flex: 1,
//                                       //   fit: FlexFit.tight,
//                                       //   child: Container(
//                                       //     height: double.infinity,
//                                       //     color: Colors.red,
//                                       //     padding: EdgeInsets.only(
//                                       //         right: SizeVariables.getWidth(
//                                       //                 context) *
//                                       //             0.02),
//                                       //     child: Row(
//                                       //       mainAxisAlignment:
//                                       //           MainAxisAlignment.end,
//                                       //       children: [
//                                       //         Transform.scale(
//                                       //           scale: 1,
//                                       //           child: Switch.adaptive(
//                                       //               thumbColor:
//                                       //                   MaterialStateProperty.all(
//                                       //                       Colors.green),
//                                       //               trackColor:
//                                       //                   MaterialStateProperty.all(
//                                       //                       Colors.greenAccent),
//                                       //               value: approved,
//                                       //               onChanged: (value) {
//                                       //                 // setState(() {
//                                       //                 //   // approved = value;
//                                       //                 // });
//                                       //                 approveAlert(
//                                       //                     value,
//                                       //                     provider[index]
//                                       //                         ['doc_no'],
//                                       //                     provider[index]);
//                                       //               }),
//                                       //         ),
//                                       //         const Text('Approve')
//                                       //       ],
//                                       //     ),
//                                       //   ),
//                                       // ),

                                      
//                                       // Flexible(
//                                       //   flex: 1,
//                                       //   fit: FlexFit.tight,
//                                       //   child: Container(
//                                       //     height: double.infinity,
//                                       //     // color: Colors.green,
//                                       //     padding: EdgeInsets.only(
//                                       //         right: SizeVariables.getWidth(
//                                       //                 context) *
//                                       //             0.02),
//                                       //     child: Row(
//                                       //       mainAxisAlignment:
//                                       //           MainAxisAlignment.end,
//                                       //       children: [
//                                       //         // Transform.scale(
//                                       //         //   scale: 1,
//                                       //         //   child: Switch.adaptive(
//                                       //         //       thumbColor:
//                                       //         //           MaterialStateProperty.all(
//                                       //         //               Colors.red),
//                                       //         //       trackColor:
//                                       //         //           MaterialStateProperty.all(
//                                       //         //               const Color.fromARGB(
//                                       //         //                   255,
//                                       //         //                   248,
//                                       //         //                   109,
//                                       //         //                   109)),
//                                       //         //       value: rejected,
//                                       //         //       onChanged: (value) {
//                                       //         //         // setState(() {
//                                       //         //         //   // rejected = value;
//                                       //         //         // });
//                                       //         //         rejectAlert(
//                                       //         //             value,
//                                       //         //             provider[index]
//                                       //         //                 ['doc_no'],
//                                       //         //             provider[index]);
//                                       //         //       }),
//                                       //         // ),
//                                       //         // const Text('Reject')
//                                       //         InkWell(
//                                       //           onTap: () => approveClaimAlert(
//                                       //               provider[index]['doc_no'],
//                                       //               provider[index]),
//                                       //           child: const Icon(
//                                       //               Icons.check_box,
//                                       //               color: Colors.orangeAccent,
//                                       //               size: 30),
//                                       //         ),
//                                       //         InkWell(
//                                       //             onTap: () => rejectClaimAlert(
//                                       //                 provider[index]['doc_no'],
//                                       //                 provider[index]),
//                                       //             child: const Icon(
//                                       //                 Icons.cancel,
//                                       //                 color:
//                                       //                     Colors.orangeAccent,
//                                       //                 size: 30)),
//                                       //       ],
//                                       //     ),
//                                       //   ),
//                                       // )
//                                     ],
//                                   ),
//                                 ))
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//               itemCount: provider.length),
//     );
//   }
// }
