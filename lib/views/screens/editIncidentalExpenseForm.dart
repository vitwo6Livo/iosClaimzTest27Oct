import 'dart:io';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/claimzFormIndividualViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../viewModel/managerIncidentalViewModel.dart';
import 'managerIncidentalScreen/managerIncidental.dart';

class IncidentalClaimsEditScreen extends StatefulWidget {
  final bool isEditable;
  final bool isPending;
  final Map<String, dynamic> logs;
  final bool isFromUser;
  final int incidentalFormId;
  final int employeeId;
  final String claimNo;
  // final int docNo;
  final String serviceProvider;
  final String billNo;
  final String gstNo;
  final String basicAmount;
  final String gstAmount;
  final String totalAmount;
  final String purpose;
  final String attachment;
  final String fromDate;
  final String toDate;

  IncidentalClaimsEditScreenState createState() =>
      IncidentalClaimsEditScreenState();

  IncidentalClaimsEditScreen(
      this.isEditable,
      this.isPending,
      this.logs,
      this.isFromUser,
      this.incidentalFormId,
      this.employeeId,
      this.claimNo,
      // this.docNo,
      this.serviceProvider,
      this.billNo,
      this.gstNo,
      this.basicAmount,
      this.gstAmount,
      this.totalAmount,
      this.purpose,
      this.attachment,
      this.fromDate,
      this.toDate);
}

class IncidentalClaimsEditScreenState extends State<IncidentalClaimsEditScreen>
    with SingleTickerProviderStateMixin {
  XFile? _ie_file;
  final ImagePicker _picker = ImagePicker();
  TextEditingController _ie_name_of_serviceprovider =
      new TextEditingController();
  TextEditingController _ie_basic_amt = new TextEditingController();
  TextEditingController _ie_gst_amt = new TextEditingController();
  TextEditingController _ie_total_amt = new TextEditingController();
  TextEditingController _ie_gst_no = new TextEditingController();
  TextEditingController _ie_bill_no = new TextEditingController();
  TextEditingController _ie_purpose = new TextEditingController();
  TextEditingController editJustification = TextEditingController();
  TextEditingController actionJustification = TextEditingController();
  TextEditingController _reason = TextEditingController();
  ClaimzFormIndividualViewModel _claimzFormData =
      ClaimzFormIndividualViewModel();
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? add;
  OverlayEntry? entry;
  var role;

  void initialiseRole() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    setState(() {
      role = localStorage.getInt('role');
    });
    print('ROLEEEEEEEEEEe: $role');
  }

  @override
  void initState() {
    // TODO: implement initState
    initialiseRole();
    // _ie_basic_amt.addListener(() {
    //   setState(() {
    //     if (_ie_basic_amt.text == '') {
    //       setState(() {
    //         _ie_total_amt.text = '0';
    //       });
    //     } else {
    //       _ie_total_amt.text =
    //           (int.parse(_ie_basic_amt.text) + int.parse(_ie_gst_amt.text))
    //               .toString();
    //     }
    //   });
    // });

    // _ie_gst_amt.addListener(() {
    //   setState(() {
    //     _ie_total_amt.text =
    //         (int.parse(_ie_basic_amt.text) + int.parse(_ie_gst_amt.text))
    //             .toString();
    //   });
    // });

    _ie_name_of_serviceprovider.text = widget.serviceProvider;
    _ie_basic_amt.text = widget.basicAmount.toString();
    _ie_gst_amt.text = widget.gstAmount.toString();
    _ie_total_amt.text = widget.totalAmount.toString();
    _ie_gst_no.text = widget.gstNo.toString();
    _ie_bill_no.text = widget.billNo.toString();
    _ie_purpose.text = widget.purpose;
    // _ie_file = XFile(File(imagePath.toString()).path);

    if (_ie_total_amt.text == '') {
      _ie_total_amt.text = '0.0';
    }

    _ie_basic_amt.addListener(() {
      setState(() {
        if (_ie_basic_amt.text == '' && _ie_gst_amt.text != '') {
          setState(() {
            _ie_total_amt.text = _ie_gst_amt.text;
          });
        } else if (_ie_basic_amt.text == '' && _ie_gst_amt.text == '') {
          _ie_total_amt.text = '0.0';
        } else if (_ie_basic_amt.text != '' && _ie_gst_amt.text == '') {
          setState(() {
            _ie_total_amt.text = _ie_basic_amt.text;
          });
        } else {
          setState(() {
            _ie_total_amt.text = (double.parse(_ie_basic_amt.text) +
                    double.parse(_ie_gst_amt.text))
                .toString();
          });
        }
      });
    });

    _ie_gst_amt.addListener(() {
      if (_ie_gst_amt.text == '' && _ie_basic_amt.text != '') {
        setState(() {
          _ie_total_amt.text = _ie_basic_amt.text;
        });
      } else if (_ie_gst_amt.text == '' && _ie_basic_amt.text == '') {
        _ie_total_amt.text = '0.0';
      } else if (_ie_gst_amt.text != '' && _ie_basic_amt.text == '') {
        setState(() {
          _ie_total_amt.text = _ie_gst_amt.text;
        });
      } else {
        setState(() {
          _ie_total_amt.text = (double.parse(_ie_basic_amt.text) +
                  double.parse(_ie_gst_amt.text))
              .toString();
        });
      }
    });

    super.initState();

    controller = TransformationController();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() => controller.value = animation!.value);
  }

  GlobalKey<NavigatorState> _pageKey = GlobalKey<NavigatorState>();

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        // Navigator.pushNamed(context, RouteNames.incidentalClaimsScreen);
        // Navigator.pushReplacementNamed(
        //     context, RouteNames.incidentalClaimsScreen);
        // Navigator.pushReplacementNamed(
        //     context, RouteNames.incidentalClaimsScreen);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
              elevation: 1,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              title: Container(
                padding: EdgeInsets.only(
                  top: SizeVariables.getHeight(context) * 0.008,
                ),
                child: widget.isFromUser == false && role == 1
                    ? Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).pushNamed(RouteNames.navbar);
                              Navigator.of(context).pop();
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) =>
                              //         ManagerIncidentalExpenseScreen())
                              //         );

                              // Navigator.pushReplacementNamed(
                              //     context, RouteNames.incidentalClaimsScreen);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/back button.svg",
                            ),
                          ),
                          SizedBox(
                              width: SizeVariables.getWidth(context) * 0.02),
                          Container(
                            // padding: EdgeInsets.only(
                            //   left: SizeVariables.getWidth(context) * 0.01,
                            // ),
                            child: Text(
                              'Incidental Expense',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).pushNamed(RouteNames.navbar);
                              Navigator.of(context).pop();
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) =>
                              //         ManagerIncidentalExpenseScreen()));

                              // Navigator.pushReplacementNamed(
                              //     context, RouteNames.incidentalClaimsScreen);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/back button.svg",
                            ),
                          ),
                          SizedBox(
                              width: SizeVariables.getWidth(context) * 0.02),
                          Container(
                            // padding: EdgeInsets.only(
                            //   left: SizeVariables.getWidth(context) * 0.01,
                            // ),
                            child: Text(
                              'Incidental Expense',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ],
                      ),
              )
              // leading: InkWell(
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     Navigator.pushNamed(context, RouteNames.incidentalClaimsScreen);
              //   },
              //   child: SvgPicture.asset(
              //     "assets/icons/back button.svg",
              //   ),
              // ),
              // title: Padding(
              //   padding:
              //       EdgeInsets.only(left: SizeVariables.getWidth(context) * 0.02),
              //   child: FittedBox(
              //     fit: BoxFit.contain,
              //     child: Text(
              //       'Incidental Form',
              //       style: Theme.of(context).textTheme.caption,
              //     ),
              //   ),
              // ),
              ),
          body: Column(children: [
            Container(
              width: double.infinity,
              height: SizeVariables.getHeight(context) * 0.15,
              // color: Colors.yellow,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      // color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('₹',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      fontSize: 35,
                                      color: const Color(0xffF59F23))),
                          // Text(_ie_total_amt.text,
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .caption!
                          //         .copyWith(fontSize: 35))
                          // TextFormField(
                          //             controller:
                          //                 _ie_name_of_serviceprovider,
                          //             readOnly: false,
                          //             keyboardType: TextInputType.text,
                          //             decoration: InputDecoration(
                          //               border: InputBorder.none,
                          //               // enabledBorder:
                          //               //     const UnderlineInputBorder(
                          //               //   borderSide: BorderSide(
                          //               //       width: 2,
                          //               //       color: Color.fromARGB(
                          //               //           255, 167, 164, 164)),
                          //               // ),
                          //               focusedBorder:
                          //                   const UnderlineInputBorder(
                          //                 borderSide: BorderSide(
                          //                     width: 2,
                          //                     color: Color.fromARGB(
                          //                         255, 194, 191, 191)),
                          //               ),
                          //               // border: InputBorder.none,
                          //               labelText: 'Name of provider',
                          //               // hintText: "From",
                          //               // hintStyle: Theme.of(context)
                          //               //     .textTheme
                          //               //     .bodyText2!
                          //               //     .copyWith(color: Colors.grey),
                          //               labelStyle: Theme.of(context)
                          //                   .textTheme
                          //                   .bodyText1!
                          //                   .copyWith(
                          //                       fontSize: 18,
                          //                       color: Colors.black),
                          //             ),
                          //             style: Theme.of(context)
                          //                 .textTheme
                          //                 .bodyText1!
                          //                 .copyWith(color: Colors.black),
                          //             showCursor: false,
                          //             cursorColor: Colors.black,
                          //           ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Container(
                      height: double.infinity,
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.01),
                      // color: Colors.blue,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _ie_total_amt,
                            readOnly: widget.isEditable == true ? true : false,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // enabledBorder:
                              //     const UnderlineInputBorder(
                              //   borderSide: BorderSide(
                              //       width: 2,
                              //       color: Color.fromARGB(
                              //           255, 167, 164, 164)),
                              // ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              // labelText: 'Name of provider',
                              // hintText: "From",
                              // hintStyle: Theme.of(context)
                              //     .textTheme
                              //     .bodyText2!
                              //     .copyWith(color: Colors.grey),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Theme.of(context).canvasColor,
                                    fontSize: 35),
                            showCursor: false,
                            cursorColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(width: SizeVariables.getWidth(context) * 0.08),
                  widget.isFromUser == false && role == 1
                      ? Flexible(
                          flex: 1,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              // height:
                              //     SizeVariables.getHeight(context) * 0.05,
                              // width:
                              //     SizeVariables.getHeight(context) * 0.05,
                              height: double.infinity,
                              // color: Colors.green,
                              // child: Lottie.asset(
                              //     'assets/json/final_submit.json')
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      width: double.infinity,
                                      // color: Colors.red,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                              onTap: () => showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        title: Text(
                                                            'Claim No: ${widget.claimNo}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1),
                                                        content: Text(
                                                            'Are You Sure You Want To Approve This Claim?',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              child: Text(
                                                                'No',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              )),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            AlertDialog(
                                                                              backgroundColor: const Color.fromARGB(255, 43, 43, 43),
                                                                              title: Text('Please Justify Your Action', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16)),
                                                                              content: Container(
                                                                                width: double.infinity,
                                                                                height: SizeVariables.getWidth(context) * 0.5,
                                                                                // color: Colors.red,

                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          child: const Icon(
                                                                                            Icons.edit,
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                        ),
                                                                                        FittedBox(
                                                                                          fit: BoxFit.contain,
                                                                                          child: Text(
                                                                                            'Reason',
                                                                                            style: Theme.of(context).textTheme.bodyText2,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: SizeVariables.getHeight(context) * 0.0001,
                                                                                    ),
                                                                                    Form(
                                                                                      key: _key,
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.only(
                                                                                            // right: SizeVariables.getWidth(context) * 0.06,
                                                                                            // left: SizeVariables.getWidth(context) * 0.025,
                                                                                            top: SizeVariables.getWidth(context) * 0.04),
                                                                                        child: ContainerStyle(
                                                                                          // margin: const EdgeInsets.only(right: 25),
                                                                                          height: SizeVariables.getHeight(context) * 0.16,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(8),
                                                                                            child: TextFormField(
                                                                                              controller: actionJustification,
                                                                                              decoration: const InputDecoration(
                                                                                                border: InputBorder.none,
                                                                                                // border: OutlineInputBorder(
                                                                                                //   borderSide: BorderSide(color: Colors.grey),
                                                                                                // ),
                                                                                                // fillColor: Colors.grey,
                                                                                              ),
                                                                                              cursorColor: Colors.white,
                                                                                              style: Theme.of(context).textTheme.bodyText1,
                                                                                              maxLines: 5,
                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty || value == '') {
                                                                                                  return 'Please enter Reason';
                                                                                                } else {
                                                                                                  add = value;
                                                                                                  return null;
                                                                                                }
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              actions: [
                                                                                TextButton(
                                                                                    onPressed: () {
                                                                                      // print('Reason: ${editJustification.text}');
                                                                                      // print('Reason: ${_ie_basic_amt.text}');
                                                                                      // print('Reason: ${_ie_gst_amt.text}');
                                                                                      // print('Reason: ${_ie_total_amt.text}');
                                                                                      if (actionJustification.text == '') {
                                                                                        Flushbar(
                                                                                          message: 'Please Enter Justificationn',
                                                                                          icon: const Icon(
                                                                                            Icons.info_outline,
                                                                                            size: 28,
                                                                                            color: Colors.red,
                                                                                          ),
                                                                                          duration: const Duration(seconds: 5),
                                                                                          leftBarIndicatorColor: Colors.red,
                                                                                        ).show(context);
                                                                                      } else {
                                                                                        Map<String, dynamic> _data = {
                                                                                          'claim_no': widget.claimNo,
                                                                                          'status': 2,
                                                                                          'claim_amount': _ie_total_amt.text,
                                                                                          'gst_amount': _ie_gst_amt.text,
                                                                                          'basic_amount': _ie_basic_amt.text,
                                                                                          'remarks': actionJustification.text
                                                                                        };
                                                                                        print('DATA: $_data');
                                                                                        FocusManager.instance.primaryFocus?.unfocus();

                                                                                        Provider.of<ManagerIncidentalViewModel>(context, listen: false).postActionIncidental(int.parse(widget.claimNo), context, true, actionJustification.text);
                                                                                        setState(() {
                                                                                          actionJustification.clear();
                                                                                        });
                                                                                      }
                                                                                    },
                                                                                    child: Text('Confirm', style: Theme.of(context).textTheme.bodyText1))
                                                                              ],
                                                                            ));
                                                              },
                                                              // showDialog(
                                                              //     context: context,
                                                              //     builder: (context) => AlertDialog(
                                                              //           backgroundColor: Colors.grey,
                                                              //           title: Text('Enter Reason', style: Theme.of(context).textTheme.bodyText1),
                                                              //           content: Container(
                                                              //             height: SizeVariables.getHeight(context) * 0.2,
                                                              //             color: Colors.red,
                                                              //             child: Container(
                                                              //               width: SizeVariables.getWidth(context) * 0.76,
                                                              //               // width: 300,
                                                              //               // height: 200,
                                                              //               child: TextFormField(
                                                              //                 controller: actionJustification,
                                                              //                 readOnly: false,
                                                              //                 keyboardType: TextInputType.text,
                                                              //                 decoration: InputDecoration(
                                                              //                   enabledBorder: const UnderlineInputBorder(
                                                              //                     borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 167, 164, 164)),
                                                              //                   ),
                                                              //                   focusedBorder: const UnderlineInputBorder(
                                                              //                     borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 194, 191, 191)),
                                                              //                   ),
                                                              //                   // border: InputBorder.none,
                                                              //                   labelText: 'Reason',
                                                              //                   // hintText: "From",
                                                              //                   // hintStyle: Theme.of(context)
                                                              //                   //     .textTheme
                                                              //                   //     .bodyText2!
                                                              //                   //     .copyWith(color: Colors.grey),
                                                              //                   labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18, color: Colors.black),
                                                              //                 ),
                                                              //                 style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
                                                              //                 showCursor: false,
                                                              //                 cursorColor: Colors.black,
                                                              //               ),
                                                              //             ),
                                                              //           ),
                                                              //           actions: [
                                                              //             TextButton(onPressed: () => Provider.of<ManagerIncidentalViewModel>(context, listen: false).postActionIncidental(int.parse(widget.claimNo), context, true, actionJustification.text).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ManagerIncidentalExpenseScreen()))), child: Text('Confirm', style: Theme.of(context).textTheme.bodyText1))
                                                              //           ],
                                                              //         )),
                                                              child: Text(
                                                                'Yes',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ))
                                                        ],
                                                      )),
                                              child: const Icon(
                                                  Icons
                                                      .check_circle_outline_sharp,
                                                  color: Colors.green,
                                                  size: 35)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Container(
                                        width: double.infinity,
                                        // color: Colors.yellow,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () => showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        title: Text(
                                                            'Claim No: ${widget.claimNo}',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1),
                                                        content: Text(
                                                            'Are You Sure You Want To Reject This Claim?',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () =>
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(),
                                                              child: Text(
                                                                'No',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              )),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            AlertDialog(
                                                                              backgroundColor: Color.fromARGB(255, 43, 43, 43),
                                                                              title: Text('Please Justify Your Action', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16)),
                                                                              content: Container(
                                                                                width: double.infinity,
                                                                                height: SizeVariables.getWidth(context) * 0.5,
                                                                                // color: Colors.red,

                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        Container(
                                                                                          child: const Icon(
                                                                                            Icons.edit,
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                        ),
                                                                                        FittedBox(
                                                                                          fit: BoxFit.contain,
                                                                                          child: Text(
                                                                                            'Reason',
                                                                                            style: Theme.of(context).textTheme.bodyText2,
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: SizeVariables.getHeight(context) * 0.0001,
                                                                                    ),
                                                                                    Form(
                                                                                      key: _key,
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.only(
                                                                                            // right: SizeVariables.getWidth(context) * 0.06,
                                                                                            // left: SizeVariables.getWidth(context) * 0.025,
                                                                                            top: SizeVariables.getWidth(context) * 0.04),
                                                                                        child: ContainerStyle(
                                                                                          // margin: const EdgeInsets.only(right: 25),
                                                                                          height: SizeVariables.getHeight(context) * 0.16,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(8),
                                                                                            child: TextFormField(
                                                                                              controller: actionJustification,
                                                                                              decoration: const InputDecoration(
                                                                                                border: InputBorder.none,
                                                                                                // border: OutlineInputBorder(
                                                                                                //   borderSide: BorderSide(color: Colors.grey),
                                                                                                // ),
                                                                                                // fillColor: Colors.grey,
                                                                                              ),
                                                                                              cursorColor: Colors.white,
                                                                                              style: Theme.of(context).textTheme.bodyText1,
                                                                                              maxLines: 5,
                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty || value == '') {
                                                                                                  return 'Please enter Reason';
                                                                                                } else {
                                                                                                  add = value;
                                                                                                  return null;
                                                                                                }
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              actions: [
                                                                                TextButton(
                                                                                    onPressed: () {
                                                                                      // print('Reason: ${editJustification.text}');
                                                                                      // print('Reason: ${_ie_basic_amt.text}');
                                                                                      // print('Reason: ${_ie_gst_amt.text}');
                                                                                      // print('Reason: ${_ie_total_amt.text}');

                                                                                      if (actionJustification.text == '') {
                                                                                        Flushbar(
                                                                                          message: 'Please Enter Justificationn',
                                                                                          icon: const Icon(
                                                                                            Icons.info_outline,
                                                                                            size: 28,
                                                                                            color: Colors.red,
                                                                                          ),
                                                                                          duration: const Duration(seconds: 5),
                                                                                          leftBarIndicatorColor: Colors.red,
                                                                                        ).show(context);
                                                                                      } else {
                                                                                        // Map<String, dynamic> _data = {
                                                                                        //   'claim_no': widget.claimNo,
                                                                                        //   'status': 2,
                                                                                        //   'claim_amount': _ie_total_amt.text,
                                                                                        //   'gst_amount': _ie_gst_amt.text,
                                                                                        //   'basic_amount': _ie_basic_amt.text,
                                                                                        //   'remarks': actionJustification.text
                                                                                        // };
                                                                                        // print('DATA: $_data');
                                                                                        FocusManager.instance.primaryFocus?.unfocus();

                                                                                        Provider.of<ManagerIncidentalViewModel>(context, listen: false).postActionIncidental(int.parse(widget.claimNo), context, false, actionJustification.text);
                                                                                        setState(() {
                                                                                          actionJustification.clear();
                                                                                        });
                                                                                      }

                                                                                      // Navigator.of(context).pop();

                                                                                      // Navigator.of(context).pop();
                                                                                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ManagerIncidentalExpenseScreen()));

                                                                                      // Navigator.of(context).pop();
                                                                                      // Navigator.of(context).pop();
                                                                                      // Navigator.of(context).pop();
                                                                                    },
                                                                                    child: Text('Confirm', style: Theme.of(context).textTheme.bodyText1))
                                                                              ],
                                                                            ));
                                                              },
                                                              // showDialog(
                                                              //     context: context,
                                                              //     builder: (context) => AlertDialog(
                                                              //           backgroundColor: Colors.grey,
                                                              //           title: Text('Enter Reason', style: Theme.of(context).textTheme.bodyText1),
                                                              //           content: Container(
                                                              //             height: SizeVariables.getHeight(context) * 0.2,
                                                              //             color: Colors.red,
                                                              //             child: Container(
                                                              //               width: SizeVariables.getWidth(context) * 0.76,
                                                              //               // width: 300,
                                                              //               // height: 200,
                                                              //               child: TextFormField(
                                                              //                 controller: actionJustification,
                                                              //                 readOnly: false,
                                                              //                 keyboardType: TextInputType.text,
                                                              //                 decoration: InputDecoration(
                                                              //                   enabledBorder: const UnderlineInputBorder(
                                                              //                     borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 167, 164, 164)),
                                                              //                   ),
                                                              //                   focusedBorder: const UnderlineInputBorder(
                                                              //                     borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 194, 191, 191)),
                                                              //                   ),
                                                              //                   // border: InputBorder.none,
                                                              //                   labelText: 'Reason',
                                                              //                   // hintText: "From",
                                                              //                   // hintStyle: Theme.of(context)
                                                              //                   //     .textTheme
                                                              //                   //     .bodyText2!
                                                              //                   //     .copyWith(color: Colors.grey),
                                                              //                   labelStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18, color: Colors.black),
                                                              //                 ),
                                                              //                 style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
                                                              //                 showCursor: false,
                                                              //                 cursorColor: Colors.black,
                                                              //               ),
                                                              //             ),
                                                              //           ),
                                                              //           actions: [
                                                              //             TextButton(onPressed: () => Provider.of<ManagerIncidentalViewModel>(context, listen: false).postActionIncidental(int.parse(widget.claimNo), context, false, actionJustification.text).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ManagerIncidentalExpenseScreen()))), child: Text('Confirm', style: Theme.of(context).textTheme.bodyText1))
                                                              //           ],
                                                              //         )),
                                                              child: Text(
                                                                'Yes',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ))
                                                        ],
                                                      )),
                                              child: const Text('X',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 32)),
                                            ),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      : widget.isEditable == true
                          ? Container()
                          : Flexible(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  Map request_filename = {
                                    "file_name": "attachment",
                                  };
                                  Map<String, String> _data = {
                                    'claim_no': widget.claimNo,
                                    // "gst_no": 'GSTIN${_ie_gst_no.text}',
                                    // "gst_amount": _ie_gst_amt.text,
                                    // "basic_amount": _ie_basic_amt.text,
                                    // "claim_amount": _ie_total_amt.text,
                                    // "purpose": _ie_purpose.text,
                                    // "service_provider":
                                    //     _ie_name_of_serviceprovider.text,
                                    // "bill_no": _ie_bill_no.text,
                                  };

                                  if (_ie_file == null) {
                                    _claimzFormData.postFinalIncidentalSubmit(
                                        context,
                                        // request_filename,
                                        // widget.attachment,
                                        _data);
                                  } else {
                                    _claimzFormData.postFinalIncidentalSubmit(
                                        context,
                                        // request_filename,
                                        // _ie_file!,
                                        _data);
                                    print(
                                        'Incidental Claimz Request Data: $_data');
                                  }
                                },
                                child: Container(
                                    height:
                                        SizeVariables.getHeight(context) * 0.05,
                                    width:
                                        SizeVariables.getHeight(context) * 0.05,
                                    // color: Colors.green,
                                    child: Lottie.asset(
                                        'assets/json/final_submit.json')),
                              ),
                            )
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      height: SizeVariables.getHeight(context) * 0.75,
                      // color: Colors.red,
                      color: const Color.fromARGB(239, 228, 226, 226),
                      // padding:
                      //     EdgeInsets.all(SizeVariables.getWidth(context) * 0.02),
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.02,
                          top: SizeVariables.getHeight(context) * 0.01,
                          right: SizeVariables.getWidth(context) * 0.02,
                          bottom: SizeVariables.getHeight(context) * 0.008),
                      child: Container(
                        width: double.infinity,
                        // height: SizeVariables.getHeight(context) * 0.1,
                        decoration: BoxDecoration(
                            // color: Colors.green,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.04),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Icon(
                                            Icons.account_circle_outlined,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.02,
                                      ),
                                      Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.76,
                                        // width: 300,
                                        // height: 200,
                                        child: TextFormField(
                                          controller:
                                              _ie_name_of_serviceprovider,
                                          readOnly: widget.isEditable == true
                                              ? true
                                              : false,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Color.fromARGB(
                                                      255, 167, 164, 164)),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Color.fromARGB(
                                                      255, 194, 191, 191)),
                                            ),
                                            // border: InputBorder.none,
                                            labelText: 'Name of provider',
                                            // hintText: "From",
                                            // hintStyle: Theme.of(context)
                                            //     .textTheme
                                            //     .bodyText2!
                                            //     .copyWith(color: Colors.grey),
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.black),
                                          showCursor: false,
                                          cursorColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height:
                                    SizeVariables.getHeight(context) * 0.03),
                            Container(
                              // color: Colors.red,
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.04,
                                  right:
                                      SizeVariables.getWidth(context) * 0.12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // color: Colors.amber,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Icon(Icons.receipt,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.02,
                                        ),
                                        Container(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.3,
                                          // width: 300,
                                          // height: 200,
                                          child: TextFormField(
                                            controller: _ie_bill_no,
                                            keyboardType: TextInputType.text,
                                            readOnly: widget.isEditable == true
                                                ? true
                                                : false,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color.fromARGB(
                                                        255, 167, 164, 164)),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color.fromARGB(
                                                        255, 194, 191, 191)),
                                              ),
                                              // border: InputBorder.none,
                                              labelText: 'Bill No.',
                                              // hintText: "From",
                                              // hintStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyText2!
                                              //     .copyWith(color: Colors.grey),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(color: Colors.black),
                                            showCursor: false,
                                            cursorColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Icon(Icons.receipt_long,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.02,
                                      ),
                                      Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.3,
                                        // width: 300,
                                        // height: 200,
                                        child: TextFormField(
                                          controller: _ie_gst_no,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(15)
                                          ],
                                          keyboardType: TextInputType.text,
                                          readOnly: widget.isEditable == true
                                              ? true
                                              : false,
                                          decoration: InputDecoration(
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Color.fromARGB(
                                                      255, 167, 164, 164)),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Color.fromARGB(
                                                      255, 194, 191, 191)),
                                            ),
                                            // border: InputBorder.none,
                                            labelText: 'GST No.',
                                            // hintText: "To",
                                            // hintStyle: Theme.of(context)
                                            //     .textTheme
                                            //     .bodyText2!
                                            //     .copyWith(color: Colors.grey),
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.black),
                                          showCursor: false,
                                          cursorColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                    SizeVariables.getHeight(context) * 0.03),
                            Container(
                              // color: Colors.red,
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.06,
                                  right:
                                      SizeVariables.getWidth(context) * 0.12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // color: Colors.amber,
                                    child: Row(
                                      children: [
                                        // Container(
                                        //   child: Icon(Icons.calendar_month_outlined,
                                        //       color: Colors.white),
                                        // ),
                                        Text('₹',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 25,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        SizedBox(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.02,
                                        ),
                                        Container(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.3,
                                          // width: 300,
                                          // height: 200,
                                          child: TextFormField(
                                            controller: _ie_basic_amt,
                                            readOnly: widget.isEditable == true
                                                ? true
                                                : false,
                                            keyboardType: TextInputType.number,
                                            // readOnly: widget.isPending == true
                                            //     ? false
                                            //     : true,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color.fromARGB(
                                                        255, 167, 164, 164)),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: Color.fromARGB(
                                                        255, 194, 191, 191)),
                                              ),
                                              // border: InputBorder.none,
                                              labelText: 'Basic Amount',
                                              // hintText: "From",
                                              // hintStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyText2!
                                              //     .copyWith(color: Colors.grey),
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(color: Colors.black),
                                            // showCursor:
                                            //     widget.isPending == true
                                            //         ? true
                                            //         : false,
                                            cursorColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text('₹',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold)),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.02,
                                      ),
                                      Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.3,
                                        // width: 300,
                                        // height: 200,
                                        child: TextFormField(
                                          controller: _ie_gst_amt,
                                          readOnly: widget.isEditable == true
                                              ? true
                                              : false,
                                          keyboardType: TextInputType.number,
                                          // readOnly: widget.isPending == true
                                          //     ? false
                                          //     : true,
                                          decoration: InputDecoration(
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Color.fromARGB(
                                                      255, 167, 164, 164)),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Color.fromARGB(
                                                      255, 194, 191, 191)),
                                            ),
                                            // border: InputBorder.none,
                                            labelText: 'GST Amount',
                                            // hintText: "To",
                                            // hintStyle: Theme.of(context)
                                            //     .textTheme
                                            //     .bodyText2!
                                            //     .copyWith(color: Colors.grey),
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.black),
                                          // showCursor: widget.isPending == true
                                          //     ? true
                                          //     : false,
                                          cursorColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                    SizeVariables.getHeight(context) * 0.02),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.04),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Icon(Icons.edit,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.02,
                                      ),
                                      Container(
                                        width: SizeVariables.getWidth(context) *
                                            0.76,
                                        // width: 300,
                                        // height: 200,
                                        child: TextFormField(
                                          controller: _ie_purpose,
                                          readOnly: widget.isEditable == true
                                              ? true
                                              : false,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            enabledBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Color.fromARGB(
                                                      255, 167, 164, 164)),
                                            ),
                                            focusedBorder:
                                                const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 2,
                                                  color: Color.fromARGB(
                                                      255, 194, 191, 191)),
                                            ),
                                            // border: InputBorder.none,
                                            labelText: 'Purpose',
                                            // hintText: "From",
                                            // hintStyle: Theme.of(context)
                                            //     .textTheme
                                            //     .bodyText2!
                                            //     .copyWith(color: Colors.grey),
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.black),
                                          showCursor: false,
                                          cursorColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                // height: SizeVariables.getHeight(context) * 0.2,
                                width: double.infinity,
                                // color: Colors.pink,
                                // padding: EdgeInsets.all(SizeVariables.getWidth(context) * 0.02),
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        SizeVariables.getWidth(context) * 0.04,
                                    vertical: SizeVariables.getHeight(context) *
                                        0.02),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        // color: Colors.pink,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // color: Colors.yellow,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                            Icons.visibility,
                                                            color:
                                                                Colors.black),
                                                        SizedBox(
                                                            width: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.02),
                                                        Text(
                                                            'Tap To View Invoice',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18))
                                                      ],
                                                    ),
                                                  ),
                                                  widget.isFromUser == false &&
                                                          role == 1
                                                      ? TextButton(
                                                          onPressed: () =>
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                            backgroundColor: Color.fromARGB(
                                                                                255,
                                                                                43,
                                                                                43,
                                                                                43),
                                                                            title:
                                                                                Text('Please Justify Your Edit', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16)),
                                                                            content:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              height: SizeVariables.getWidth(context) * 0.5,
                                                                              // color: Colors.red,

                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Container(
                                                                                        child: const Icon(
                                                                                          Icons.edit,
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                      FittedBox(
                                                                                        fit: BoxFit.contain,
                                                                                        child: Text(
                                                                                          'Reason',
                                                                                          style: Theme.of(context).textTheme.bodyText2,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: SizeVariables.getHeight(context) * 0.0001,
                                                                                  ),
                                                                                  Form(
                                                                                    key: _key,
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.only(
                                                                                          // right: SizeVariables.getWidth(context) * 0.06,
                                                                                          // left: SizeVariables.getWidth(context) * 0.025,
                                                                                          top: SizeVariables.getWidth(context) * 0.04),
                                                                                      child: ContainerStyle(
                                                                                        // margin: const EdgeInsets.only(right: 25),
                                                                                        height: SizeVariables.getHeight(context) * 0.16,
                                                                                        child: Padding(
                                                                                          padding: const EdgeInsets.all(8),
                                                                                          child: TextFormField(
                                                                                            controller: _reason,
                                                                                            decoration: const InputDecoration(
                                                                                              border: InputBorder.none,
                                                                                              // border: OutlineInputBorder(
                                                                                              //   borderSide: BorderSide(color: Colors.grey),
                                                                                              // ),
                                                                                              // fillColor: Colors.grey,
                                                                                            ),
                                                                                            cursorColor: Colors.white,
                                                                                            style: Theme.of(context).textTheme.bodyText1,
                                                                                            maxLines: 5,
                                                                                            validator: (value) {
                                                                                              if (value!.isEmpty || value == '') {
                                                                                                return 'Please enter Reason';
                                                                                              } else {
                                                                                                add = value;
                                                                                                return null;
                                                                                              }
                                                                                            },
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            actions: [
                                                                              TextButton(
                                                                                  onPressed: () {
                                                                                    // print('Reason: ${editJustification.text}');
                                                                                    // print('Reason: ${_ie_basic_amt.text}');
                                                                                    // print('Reason: ${_ie_gst_amt.text}');
                                                                                    // print('Reason: ${_ie_total_amt.text}');
                                                                                    // if (_key.currentState!.validate()) {

                                                                                    print('EDIT JUSTIFICATION: ${_reason.text}');

                                                                                    if (_reason.text == '') {
                                                                                      Flushbar(
                                                                                        message: 'Please Enter Justificationn',
                                                                                        icon: const Icon(
                                                                                          Icons.info_outline,
                                                                                          size: 28,
                                                                                          color: Colors.red,
                                                                                        ),
                                                                                        duration: const Duration(seconds: 5),
                                                                                        leftBarIndicatorColor: Colors.red,
                                                                                      ).show(context);
                                                                                    } else {
                                                                                      Map<String, dynamic> data = {
                                                                                        'claim_no': widget.claimNo,
                                                                                        'status': 2,
                                                                                        'claim_amount': _ie_total_amt.text,
                                                                                        'gst_amount': _ie_gst_amt.text,
                                                                                        'basic_amount': _ie_basic_amt.text,
                                                                                        'remarks': _reason.text
                                                                                      };
                                                                                      print('DATA: $data');
                                                                                      FocusManager.instance.primaryFocus?.unfocus();

                                                                                      // Navigator.of(context).pop();

                                                                                      Provider.of<ManagerIncidentalViewModel>(context, listen: false).editIncidentalExpense(context, data, widget.fromDate, widget.toDate);
                                                                                      setState(() {
                                                                                        _reason.clear();
                                                                                      });
                                                                                    }

                                                                                    // .then((value) {

                                                                                    // });
                                                                                    // }
                                                                                  },
                                                                                  child: Text('Confirm', style: Theme.of(context).textTheme.bodyText1))
                                                                            ],
                                                                          )),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: SizeVariables
                                                                          .getWidth(
                                                                              context) *
                                                                      0.01),
                                                              const Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 18),
                                                              Text('Update',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                            ],
                                                          ))
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.01),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () => showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                          content: Container(
                                                            height: SizeVariables
                                                                    .getHeight(
                                                                        context) *
                                                                0.4,
                                                            width:
                                                                double.infinity,
                                                            child:
                                                                InteractiveViewer(
                                                              // clipBehavior:
                                                              //     Clip.none,
                                                              // minScale: 1,
                                                              // maxScale: 4,
                                                              // transformationController:
                                                              //     controller,
                                                              // // onInteractionStart: (details) {
                                                              // //   if (details.pointerCount < 2) return;
                                                              // //   if (entry == null) {
                                                              // //     showOverlay(context);
                                                              // //   }
                                                              // // },
                                                              // onInteractionEnd:
                                                              //     (details) {
                                                              //   resetAnimation();
                                                              // },
                                                              child: AspectRatio(
                                                                  aspectRatio: 1,
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(20),
                                                                      child: _ie_file == null
                                                                          ? Image.network(
                                                                              widget.attachment,
                                                                              fit: BoxFit.fill,
                                                                            )
                                                                          : Image.file(File(_ie_file!.path), fit: BoxFit.cover))),
                                                            ),
                                                          ),
                                                        )),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  child: Container(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.4,
                                                    // color: Colors.yellow,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 2)),
                                                    child: _ie_file == null
                                                        ?
                                                        // Center(
                                                        //     child: Text(
                                                        //         'Please Upload Invoice',
                                                        //         style: Theme.of(
                                                        //                 context)
                                                        //             .textTheme
                                                        //             .bodyText1!
                                                        //             .copyWith(
                                                        //                 color:
                                                        //                     Colors.black)),
                                                        //   )
                                                        Image.network(
                                                            widget.attachment,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Stack(
                                                            children: [
                                                              Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        image: FileImage(
                                                                            File(_ie_file!.path)))),
                                                                // color: Colors.red,
                                                                // child: Image.file(
                                                                //     _ie_file.toString()
                                                                //         as File,
                                                                //     fit: BoxFit
                                                                //         .cover),
                                                              ),
                                                              const Positioned(
                                                                top: 2,
                                                                right: 5,
                                                                child: Icon(
                                                                    Icons
                                                                        .expand_sharp,
                                                                    color: Colors
                                                                        .white),
                                                              )
                                                            ],
                                                          ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    widget.isFromUser == false && role == 1 ||
                                            widget.isEditable == true
                                        ? Container()
                                        : Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Container(
                                              height: double.infinity,
                                              // color: Colors.orange,
                                              padding: EdgeInsets.only(
                                                  left: SizeVariables.getWidth(
                                                          context) *
                                                      0.01,
                                                  top: SizeVariables.getHeight(
                                                          context) *
                                                      0.02),
                                              child: Container(
                                                // color: Colors.blue,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      flex: 2,
                                                      fit: FlexFit.tight,
                                                      child: Container(
                                                        // color: Colors.yellow,
                                                        width: double.infinity,
                                                        padding: EdgeInsets.only(
                                                            top: SizeVariables
                                                                    .getHeight(
                                                                        context) *
                                                                0.05),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            InkWell(
                                                                onTap:
                                                                    () async {
                                                                  var imagePath =
                                                                      await EdgeDetection
                                                                          .detectEdge;

                                                                  setState(() {
                                                                    _ie_file = XFile(
                                                                        File(imagePath.toString())
                                                                            .path);
                                                                  });
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .camera_alt,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 35,
                                                                )),
                                                            InkWell(
                                                                onTap:
                                                                    () async {
                                                                  var imagePath =
                                                                      await EdgeDetection
                                                                          .detectEdge;

                                                                  setState(() {
                                                                    _ie_file = XFile(
                                                                        File(imagePath.toString())
                                                                            .path);
                                                                  });
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .upload_file_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 35,
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        width: double.infinity,
                                                        // color: Colors.red,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              // padding: EdgeInsets.only(
                                                              //     right: SizeVariables
                                                              //             .getWidth(
                                                              //                 context) *
                                                              //         0.05),
                                                              child:
                                                                  AnimatedButton(
                                                                height: 45,
                                                                width: 100,
                                                                text:
                                                                    'Save as Draft',
                                                                isReverse: true,
                                                                selectedTextColor:
                                                                    Colors
                                                                        .black,
                                                                transitionType:
                                                                    TransitionType
                                                                        .LEFT_TO_RIGHT,
                                                                textStyle:
                                                                    TextStyle(
                                                                        fontSize:
                                                                            13),
                                                                backgroundColor:
                                                                    Colors
                                                                        .black,
                                                                borderColor:
                                                                    Colors
                                                                        .white,
                                                                borderRadius: 8,
                                                                borderWidth: 2,
                                                                onPress: () {
                                                                  Map request_filename =
                                                                      {
                                                                    "file_name":
                                                                        "attachment",
                                                                  };
                                                                  Map<String,
                                                                          String>
                                                                      request_data =
                                                                      {
                                                                    "gst_no":
                                                                        'GSTIN${_ie_gst_no.text}',
                                                                    "gst_amount":
                                                                        _ie_gst_amt
                                                                            .text,
                                                                    "basic_amount":
                                                                        _ie_basic_amt
                                                                            .text,
                                                                    "claim_amount":
                                                                        _ie_total_amt
                                                                            .text,
                                                                    "purpose":
                                                                        _ie_purpose
                                                                            .text,
                                                                    "service_provider":
                                                                        _ie_name_of_serviceprovider
                                                                            .text,
                                                                    "bill_no":
                                                                        _ie_bill_no
                                                                            .text,
                                                                  };
                                                                  if (_ie_file ==
                                                                      null) {
                                                                    _claimzFormData.postIncidentalClaimz(
                                                                        context,
                                                                        request_filename,
                                                                        widget.attachment
                                                                            as XFile,
                                                                        request_data);
                                                                  } else {
                                                                    _claimzFormData.postIncidentalClaimz(
                                                                        context,
                                                                        request_filename,
                                                                        _ie_file!,
                                                                        request_data);
                                                                    print(
                                                                        'Incidental Claimz Request Data: $request_data');
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: const Color.fromARGB(239, 228, 226, 226),
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.02,
                          top: SizeVariables.getHeight(context) * 0.01,
                          right: SizeVariables.getWidth(context) * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Approval Status',
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                          ),
                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.01,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.02,
                              right: SizeVariables.getWidth(context) * 0.02,
                              top: SizeVariables.getHeight(context) * 0.015,
                              bottom: SizeVariables.getHeight(context) * 0.015,
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.logs['approval_log'].length,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    reMarksPopup(context,
                                        widget.logs['approval_log'][index]);
                                  },
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius:
                                                      SizeVariables.getWidth(
                                                              context) *
                                                          0.07,
                                                  backgroundColor: Colors.green,
                                                  backgroundImage:
                                                      const AssetImage(
                                                    'assets/img/profilePic.jpg',
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.012,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        widget.logs[
                                                                'approval_log']
                                                            [index]['emp_name'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText2!
                                                            .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 18,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                            ),
                                                      ),
                                                    ),
                                                    FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        widget.logs[
                                                                'approval_log']
                                                            [index]['status'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 14,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.currency_rupee_outlined,
                                                  color: Colors.black,
                                                  size: 18,
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    widget.logs['approval_log']
                                                        [index]['claim_amount'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 181, 137, 4),
                                                          fontSize: 20,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Remarks: ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                      ),
                                                ),
                                                Container(
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.35,
                                                  child: Text(
                                                    widget.logs['approval_log']
                                                                        [index][
                                                                    'approve_remarks'] ==
                                                                null ||
                                                            widget.logs['approval_log']
                                                                        [index][
                                                                    'approve_remarks'] ==
                                                                ''
                                                        ? 'No Remarks'
                                                        : widget.logs[
                                                                    'approval_log']
                                                                [index]
                                                            ['approve_remarks'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          color: Colors.black38,
                                                          fontSize: 15,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                widget.logs['approval_log']
                                                    [index]['updated_at'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.01,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.001,
                                          color: Color.fromARGB(
                                              255, 172, 171, 171),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.01,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future<dynamic> reMarksPopup(BuildContext context, dynamic popUp) {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Remarks',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.black,
                      fontSize: 20,
                    ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                ),
              ),
            ],
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              popUp['approve_remarks'],
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
            ),
          ),
        );
      },
    );
  }

  void _errorVal(BuildContext context) {
    Flushbar(
      message: "please provide image",
      icon: const Icon(
        Icons.warning_amber_outlined,
        size: 28.0,
        color: Colors.red,
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.red,
    )..show(context);
  }

  Future<bool> _backPressed(GlobalKey<NavigatorState> _yourKey) async {
    //Checks if current Navigator still has screens on the stack.
    if (_yourKey.currentState!.canPop()) {
      // 'maybePop' method handles the decision of 'pop' to another WillPopScope if they exist.
      //If no other WillPopScope exists, it returns true
      Navigator.pushNamed(context, RouteNames.incidentalClaimsScreen);
      _yourKey.currentState!.maybePop();
      return Future<bool>.value(false);
    }
//if nothing remains in the stack, it simply pops
    return Future<bool>.value(true);
  }

  void resetAnimation() {
    animation = Matrix4Tween(begin: controller.value, end: Matrix4.identity())
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.bounceIn));

    animationController.forward(from: 0);
  }

  void showOverlay(BuildContext context) {
    final overlay = Overlay.of(context)!;
    overlay.insert(entry!);
  }
}
