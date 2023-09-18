// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class CustomDialog extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final VoidCallback onOk;
//   final VoidCallback onCancel;

//   const CustomDialog({
//     required this.title,
//     required this.subtitle,
//     required this.onOk,
//     required this.onCancel,
//   });

//   // dialogContent(BuildContext context) {
//   //   return Container(
//   //     decoration: new BoxDecoration(
//   //       color: Colors.white,
//   //       shape: BoxShape.rectangle,
//   //       borderRadius: BorderRadius.circular(10),
//   //       boxShadow: [
//   //         BoxShadow(
//   //           color: Colors.black26,
//   //           blurRadius: 10.0,
//   //           offset: const Offset(0.0, 10.0),
//   //         ),
//   //       ],
//   //     ),
//   //     child: Column(
//   //       mainAxisSize: MainAxisSize.min, // To make the card compact
//   //       children: <Widget>[
//   //         SizedBox(height: 16.0),
//   //         // Image.asset('assets/images/splashscreen.png', height: 100),
//   //         Text(
//   //           title,
//   //           style:Theme.of(context).textTheme.headline5,
//   //         ),
//   //         SizedBox(height: 16.0),
//   //         Text(
//   //           subtitle,
//   //           style: Theme.of(context).textTheme.bodyText2!.copyWith(
//   //             color: Colors.red
//   //           ),
//   //         ),
//   //         SizedBox(height: 24.0),
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.center,
//   //           children: [
//   //             RaisedButton(
//   //               //     disabledColor: Colors.red,
//   //               // disabledTextColor: Colors.black,
//   //               padding: const EdgeInsets.all(20),
//   //               textColor: Colors.white,
//   //               color: Colors.blue,
//   //               onPressed: onOk,
//   //               child:  Text('OK',
//   //                 style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white)),
//   //             ),
//   //             const SizedBox(
//   //               height: 20,
//   //               width: 20,
//   //             ),
//   //             RaisedButton(
//   //               //     disabledColor: Colors.red,
//   //               // disabledTextColor: Colors.black,
//   //               padding: const EdgeInsets.all(20),
//   //               textColor: Colors.white,
//   //               color: Colors.red,
//   //               onPressed: onCancel,
//   //               child: Text('Cancel',
//   //                   style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white)),
//   //             ),
//   //           ],

//   //         ),
//   //         SizedBox(height: 16.0),

//   //       ],
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // return Dialog(
//     //   shape: RoundedRectangleBorder(
//     //     borderRadius: BorderRadius.circular(10),
//     //   ),
//     //   elevation: 0.0,
//     //   backgroundColor: Colors.transparent,
//     //   child: dialogContent(context),
//     // );
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
//       child: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Flushbar(
//               duration: const Duration(seconds: 4),
//               flushbarPosition: FlushbarPosition.BOTTOM,
//               borderRadius: BorderRadius.circular(10),
//               icon: const Icon(Icons.error, color: Colors.white),
//               // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
//               title: title,
//               message: subtitle,
//               barBlur: 20,
//             ).show(context),
//           ],
//         ),
//       ),
//     );
//   }
// }
