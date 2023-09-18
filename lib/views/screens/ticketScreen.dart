import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/views/screens/logs/travel/travelview.dart';
import 'package:claimz/views/screens/ticketHistoryscroll.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../provider/theme_provider.dart';
import '../../res/components/containerStyle.dart';
import '../../utils/routes/routeNames.dart';
import '../config/mediaQuery.dart';

class TicketScreen extends StatefulWidget {
  final Map<String, dynamic> profile;

  // const TicketScreen({Key? key}) : super(key: key);

  TicketScreen(this.profile);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

String body = '';
// var tfile;
// var torgfile;
// String? tfile_link;
// String? torgfile_link;
// var ffile;
// var forgfile;
// String? ffile_link;
// String? forgfile_link;
// XFile? _ie_file;

GlobalKey<FormState> _key1 = GlobalKey<FormState>();
TextEditingController _taskTitle = TextEditingController();
TextEditingController taskController = TextEditingController();

class _TicketScreenState extends State<TicketScreen> {
  File? image;
  List _ticketList = [];
  String _priorityRadioBtnValue = 'low';
  final formKey = GlobalKey<FormState>;

  Future<void> uploadTicket() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    EasyLoading.show(status: 'Submitting Ticket...');
    var stream;
    var length;

    // if (image != null) {
    //   stream = new http.ByteStream(image!.openRead());
    //   stream.cast();

    //   length = await image!.length();
    // }
    // var stream = new http.ByteStream(image!.openRead());
    // stream.cast();

    // var length = await image!.length();

    var uri = Uri.parse('https://console.claimz.in/api/api/post-ticket');

    var request = new http.MultipartRequest('POST', uri);

    request.fields['title'] = _taskTitle.text;
    request.fields['description'] = taskController.text;
    request.fields['priority'] = _priorityRadioBtnValue;

    request.headers
        .addAll({'Authorization': 'Bearer ${localStorage.getString('token')}'});

    // var multipart = new http.MultipartFile('document', stream, length);

    if (image != null) {
      //var multipart = new http.MultipartFile('document', stream, length);
      request.files.add(await http.MultipartFile.fromPath(
          'document', image!.path.toString()));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      EasyLoading.showSuccess("Submmited ticket").then((value) {
        _taskTitle.text = '';
        taskController.text = '';

        setState(() {
          image = null;
        });
      });
      EasyLoading.dismiss();
      // Navigator.pop(context);
      //print('ticket submitted');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TicketHistoryScroll(widget.profile),
        ),
      );
    } else {
      print('failed');
      EasyLoading.dismiss();
      Flushbar(
        message: 'An Error Occured',
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.blue,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.blue,
      )..show(context);
    }
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  int? _radioValue = 0;
  /* var sheetController = showBottomSheet(
        context: context,
        builder: (context) => BottomSheetWidget());*/
  void _handleRadioValueChange(value) {
    setState(() {
      _radioValue = value;
    });
    print("first" + value.toString() + "radiovalue" + _radioValue.toString());

    // print('RADIO VALUEEEEEEEE: $value');
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final themeProvider = Provider.of<ThemeProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Container(
            // height: 500,
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.025,
              right: SizeVariables.getWidth(context) * 0.025,
            ),
            child: ListView(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.02,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/back button.svg",
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeVariables.getHeight(context) * 0.024,
                                  left: SizeVariables.getWidth(context) * 0.01),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Ticket',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(30),
                      //       ),
                      //       primary: (themeProvider.darkTheme)
                      //           ? Color.fromARGB(168, 94, 92, 92)
                      //           : Colors.amberAccent,
                      //     ),
                      //     onPressed: () {
                      //       Navigator.pushNamed(
                      //           context, RouteNames.tickethistory);
                      //     },
                      //     child: Text('View ',
                      //         style: (themeProvider.darkTheme)
                      //             ? Theme.of(context)
                      //                 .textTheme
                      //                 .bodyText2
                      //                 ?.copyWith(
                      //                   color: Color(0xffF59F23),
                      //                 )
                      //             : TextStyle(
                      //                 color: Colors.black,
                      //               )),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Container(
                  child: Form(
                    key: _key1,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          child: TextFormField(
                            controller: _taskTitle,
                            cursorColor: Colors.white,
                            // controller: taskController,
                            // maxLines: 5,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.amber,
                                ),
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              // border: new OutlineInputBorder(
                              //   borderSide: new BorderSide(color: Colors.amber),
                              // ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  // width: 2.0,
                                ),
                              ),
                              label: Text(
                                "Title",
                                style: Theme.of(context).textTheme.bodyText1!,
                              ),
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              //border: InputBorder.none,
                            ),
                            // validator: (value) {
                            //   if (value != null && value.length == 0) {
                            //     return 'Enter a title';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          child: TextFormField(
                            controller: taskController,
                            cursorColor: Colors.white,
                            // controller: taskController,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.amber,
                                ),
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              // border: new OutlineInputBorder(
                              //   borderSide: new BorderSide(color: Colors.amber),
                              // ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  // width: 2.0,
                                ),
                              ),
                              label: Text(
                                "Description",
                                style: Theme.of(context).textTheme.bodyText1!,
                              ),
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              //border: InputBorder.none,
                            ),
                            // validator: (value) {
                            //   if (value != null && value.length == 0) {
                            //     return 'Enter a description';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: SizeVariables.getHeight(context) * 0.01,
                            left: SizeVariables.getWidth(context) * 0.04,
                          ),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Priority',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      fillColor: (themeProvider.darkTheme)
                                          ? MaterialStateProperty.resolveWith<
                                              Color>((states) {
                                              if (states.contains(
                                                  MaterialState.disabled)) {
                                                return Colors.black;
                                              }
                                              return Colors.white;
                                            })
                                          : MaterialStateProperty.resolveWith<
                                              Color>((states) {
                                              if (states.contains(
                                                  MaterialState.disabled)) {
                                                return Colors.black;
                                              }
                                              return Colors.black;
                                            }),
                                      value: 'low',
                                      groupValue: _priorityRadioBtnValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _priorityRadioBtnValue = 'low';
                                        });
                                        print("radiosecond " +
                                            value.toString() +
                                            "radiovalue " +
                                            _radioValue.toString());
                                        _handleRadioValueChange(_radioValue);
                                      },
                                    ),
                                    const Text(
                                      'Low',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      fillColor: (themeProvider.darkTheme)
                                          ? MaterialStateProperty.resolveWith<
                                              Color>((states) {
                                              if (states.contains(
                                                  MaterialState.disabled)) {
                                                return Colors.black;
                                              }
                                              return Colors.white;
                                            })
                                          : MaterialStateProperty.resolveWith<
                                              Color>((states) {
                                              if (states.contains(
                                                  MaterialState.disabled)) {
                                                return Colors.black;
                                              }
                                              return Colors.black;
                                            }),
                                      value: 'medium',
                                      groupValue: _priorityRadioBtnValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _priorityRadioBtnValue = 'medium';
                                        });
                                        print("radiosecond " +
                                            value.toString() +
                                            "radiovalue " +
                                            _radioValue.toString());
                                        _handleRadioValueChange(_radioValue);
                                      },
                                    ),
                                    const Text(
                                      'Medium',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      fillColor: (themeProvider.darkTheme)
                                          ? MaterialStateProperty.resolveWith<
                                              Color>((states) {
                                              if (states.contains(
                                                  MaterialState.disabled)) {
                                                return Colors.black;
                                              }
                                              return Colors.white;
                                            })
                                          : MaterialStateProperty.resolveWith<
                                              Color>((states) {
                                              if (states.contains(
                                                  MaterialState.disabled)) {
                                                return Colors.black;
                                              }
                                              return Colors.black;
                                            }),
                                      value: 'high',
                                      groupValue: _priorityRadioBtnValue,
                                      onChanged: (value) {
                                        setState(() {
                                          _priorityRadioBtnValue = 'high';
                                        });
                                        print("radiosecond " +
                                            value.toString() +
                                            "radiovalue " +
                                            _radioValue.toString());
                                        _handleRadioValueChange(_radioValue);
                                      },
                                    ),
                                    const Text(
                                      'High',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   padding: EdgeInsets.only(
                        //     left: SizeVariables.getWidth(context) * 0.025,
                        //     // top: SizeVariables.getWidth(context) * 0.02,
                        //   ),
                        //   width: 70,
                        //   child: FittedBox(
                        //     fit: BoxFit.contain,
                        //     child: Text(
                        //       'Description',
                        //       style: Theme.of(context).textTheme.caption,
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       right: SizeVariables.getWidth(context) * 0.025,
                        //       left: SizeVariables.getWidth(context) * 0.025,
                        //       top: SizeVariables.getWidth(context) * 0.04),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       boxShadow: (themeProvider.darkTheme)
                        //           ? []
                        //           : [
                        //               BoxShadow(
                        //                 color: Colors.grey.withOpacity(0.5),
                        //                 spreadRadius: 0,
                        //                 blurRadius: 7,
                        //                 //offset: Offset(0, 3), // changes position of shadow
                        //               ),
                        //             ],
                        //     ),
                        //     child: ContainerStyle(
                        //       // margin: const EdgeInsets.only(right: 25),
                        //       height: MediaQuery.of(context).size.height > 750
                        //           ? 16.h
                        //           : MediaQuery.of(context).size.height < 650
                        //               ? 19.h
                        //               : 16.h,
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8),
                        //         child: TextFormField(
                        //           autofocus: false,
                        //           controller: taskController,
                        //           decoration: const InputDecoration(
                        //             border: InputBorder.none,
                        //             // border: OutlineInputBorder(
                        //             //   borderSide: BorderSide(color: Colors.grey),
                        //             // ),
                        //             // fillColor: Colors.grey,
                        //           ),
                        //           style: Theme.of(context).textTheme.bodyText1,
                        //           maxLines: 5,
                        //           validator: (value) {
                        //             if (value!.isEmpty || value == '') {
                        //               return 'Please enter Task';
                        //             } else {
                        //               body = value;
                        //               return null;
                        //             }
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          // color: Colors.amber,
                          height: height > 750
                              ? 37.h
                              : height < 650
                                  ? 50.h
                                  : 46.h,
                          // width: 220,
                          child: Container(
                            // height: SizeVariables.getHeight(context) * 0.2,
                            width: double.infinity,
                            // color: Colors.pink,
                            // padding: EdgeInsets.all(SizeVariables.getWidth(context) * 0.02),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    SizeVariables.getWidth(context) * 0.04,
                                vertical:
                                    SizeVariables.getHeight(context) * 0.02),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.loose,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.visibility,
                                                        color: Colors.white),
                                                    SizedBox(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.02),
                                                    Container(
                                                      width: SizeVariables
                                                              .getWidth(
                                                                  context) *
                                                          0.3,
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                            'Uploaded Ticket',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              // Container(
                                              //   child: Row(
                                              //     children: [
                                              //       const Icon(Icons.visibility,
                                              //           color: Colors.black),
                                              //       SizedBox(
                                              //           width: SizeVariables.getWidth(
                                              //                   context) *
                                              //               0.02),
                                              //       Text('Upload Org. Invoice',
                                              //           style: Theme.of(context)
                                              //               .textTheme
                                              //               .bodyText1!
                                              //               .copyWith(
                                              //                   color: Colors.black,
                                              //                   fontSize: 18))
                                              //     ],
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.015),
                                        Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.4,
                                              child: Container(
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    child: Container(
                                                      width: SizeVariables
                                                              .getWidth(
                                                                  context) *
                                                          0.1,
                                                      height: 250,
                                                      // color: Colors.yellow,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2)),
                                                      child: (image != null)
                                                          ? Image.file(
                                                              image!,
                                                              fit: BoxFit.cover,
                                                            )
                                                          : Center(
                                                              child: Text(
                                                                  'Upload Image'),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // color: Colors.yellow,
                                              // width: double.infinity,
                                              padding: EdgeInsets.only(
                                                  top: SizeVariables.getHeight(
                                                          context) *
                                                      0.05,
                                                  left: SizeVariables.getWidth(
                                                          context) *
                                                      0.05),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  InkWell(
                                                      onTap: pickImage,
                                                      child: const Icon(
                                                        Icons
                                                            .upload_file_outlined,
                                                        color: Colors.white,
                                                        size: 35,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: SizeVariables.getHeight(context) * 0.03),
                        Center(
                          child: Container(
                            child: AnimatedButton(
                              height: 45,
                              width: 100,
                              text: 'Submit',
                              isReverse: true,
                              selectedTextColor: Colors.black,
                              transitionType: TransitionType.LEFT_TO_RIGHT,
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  color: (themeProvider.darkTheme)
                                      ? Colors.white
                                      : Colors.black),
                              backgroundColor: (themeProvider.darkTheme)
                                  ? Colors.black
                                  : Colors.amberAccent,
                              borderColor: (themeProvider.darkTheme)
                                  ? Colors.white
                                  : Colors.amberAccent,
                              borderRadius: 8,
                              borderWidth: 2,
                              //onPress: uploadTicket,
                              onPress: () {
                                if (_taskTitle.text == null ||
                                    _taskTitle.text == '') {
                                  Flushbar(
                                          duration: const Duration(seconds: 4),
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          leftBarIndicatorColor: Colors.red,
                                          icon: const Icon(Icons.error,
                                              color: Colors.white),
                                          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

                                          message: 'Please Enter a title')
                                      .show(context);
                                } else if (taskController.text == null ||
                                    taskController.text == '') {
                                  Flushbar(
                                          duration: const Duration(seconds: 4),
                                          flushbarPosition:
                                              FlushbarPosition.BOTTOM,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          leftBarIndicatorColor: Colors.red,
                                          icon: const Icon(Icons.error,
                                              color: Colors.white),
                                          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

                                          message: 'Please Enter a description')
                                      .show(context);
                                } else {
                                  uploadTicket();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    //here will be content
                  ),
                ),
                // Container(
                //   // color: Colors.amber,
                //   height: height > 750
                //       ? 37.h
                //       : height < 650
                //           ? 50.h
                //           : 46.h,
                //   // width: 220,
                //   child: Container(
                //     // height: SizeVariables.getHeight(context) * 0.2,
                //     width: double.infinity,
                //     // color: Colors.pink,
                //     // padding: EdgeInsets.all(SizeVariables.getWidth(context) * 0.02),
                //     padding: EdgeInsets.symmetric(
                //         horizontal: SizeVariables.getWidth(context) * 0.04,
                //         vertical: SizeVariables.getHeight(context) * 0.02),
                //     child: Row(
                //       children: [
                //         Flexible(
                //           flex: 1,
                //           fit: FlexFit.loose,
                //           child: Container(
                //             // color: Colors.pink,
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Container(
                //                   // color: Colors.yellow,
                //                   child: Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Container(
                //                         child: Row(
                //                           children: [
                //                             const Icon(Icons.visibility,
                //                                 color: Colors.white),
                //                             SizedBox(
                //                                 width: SizeVariables.getWidth(
                //                                         context) *
                //                                     0.02),
                //                             Container(
                //                               width: SizeVariables.getWidth(
                //                                       context) *
                //                                   0.3,
                //                               child: FittedBox(
                //                                 fit: BoxFit.contain,
                //                                 child: Text('Uploaded Ticket',
                //                                     style: Theme.of(context)
                //                                         .textTheme
                //                                         .bodyText1!
                //                                         .copyWith(
                //                                             color: Colors.white,
                //                                             fontSize: 18)),
                //                               ),
                //                             )
                //                           ],
                //                         ),
                //                       ),
                //                       // Container(
                //                       //   child: Row(
                //                       //     children: [
                //                       //       const Icon(Icons.visibility,
                //                       //           color: Colors.black),
                //                       //       SizedBox(
                //                       //           width: SizeVariables.getWidth(
                //                       //                   context) *
                //                       //               0.02),
                //                       //       Text('Upload Org. Invoice',
                //                       //           style: Theme.of(context)
                //                       //               .textTheme
                //                       //               .bodyText1!
                //                       //               .copyWith(
                //                       //                   color: Colors.black,
                //                       //                   fontSize: 18))
                //                       //     ],
                //                       //   ),
                //                       // ),
                //                     ],
                //                   ),
                //                 ),
                //                 SizedBox(
                //                     height: SizeVariables.getHeight(context) *
                //                         0.015),
                //                 Row(
                //                   // mainAxisAlignment:
                //                   //     MainAxisAlignment.spaceBetween,
                //                   children: [
                //                     Container(
                //                       width:
                //                           SizeVariables.getWidth(context) * 0.4,
                //                       child: Container(
                //                         child: InkWell(
                //                           onTap: () {},
                //                           child: ClipRRect(
                //                             borderRadius:
                //                                 const BorderRadius.all(
                //                                     Radius.circular(20)),
                //                             child: Container(
                //                               width: SizeVariables.getWidth(
                //                                       context) *
                //                                   0.1,
                //                               height: 250,
                //                               // color: Colors.yellow,
                //                               decoration: BoxDecoration(
                //                                   border: Border.all(
                //                                       color: Colors.white,
                //                                       width: 2)),
                //                               child: (image != null)
                //                                   ? Image.file(
                //                                       image!,
                //                                       fit: BoxFit.cover,
                //                                     )
                //                                   : Center(
                //                                       child:
                //                                           Text('Upload Image'),
                //                                     ),
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                     Container(
                //                       // color: Colors.yellow,
                //                       // width: double.infinity,
                //                       padding: EdgeInsets.only(
                //                           top:
                //                               SizeVariables.getHeight(context) *
                //                                   0.05,
                //                           left:
                //                               SizeVariables.getWidth(context) *
                //                                   0.05),
                //                       child: Column(
                //                         crossAxisAlignment:
                //                             CrossAxisAlignment.start,
                //                         children: [
                //                           SizedBox(
                //                             height: 20,
                //                           ),
                //                           InkWell(
                //                               onTap: pickImage,
                //                               child: const Icon(
                //                                 Icons.upload_file_outlined,
                //                                 color: Colors.white,
                //                                 size: 35,
                //                               )),
                //                         ],
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(height: SizeVariables.getHeight(context) * 0.03),
                // Center(
                //   child: Container(
                //     child: AnimatedButton(
                //       height: 45,
                //       width: 100,
                //       text: 'Submit',
                //       isReverse: true,
                //       selectedTextColor: Colors.black,
                //       transitionType: TransitionType.LEFT_TO_RIGHT,
                //       textStyle: TextStyle(
                //           fontSize: 16,
                //           color: (themeProvider.darkTheme)
                //               ? Colors.white
                //               : Colors.black),
                //       backgroundColor: (themeProvider.darkTheme)
                //           ? Colors.black
                //           : Colors.amberAccent,
                //       borderColor: (themeProvider.darkTheme)
                //           ? Colors.white
                //           : Colors.amberAccent,
                //       borderRadius: 8,
                //       borderWidth: 2,
                //       onPress: uploadTicket,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void openFileNetworkFile(
    {required String fileLink, required String? fileName}) async {
  final file = await downloadFile(fileLink, fileName!);
  if (file == null) return;

  print('Path: ${file.path}');

  OpenFile.open(file.path);
}
