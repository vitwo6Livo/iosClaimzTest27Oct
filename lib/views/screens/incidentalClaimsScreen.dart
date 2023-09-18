import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/claimzFormIndividualViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncidentalClaimsScreen extends StatefulWidget {
  // const ProfileInfoScreen({Key? key}) : super(key: key);

  @override
  State<IncidentalClaimsScreen> createState() => IncidentalClaimsScreenState();
}

class IncidentalClaimsScreenState extends State<IncidentalClaimsScreen>
    with SingleTickerProviderStateMixin {
  dynamic _ie_file;
  final ImagePicker _picker = ImagePicker();
  TextEditingController _ie_name_of_serviceprovider = TextEditingController();
  TextEditingController _ie_basic_amt = TextEditingController();
  TextEditingController _ie_gst_amt = TextEditingController();
  TextEditingController _ie_total_amt = TextEditingController();
  TextEditingController _ie_gst_no = TextEditingController();
  TextEditingController _ie_bill_no = TextEditingController();
  TextEditingController _ie_purpose = TextEditingController();
  ClaimzFormIndividualViewModel _claimzFormData =
      ClaimzFormIndividualViewModel();
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  OverlayEntry? entry;

  @override
  void initState() {
    // TODO: implement initState

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

  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        compressFormat: ImageCompressFormat.jpg);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   _ie_basic_amt.addListener(() {
  //     setState(() {
  //       if (_ie_basic_amt.text == '') {
  //         setState(() {
  //           _ie_total_amt.text = '0';
  //         });
  //       } else {
  //         _ie_total_amt.text =
  //             (int.parse(_ie_basic_amt.text) + int.parse(_ie_gst_amt.text))
  //                 .toString();
  //       }
  //     });
  //   });

  //   _ie_gst_amt.addListener(() {
  //     setState(() {
  //       _ie_total_amt.text =
  //           (int.parse(_ie_basic_amt.text) + int.parse(_ie_gst_amt.text))
  //               .toString();
  //     });
  //   });

  //   _ie_name_of_serviceprovider.text = widget.serviceProvider;
  //   _ie_basic_amt.text = widget.basicAmount.toString();
  //   _ie_gst_amt.text = widget.gstAmount.toString();
  //   _ie_total_amt.text = widget.totalAmount.toString();
  //   _ie_gst_no.text = widget.gstNo.toString();
  //   _ie_bill_no.text = widget.billNo.toString();
  //   _ie_purpose.text = widget.purpose;
  //   super.initState();

  //   controller = TransformationController();
  //   animationController = AnimationController(
  //       vsync: this, duration: const Duration(milliseconds: 200))
  //     ..addListener(() => controller.value = animation!.value);
  // }

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
    final themeProvider = Provider.of<ThemeProvider>(context);
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
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Container(
                padding: EdgeInsets.only(
                  top: SizeVariables.getHeight(context) * 0.008,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.of(context).pushNamed(RouteNames.navbar);
                        Navigator.of(context).pop();

                        // Navigator.pushReplacementNamed(
                        //     context, RouteNames.incidentalClaimsScreen);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/back button.svg",
                      ),
                    ),
                    SizedBox(width: SizeVariables.getWidth(context) * 0.02),
                    Container(
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
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Container(
                width: double.infinity,
                // color: Colors.red,
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
                              readOnly: true,
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
                                      color:
                                          Color.fromARGB(255, 194, 191, 191)),
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
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
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
                    Flexible(
                      flex: 1,
                      child: InkWell(
                        onTap: () async {
                          SharedPreferences localStorage =
                              await SharedPreferences.getInstance();

                          // SharedPreferences localStorage =
                          //     await SharedPreferences.getInstance();
                          Map request_filename = {
                            "file_name": "attachment",
                          };
                          // var claimNo =
                          //     localStorage.getString('claimNo') == null
                          //         ? ''
                          //         : localStorage.getString('claimNo');
                          Map<String, dynamic> _data = {
                            'claim_no': localStorage.getString('claimNo') ?? '',
                            "gst_no": 'GSTIN${_ie_gst_no.text}',
                            "gst_amount": _ie_gst_amt.text,
                            "basic_amount": _ie_basic_amt.text,
                            "claim_amount": _ie_total_amt.text,
                            "purpose": _ie_purpose.text,
                            "service_provider":
                                _ie_name_of_serviceprovider.text,
                            "bill_no": _ie_bill_no.text,
                            // 'attachment': _ie_file!.path.toString()
                          };

                          print('Incidental Claimz Request Data: $_data');

                          print(
                              'Incidental Claimz Request FILEEEEEEE: $_ie_file');

                          print(
                              'Incidental Claimz Request FILEEEEEEE NAMMMMMEEEEE: $request_filename');

                          if (_ie_file == null) {
                            _errorVal(context);
                          } else {
                            _claimzFormData
                                .directIncidentalSubmit(
                                    context, request_filename, _ie_file!, _data)
                                .then((_) {
                              setState(() {
                                localStorage.remove('claimNo');
                              });
                            });
                            // .then(
                            //     (value) => localStorage.remove('claimNo'));
                          }
                        },
                        child: Container(
                            height: SizeVariables.getHeight(context) * 0.05,
                            width: SizeVariables.getHeight(context) * 0.05,
                            // color: Colors.green,
                            child:
                                Lottie.asset('assets/json/final_submit.json')),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Container(
                  width: double.infinity,
                  color: const Color.fromARGB(239, 228, 226, 226),
                  // padding:
                  //     EdgeInsets.all(SizeVariables.getWidth(context) * 0.02),
                  padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.02,
                      top: SizeVariables.getHeight(context) * 0.01,
                      right: SizeVariables.getWidth(context) * 0.02,
                      bottom: SizeVariables.getHeight(context) * 0.008),
                  child: Column(
                    children: [
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Container(
                          width: double.infinity,
                          // height: SizeVariables.getHeight(context) * 0.1,
                          decoration: BoxDecoration(
                              // color: Colors.red,
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
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.02,
                                        ),
                                        Container(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.76,
                                          // width: 300,
                                          // height: 200,
                                          child: TextFormField(
                                            controller:
                                                _ie_name_of_serviceprovider,
                                            readOnly: false,
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
                                    left:
                                        SizeVariables.getWidth(context) * 0.04,
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
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.02,
                                          ),
                                          Container(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.3,
                                            // width: 300,
                                            // height: 200,
                                            child: TextFormField(
                                              controller: _ie_bill_no,
                                              keyboardType: TextInputType.text,
                                              readOnly: false,
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
                                                  .copyWith(
                                                      color: Colors.black),
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
                                            controller: _ie_gst_no,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  15)
                                            ],
                                            keyboardType: TextInputType.text,
                                            readOnly: false,
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
                                    left:
                                        SizeVariables.getWidth(context) * 0.06,
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
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.02,
                                          ),
                                          Container(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.3,
                                            // width: 300,
                                            // height: 200,
                                            child: TextFormField(
                                              controller: _ie_basic_amt,
                                              keyboardType:
                                                  TextInputType.number,
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
                                                  .copyWith(
                                                      color: Colors.black),
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
                                            controller: _ie_gst_amt,
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
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.02,
                                        ),
                                        Container(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.76,
                                          // width: 300,
                                          // height: 200,
                                          child: TextFormField(
                                            controller: _ie_purpose,
                                            readOnly: false,
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
                                          SizeVariables.getWidth(context) *
                                              0.04,
                                      vertical:
                                          SizeVariables.getHeight(context) *
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
                                                          Text('Upload Invoice',
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
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.01),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () => showDialog(
                                                      context: context,
                                                      builder:
                                                          (context) =>
                                                              AlertDialog(
                                                                content:
                                                                    Container(
                                                                  height: SizeVariables
                                                                          .getHeight(
                                                                              context) *
                                                                      0.4,
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      InteractiveViewer(
                                                                    // clipBehavior:
                                                                    //     Clip.none,
                                                                    // minScale: 1,
                                                                    // maxScale: 4,
                                                                    // transformationController:
                                                                    //     controller,
                                                                    // onInteractionStart: (details) {
                                                                    //   if (details.pointerCount < 2) return;
                                                                    //   if (entry == null) {
                                                                    //     showOverlay(context);
                                                                    //   }
                                                                    // },
                                                                    // onInteractionEnd:
                                                                    //     (details) {
                                                                    //   resetAnimation();
                                                                    // },
                                                                    child: AspectRatio(
                                                                        aspectRatio:
                                                                            1,
                                                                        child: ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            child: Image.file(File(_ie_file!.path), fit: BoxFit.cover))),
                                                                  ),
                                                                ),
                                                              )),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    child: Container(
                                                      width: SizeVariables
                                                              .getWidth(
                                                                  context) *
                                                          0.4,
                                                      // color: Colors.yellow,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey,
                                                              width: 2)),
                                                      child: _ie_file == null
                                                          ? Center(
                                                              child: Text(
                                                                  'Please Upload Invoice',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(
                                                                          color:
                                                                              Colors.black)),
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
                                                                          image:
                                                                              FileImage(File(_ie_file!.path)))),
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
                                      Flexible(
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
                                                            onTap: () async {
                                                              // var imagePath =
                                                              //     await EdgeDetection
                                                              //         .detectEdge;

                                                              // setState(() {
                                                              //   _ie_file = XFile(
                                                              //       File(imagePath
                                                              //               .toString())
                                                              //           .path);
                                                              // });
                                                              final image =
                                                                  await ImagePicker()
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.camera);
                                                              if (image == null)
                                                                return;

                                                              // imageTemporary = cropSquareImage(File(image.path));

                                                              File?
                                                                  imageTemporary =
                                                                  File(image
                                                                      .path);

                                                              imageTemporary =
                                                                  await cropImage(
                                                                      imageTemporary);

                                                              setState(() {
                                                                _ie_file =
                                                                    imageTemporary;
                                                                // isLoading =
                                                                //     false;
                                                                // isGallery =
                                                                //     true;
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons.camera_alt,
                                                              color:
                                                                  Colors.black,
                                                              size: 35,
                                                            )),
                                                        InkWell(
                                                            onTap: () async {
                                                              // var imagePath =
                                                              //     await EdgeDetection
                                                              //         .detectEdge;

                                                              // setState(() {
                                                              //   _ie_file = XFile(
                                                              //       File(imagePath
                                                              //               .toString())
                                                              //           .path);
                                                              // });
                                                              final image =
                                                                  await ImagePicker()
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.gallery);
                                                              if (image == null)
                                                                return;

                                                              // imageTemporary = cropSquareImage(File(image.path));

                                                              File?
                                                                  imageTemporary =
                                                                  File(image
                                                                      .path);

                                                              imageTemporary =
                                                                  await cropImage(
                                                                      imageTemporary);

                                                              setState(() {
                                                                _ie_file =
                                                                    imageTemporary;
                                                                // isLoading =
                                                                //     false;
                                                                // isGallery =
                                                                //     true;
                                                              });
                                                            },
                                                            child: const Icon(
                                                              Icons
                                                                  .upload_file_outlined,
                                                              color:
                                                                  Colors.black,
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
                                                          MainAxisAlignment.end,
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
                                                          child: AnimatedButton(
                                                            height: 45,
                                                            width: 100,
                                                            text:
                                                                'Save as Draft',
                                                            isReverse: true,
                                                            selectedTextColor:
                                                                Colors.black,
                                                            transitionType:
                                                                TransitionType
                                                                    .LEFT_TO_RIGHT,
                                                            textStyle: TextStyle(
                                                                fontSize: 13,
                                                                color: (themeProvider
                                                                        .darkTheme)
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                            backgroundColor: (themeProvider
                                                                    .darkTheme)
                                                                ? Colors.black
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimary,
                                                            borderColor: (themeProvider
                                                                    .darkTheme)
                                                                ? Colors.white
                                                                : Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onPrimary,
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
                                                                _errorVal(
                                                                    context);
                                                              } else {
                                                                _claimzFormData
                                                                    .postIncidentalClaimz(
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
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(height: SizeVariables.getHeight(context) * 0.01),
                      // Flexible(
                      //   flex: 1,
                      //   fit: FlexFit.tight,
                      //   child: Container(
                      //     width: double.infinity,
                      //     color: Colors.red,
                      //   ),
                      // )
                    ],
                  ),
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
    final overlay = Overlay.of(context);
    overlay.insert(entry!);
  }
}
