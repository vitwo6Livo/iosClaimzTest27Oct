import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/res/components/content_dialog.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/claimzViewModel.dart';
import 'package:claimz/views/config/appColors.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/widgets/custom_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import "package:latlong2/latlong.dart";
import 'package:lottie/lottie.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'claimzFrom.dart';
import 'package:face_camera/face_camera.dart';

import 'conveyanceCamera.dart';

class Claimz_category extends StatefulWidget {
  @override
  State<Claimz_category> createState() => _Claimz_categoryState();
}

class _Claimz_categoryState extends State<Claimz_category>
    with WidgetsBindingObserver {
  //class variables
  String _statusmsg = "press the options to start";
  Key _key0fripple = GlobalKey();
  String _duration = "";
  String _distance = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  String _doc_id = "";
  int _list_count = 0;
  TextEditingController _place = TextEditingController();
  TextEditingController _purpose = TextEditingController();
  TextEditingController _meetToWhom = TextEditingController();
  TextEditingController _remarks = TextEditingController();

  List<String> options = ['Meeting', 'Other than Meeting'];
  var _selectedItem;

  String _to_lat = "";
  String _to_long = "";
  File? _capturedImage;

  //styles start
  var curveGradient = RadialGradient(
    colors: <Color>[
      // AppColors.buttonColor2,
      Colors.white60,
      AppColors.gradientStartColor
    ],
    focalRadius: 16,
  );
  var connectedStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    height: 1.6,
    color: Colors.white,
  );
  var connectedGreenStyle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: Colors.greenAccent,
  );
  var connectedSubtitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  var greenGradient = LinearGradient(
    colors: <Color>[
      Color(0XFF00D58D),
      Color(0XFF00C2A0),
    ],
  );
  var redGradient = LinearGradient(
    colors: <Color>[
      Colors.redAccent,
      Colors.red,
    ],
  );

  //styles end

  late Position _currentPosition;
  String _currentAddress = '';
  String _currentAddress_locality = '';

  late LatLng myLocation;

  // // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() async {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        myLocation = LatLng(position.latitude, position.longitude);
        _getAddress();
      });
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name},${place.subLocality},${place.administrativeArea},${place.subAdministrativeArea}, ${place.locality}, ${place.postalCode}, ${place.country}";
        _currentAddress_locality = place.locality.toString();
        print("ADDRESS>>" + _currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }

  ClaimzViewModel claimz_detail = ClaimzViewModel();
  var kGoogleApiKey = "AIzaSyDJJ7rw4YTPHxvD1KuReHoQ-ja2VT3Sp18";
  // var kGoogleApiKey = 'AIzaSyBqJcRGUAyEwdwkYlwBDCzAPrAUIbLol8A';

  void cameraInitialisation() async {
    _cameras = await availableCameras();
  }

  @override
  void initState() {
    // TODO: implement initState
    // cameraInitialisation();

    // _controller = CameraController(
    //   // Get a specific camera from the list of available cameras.
    //   // widget.camera.lensDirection,
    //   _cameras[1],
    //   // Define the resolution to use.
    //   ResolutionPreset.medium,
    // );

    // // Next, initialize the controller. This returns a Future.
    // _initializeControllerFuture = _controller.initialize();

    super.initState();
    _getCurrentLocation();
    claimz_detail.getClaimzDetails(context);
  }

  @override
  void dispose() {
    // _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ListView(
          children: <Widget>[
            Stack(
              // overflow: Overflow.visible,
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: <Widget>[
                upperCurvedContainer(context),
                circularButtonWidget(screenHeight, context, screenWidth),
              ],
            ),
            SizedBox(height: screenWidth * 0.2),
            StatusText(),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.02,
            ),
            Row(children: [
              Expanded(
                child: _buttonDesign2(
                  "Travel History",
                  Icons.location_history,
                  () {
                    Navigator.pushNamed(context, RouteNames.claimzhistory);
                  },
                ),
              ),
              SizedBox(
                child: Container(
                  width: 2,
                  height: screenWidth * 0.2,
                  color: AppColors.buttonColor2,
                ),
              ),
              Expanded(
                child: _buttonDesign2("Smart Route", Icons.travel_explore, () {
                  _displayTextInputDialog(context, _currentAddress);
                }),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                height: 2,
                color: AppColors.buttonColor2,
              ),
            ),
            // Row(children: [
            //   Expanded(
            //     child: _buttonDesign2("Smart Route", Icons.travel_explore, () {
            //       _displayTextInputDialog(context, _currentAddress);
            //     }),
            //   ),
            //   SizedBox(
            //     child: Container(
            //       width: 2,
            //       height: 80,
            //       color: AppColors.buttonColor2,
            //     ),
            //   ),
            //   Expanded(
            //       child: _buttonDesign2(
            //           "Claimz",
            //           Icons.wallet_membership_sharp,
            //           () => Navigator.of(context).push(MaterialPageRoute(
            //               builder: (context) => ClaimzFrom(
            //                     claimzId: '',
            //                     docId: '',
            //                   ))))),
            // ]),
            // SizedBox(height: 20),
          ],
        ));
  }

  Widget _topRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              height: 40,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  "My Daily Travel's",
                  style: TextStyle(
                    fontSize: 9,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        ChangeNotifierProvider<ClaimzViewModel>(
          create: (BuildContext context) => claimz_detail,
          child: Consumer<ClaimzViewModel>(
            builder: (context, value, child) {
              if (value.claimzdata.status == Status.COMPLETED) {
                //define the current status of the travel and meeting

                if (value.claimzdata.data!.data!.isNotEmpty) {
                  _doc_id = value.claimzdata.data!.data![0].docNo.toString();

                  _list_count = value.claimzdata.data!.data!.length;

                  // give button color as the state has

                  Future.delayed(Duration(milliseconds: 200), () {
                    setState(() {
                      if (_list_count == 1) {
                        Provider.of<ClaimzViewModel>(context, listen: false)
                            .defaultGradient = redGradient;
                        _statusmsg = "END TRAVEL";
                      } else if (_list_count == 2) {
                        Provider.of<ClaimzViewModel>(context, listen: false)
                            .defaultGradient = greenGradient;
                        _statusmsg = "START MEETING";
                      } else if (_list_count == 3) {
                        Provider.of<ClaimzViewModel>(context, listen: false)
                            .defaultGradient = redGradient;
                        _statusmsg = "END MEETING";
                      } else if (_list_count == null || _list_count == 0)
                      //4
                      {
                        Provider.of<ClaimzViewModel>(context, listen: false)
                            .defaultGradient = greenGradient;
                        _statusmsg = "START TRAVEL";
                      }
                    });
                  });
                } else {
                  Future.delayed(Duration(milliseconds: 200), () {
                    setState(() {
                      _list_count = 0;
                      Provider.of<ClaimzViewModel>(context, listen: false)
                          .defaultGradient = greenGradient;
                      _statusmsg = "START TRAVEL";
                    });
                  });
                }

                // claimz_detail.defaultGradient = _list_count==2?greenGradient:
                // _list_count==4?greenGradient:redGradient;
              }
              switch (value.claimzdata.status) {
                case Status.LOADING:
                  return CircularProgressIndicator();

                case Status.ERROR:
                  print(value.claimzdata.message.toString());
                  // return Center(
                  //   child: Text(value.claimzdata.message.toString()),
                  // );

                  return Center(
                    child: Lottie.asset('assets/json/location.json',
                        height: 200, width: 300),
                  );

                case Status.COMPLETED:
                  if (value.claimzdata.data!.data!.isEmpty) {
                    return Center(
                      child: Lottie.asset('assets/json/ToDo.json',
                          height: 200, width: 300),
                    );
                  } else {
                    return Container(
                        height: 200,
                        child: ListView(shrinkWrap: true, children: <Widget>[
                          _createTimeline(
                              true,
                              value.claimzdata.data!.data![0].claimTime
                                  .toString(),
                              "\nTravel Started",
                              false,
                              value.claimzdata.data!.data![0].claimTime
                                      .toString()
                                      .isEmpty
                                  ? true
                                  : false,
                              value.claimzdata.data!.data!.length == 1
                                  ? true
                                  : false),

                          //condition 2
                          value.claimzdata.data!.data!.length >= 2
                              ? _createTimeline(
                                  false,
                                  value.claimzdata.data!.data![1].claimTime
                                      .toString(),
                                  "\nTravel Ended ",
                                  false,
                                  value.claimzdata.data!.data![1].claimTime
                                          .toString()
                                          .isEmpty
                                      ? true
                                      : false,
                                  value.claimzdata.data!.data!.length == 2
                                      ? true
                                      : false)
                              : SizedBox(),
                          // condition 3
                          value.claimzdata.data!.data!.length >= 3
                              ? _createTimeline(
                                  false,
                                  value.claimzdata.data!.data![2].claimTime
                                      .toString(),
                                  "\nMeeting Started",
                                  false,
                                  value.claimzdata.data!.data![2].claimTime
                                          .toString()
                                          .isEmpty
                                      ? true
                                      : false,
                                  value.claimzdata.data!.data!.length == 3
                                      ? true
                                      : false)
                              : SizedBox(),
                          //condition 4
                          value.claimzdata.data!.data!.length >= 4
                              ? _createTimeline(
                                  false,
                                  value.claimzdata.data!.data![3].claimTime
                                      .toString(),
                                  "\nMeeting Ended\n",
                                  true,
                                  value.claimzdata.data!.data![3].claimTime
                                          .toString()
                                          .isEmpty
                                      ? true
                                      : false,
                                  value.claimzdata.data!.data!.length == 4
                                      ? true
                                      : false)
                              : SizedBox(),
                        ]));
                  }

                // return SizedBox(child: Text(value.claimzdata.data!.data![0].toString()),);

                default:
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  Widget upperCurvedContainer(BuildContext context) {
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        height: SizeVariables.getHeight(context) * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: curveGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _topRow(),
            // _bottomRow(),
          ],
        ),
      ),
    );
  }

  Widget circularButtonWidget(screenheight, BuildContext context, width) {
    return Positioned(
      top: screenheight * 0.34,
      child: ChangeNotifierProvider<ClaimzViewModel>(
        create: (_) => claimz_detail,
        child: Consumer<ClaimzViewModel>(
          builder: (context, state, _) => Stack(
            alignment: Alignment.center,
            children: <Widget>[
              RippleAnimation(
                repeat: false,
                key: _key0fripple,
                color: Colors.grey,
                minRadius: 100,
                ripplesCount: 3,
                child: Container(
                  height: width * 0.51,
                  width: width * 0.51,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: curveGradient,
                    // color: Colors.red,
                  ),
                  child: Center(
                    child: Container(
                      // height: width * 0.4,
                      width: width * 0.4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            if (_list_count == 4 || _list_count == 0) {
                              showDialog(
                                  context: _scaffoldKey.currentContext!,
                                  builder: (context) => ContainerDialog(
                                        title: 'Provide Destination',
                                        subtitle:
                                            "search for the destination and press 'ok' to start your travel",
                                        onOk: () {
                                          print(
                                              'TO LAT: $_to_lat & TO LNG: $_to_long');
                                          if (_to_lat == '' && _to_long == '') {
                                            Flushbar(
                                              leftBarIndicatorColor: Colors.red,
                                              icon: const Icon(Icons.warning,
                                                  color: Colors.white),
                                              message:
                                                  'Please Enter Address To Continue',
                                              duration:
                                                  const Duration(seconds: 10),
                                            ).show(context);
                                          } else if (_meetToWhom.text == '') {
                                            Flushbar(
                                              leftBarIndicatorColor: Colors.red,
                                              icon: const Icon(Icons.warning,
                                                  color: Colors.white),
                                              message:
                                                  'Please Mention Whom To Meet',
                                              duration:
                                                  const Duration(seconds: 10),
                                            ).show(context);
                                          } else if (_purpose.text == '') {
                                            Flushbar(
                                              leftBarIndicatorColor: Colors.red,
                                              icon: const Icon(Icons.warning,
                                                  color: Colors.white),
                                              message: 'Please Specify Purpose',
                                              duration:
                                                  const Duration(seconds: 10),
                                            ).show(context);
                                          } else {
                                            Map<String, dynamic> data = {
                                              'lat': myLocation.latitude
                                                  .toString(),
                                              'lng': myLocation.longitude
                                                  .toString(),
                                              'destination_lat': _to_lat,
                                              't_start_origin_address':
                                                  _currentAddress_locality,
                                              'destination_lng': _to_long,
                                              'suggested_destination_address':
                                                  _place.text.toString(),
                                              'suggested_duration': _duration,
                                              'suggested_distance': _distance,
                                              'met_to_whom': _meetToWhom.text,
                                              'travel_purpose': _purpose.text
                                            };
                                            if (kDebugMode) {
                                              print('MEETING DATA $data');
                                            }
                                            Provider.of<ClaimzViewModel>(
                                                    _scaffoldKey
                                                        .currentContext!,
                                                    listen: false)
                                                .postClaimzExecute(
                                                    _scaffoldKey
                                                        .currentContext!,
                                                    data)

                                                // Provider.of<ClaimzViewModel>(context, listen: false).claimzExecute(context, data)
                                                .then((value) {
                                              //     print('DOCCCCCCCCCCC IDDDDDDDDDDDDD: ${value['doc']}');

                                              // setState(() {
                                              //   _doc_id = value['doc'].toString();
                                              // });

                                              _key0fripple = UniqueKey();

                                              Navigator.pop(context);
                                            });
                                          }
                                        },
                                        onCancel: () =>
                                            Navigator.of(context).pop(),
                                        container: Container(
                                          child: ContainerDetails(),
                                        ),
                                      )).then((value) {
                                // print(
                                //     'DOCCCCCCCCCCCC IDDDDDDDDDD: ${value['doc']}');

                                //on dialog close
                                Future.delayed(
                                    const Duration(seconds: 1),
                                    () => Provider.of<ClaimzViewModel>(context,
                                            listen: false)
                                        .getClaimzDetails(context));
                              });
                            } else if (_list_count == 3) {
                              // Builder(builder: (context) {
                              //   if (_capturedImage != null) {
                              //     return Center(
                              //       child: Stack(
                              //         alignment: Alignment.bottomCenter,
                              //         children: [
                              //           Image.file(
                              //             _capturedImage!,
                              //             width: double.maxFinite,
                              //             fit: BoxFit.fitWidth,
                              //           ),
                              //           ElevatedButton(
                              //               onPressed: () => setState(
                              //                   () => _capturedImage = null),
                              //               child: const Text(
                              //                 'Capture Again',
                              //                 textAlign: TextAlign.center,
                              //                 style: TextStyle(
                              //                     fontSize: 14,
                              //                     fontWeight: FontWeight.w700),
                              //               ))
                              //         ],
                              //       ),
                              //     );
                              //   }
                              //   return SmartFaceCamera(
                              //       autoCapture: true,
                              //       defaultCameraLens: CameraLens.front,
                              //       onCapture: (File? image) {
                              //         setState(() => _capturedImage = image);
                              //       },
                              //       onFaceDetected: (Face? face) {
                              //         //Do something
                              //       },
                              //       messageBuilder: (context, face) {
                              //         if (face == null) {
                              //           return Text(
                              //               'Place your face in the camera');
                              //         }
                              //         if (!face.wellPositioned) {
                              //           return Text(
                              //               'Center your face in the square');
                              //         }
                              //         return const SizedBox.shrink();
                              //       });
                              // });

                              showDialog(
                                  context: _scaffoldKey.currentContext!,
                                  builder: (context) => ContainerDialog(
                                        title: 'Remarksss',
                                        subtitle: 'Camera',
                                        onOk: () {
                                          Map<String, dynamic> data = {
                                            'lat':
                                                myLocation.latitude.toString(),
                                            'lng':
                                                myLocation.longitude.toString(),
                                            'origin_address':
                                                _currentAddress_locality,
                                            'remarks': _remarks.text,
                                            'purpose':
                                                _selectedItem ?? 'Meeting',
                                            'doc': _doc_id,
                                          };

                                          print('REMAAAAARKS: $data');

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ConveyanceCamera(data)));

                                          //Restore Code if Required

                                          // Provider.of<ClaimzViewModel>(
                                          //         _scaffoldKey.currentContext!,
                                          //         listen: false)
                                          //     .postClaimzExecute(
                                          //         _scaffoldKey.currentContext!,
                                          //         data)
                                          //     .then((value) {
                                          //   _key0fripple = UniqueKey();
                                          //   Navigator.pop(context);
                                          // Navigator.of(context).pushNamed(
                                          //     RouteNames.claimzhistory);
                                          // });
                                        },
                                        onCancel: () =>
                                            Navigator.of(context).pop(),
                                        container: Container(
                                          child: ContainerRemarksDetails(),
                                        ),
                                      )).then((value) => Future.delayed(
                                  const Duration(seconds: 1),
                                  () => Provider.of<ClaimzViewModel>(context,
                                          listen: false)
                                      .getClaimzDetails(context)));
                            } else if (_list_count == 1) {
                              //travel end
                              Map<String, dynamic> data = {
                                'lat': myLocation.latitude.toString(),
                                'lng': myLocation.longitude.toString(),
                                'origin_address': _currentAddress_locality,
                                'doc': _list_count >= 4 ? "" : _doc_id,
                              };
                              print(data);
                              Provider.of<ClaimzViewModel>(context,
                                      listen: false)
                                  .postCheckRange(context, data)
                                  .then((value) {
                                print(value.toString());
                                _key0fripple = UniqueKey();
                                if (value["status"] == false) {
                                  showDialog(
                                    context: _scaffoldKey.currentContext!,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.grey,
                                      title: const Text('Confirm Action',
                                          style:
                                              TextStyle(color: Colors.amber)),
                                      content: Text(
                                          double.parse(value['distance']
                                                      .toString()) >
                                                  0.0
                                              ? 'Do you really want to end travel as you are ${double.parse(value['distance'].toString()).toStringAsFixed(2)} km(s) away from destination ?'
                                              : 'Do you want to end travel ?',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Provider.of<ClaimzViewModel>(
                                                      context,
                                                      listen: false)
                                                  .postClaimzExecute(
                                                      context, data)
                                                  .then((value) {
                                                _key0fripple = UniqueKey();
                                              });
                                            },
                                            child: const Text('OK',
                                                style: TextStyle(
                                                    color: Colors.amber)))
                                      ],
                                    ),
                                    // builder: (context) => ContainerDialog(
                                    //       title: 'Confirm Action',
                                    //       subtitle:
                                    //           'Do you really want to end travel? ' +
                                    //               'as you are ' +
                                    //               double.parse(
                                    //                       value["distance"]
                                    //                           .toString())
                                    //                   .toStringAsFixed(2) +
                                    //               ' km away from destination',
                                    //       onOk: () {
                                    //         Navigator.pop(context);
                                    //         Provider.of<ClaimzViewModel>(
                                    //                 context,
                                    //                 listen: false)
                                    //             .postClaimzExecute(
                                    //                 context, data)
                                    //             .then((value) {
                                    //           _key0fripple = UniqueKey();
                                    //         });
                                    //       },
                                    //       onCancel: () {
                                    //         Navigator.pop(context);
                                    //       },
                                    //       container: Container(height: 5),
                                    //     )
                                  ).then((value) {
                                    Future.delayed(
                                        Duration(seconds: 1),
                                        () => Provider.of<ClaimzViewModel>(
                                                context,
                                                listen: false)
                                            .getClaimzDetails(context));
                                  });
                                } else {
                                  Provider.of<ClaimzViewModel>(context,
                                          listen: false)
                                      .postClaimzExecute(context, data)
                                      .then((value) {
                                    _key0fripple = UniqueKey();
                                    Future.delayed(
                                        const Duration(seconds: 1),
                                        () => Provider.of<ClaimzViewModel>(
                                                context,
                                                listen: false)
                                            .getClaimzDetails(context));
                                  });
                                }
                              });
                            } else {
                              Map<String, dynamic> data = {
                                'lat': myLocation.latitude.toString(),
                                'lng': myLocation.longitude.toString(),
                                'origin_address': _currentAddress_locality,
                                'doc': _list_count >= 4 ? "" : _doc_id,
                              };
                              Provider.of<ClaimzViewModel>(context,
                                      listen: false)
                                  .postClaimzExecute(context, data)
                                  .then((value) {
                                _key0fripple = UniqueKey();
                                Future.delayed(
                                    const Duration(seconds: 1),
                                    () => Provider.of<ClaimzViewModel>(context,
                                            listen: false)
                                        .getClaimzDetails(context));
                              });
                            }
                          },
                          child: Container(
                            height: width * 0.3,
                            width: width * 0.3,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: state.defaultGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color(0XFF00D58D).withOpacity(.2),
                                    spreadRadius: 15,
                                    blurRadius: 15,
                                  ),
                                ]),
                            child: const Center(
                              child: Icon(Icons.power_settings_new_outlined,
                                  color: Colors.white, size: 50),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget StatusText() {
    return Align(
        alignment: Alignment.topCenter,
        child: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
              text: 'CLICK TO  ',
              style: connectedStyle.copyWith(
                fontFamily: "Gilroy",
                fontSize: 12,
                color: Theme.of(context).canvasColor,
              ),
              children: [
                TextSpan(
                    text: _statusmsg + '\n',
                    style: connectedGreenStyle.copyWith(
                        fontFamily: "Gilroy",
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
                // TextSpan(text: '00:22:45', style: connectedSubtitle),
              ]),
        ));
  }

  Widget _buttonDesign2(String topic, IconData icon, VoidCallback onclick) {
    return InkWell(
      onTap: onclick,
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 30, color: Theme.of(context).canvasColor),
                Text(topic,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Gilroy",
                        color: topic == "Travel End"
                            ? Colors.redAccent
                            : topic == "Meeting End"
                                ? Colors.redAccent
                                : AppColors.buttonColor2))
              ],
            ),
          ),
          // Positioned(  // draw a red marble
          //   top: 0.0,
          //   right: 30.0,
          //   child: new Icon(Icons.check_circle, size: 16.0,
          //       color: Colors.greenAccent),
          // )
        ],
      ),
    );
  }

  _createTimeline(bool isfirst, String time, String msg, bool islast,
      bool disabled, bool ongoing) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.5,
      isFirst: isfirst,
      isLast: islast,
      indicatorStyle: IndicatorStyle(
        width: 15,
        color: disabled
            ? Colors.grey
            : ongoing
                ? Colors.greenAccent
                : AppColors.buttonColor2,
        padding: EdgeInsets.all(6),
      ),
      endChild: Text(
        time,
        style: ThemeData.light().textTheme.bodyText2!.copyWith(
              color: Colors.white,
              fontSize: 13,
            ),
      ),
      startChild: Text(
        msg,
        style: ThemeData.light().textTheme.bodyText2!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontFamily: "Gilroy"),
      ),
      beforeLineStyle: LineStyle(
        color: AppColors.buttonColor2,
      ),
    );
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, String currentAddress) async {
    TextEditingController _source = TextEditingController();
    TextEditingController _destination = TextEditingController();
    _source.text = currentAddress;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 103, 103, 101),
            title: Text(
              'Smart Route Finder',
              style: Theme.of(context).textTheme.caption,
            ),
            content: Container(
              height: 100,
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {},
                    controller: _source,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        hintText: "Give Source Address",
                        hintStyle: Theme.of(context).textTheme.bodyText1),
                    style: Theme.of(context).textTheme.bodyText1,
                    cursorColor: Colors.white,
                  ),
                  TextField(
                    onChanged: (value) {},
                    controller: _destination,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white),
                      ),
                      hintText: "Give Destination Address",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.grey),
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                    cursorColor: Colors.white,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  bottom: SizeVariables.getHeight(context) * 0.02,
                ),
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(168, 94, 92, 92),
                    ),
                    //     disabledColor: Colors.red,
                    // disabledTextColor: Colors.black,
                    // padding: const EdgeInsets.all(8),
                    // textColor: Color(0xffF59F23),
                    // color: Color.fromARGB(168, 81, 80, 80),
                    onPressed: () {
                      setState(() {
                        urlLaunch(_source.text, _destination.text);
                        Navigator.pop(context);
                      });
                    },
                    child: Text('Submit',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: Color(0xffF59F23),
                            )),
                  ),
                  decoration: new BoxDecoration(
                    // color: Color.fromARGB(168, 94, 92, 92),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 74, 74, 70),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  void urlLaunch(String origin, String destination) async {
    String url = "https://www.google.com/maps/dir/?api=1&origin=" +
        origin +
        "&destination=" +
        destination +
        "&travelmode=driving&dir_action=navigate";
    final String encodedURl = Uri.encodeFull(url);

    if (!await launchUrl(
      Uri.parse(encodedURl),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  ContainerDetails() {
    return Column(
      children: [
        TextFormField(
          cursorColor: Colors.white,
          controller: _place,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Enter Address",
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              Icons.map,
              color: Colors.white,
            ),
          ),
          style: Theme.of(context).textTheme.bodyText1,
          onTap: () async {
            await PlacesAutocomplete.show(
              context: context,
              radius: 10000000,
              logo: Text(""),
              types: [],
              strictbounds: false,
              apiKey: kGoogleApiKey,
              mode: Mode.overlay,
              language: "en",
              components: [
                Component(Component.country, "in"),
                Component(Component.country, "ken"),
                Component(Component.country, "sl")
              ],
            ).then((value) {
              String p = value!.placeId.toString();
              displayPrediction(p);
            });
          },
          validator: (val) => val!.isEmpty ? 'Enter address' : null,
          onChanged: (val) async {
            setState(() => _place.text = val);
          },
        ),
        TextFormField(
          controller: _meetToWhom,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Whom To Meet",
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          // style: Theme.of(context).textTheme.bodyText1,
        ),
        TextFormField(
          controller: _purpose,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Purpose",
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          // style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }

  Future<Null> displayPrediction(String place_id) async {
    if (place_id != null) {
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(place_id);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      Map data = {
        "from_lat": myLocation.latitude.toString(),
        "from_long": myLocation.longitude.toString(),
        'origin_address': _currentAddress_locality,
        "to_lat": lat.toString(),
        "to_long": lng.toString(),
      };
      if (kDebugMode) {
        print(data.toString());
      }
      _place.text = detail.result.name;

      Provider.of<ClaimzViewModel>(context, listen: false)
          .getEstimatedDetails(context, data)
          .then((value) {
        print(value);

        setState(() {
          _distance = value.distance.toString();
          _duration = value.time.toString();
          _to_long = lng.toString();
          _to_lat = lat.toString();
        });
      });
    }
  }

  ContainerRemarksDetails() {
    return Column(
      children: [
        // TextFormField(
        //   controller: _purpose,
        //   decoration: InputDecoration(
        //     hintText: "Enter Purpose",
        //     prefixIcon: Icon(Icons.account_circle_outlined),
        //   ),

        // ),

        StatefulBuilder(
            builder: (BuildContext context, StateSetter dropDownState) {
          return DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              dropdownColor: Color.fromARGB(255, 109, 109, 109),
              items: <String>[
                'Meeting',
                'Other than Meeting',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Text(
                        value,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ); //DropMenuItem
              }).toList(),
              value: _selectedItem,
              onChanged: (String? newValue) {
                dropDownState(() {
                  _selectedItem = newValue;
                  print('SELECTED ITEM: $_selectedItem');
                });
                //setState
              },
              //OnChange
              isExpanded: false,
              hint: Row(
                children: [
                  Text(
                    'Meeting',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }),
        TextFormField(
          controller: _remarks,
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            // border: InputBorder.none,
            hintText: "Enter Remarks",
            hintStyle: TextStyle(color: Colors.grey),
            // prefixIcon: Icon(
            //   Icons.send,
            //   color: Colors.white,
            // ),
          ),
          style: Theme.of(context).textTheme.bodyText1,
          cursorColor: Colors.white,
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
