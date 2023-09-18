// import 'package:another_flushbar/flushbar.dart';
// import 'package:claimz/utils/routes/routeNames.dart';
// import 'package:claimz/viewModel/claimzFormIndividualViewModel.dart';
// import 'package:claimz/views/config/mediaQuery.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// import '../../../viewModel/managerIncidentalViewModel.dart';

// class ManagerIncidentalClaimsEditScreen extends StatefulWidget {
//   final bool isPending;
//   final int incidentalFormId;
//   final int employeeId;
//   final int claimNo;
//   final int docNo;
//   final String serviceProvider;
//   final String billNo;
//   final int gstNo;
//   final int basicAmount;
//   final int gstAmount;
//   final int totalAmount;
//   final String purpose;
//   final String attachment;

//   ManagerIncidentalClaimsEditScreenState createState() =>
//       ManagerIncidentalClaimsEditScreenState();

//   ManagerIncidentalClaimsEditScreen(
//       this.isPending,
//       this.incidentalFormId,
//       this.employeeId,
//       this.claimNo,
//       this.docNo,
//       this.serviceProvider,
//       this.billNo,
//       this.gstNo,
//       this.basicAmount,
//       this.gstAmount,
//       this.totalAmount,
//       this.purpose,
//       this.attachment);
// }

// class ManagerIncidentalClaimsEditScreenState
//     extends State<ManagerIncidentalClaimsEditScreen> {
//   XFile? _ie_file;
//   final ImagePicker _picker = ImagePicker();
//   TextEditingController _ie_name_of_serviceprovider =
//       new TextEditingController();
//   TextEditingController _ie_basic_amt = new TextEditingController();
//   TextEditingController _ie_gst_amt = new TextEditingController();
//   TextEditingController _ie_total_amt = new TextEditingController();
//   TextEditingController _ie_gst_no = new TextEditingController();
//   TextEditingController _ie_bill_no = new TextEditingController();
//   TextEditingController _ie_purpose = new TextEditingController();
//   ClaimzFormIndividualViewModel _claimzFormData =
//       ClaimzFormIndividualViewModel();

//   @override
//   void initState() {
//     // TODO: implement initState
//     _ie_basic_amt.addListener(() {
//       setState(() {
//         if (_ie_basic_amt.text == '') {
//           setState(() {
//             _ie_total_amt.text = '0';
//           });
//         } else {
//           // _ie_total_amt.text = (double.parse(_ie_basic_amt.text) +
//           //         double.parse(_ie_gst_amt.text))
//           //     .toString();
//           setState(() {
//             _ie_total_amt.text =
//                 (int.parse(_ie_basic_amt.text) + int.parse(_ie_gst_amt.text))
//                     .toString();
//           });
//         }
//       });
//     });

//     _ie_gst_amt.addListener(() {
//       setState(() {
//         _ie_total_amt.text =
//             (int.parse(_ie_basic_amt.text) + int.parse(_ie_gst_amt.text))
//                 .toString();
//       });
//     });

//     _ie_name_of_serviceprovider.text = widget.serviceProvider;
//     _ie_basic_amt.text = widget.basicAmount.toString();
//     _ie_gst_amt.text = widget.gstAmount.toString();
//     _ie_total_amt.text = widget.totalAmount.toString();

//     print('TOTAAAAAAAL AMOOOOOOUNT: ${_ie_total_amt.text}');

//     _ie_gst_no.text = widget.gstNo.toString();
//     _ie_bill_no.text = widget.billNo.toString();
//     _ie_purpose.text = widget.purpose;
//     super.initState();
//   }

//   GlobalKey<NavigatorState> _pageKey = GlobalKey<NavigatorState>();

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.of(context).pop();
//         return false;
//       },
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.black,
//           appBar: AppBar(
//               automaticallyImplyLeading: false,
//               backgroundColor: Colors.black,
//               title: Container(
//                 padding: EdgeInsets.only(
//                   top: SizeVariables.getHeight(context) * 0.008,
//                 ),
//                 child: Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         // Navigator.of(context).pushNamed(RouteNames.navbar);
//                         Navigator.of(context).pop();
//                         // Navigator.pushReplacementNamed(
//                         //     context, RouteNames.incidentalClaimsScreen);
//                       },
//                       child: SvgPicture.asset(
//                         "assets/icons/back button.svg",
//                       ),
//                     ),
//                     SizedBox(width: SizeVariables.getWidth(context) * 0.05),
//                     Container(
//                       padding: EdgeInsets.only(
//                         left: SizeVariables.getWidth(context) * 0.01,
//                       ),
//                       child: Text(
//                         'Incidental Form',
//                         style: Theme.of(context).textTheme.caption,
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//           body: ListView(children: [
//             Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.only(
//                       left: SizeVariables.getWidth(context) * 0.04),
//                   child: Row(
//                     children: [
//                       Container(
//                         child: Icon(Icons.account_circle_outlined,
//                             color: Colors.white),
//                       ),
//                       SizedBox(
//                         width: SizeVariables.getWidth(context) * 0.02,
//                       ),
//                       Container(
//                         width: SizeVariables.getWidth(context) * 0.76,
//                         // width: 300,
//                         // height: 200,
//                         child: TextFormField(
//                           controller: _ie_name_of_serviceprovider,
//                           readOnly: true,
//                           keyboardType: TextInputType.text,
//                           decoration: InputDecoration(
//                             enabledBorder: const UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: 2,
//                                   color: Color.fromARGB(255, 167, 164, 164)),
//                             ),
//                             focusedBorder: const UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: 2,
//                                   color: Color.fromARGB(255, 194, 191, 191)),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'Name of provider',
//                             // hintText: "From",
//                             // hintStyle: Theme.of(context)
//                             //     .textTheme
//                             //     .bodyText2!
//                             //     .copyWith(color: Colors.grey),
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 18, color: Colors.white),
//                           ),
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: Colors.white),
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: SizeVariables.getHeight(context) * 0.03),

//             Container(
//               // color: Colors.red,
//               padding: EdgeInsets.only(
//                   left: SizeVariables.getWidth(context) * 0.04,
//                   right: SizeVariables.getWidth(context) * 0.12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     // color: Colors.amber,
//                     child: Row(
//                       children: [
//                         Container(
//                           child: Icon(Icons.receipt, color: Colors.white),
//                         ),
//                         SizedBox(
//                           width: SizeVariables.getWidth(context) * 0.02,
//                         ),
//                         Container(
//                           width: SizeVariables.getWidth(context) * 0.3,
//                           // width: 300,
//                           // height: 200,
//                           child: TextFormField(
//                             controller: _ie_bill_no,
//                             keyboardType: TextInputType.text,
//                             readOnly: true,
//                             decoration: InputDecoration(
//                               enabledBorder: const UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                     width: 2,
//                                     color: Color.fromARGB(255, 167, 164, 164)),
//                               ),
//                               focusedBorder: const UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                     width: 2,
//                                     color: Color.fromARGB(255, 194, 191, 191)),
//                               ),
//                               // border: InputBorder.none,
//                               labelText: 'Bill No.',
//                               // hintText: "From",
//                               // hintStyle: Theme.of(context)
//                               //     .textTheme
//                               //     .bodyText2!
//                               //     .copyWith(color: Colors.grey),
//                               labelStyle: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(fontSize: 18, color: Colors.white),
//                             ),
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(color: Colors.white),
//                             showCursor: false,
//                             cursorColor: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         child: Icon(Icons.receipt_long, color: Colors.white),
//                       ),
//                       SizedBox(
//                         width: SizeVariables.getWidth(context) * 0.02,
//                       ),
//                       Container(
//                         width: SizeVariables.getWidth(context) * 0.3,
//                         // width: 300,
//                         // height: 200,
//                         child: TextFormField(
//                           controller: _ie_gst_no,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(15)
//                           ],
//                           keyboardType: TextInputType.text,
//                           readOnly: true,
//                           decoration: InputDecoration(
//                             enabledBorder: const UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: 2,
//                                   color: Color.fromARGB(255, 167, 164, 164)),
//                             ),
//                             focusedBorder: const UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: 2,
//                                   color: Color.fromARGB(255, 194, 191, 191)),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'GST No.',
//                             // hintText: "To",
//                             // hintStyle: Theme.of(context)
//                             //     .textTheme
//                             //     .bodyText2!
//                             //     .copyWith(color: Colors.grey),
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 18, color: Colors.white),
//                           ),
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: Colors.white),
//                           showCursor: false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: SizeVariables.getHeight(context) * 0.03),

//             // Container(
//             //   // color: Colors.red,
//             //   padding: EdgeInsets.only(
//             //       left: SizeVariables.getWidth(context) * 0.04,
//             //       right: SizeVariables.getWidth(context) * 0.12),
//             //   child: Column(
//             //     children: [
//             //       Row(
//             //         children: [
//             //           const Icon(Icons.upload, color: Colors.white),
//             //           SizedBox(
//             //             width: SizeVariables.getWidth(context) * 0.02,
//             //           ),
//             //           Text('Upload Invoice',
//             //               style: Theme.of(context)
//             //                   .textTheme
//             //                   .bodyText1!
//             //                   .copyWith(color: Colors.white, fontSize: 18))
//             //         ],
//             //       ),
//             //       SizedBox(height: SizeVariables.getHeight(context) * 0.01),
//             //       Container(
//             //         // color: Colors.green,
//             //         padding: EdgeInsets.only(
//             //             left: SizeVariables.getHeight(context) * 0.04),
//             //         child: Row(
//             //           children: [
//             //             InkWell(
//             //                 onTap: () async {
//             //                   _ie_file = await _picker.pickImage(
//             //                       source: ImageSource.camera);
//             //                 },
//             //                 child: const Icon(Icons.camera_alt,
//             //                     color: Colors.white, size: 30)),
//             //             SizedBox(width: SizeVariables.getWidth(context) * 0.02),
//             //             InkWell(
//             //               onTap: () async {
//             //                 _ie_file = await _picker.pickImage(
//             //                     source: ImageSource.gallery);
//             //               },
//             //               child: const Icon(Icons.upload_file_outlined,
//             //                   color: Colors.white, size: 30),
//             //             )
//             //           ],
//             //         ),
//             //       )
//             //     ],
//             //   ),
//             // ),

//             // SizedBox(height: SizeVariables.getHeight(context) * 0.02),

//             Container(
//               // color: Colors.red,
//               padding: EdgeInsets.only(
//                   left: SizeVariables.getWidth(context) * 0.04,
//                   right: SizeVariables.getWidth(context) * 0.12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     // color: Colors.amber,
//                     child: Row(
//                       children: [
//                         // Container(
//                         //   child: Icon(Icons.calendar_month_outlined,
//                         //       color: Colors.white),
//                         // ),
//                         Text('₹',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(
//                                     color: Colors.white,
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.bold)),
//                         SizedBox(
//                           width: SizeVariables.getWidth(context) * 0.02,
//                         ),
//                         Container(
//                           width: SizeVariables.getWidth(context) * 0.3,
//                           // width: 300,
//                           // height: 200,
//                           child: TextFormField(
//                             controller: _ie_basic_amt,
//                             keyboardType: TextInputType.number,
//                             readOnly: widget.isPending == true ? false : true,
//                             decoration: InputDecoration(
//                               enabledBorder: const UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                     width: 2,
//                                     color: Color.fromARGB(255, 167, 164, 164)),
//                               ),
//                               focusedBorder: const UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                     width: 2,
//                                     color: Color.fromARGB(255, 194, 191, 191)),
//                               ),
//                               // border: InputBorder.none,
//                               labelText: 'Basic (₹${widget.basicAmount})',
//                               // hintText: "From",
//                               // hintStyle: Theme.of(context)
//                               //     .textTheme
//                               //     .bodyText2!
//                               //     .copyWith(color: Colors.grey),
//                               labelStyle: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(fontSize: 18, color: Colors.white),
//                             ),
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(color: Colors.white),
//                             showCursor: widget.isPending == true ? true : false,
//                             cursorColor: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Text('₹',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(
//                                   color: Colors.white,
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.bold)),
//                       SizedBox(
//                         width: SizeVariables.getWidth(context) * 0.02,
//                       ),
//                       Container(
//                         width: SizeVariables.getWidth(context) * 0.3,
//                         // width: 300,
//                         // height: 200,
//                         child: TextFormField(
//                           controller: _ie_gst_amt,
//                           keyboardType: TextInputType.number,
//                           readOnly: widget.isPending == true ? false : true,
//                           decoration: InputDecoration(
//                             enabledBorder: const UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: 2,
//                                   color: Color.fromARGB(255, 167, 164, 164)),
//                             ),
//                             focusedBorder: const UnderlineInputBorder(
//                               borderSide: BorderSide(
//                                   width: 2,
//                                   color: Color.fromARGB(255, 194, 191, 191)),
//                             ),
//                             // border: InputBorder.none,
//                             labelText: 'GST (₹${widget.gstAmount})',
//                             // hintText: "To",
//                             // hintStyle: Theme.of(context)
//                             //     .textTheme
//                             //     .bodyText2!
//                             //     .copyWith(color: Colors.grey),
//                             labelStyle: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(fontSize: 18, color: Colors.white),
//                           ),
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: Colors.white),
//                           showCursor: widget.isPending == true ? true : false,
//                           cursorColor: Colors.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: SizeVariables.getHeight(context) * 0.03),

//             Container(
//               // color: Colors.red,
//               padding: EdgeInsets.only(
//                   left: SizeVariables.getWidth(context) * 0.04,
//                   right: SizeVariables.getWidth(context) * 0.12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     // color: Colors.amber,
//                     child: Row(
//                       children: [
//                         Text('₹',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(
//                                     color: Colors.white,
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.bold)),
//                         SizedBox(
//                           width: SizeVariables.getWidth(context) * 0.02,
//                         ),
//                         Container(
//                           width: SizeVariables.getWidth(context) * 0.3,
//                           // width: 300,
//                           // height: 200,
//                           child: TextFormField(
//                             controller: _ie_total_amt,
//                             keyboardType: TextInputType.number,
//                             readOnly: widget.isPending == true ? false : true,
//                             decoration: InputDecoration(
//                               enabledBorder: const UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                     width: 2,
//                                     color: Color.fromARGB(255, 167, 164, 164)),
//                               ),
//                               focusedBorder: const UnderlineInputBorder(
//                                 borderSide: BorderSide(
//                                     width: 2,
//                                     color: Color.fromARGB(255, 194, 191, 191)),
//                               ),
//                               // border: InputBorder.none,
//                               labelText: 'Total (₹${widget.totalAmount})',
//                               // hintText: "From",
//                               // hintStyle: Theme.of(context)
//                               //     .textTheme
//                               //     .bodyText2!
//                               //     .copyWith(color: Colors.grey),
//                               labelStyle: Theme.of(context)
//                                   .textTheme
//                                   .bodyText1!
//                                   .copyWith(fontSize: 18, color: Colors.white),
//                             ),
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText1!
//                                 .copyWith(color: Colors.white),
//                             showCursor: widget.isPending == true ? true : false,
//                             cursorColor: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: SizeVariables.getHeight(context) * 0.05),

//             //View Receipt
//             InkWell(
//               onTap: () => showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                         backgroundColor: const Color.fromARGB(255, 62, 61, 61),
//                         title: Text('Receipt',
//                             style: Theme.of(context).textTheme.bodyText1),
//                         content: Container(
//                           height: SizeVariables.getHeight(context) * 0.5,
//                           width: double.infinity,
//                           // color: Colors.red,
//                           child: Image.network(widget.attachment),
//                         ),
//                       )),
//               child: Container(
//                 width: double.infinity,
//                 // color: Colors.amber,
//                 padding: EdgeInsets.only(
//                     left: SizeVariables.getWidth(context) * 0.048),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Icon(Icons.receipt, color: Colors.amber),
//                     SizedBox(height: SizeVariables.getWidth(context) * 0.04),
//                     const Text('View Receipt')
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: SizeVariables.getHeight(context) * 0.04),

//             //Submit Button

//             widget.isPending == true
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: SizeVariables.getHeight(context) * 0.04,
//                         width: SizeVariables.getWidth(context) * 0.4,
//                         child: ElevatedButton(
//                           style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   Color.fromARGB(168, 81, 80, 80)),
//                               foregroundColor: MaterialStateProperty.all<Color>(
//                                   Color(0xffF59F23))),
//                           onPressed: () {
//                             Map request_filename = {
//                               "file_name": "attachment",
//                             };
//                             Map<String, String> request_data = {
//                               // "GST_no": 'GSTIN${_ie_gst_no.text}',
//                               "gst_amount": _ie_gst_amt.text,
//                               "paid_amount": _ie_basic_amt.text,
//                               "total_amount": _ie_total_amt.text,
//                               'claim_no': widget.claimNo.toString()
//                               // "purpose": _ie_purpose.text,
//                               // "service_provider":
//                               //     _ie_name_of_serviceprovider.text,
//                               // "bill_no": _ie_bill_no.text,
//                             };

//                             if (int.parse(_ie_total_amt.text) >
//                                 int.parse(widget.totalAmount.toString())) {
//                               Flushbar(
//                                 message:
//                                     "Total Amount must be less than or equal to the Initial Claim Amount",
//                                 icon: Icon(
//                                   Icons.info_outline,
//                                   size: 28.0,
//                                   color: Colors.blue,
//                                 ),
//                                 duration: Duration(seconds: 3),
//                                 leftBarIndicatorColor: Colors.blue,
//                               )..show(context);
//                             } else {
//                               Provider.of<ManagerIncidentalViewModel>(context,
//                                       listen: false)
//                                   .editIncidentalExpense(context, request_data);
//                             }
//                           },
//                           child: Text('Amend Claim',
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText2
//                                   ?.copyWith(
//                                     color: const Color(0xffF59F23),
//                                   )),
//                         ),
//                         decoration: new BoxDecoration(
//                           color: Color.fromARGB(168, 94, 92, 92),
//                           shape: BoxShape.rectangle,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color.fromARGB(255, 74, 74, 70),
//                               blurRadius: 5.0,
//                               offset: const Offset(2.0, 2.0),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   )
//                 : Container(),

//             // Container(
//             //   child: Padding(
//             //     padding: const EdgeInsets.all(8.0),
//             //     child: Card(
//             //       color: Colors.black,
//             //       // surfaceTintColor: Colors.white,
//             //       child: Column(
//             //         children: [
//             //           SizedBox(
//             //             height: SizeVariables.getHeight(context) * 0.02,
//             //           ),
//             //           SizedBox(
//             //             height: SizeVariables.getHeight(context) * 0.01,
//             //           ),
//             //           Row(
//             //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //             children: [
//             //               Container(
//             //                 height: SizeVariables.getHeight(context) * 0.075,
//             //                 width: SizeVariables.getWidth(context) * 0.4,
//             //                 child: Center(
//             //                   child: TextFormField(
//             //                     controller: _ie_name_of_serviceprovider,
//             //                     readOnly: true,
//             //                     decoration: InputDecoration(
//             //                       enabledBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       focusedBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       // border: InputBorder.none,
//             //                       labelText: 'Name of Service Provider',
//             //                       labelStyle: Theme.of(context)
//             //                           .textTheme
//             //                           .bodyText1!
//             //                           .copyWith(fontSize: 12),
//             //                     ),
//             //                     style: Theme.of(context).textTheme.bodyText1,
//             //                     showCursor: false,
//             //                     cursorColor: Colors.white,
//             //                   ),
//             //                 ),
//             //               ),
//             //               Container(
//             //                 height: SizeVariables.getHeight(context) * 0.075,
//             //                 width: SizeVariables.getWidth(context) * 0.4,
//             //                 child: Center(
//             //                   child: TextFormField(
//             //                     controller: _ie_bill_no,
//             //                     readOnly: true,
//             //                     decoration: InputDecoration(
//             //                       enabledBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       focusedBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       // border: InputBorder.none,
//             //                       labelText: 'Bill No',
//             //                       labelStyle: Theme.of(context)
//             //                           .textTheme
//             //                           .bodyText1!
//             //                           .copyWith(fontSize: 12),
//             //                     ),
//             //                     style: Theme.of(context).textTheme.bodyText1,
//             //                     showCursor: false,
//             //                     cursorColor: Colors.white,
//             //                   ),
//             //                 ),
//             //               ),
//             //             ],
//             //           ),
//             //           SizedBox(
//             //             height: SizeVariables.getHeight(context) * 0.01,
//             //           ),
//             //           Row(
//             //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //             children: [
//             //               Container(
//             //                 // color: Colors.amber,
//             //                 // padding: EdgeInsets.all(8),
//             //                 height: SizeVariables.getHeight(context) * 0.075,
//             //                 width: SizeVariables.getWidth(context) * 0.4,
//             //                 // decoration: BoxDecoration(
//             //                 //   color: Color.fromARGB(255, 17, 17, 17),
//             //                 //   borderRadius: BorderRadius.circular(12),
//             //                 // ),
//             //                 child: Center(
//             //                   child: TextFormField(
//             //                     controller: _ie_gst_no,
//             //                     readOnly: true,
//             //                     inputFormatters: [
//             //                       LengthLimitingTextInputFormatter(15)
//             //                     ],
//             //                     decoration: InputDecoration(
//             //                       enabledBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       focusedBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       // border: InputBorder.none,
//             //                       labelText: 'GST No',
//             //                       labelStyle: Theme.of(context)
//             //                           .textTheme
//             //                           .bodyText1!
//             //                           .copyWith(fontSize: 12),
//             //                     ),
//             //                     style: Theme.of(context).textTheme.bodyText1,
//             //                     showCursor: false,
//             //                     cursorColor: Colors.white,
//             //                   ),
//             //                 ),
//             //               ),
//             //               Column(
//             //                 children: [
//             //                   Container(
//             //                     // color: Colors.amber,
//             //                     // padding: EdgeInsets.all(8),
//             //                     // height: SizeVariables.getHeight(context) * 0.075,
//             //                     width: SizeVariables.getWidth(context) * 0.4,
//             //                     // decoration: BoxDecoration(
//             //                     //   color: Color.fromARGB(255, 17, 17, 17),
//             //                     //   borderRadius: BorderRadius.circular(12),
//             //                     // ),
//             //                     child: Center(
//             //                       child: TextFormField(
//             //                         controller: _ie_basic_amt,
//             //                         readOnly:
//             //                             widget.isPending == true ? false : true,
//             //                         keyboardType: TextInputType.number,
//             //                         decoration: InputDecoration(
//             //                           enabledBorder: UnderlineInputBorder(
//             //                             borderSide: BorderSide(
//             //                                 width: 2, color: Colors.white),
//             //                           ),
//             //                           focusedBorder: UnderlineInputBorder(
//             //                             borderSide: BorderSide(
//             //                                 width: 2, color: Colors.white),
//             //                           ),
//             //                           // border: InputBorder.none,
//             //                           labelText:
//             //                               'Basic Amount (₹${widget.basicAmount})',
//             //                           labelStyle: Theme.of(context)
//             //                               .textTheme
//             //                               .bodyText1!
//             //                               .copyWith(fontSize: 12),
//             //                         ),
//             //                         style:
//             //                             Theme.of(context).textTheme.bodyText1,
//             //                         showCursor: false,
//             //                         cursorColor: Colors.white,
//             //                       ),
//             //                     ),
//             //                   ),
//             //                 ],
//             //               ),
//             //             ],
//             //           ),
//             //           SizedBox(
//             //             height: SizeVariables.getHeight(context) * 0.01,
//             //           ),
//             //           Row(
//             //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //             children: [
//             //               Container(
//             //                 height: SizeVariables.getHeight(context) * 0.075,
//             //                 width: SizeVariables.getWidth(context) * 0.4,
//             //                 child: Center(
//             //                   child: TextFormField(
//             //                     controller: _ie_gst_amt,
//             //                     readOnly:
//             //                         widget.isPending == true ? false : true,
//             //                     keyboardType: TextInputType.number,
//             //                     decoration: InputDecoration(
//             //                       enabledBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       focusedBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       // border: InputBorder.none,
//             //                       labelText:
//             //                           'GST Amount (₹${widget.gstAmount})',
//             //                       labelStyle: Theme.of(context)
//             //                           .textTheme
//             //                           .bodyText1!
//             //                           .copyWith(fontSize: 12),
//             //                     ),
//             //                     style: Theme.of(context).textTheme.bodyText1,
//             //                     showCursor: false,
//             //                     cursorColor: Colors.white,
//             //                   ),
//             //                 ),
//             //               ),
//             //               Container(
//             //                 // color: Colors.amber,
//             //                 // padding: EdgeInsets.all(8),
//             //                 height: SizeVariables.getHeight(context) * 0.075,
//             //                 width: SizeVariables.getWidth(context) * 0.4,
//             //                 // decoration: BoxDecoration(
//             //                 //   color: Color.fromARGB(255, 17, 17, 17),
//             //                 //   borderRadius: BorderRadius.circular(12),
//             //                 // ),
//             //                 child: Center(
//             //                   child: TextFormField(
//             //                     controller: _ie_total_amt,
//             //                     autofocus:
//             //                         widget.isPending == true ? true : false,
//             //                     readOnly:
//             //                         widget.isPending == true ? false : true,
//             //                     keyboardType: TextInputType.number,
//             //                     decoration: InputDecoration(
//             //                       enabledBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       focusedBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       // border: InputBorder.none,
//             //                       labelText:
//             //                           'Total Amount (₹${widget.totalAmount})',
//             //                       labelStyle: Theme.of(context)
//             //                           .textTheme
//             //                           .bodyText1!
//             //                           .copyWith(fontSize: 12),
//             //                     ),
//             //                     style: Theme.of(context).textTheme.bodyText1,
//             //                     showCursor: false,
//             //                     cursorColor: Colors.white,
//             //                   ),
//             //                 ),
//             //               ),
//             //             ],
//             //           ),
//             //           SizedBox(
//             //             height: SizeVariables.getHeight(context) * 0.04,
//             //           ),
//             //           Row(
//             //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //             children: [
//             //               Container(
//             //                 // color: Colors.amber,
//             //                 // padding: EdgeInsets.all(8),
//             //                 height: SizeVariables.getHeight(context) * 0.1,
//             //                 width: SizeVariables.getWidth(context) * 0.9,
//             //                 // decoration: BoxDecoration(
//             //                 //   color: Color.fromARGB(255, 17, 17, 17),
//             //                 //   borderRadius: BorderRadius.circular(12),
//             //                 // ),
//             //                 child: Center(
//             //                   child: TextFormField(
//             //                     controller: _ie_purpose,
//             //                     readOnly: true,
//             //                     maxLength: 25,
//             //                     decoration: InputDecoration(
//             //                       enabledBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       focusedBorder: UnderlineInputBorder(
//             //                         borderSide: BorderSide(
//             //                             width: 2, color: Colors.white),
//             //                       ),
//             //                       // border: InputBorder.none,
//             //                       labelText: 'Purpose',
//             //                       labelStyle: Theme.of(context)
//             //                           .textTheme
//             //                           .bodyText1!
//             //                           .copyWith(fontSize: 12),
//             //                     ),
//             //                     style: Theme.of(context).textTheme.bodyText1,
//             //                     showCursor: false,
//             //                     cursorColor: Colors.white,
//             //                   ),
//             //                 ),
//             //               ),
//             //             ],
//             //           ),
//             //           SizedBox(height: SizeVariables.getHeight(context) * 0.02),

//             //           //View Receipt
//             //           InkWell(
//             //             onTap: () => showDialog(
//             //                 context: context,
//             //                 builder: (context) => AlertDialog(
//             //                       backgroundColor:
//             //                           const Color.fromARGB(255, 62, 61, 61),
//             //                       title: Text('Receipt',
//             //                           style: Theme.of(context)
//             //                               .textTheme
//             //                               .bodyText1),
//             //                       content: Container(
//             //                         height:
//             //                             SizeVariables.getHeight(context) * 0.5,
//             //                         width: double.infinity,
//             //                         // color: Colors.red,
//             //                         child: Image.network(widget.attachment),
//             //                       ),
//             //                     )),
//             //             child: Container(
//             //               width: double.infinity,
//             //               // color: Colors.amber,
//             //               padding: EdgeInsets.only(
//             //                   left: SizeVariables.getWidth(context) * 0.02),
//             //               child: Row(
//             //                 mainAxisAlignment: MainAxisAlignment.start,
//             //                 children: [
//             //                   const Icon(Icons.receipt, color: Colors.amber),
//             //                   SizedBox(
//             //                       height:
//             //                           SizeVariables.getWidth(context) * 0.04),
//             //                   const Text('View Receipt')
//             //                 ],
//             //               ),
//             //             ),
//             //           ),
//             //           SizedBox(height: SizeVariables.getHeight(context) * 0.04),

//             //           //Submit Button

//             //           widget.isPending == true
//             //               ? Row(
//             //                   mainAxisAlignment: MainAxisAlignment.center,
//             //                   children: [
//             //                     Container(
//             //                       height:
//             //                           SizeVariables.getHeight(context) * 0.04,
//             //                       width: SizeVariables.getWidth(context) * 0.4,
//             //                       child: ElevatedButton(
//             //                         style: ButtonStyle(
//             //                             backgroundColor:
//             //                                 MaterialStateProperty.all<Color>(
//             //                                     Color.fromARGB(
//             //                                         168, 81, 80, 80)),
//             //                             foregroundColor:
//             //                                 MaterialStateProperty.all<Color>(
//             //                                     Color(0xffF59F23))),
//             //                         onPressed: () {
//             //                           Map request_filename = {
//             //                             "file_name": "attachment",
//             //                           };
//             //                           Map<String, String> request_data = {
//             //                             // "GST_no": 'GSTIN${_ie_gst_no.text}',
//             //                             "gst_amount": _ie_gst_amt.text,
//             //                             "paid_amount": _ie_basic_amt.text,
//             //                             "total_amount": _ie_total_amt.text,
//             //                             'claim_no': widget.claimNo.toString()
//             //                             // "purpose": _ie_purpose.text,
//             //                             // "service_provider":
//             //                             //     _ie_name_of_serviceprovider.text,
//             //                             // "bill_no": _ie_bill_no.text,
//             //                           };

//             //                           if (int.parse(_ie_total_amt.text) >
//             //                               int.parse(
//             //                                   widget.totalAmount.toString())) {
//             //                             Flushbar(
//             //                               message:
//             //                                   "Total Amount must be less than or equal to the Initial Claim Amount",
//             //                               icon: Icon(
//             //                                 Icons.info_outline,
//             //                                 size: 28.0,
//             //                                 color: Colors.blue,
//             //                               ),
//             //                               duration: Duration(seconds: 3),
//             //                               leftBarIndicatorColor: Colors.blue,
//             //                             )..show(context);
//             //                           } else {
//             //                             Provider.of<ClaimzFormIndividualViewModel>(
//             //                                     context,
//             //                                     listen: false)
//             //                                 .editIncidentalExpense(
//             //                                     context, request_data);
//             //                           }
//             //                         },
//             //                         child: Text('Amend Claim',
//             //                             style: Theme.of(context)
//             //                                 .textTheme
//             //                                 .bodyText2
//             //                                 ?.copyWith(
//             //                                   color: const Color(0xffF59F23),
//             //                                 )),
//             //                       ),
//             //                       decoration: new BoxDecoration(
//             //                         color: Color.fromARGB(168, 94, 92, 92),
//             //                         shape: BoxShape.rectangle,
//             //                         borderRadius: BorderRadius.circular(8),
//             //                         boxShadow: [
//             //                           BoxShadow(
//             //                             color: Color.fromARGB(255, 74, 74, 70),
//             //                             blurRadius: 5.0,
//             //                             offset: const Offset(2.0, 2.0),
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 )
//             //               : Container(),
//             //         ],
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ]),
//         ),
//       ),
//     );
//   }

//   void _errorVal(BuildContext context) {
//     Flushbar(
//       message: "please provide image",
//       icon: Icon(
//         Icons.warning_amber_outlined,
//         size: 28.0,
//         color: Colors.red,
//       ),
//       duration: Duration(seconds: 3),
//       leftBarIndicatorColor: Colors.red,
//     )..show(context);
//   }

//   Future<bool> _backPressed(GlobalKey<NavigatorState> _yourKey) async {
//     //Checks if current Navigator still has screens on the stack.
//     if (_yourKey.currentState!.canPop()) {
//       // 'maybePop' method handles the decision of 'pop' to another WillPopScope if they exist.
//       //If no other WillPopScope exists, it returns true
//       Navigator.pushNamed(context, RouteNames.incidentalClaimsScreen);
//       _yourKey.currentState!.maybePop();
//       return Future<bool>.value(false);
//     }
// //if nothing remains in the stack, it simply pops
//     return Future<bool>.value(true);
//   }
// }
