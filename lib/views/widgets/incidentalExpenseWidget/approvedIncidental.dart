// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import '../../../res/components/containerStyle.dart';
// import '../../../viewModel/userIncidentalViewModel.dart';
// import '../../config/mediaQuery.dart';
// import '../../screens/editIncidentalExpenseForm.dart';

// class ApprovedIncidental extends StatelessWidget {
//   bool isPending = false;

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<UserIncidentalViewModel>(context).approved;

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
//               child: Text('No Approved Incidental Claims',
//                   style: Theme.of(context).textTheme.bodyText1),
//             )
//           : ListView.builder(
//               itemBuilder: (context, index) => InkWell(
//                   onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => IncidentalClaimsEditScreen(
//                           isPending,
//                           provider[index]['incedental_form_id'],
//                           provider[index]['emp_id'],
//                           provider[index]['claim_no'],
//                           provider[index]['doc_no'],
//                           provider[index]['service_provider'],
//                           provider[index]['bill_no'],
//                           provider[index]['GST_no'],
//                           provider[index]['basic_amount'],
//                           provider[index]['GST_amount'],
//                           provider[index]['total_amount'],
//                           provider[index]['purpose'],
//                           provider[index]['attachment']))),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(
//                         SizeVariables.getWidth(context) * 0.02),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                       child: Container(
//                           width: double.infinity,
//                           // height: 50,
//                           margin: EdgeInsets.only(
//                               bottom: SizeVariables.getHeight(context) * 0.01),
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 15),
//                           decoration: BoxDecoration(
//                             color: Color.fromARGB(255, 181, 179, 179)
//                                 .withOpacity(0.1),
//                             border: const Border(
//                                 bottom: BorderSide(width: 0.06),
//                                 top: BorderSide(width: 0.06),
//                                 right: BorderSide(width: 0.06),
//                                 left: BorderSide(width: 0.06)),
//                             // boxShadow: [
//                             //   BoxShadow(
//                             //       color: Color.fromARGB(255, 57, 57, 57),
//                             //       blurRadius: 15,
//                             //       spreadRadius: 1,
//                             //       offset: Offset(1, 2))
//                             // ]
//                           ),
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: double.infinity,
//                                 height: SizeVariables.getHeight(context) * 0.06,
//                                 child: Row(
//                                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Flexible(
//                                       flex: 1,
//                                       fit: FlexFit.tight,
//                                       child: Container(
//                                         height: double.infinity,
//                                         // color: Colors.red,
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: const [
//                                                 Icon(Icons.receipt,
//                                                     color: Colors.amber),
//                                                 Text('Doc No:')
//                                               ],
//                                             ),
//                                             FittedBox(
//                                               fit: BoxFit.contain,
//                                               child: Text(
//                                                   provider[index]['doc_no']
//                                                       .toString(),
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .bodyText1!
//                                                       .copyWith(
//                                                           fontSize: 12,
//                                                           color: const Color
//                                                                   .fromARGB(255,
//                                                               208, 204, 204))),
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
//                                         // color: Colors.green,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                                 DateFormat('dd-MMM-yyyy')
//                                                     .format(DateTime.parse(
//                                                         provider[index]
//                                                             ['date'])),
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1)
//                                           ],
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: double.infinity,
//                                 // color: Colors.red,
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('Purpose: ',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyText1!
//                                             .copyWith(
//                                                 fontWeight: FontWeight.bold)),
//                                     Expanded(
//                                         child: Text(provider[index]['purpose'],
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyText1!
//                                                 .copyWith(
//                                                     fontSize: 14,
//                                                     color: const Color.fromARGB(
//                                                         255, 208, 204, 204))))
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                   height:
//                                       SizeVariables.getHeight(context) * 0.02),
//                               InkWell(
//                                 onTap: () => Navigator.of(context).push(
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             IncidentalClaimsEditScreen(
//                                                 isPending,
//                                                 provider[index]
//                                                     ['incedental_form_id'],
//                                                 provider[index]['emp_id'],
//                                                 provider[index]['claim_no'],
//                                                 provider[index]['doc_no'],
//                                                 provider[index]
//                                                     ['service_provider'],
//                                                 provider[index]['bill_no'],
//                                                 provider[index]['GST_no'],
//                                                 provider[index]['basic_amount'],
//                                                 provider[index]['GST_amount'],
//                                                 provider[index]['total_amount'],
//                                                 provider[index]['purpose'],
//                                                 provider[index]
//                                                     ['attachment']))),
//                                 child: Container(
//                                   width: double.infinity,
//                                   height:
//                                       SizeVariables.getHeight(context) * 0.05,
//                                   // color: Colors.red,
//                                   child: Row(
//                                     children: [
//                                       Flexible(
//                                         flex: 1,
//                                         fit: FlexFit.tight,
//                                         child: Container(
//                                           height: double.infinity,
//                                           // color: Colors.green,
//                                           child: Row(
//                                             children: const [
//                                               Icon(Icons.info,
//                                                   color: Colors.amber),
//                                               Text('View Claim')
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Flexible(
//                                         flex: 1,
//                                         fit: FlexFit.tight,
//                                         child: Container(
//                                           height: double.infinity,
//                                           // color: Colors.blue,
//                                           child: Column(
//                                             // mainAxisAlignment:
//                                             //     MainAxisAlignment.end,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                             children: [
//                                               Text(
//                                                   '₹${provider[index]['total_amount']}',
//                                                   style: const TextStyle(
//                                                       decoration: TextDecoration
//                                                           .lineThrough)),
//                                               Text(
//                                                   provider[index]['paid_total_amount'] ==
//                                                               '' ||
//                                                           provider[index][
//                                                                   'paid_total_amount'] ==
//                                                               null ||
//                                                           provider[index][
//                                                                   'paid_total_amount'] ==
//                                                               0
//                                                       ? '₹${provider[index]['total_amount']}'
//                                                       : '₹${provider[index]['paid_total_amount']}',
//                                                   style: const TextStyle(
//                                                       // decoration: TextDecoration
//                                                       //     .lineThrough,
//                                                       color: Color.fromARGB(
//                                                           255, 118, 227, 122)
//                                                       // decorationThickness: 5,
//                                                       )),
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           )),
//                     ),
//                   )),
//               itemCount: provider.length),
//       // ListView.builder(
//       //     itemBuilder: (context, index) => InkWell(
//       //           onTap: () => Navigator.of(context).push(MaterialPageRoute(
//       //               builder: (context) => IncidentalClaimsEditScreen(
//       //                   isPending,
//       //                   provider[index]['incedental_form_id'],
//       //                   provider[index]['emp_id'],
//       //                   provider[index]['claim_no'],
//       //                   provider[index]['doc_no'],
//       //                   provider[index]['service_provider'],
//       //                   provider[index]['bill_no'],
//       //                   provider[index]['GST_no'],
//       //                   provider[index]['basic_amount'],
//       //                   provider[index]['GST_amount'],
//       //                   provider[index]['total_amount'],
//       //                   provider[index]['purpose'],
//       //                   provider[index]['attachment']))),
//       //           child: Container(
//       //             margin: EdgeInsets.only(
//       //                 bottom: SizeVariables.getHeight(context) * 0.02),
//       //             child: ContainerStyle(
//       //               height: SizeVariables.getHeight(context) * 0.25,
//       //               child: Column(
//       //                 children: [
//       //                   Flexible(
//       //                     flex: 1,
//       //                     fit: FlexFit.tight,
//       //                     child: Container(
//       //                       width: double.infinity,
//       //                       // color: Colors.red,
//       //                       child: Row(
//       //                         children: [
//       //                           Flexible(
//       //                             flex: 1,
//       //                             fit: FlexFit.tight,
//       //                             child: Container(
//       //                               height: double.infinity,
//       //                               // decoration: BoxDecoration(
//       //                               //   color: Colors.green,
//       //                               // ),
//       //                               padding: EdgeInsets.only(
//       //                                   left: SizeVariables.getWidth(
//       //                                           context) *
//       //                                       0.02,
//       //                                   right: SizeVariables.getWidth(
//       //                                           context) *
//       //                                       0.02),
//       //                               child: Column(
//       //                                 mainAxisAlignment:
//       //                                     MainAxisAlignment.center,
//       //                                 crossAxisAlignment:
//       //                                     CrossAxisAlignment.start,
//       //                                 children: [
//       //                                   Row(
//       //                                     children: [
//       //                                       const Icon(Icons.receipt,
//       //                                           color: Colors.amber),
//       //                                       Text(
//       //                                         'Doc No:',
//       //                                         style: Theme.of(context)
//       //                                             .textTheme
//       //                                             .bodyText1,
//       //                                       ),
//       //                                     ],
//       //                                   ),
//       //                                   FittedBox(
//       //                                     fit: BoxFit.contain,
//       //                                     child: Text(
//       //                                       provider[index]['doc_no']
//       //                                           .toString(),
//       //                                       style: Theme.of(context)
//       //                                           .textTheme
//       //                                           .bodyText1!
//       //                                           .copyWith(
//       //                                               fontSize: 12,
//       //                                               color: const Color
//       //                                                       .fromARGB(255,
//       //                                                   208, 204, 204)),
//       //                                     ),
//       //                                   )
//       //                                 ],
//       //                               ),
//       //                             ),
//       //                           ),
//       //                           Flexible(
//       //                             flex: 1,
//       //                             fit: FlexFit.tight,
//       //                             child: Container(
//       //                               height: double.infinity,
//       //                               // color: Colors.blue,
//       //                               padding: EdgeInsets.only(
//       //                                   right: SizeVariables.getWidth(
//       //                                           context) *
//       //                                       0.02),
//       //                               child: Row(
//       //                                 mainAxisAlignment:
//       //                                     MainAxisAlignment.end,
//       //                                 children: [
//       //                                   // const Text('Date: '),
//       //                                   Text(
//       //                                       DateFormat('dd-MMM-yyyy')
//       //                                           .format(DateTime.parse(
//       //                                               provider[index]
//       //                                                   ['date'])),
//       //                                       style: Theme.of(context)
//       //                                           .textTheme
//       //                                           .bodyText1),
//       //                                 ],
//       //                               ),
//       //                             ),
//       //                           )
//       //                         ],
//       //                       ),
//       //                     ),
//       //                   ),
//       //                   Flexible(
//       //                     flex: 2,
//       //                     fit: FlexFit.tight,
//       //                     child: Container(
//       //                       width: double.infinity,
//       //                       // color: Colors.yellow,
//       //                       child: Row(
//       //                         children: [
//       //                           Flexible(
//       //                             flex: 2,
//       //                             fit: FlexFit.tight,
//       //                             child: Container(
//       //                               height: double.infinity,
//       //                               // color: Colors.pink,
//       //                               padding: EdgeInsets.only(
//       //                                 left:
//       //                                     SizeVariables.getWidth(context) *
//       //                                         0.02,
//       //                                 top:
//       //                                     SizeVariables.getHeight(context) *
//       //                                         0.005,
//       //                                 right:
//       //                                     SizeVariables.getWidth(context) *
//       //                                         0.02,
//       //                                 // bottom: SizeVariables.getHeight(context) * 0.00
//       //                               ),
//       //                               child: Row(
//       //                                 mainAxisAlignment:
//       //                                     MainAxisAlignment.start,
//       //                                 crossAxisAlignment:
//       //                                     CrossAxisAlignment.start,
//       //                                 children: [
//       //                                   Text('Purpose: ',
//       //                                       style: Theme.of(context)
//       //                                           .textTheme
//       //                                           .bodyText1),
//       //                                   Expanded(
//       //                                       child: Text(
//       //                                     provider[index]['purpose'],
//       //                                     style: Theme.of(context)
//       //                                         .textTheme
//       //                                         .bodyText1!
//       //                                         .copyWith(
//       //                                             fontSize: 14,
//       //                                             color:
//       //                                                 const Color.fromARGB(
//       //                                                     255,
//       //                                                     208,
//       //                                                     204,
//       //                                                     204)),
//       //                                   ))
//       //                                   // SizedBox(
//       //                                   //     height: SizeVariables.getHeight(
//       //                                   //             context) *
//       //                                   //         0.005),
//       //                                   // Container(
//       //                                   //   height: SizeVariables.getHeight(
//       //                                   //           context) *
//       //                                   //       0.06,
//       //                                   //   // width: SizeVariables.getWidth(context) * 0.4,
//       //                                   //   padding: const EdgeInsets.all(5),
//       //                                   //   decoration: BoxDecoration(
//       //                                   //       // color: Colors.blue,
//       //                                   //       border: Border.all(
//       //                                   //           color: Colors.white),
//       //                                   //       borderRadius:
//       //                                   //           BorderRadius.circular(10)),
//       //                                   //   child: Row(
//       //                                   //     mainAxisAlignment:
//       //                                   //         MainAxisAlignment.start,
//       //                                   //     children: [
//       //                                   //       Expanded(
//       //                                   //           child: Text(
//       //                                   //               provider[index]
//       //                                   //                   ['purpose'],
//       //                                   //               style: Theme.of(context)
//       //                                   //                   .textTheme
//       //                                   //                   .bodyText1)),
//       //                                   //     ],
//       //                                   //   ),
//       //                                   // ),
//       //                                 ],
//       //                               ),
//       //                             ),
//       //                           ),
//       //                           // Flexible(
//       //                           //   flex: 1,
//       //                           //   fit: FlexFit.tight,
//       //                           //   child: Container(
//       //                           //     height: double.infinity,
//       //                           //     // color: Colors.red,
//       //                           //     padding: EdgeInsets.only(
//       //                           //         right:
//       //                           //             SizeVariables.getWidth(context) *
//       //                           //                 0.02),
//       //                           //     child: Row(
//       //                           //       mainAxisAlignment:
//       //                           //           MainAxisAlignment.end,
//       //                           //       children: [
//       //                           //         Text(
//       //                           //             '₹${provider[index]['total_amount']}'),
//       //                           //       ],
//       //                           //     ),
//       //                           //   ),
//       //                           // )
//       //                         ],
//       //                       ),
//       //                     ),
//       //                   ),
//       //                   Flexible(
//       //                     flex: 1,
//       //                     fit: FlexFit.tight,
//       //                     child: Container(
//       //                       width: double.infinity,
//       //                       // color: Colors.red,
//       //                       child: Row(
//       //                         children: [
//       //                           Flexible(
//       //                             flex: 1,
//       //                             fit: FlexFit.tight,
//       //                             child: Container(
//       //                               height: double.infinity,
//       //                               // color: Colors.green,
//       //                               padding: EdgeInsets.only(
//       //                                   left: SizeVariables.getWidth(
//       //                                           context) *
//       //                                       0.02),
//       //                               child: Row(
//       //                                 children: [
//       //                                   const Icon(Icons.info,
//       //                                       color: Colors.amber),
//       //                                   SizedBox(
//       //                                       width: SizeVariables.getWidth(
//       //                                               context) *
//       //                                           0.01),
//       //                                   InkWell(
//       //                                       onTap: () => Navigator.of(context).push(MaterialPageRoute(
//       //                                           builder: (context) => IncidentalClaimsEditScreen(
//       //                                               isPending,
//       //                                               provider[index][
//       //                                                   'incedental_form_id'],
//       //                                               provider[index]
//       //                                                   ['emp_id'],
//       //                                               provider[index]
//       //                                                   ['claim_no'],
//       //                                               provider[index]
//       //                                                   ['doc_no'],
//       //                                               provider[index][
//       //                                                   'service_provider'],
//       //                                               provider[index]
//       //                                                   ['bill_no'],
//       //                                               provider[index]
//       //                                                   ['GST_no'],
//       //                                               provider[index]
//       //                                                   ['basic_amount'],
//       //                                               provider[index]
//       //                                                   ['GST_amount'],
//       //                                               provider[index]
//       //                                                   ['total_amount'],
//       //                                               provider[index]
//       //                                                   ['purpose'],
//       //                                               provider[index]
//       //                                                   ['attachment']))),
//       //                                       child:
//       //                                           Text('View/Edit Claim', style: Theme.of(context).textTheme.bodyText1))
//       //                                 ],
//       //                               ),
//       //                             ),
//       //                           ),
//       //                           // Flexible(
//       //                           //   flex: 1,
//       //                           //   fit: FlexFit.tight,
//       //                           //   child: Container(
//       //                           //     height: double.infinity,
//       //                           //     // color: Colors.blue,
//       //                           //   ),
//       //                           // )
//       //                           Flexible(
//       //                             flex: 1,
//       //                             fit: FlexFit.tight,
//       //                             child: Container(
//       //                               height: double.infinity,
//       //                               // color: Colors.red,
//       //                               padding: EdgeInsets.only(
//       //                                   top: SizeVariables.getHeight(
//       //                                           context) *
//       //                                       0.01,
//       //                                   right: SizeVariables.getWidth(
//       //                                           context) *
//       //                                       0.02),
//       //                               child: Column(
//       //                                 mainAxisAlignment:
//       //                                     MainAxisAlignment.start,
//       //                                 crossAxisAlignment:
//       //                                     CrossAxisAlignment.end,
//       //                                 children: [
//       //                                   Text(
//       //                                       '₹${provider[index]['total_amount']}',
//       //                                       style: const TextStyle(
//       //                                           decoration: TextDecoration
//       //                                               .lineThrough)),
//       //                                   Text(
//       //                                       provider[index]['paid_total_amount'] ==
//       //                                                   '' ||
//       //                                               provider[index][
//       //                                                       'paid_total_amount'] ==
//       //                                                   null ||
//       //                                               provider[index][
//       //                                                       'paid_total_amount'] ==
//       //                                                   0
//       //                                           ? '₹${provider[index]['total_amount']}'
//       //                                           : '₹${provider[index]['paid_total_amount']}',
//       //                                       style: const TextStyle(
//       //                                           // decoration: TextDecoration
//       //                                           //     .lineThrough,
//       //                                           color: Color.fromARGB(
//       //                                               255, 118, 227, 122)
//       //                                           // decorationThickness: 5,
//       //                                           )),
//       //                                 ],
//       //                               ),
//       //                             ),
//       //                           )
//       //                         ],
//       //                       ),
//       //                     ),
//       //                   )
//       //                   // Flexible(
//       //                   //   flex: 1,
//       //                   //   fit: FlexFit.tight,
//       //                   //   child: InkWell(
//       //                   //     onTap: () => showDialog(
//       //                   //         context: context,
//       //                   //         builder: (context) => AlertDialog(
//       //                   //               backgroundColor: const Color.fromARGB(
//       //                   //                   255, 62, 61, 61),
//       //                   //               title: Text('Receipt',
//       //                   //                   style: Theme.of(context)
//       //                   //                       .textTheme
//       //                   //                       .bodyText1),
//       //                   //               content: Container(
//       //                   //                 height:
//       //                   //                     SizeVariables.getHeight(context) *
//       //                   //                         0.5,
//       //                   //                 width: double.infinity,
//       //                   //                 // color: Colors.red,
//       //                   //                 child: Image.network(
//       //                   //                     provider[index]['attachment']),
//       //                   //               ),
//       //                   //             )),
//       //                   //     child: Container(
//       //                   //       width: double.infinity,
//       //                   //       // color: Colors.amber,
//       //                   //       padding: EdgeInsets.only(
//       //                   //           left:
//       //                   //               SizeVariables.getWidth(context) * 0.02),
//       //                   //       child: Row(
//       //                   //         mainAxisAlignment: MainAxisAlignment.start,
//       //                   //         children: const [
//       //                   //           Icon(Icons.receipt, color: Colors.white),
//       //                   //           Text('View')
//       //                   //         ],
//       //                   //       ),
//       //                   //     ),
//       //                   //   ),
//       //                   // )
//       //                 ],
//       //               ),
//       //             ),
//       //           ),
//       //         ),
//       //     itemCount: provider.length),
//     );
//   }
// }
