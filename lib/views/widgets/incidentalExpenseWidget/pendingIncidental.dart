// import 'dart:ui';

// import 'package:claimz/res/components/containerStyle.dart';
// import 'package:claimz/views/config/mediaQuery.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import '../../../viewModel/userIncidentalViewModel.dart';
// import '../../screens/editIncidentalExpenseForm.dart';

// class PendingIncidental extends StatelessWidget {
//   bool pendingIncidental = true;

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<UserIncidentalViewModel>(context).pending;

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
//                   onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => IncidentalClaimsEditScreen(
//                           pendingIncidental,
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
//                                                 pendingIncidental,
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
//                                       SizeVariables.getHeight(context) * 0.04,
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
//                                               Text('View/Edit Claim')
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
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.end,
//                                             children: [
//                                               Text(
//                                                   '₹${provider[index]['total_amount']}'),
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
//     );
//   }
// }
