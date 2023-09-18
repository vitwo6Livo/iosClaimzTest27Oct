import 'dart:io';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/claimzFormIndividualViewModel.dart';
import 'package:claimz/viewModel/managerIncidentalViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:expandable/expandable.dart';
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

class Incidentalview extends StatefulWidget {
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

  IncidentalviewState createState() => IncidentalviewState();

  Incidentalview(
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
      this.attachment);
}

class IncidentalviewState extends State<Incidentalview>
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

    print('Image: ${widget.attachment}');

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
                              width: SizeVariables.getWidth(context) * 0.05),
                          Container(
                            padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.01,
                            ),
                            child: Text(
                              'Incidental Expense ',
                              style: Theme.of(context).textTheme.bodyText1,
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
                              width: SizeVariables.getWidth(context) * 0.05),
                          Container(
                            padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.01,
                            ),
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
                                          readOnly: true,
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
                                            readOnly: true,
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
                                          readOnly: true,
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
                                            readOnly: true,
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
                                          readOnly: true,
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
                                          readOnly: true,
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
                    // SizedBox(height: SizeVariables.getHeight(context) * 0.02),

                    widget.isFromUser == false
                        ? Container()
                        : Container(
                            width: double.infinity,
                            // height: SizeVariables.getHeight(context) * 0.2,
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
                                  // textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: Colors.black, fontSize: 20),
                                ),
                                // SizedBox(
                                //     height: SizeVariables.getHeight(context) *
                                //         0.02),
                                Container(
                                  // height:
                                  //     SizeVariables.getHeight(context) * 0.5,
                                  // color: Colors.red,
                                  child: Scrollbar(
                                    child: Scrollbar(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        // itemCount: approvalLog!.length,
                                        itemCount:
                                            widget.logs['approval_log'].length,

                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: 250,
                                            child: TimelineTile(
                                              endChild: Container(
                                                padding: EdgeInsets.only(
                                                  top: SizeVariables.getHeight(
                                                          context) *
                                                      0.03,
                                                ),
                                                // color: Color.fromARGB(239, 228, 226, 226),
                                                // height: 50,
                                                child: Accordion(
                                                  disableScrolling: true,
                                                  // maxOpenSections: 1,
                                                  headerBackgroundColorOpened:
                                                      Color.fromARGB(
                                                          239, 228, 226, 226),
                                                  scaleWhenAnimating: true,
                                                  openAndCloseAnimation: true,
                                                  headerPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 7,
                                                          horizontal: 15),
                                                  sectionOpeningHapticFeedback:
                                                      SectionHapticFeedback
                                                          .heavy,
                                                  sectionClosingHapticFeedback:
                                                      SectionHapticFeedback
                                                          .light,
                                                  children: [
                                                    AccordionSection(
                                                      contentBackgroundColor:
                                                          Color.fromARGB(239,
                                                              228, 226, 226),
                                                      // isO?pen: true,

                                                      headerBackgroundColor:
                                                          Color.fromARGB(239,
                                                              228, 226, 226),
                                                      headerBackgroundColorOpened:
                                                          Color.fromARGB(239,
                                                              228, 226, 226),
                                                      contentBorderColor:
                                                          Color.fromARGB(239,
                                                              228, 226, 226),
                                                      header: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child: Icon(
                                                                  Icons
                                                                      .currency_rupee_outlined,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 18,
                                                                ),
                                                              ),
                                                              FittedBox(
                                                                fit: BoxFit
                                                                    .contain,
                                                                child: Text(
                                                                  widget.logs['approval_log']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'claim_amount'],
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText2!
                                                                      .copyWith(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              20),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            width: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.3,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              color: Color(
                                                                  0xfffe2f6ed),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 5.0,
                                                                      right:
                                                                          5.0,
                                                                      top: 2.5,
                                                                      bottom:
                                                                          2.5),
                                                              child: Center(
                                                                child:
                                                                    FittedBox(
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  child: Text(
                                                                    widget.logs['approval_log'][index]['status'] ==
                                                                            0
                                                                        ? 'Pending For Approval'
                                                                        : widget.logs['approval_log'][index]['status'] ==
                                                                                1
                                                                            ? 'Pending For Approval'
                                                                            : widget.logs['approval_log'][index]['status'] == 4
                                                                                ? 'Pending For Payment'
                                                                                : 'Rejected',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            color:
                                                                                Color(0xfff26af48),
                                                                            fontSize: 12),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      content: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: Colors.grey,
                                                            width: 3,
                                                          ),
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: SizeVariables
                                                                          .getWidth(
                                                                              context) *
                                                                      0.54,
                                                                  // color: Colors.red,
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    child: Text(
                                                                      widget.logs['approval_log'][index]['approve_remarks'] == null ||
                                                                              widget.logs['approval_log'][index]['approve_remarks'] ==
                                                                                  ''
                                                                          ? 'No Remarks'
                                                                          : widget.logs['approval_log'][index]
                                                                              [
                                                                              'approve_remarks'],
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                              color: Colors.black,
                                                                              fontSize: 15),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .contain,
                                                                child: Text(
                                                                  widget.logs['approval_log']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'emp_name'],
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText2!
                                                                      .copyWith(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              15,
                                                                          fontStyle:
                                                                              FontStyle.italic),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 2,
                                                              width: SizeVariables
                                                                      .getWidth(
                                                                          context) *
                                                                  0.6,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(
                                                              height: SizeVariables
                                                                      .getHeight(
                                                                          context) *
                                                                  0.007,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Container(
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    child: Text(
                                                                      widget.logs['approval_log']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'updated_at'],
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // Container(
                                                                //   child: FittedBox(
                                                                //     fit: BoxFit.contain,
                                                                //     child: Text(
                                                                //       '12:02:03',
                                                                //       style: Theme.of(context)
                                                                //           .textTheme
                                                                //           .bodyText1!
                                                                //           .copyWith(
                                                                //               color: Colors.black),
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      contentHorizontalPadding:
                                                          20,
                                                      contentBorderWidth: 1,
                                                      // onOpenSection: () => print('onOpenSection ...'),
                                                      // onCloseSection: () => print('onCloseSection ...'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              isLast: true,
                                              isFirst: true,
                                              indicatorStyle: IndicatorStyle(
                                                height: 100,
                                                width: 25,
                                                color: Colors.green,
                                                iconStyle: IconStyle(
                                                  iconData: Icons.download_done,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
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

  void _errorVal(BuildContext context) {
    Flushbar(
      message: "please provide image",
      icon: Icon(
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
