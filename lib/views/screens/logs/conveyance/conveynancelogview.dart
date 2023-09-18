import 'dart:io';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:chip_list/chip_list.dart';
import 'package:claimz/viewModel/claimzFormIndividualViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ConvenyanceLogsViews extends StatefulWidget {
  final Map<String, dynamic> data;

  @override
  State<ConvenyanceLogsViews> createState() => ConvenyanceLogsViewsState();

  ConvenyanceLogsViews(this.data);
}

class ConvenyanceLogsViewsState extends State<ConvenyanceLogsViews>
    with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();

  XFile? _ie_file;
  late TransformationController controller;
  late AnimationController animationController;
  Animation<Matrix4>? animation;
  OverlayEntry? entry;

  TextEditingController meet_to = TextEditingController();
  TextEditingController feedback = TextEditingController();
  TextEditingController purpose = TextEditingController();

  TextEditingController serviceprovider = TextEditingController();
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  TextEditingController departure = TextEditingController();
  TextEditingController return_travel = TextEditingController();
  TextEditingController tfrom_date = TextEditingController();
  TextEditingController tto_date = TextEditingController();
  TextEditingController tclaim_date = TextEditingController();
  TextEditingController tfrom_time = TextEditingController();
  TextEditingController tto_time = TextEditingController();
  TextEditingController tgst_no = TextEditingController();
  TextEditingController tgst_amount = TextEditingController();
  TextEditingController tbasic_amount = TextEditingController();
  TextEditingController tclaim_amount = TextEditingController();
  TextEditingController texchangerate = TextEditingController();
  TextEditingController distanceTravelled = TextEditingController();
  TextEditingController tBillNo = TextEditingController();
  var travelLimit;
  var foodLimit;
  var incidentalLimit;

  XFile? tfile;
  XFile? torgfile;
  String? tfile_link;
  TextEditingController _place = TextEditingController();

  TextEditingController fserviceprovider = TextEditingController();
  TextEditingController ffrom = TextEditingController();
  TextEditingController fto = TextEditingController();
  TextEditingController ffrom_date = TextEditingController();
  TextEditingController fto_date = TextEditingController();
  TextEditingController fclaim_date = TextEditingController();
  TextEditingController ffrom_time = TextEditingController();
  TextEditingController fto_time = TextEditingController();
  TextEditingController fgst_no = TextEditingController();
  TextEditingController fgst_amount = TextEditingController();
  TextEditingController fbasic_amount = TextEditingController();
  TextEditingController fclaim_amount = TextEditingController();
  TextEditingController fexchangerate = TextEditingController();
  TextEditingController fBillNo = TextEditingController();

  XFile? ffile;
  XFile? forgfile;
  String? ffile_link;

  TextEditingController iserviceprovider = TextEditingController();
  TextEditingController ipurchase = TextEditingController();
  TextEditingController ifrom = TextEditingController();
  TextEditingController ito = TextEditingController();
  TextEditingController ifrom_date = TextEditingController();
  TextEditingController ito_date = TextEditingController();
  TextEditingController iclaim_date = TextEditingController();
  TextEditingController ifrom_time = TextEditingController();
  TextEditingController ito_time = TextEditingController();
  TextEditingController igst_no = TextEditingController();
  TextEditingController igst_amount = TextEditingController();
  TextEditingController ibasic_amount = TextEditingController();
  TextEditingController iclaim_amount = TextEditingController();
  TextEditingController iexchangerate = TextEditingController();
  TextEditingController iBillNo = TextEditingController();

  XFile? ifile;
  XFile? iorgfile;
  String? ifile_link;

  // i.XFile? _ie_file;
  int _selection = 1;
  String selected_mode = '', selected_accomondation = '';
  int travelModeId = 1;
  // TravelViewModel _iternaryDetails =  TravelViewModel();
  // TravelViewModel _travel_details =  TravelViewModel();

  double _final_amount = 0.0;
  double _travel_amount = 0.0;
  double _accomodation_amount = 0.0;
  double _food_amount = 0.0;
  double _local_amount = 0.0;
  double _incidental_amount = 0.0;
  String doc_no = "null";
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateTime? _dateTime;
  TimeOfDay timeFrom = TimeOfDay.now();
  String time_day = '';
  int page_load = 0;

  TimeOfDay _timeFrom = TimeOfDay.now();
  String _time_day = '';
  var kGoogleApiKey = "AIzaSyDJJ7rw4YTPHxvD1KuReHoQ-ja2VT3Sp18";
  late LatLng myLocation;
  String _to_lat = "";
  String _to_long = "";
  String _duration = "";
  String _distance = "";
  bool isClicked = false;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState

    feedback.text = widget.data['remarks'] ?? "no remarks";
    tclaim_date.text = widget.data['date'];
    from.text = widget.data['from'];
    to.text = widget.data['to'];

    fclaim_date.text = widget.data['date'];
    iclaim_date.text = widget.data['date'];

    Provider.of<ClaimzFormIndividualViewModel>(context as BuildContext,
            listen: false)
        .getClaimzLimit(widget.data['doc_no'], context as BuildContext)
        .then((value) {
      Provider.of<ClaimzFormIndividualViewModel>(context as BuildContext,
              listen: false)
          .getConveyanceDetails(context as BuildContext, widget.data['doc_no'])
          .then((_) {
        setState(() {
          isLoading = false;
          final providerLimit = Provider.of<ClaimzFormIndividualViewModel>(
                  context as BuildContext,
                  listen: false)
              .limit;

          final details = Provider.of<ClaimzFormIndividualViewModel>(
                  context as BuildContext,
                  listen: false)
              .claimzForm;

          travelLimit = providerLimit['travel'][0]['limit_per_km'];
          foodLimit = providerLimit['food'][0]['limit'];
          incidentalLimit = providerLimit['incidental'][0]['limit'];

          print('INIIIIIIIIIIT: $travelLimit');
          print('FOOOOOOOOOD: $travelLimit');
          print('INCIDENNNNNTALLLLLLLLL: $travelLimit');

          if (!details['data'].containsKey('travel') ||
              !details['data'].containsKey('food') ||
              !details['data'].containsKey('incidental')) {
            serviceprovider.text = '';
            departure.text = '';
            return_travel.text = '';
            tfrom_date.text = '';
            tto_date.text = '';

            tfrom_time.text = '';
            tto_time.text = '';
            tgst_no.text = '';
            tgst_amount.text = '';
            tbasic_amount.text = '';
            tclaim_amount.text = '';
            texchangerate.text = '';
            distanceTravelled.text = '';
            tBillNo.text = '';
            tfile_link = '';

            fserviceprovider.text = '';
            ffrom.text = '';
            fto.text = '';
            ffrom_date.text = '';
            fto_date.text = '';

            ffrom_time.text = '';
            fto_time.text = '';
            fgst_no.text = '';
            fgst_amount.text = '';
            fbasic_amount.text = '';
            fclaim_amount.text = '';
            fexchangerate.text = '';
            fBillNo.text = '';
            ffile_link = '';

            iserviceprovider.text = '';
            ifrom.text = '';
            ito.text = '';
            ifrom_date.text = '';
            ito_date.text = '';

            ifrom_time.text = '';
            ito_time.text = '';
            igst_no.text = '';
            igst_amount.text = '';
            ibasic_amount.text = '';
            iclaim_amount.text = '';
            iexchangerate.text = '';
            iBillNo.text = '';
            ifile_link = '';
          }
          if (details['data'].containsKey('travel')) {
            serviceprovider.text =
                details['data']['travel']['service_provider'];
            tgst_no.text = details['data']['travel']['GST_no'].toString();
            tgst_amount.text =
                details['data']['travel']['GST_amount'].toString();
            tbasic_amount.text =
                details['data']['travel']['basic_amount'].toString();
            tclaim_amount.text =
                details['data']['travel']['total_amount'].toString();
            distanceTravelled.text =
                details['data']['travel']['distance'].toString();
            tBillNo.text = details['data']['travel']['bill_no'].toString();
            tfile_link = details['data']['travel']['attachment'] == null ||
                    details['data']['travel']['attachment'] ==
                        'https://claimz.vitwo.in/public/pdf/'
                ? ''
                : 'https://claimz.vitwo.in/public/pdf/${details['data']['travel']['attachment']}';

            setState(() {
              _finalSum("travel", details.toString(), tclaim_amount.text);
            });
          }
          if (details['data'].containsKey('food')) {
            fserviceprovider.text = details['data']['food']['service_provider'];
            fgst_no.text = details['data']['food']['GST_no'].toString();
            fgst_amount.text = details['data']['food']['GST_amount'].toString();
            fbasic_amount.text =
                details['data']['food']['basic_amount'].toString();
            fclaim_amount.text =
                details['data']['food']['total_amount'].toString();
            fBillNo.text = details['data']['food']['bill_no'].toString();
            ffile_link = details['data']['food']['attachment'] == null
                ? ''
                : 'https://claimz.vitwo.in/public/pdf/${details['data']['food']['attachment']}';

            setState(() {
              _finalSum("food", details.toString(), fclaim_amount.text);
            });
          }
          if (details['data'].containsKey('incidental')) {
            iserviceprovider.text =
                details['data']['incidental']['service_provider'];
            igst_no.text = details['data']['incidental']['GST_no'].toString();
            igst_amount.text =
                details['data']['incidental']['GST_amount'].toString();
            ibasic_amount.text =
                details['data']['incidental']['basic_amount'].toString();
            iclaim_amount.text =
                details['data']['incidental']['total_amount'].toString();
            iBillNo.text = details['data']['incidental']['bill_no'].toString();
            ifile_link = details['data']['incidental']['attachment'] == null
                ? ''
                : 'https://claimz.vitwo.in/public/pdf/${details['data']['incidental']['attachment']}';

            setState(() {
              _finalSum("incidental", details.toString(), iclaim_amount.text);
            });
          }
        });
      });
    });

    // final providerLimit =
    //     Provider.of<ClaimzFormIndividualViewModel>(context, listen: false)
    //         .limit;

    // travelLimit = providerLimit['travel'][0]['limit_per_km'];

    super.initState();

    controller = TransformationController();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() => controller.value = animation!.value);

    // Map data_iternary = {
    //   "doc_no": widget.args["doc"].toString(),
    //   "all": widget.args["all"].toString(),
    // };
    // print(data_iternary);
    // _iternaryDetails.postTravelIternary(data_iternary);

    // if (widget.args["doc"].toString() != null) {
    //   _travel_details.postTravelDoc(data_iternary);
    // }

//adding listners

    // tclaim_amount.addListener(() {
    //   _travel_amount =  double.parse(tclaim_amount.text);
    //   setState(() {
    //     if(tclaim_amount.text==""){
    //       _final_amount = 0.0;
    //     }
    //
    //     _final_amount = _travel_amount;
    //
    //
    //   });
    // });

    // tclaim_amount.addListener(() {
    //   _travel_amount = double.parse(tclaim_amount.text);
    //   setState(() {
    //     if (tclaim_amount.text == "") {
    //       _final_amount = 0.0;
    //     }
    //
    //     _final_amount = _travel_amount;
    //   });
    // });

    // doc_no = widget.args["doc"].toString();

    // if (doc_no != "null") {
    //   _travel_details.postTravelDoc(widget.args);
    // }
  }

  int _mode_of_travel = 0;
  final List<String> clipstyle = [
    'Business',
    'Economic',
    'AC III',
    'AC II',
    'AC I',
    'SL',
    'Chair'
  ];
  int _mode_of_acco = 0;
  final List<String> cliphotel = [
    'Hotel',
  ];

  var mydata = "One way";
  List<String> datatrip = [
    "One way",
    "Roundtrip",
  ];
  int? role;

  var details = "Paid by company";
  var adetails = "Paid by company";
  var fdetails = "Paid by company";
  var idetails = "Paid by company";
  var ldetails = "Paid by company";

  List<String> detail = [
    "Paid by company",
    "Paid by self",
  ];
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ClaimzFormIndividualViewModel>(context).modeOfTravel;

    final providerLimit =
        Provider.of<ClaimzFormIndividualViewModel>(context).limit;

    final conveyanceDetails =
        Provider.of<ClaimzFormIndividualViewModel>(context).claimzForm;

    final travelDetails =
        Provider.of<ClaimzFormIndividualViewModel>(context).travelDetails;
    final foodDetails =
        Provider.of<ClaimzFormIndividualViewModel>(context).foodDetails;
    final incidentalDetails =
        Provider.of<ClaimzFormIndividualViewModel>(context).incidentalDetails;

    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: [
              Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: Column(
                  children: <Widget>[
                    Padding(
                      //box
                      padding: EdgeInsets.only(
                        top: SizeVariables.getHeight(context) * 0.05,
                        left: SizeVariables.getWidth(context) * 0.04,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/back button.svg",
                                ),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Convenyance Claim Form',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          fontSize: 16, color: Colors.grey),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.08,
                                ),
                                child: Row(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Icon(
                                        Icons.file_open_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                    SizedBox(
                                        width: SizeVariables.getWidth(context) *
                                            0.02),
                                    FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        widget.data['doc_no'].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.amber,
                                                fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.05,
                              right: SizeVariables.getWidth(context) * 0.1,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.03,
                                    ),
                                    child: const Text(
                                      '₹',
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xffF59F23),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: SizeVariables.getWidth(context) * 0.02,
                                  // ),
                                  Container(
                                    // padding: EdgeInsets.only(
                                    //   right: SizeVariables.getWidth(context)*0.3,
                                    // ),
                                    child: Text(
                                      _final_amount.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            fontSize: 30,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.02,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selection = 1;
                                    Map data = {
                                      "month": "",
                                      "type": "incidental",
                                      "year": "",
                                      "user_id": "",
                                      "all": "1" //self
                                    };
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 3,
                                    ),
                                  ),
                                  child: RippleAnimation(
                                    repeat: true,
                                    color: Colors.grey,
                                    minRadius: 29,
                                    ripplesCount: 1,
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            child: SvgPicture.asset(
                                              "assets/travelIcon/Information.svg",
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.03,
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.02,
                                            ),
                                          ),
                                          // SizedBox(
                                          //     height:
                                          //     SizeVariables.getHeight(context) *
                                          //         0.007),
                                          // FittedBox(
                                          //   fit: BoxFit.contain,
                                          //   child: Text(
                                          //     'Info.',
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .bodyText1,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      SizeVariables.getWidth(context) * 0.045),
                              Container(
                                // color: Colors.pink,
                                width: SizeVariables.getWidth(context) * 0.77,
                                height: SizeVariables.getHeight(context) * 0.1,
                                // color: Colors.pink,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: _selection == 0
                                            ? Colors.amber
                                            : Colors.black,
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(3),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selection = 0;
                                          Map data = {
                                            "month": "",
                                            "type": "Travel",
                                            "year": "",
                                            "user_id": "",
                                            "all": "1" //self
                                          };
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              // color: Colors.orangeAccent,
                                              blurRadius: 2.0,
                                              offset: const Offset(0.0, 2.0),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white24,
                                          radius: 30,
                                          // color: Colors.pink,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: SizeVariables.getHeight(
                                                          context) *
                                                      0.015,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/travelIcon/flightbus.svg",
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.035,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.05,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeVariables.getHeight(context) *
                                          0.025,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(3),
                                        primary: _selection == 3
                                            ? Colors.amber
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selection = 3;
                                          Map data = {
                                            "month": "",
                                            "type": "Food",
                                            "year": "",
                                            "user_id": "",
                                            "all": "3" //self
                                          };
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                              // color: Colors.orangeAccent,
                                              blurRadius: 2.0,
                                              offset: const Offset(0.0, 2.0),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white24,
                                          radius: 30,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: SizeVariables.getHeight(
                                                          context) *
                                                      0.015,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/travelIcon/Food.svg",
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.035,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.05,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeVariables.getHeight(context) *
                                          0.025,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                        padding: EdgeInsets.all(3),
                                        primary: _selection == 5
                                            ? Colors.amber
                                            : Colors.black,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _selection = 5;
                                          Map data = {
                                            "month": "",
                                            "type": "incidental",
                                            "year": "",
                                            "user_id": "",
                                            "all": "5" //self
                                          };
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                              // color: Colors.orangeAccent,
                                              blurRadius: 2.0,
                                              offset: const Offset(0.0, 2.0),
                                            ),
                                          ],
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white24,
                                          radius: 30,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: SizeVariables.getHeight(
                                                          context) *
                                                      0.016,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/travelIcon/incidentals.svg",
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.035,
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.05,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.02,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Container(
                          // color: Colors.pink,
                          decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.only(
                              //   topRight: Radius.circular(20),
                              //   topLeft: Radius.circular(20),
                              //   // bottomLeft: Radius.circular(40),
                              //   // bottomRight: Radius.circular(40),
                              // ),
                              color: Color.fromARGB(239, 228, 226, 226)),
                          child: ListView(
                            children: [
                              _selection == 1
                                  ?
                                  // _infotab(valuex.iternaryDetails!.data!.data!.meetingDetails,
                                  //     valuex.iternaryDetails!.data!.data!.approvalLog)
                                  _infotab(conveyanceDetails)
                                  : SizedBox(),
                              _selection == 0
                                  ? _traveltab(provider, providerLimit,
                                      widget.data['doc_no'], travelDetails)
                                  : SizedBox(),
                              // _selection == 2 ? _accomondationtab() : SizedBox(),
                              _selection == 3
                                  ? _foodtab(providerLimit,
                                      widget.data['doc_no'], foodDetails)
                                  : SizedBox(),
                              // _selection == 4 ? _localtab() : SizedBox(),
                              _selection == 5
                                  ? _incidentaltab(providerLimit,
                                      widget.data['doc_no'], incidentalDetails)
                                  : SizedBox(),
                              SizedBox(
                                height: SizeVariables.getHeight(context) * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }

  _infotab(Map<String, dynamic> conveyanceDetails) {
    // if (doc_no != null) {
    //   // List<MeetingDetails>? meetingDetails,List<ApprovalLog>? approvalLog
    //   // meet_to.text = meetingDetails![0].metWhom.toString();
    // }
    return Padding(
      // info
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: SizeVariables.getHeight(context) * 0.02,
                            left: SizeVariables.getWidth(context) * 0.054,
                          ),
                          // color: Colors.amber,
                          child: Text(
                            'Meeting details',
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.account_circle_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.3,
                                // width: 300,
                                // height: 200,
                                child: TextFormField(
                                  controller: meet_to,
                                  keyboardType: TextInputType.text,
                                  readOnly: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? true
                                      : false,
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 167, 164, 164)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 194, 191, 191)),
                                    ),
                                    // border: InputBorder.none,
                                    labelText: 'Meet to whom',
                                    // hintText: "From",
                                    // hintStyle: Theme.of(context)
                                    //     .textTheme
                                    //     .bodyText2!
                                    //     .copyWith(color: Colors.grey),
                                    labelStyle:
                                        Theme.of(context as BuildContext)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 16,
                                                color: Colors.black),
                                  ),
                                  style: Theme.of(context as BuildContext)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                  showCursor: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? false
                                      : true,
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // color: Colors.blue,
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.book_online_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.3,
                                // width: 300,
                                // height: 200,
                                child: TextFormField(
                                  controller: feedback,
                                  keyboardType: TextInputType.text,
                                  readOnly: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? true
                                      : false,
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 167, 164, 164)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 194, 191, 191)),
                                    ),
                                    // border: InputBorder.none,
                                    labelText: 'Feedback',
                                    // hintText: "To",
                                    // hintStyle: Theme.of(context)
                                    //     .textTheme
                                    //     .bodyText2!
                                    //     .copyWith(color: Colors.grey),
                                    labelStyle:
                                        Theme.of(context as BuildContext)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 16,
                                                color: Colors.black),
                                  ),
                                  style: Theme.of(context as BuildContext)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                  showCursor: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? false
                                      : true,
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.035,
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.handshake_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            width: SizeVariables.getWidth(context) * 0.8,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              controller: purpose,
                              keyboardType: TextInputType.text,
                              readOnly: widget.data['status'] == 1 ||
                                      widget.data['status'] == 4
                                  ? true
                                  : false,
                              decoration: InputDecoration(
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 167, 164, 164)),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color:
                                          Color.fromARGB(255, 194, 191, 191)),
                                ),
                                // border: InputBorder.none,
                                labelText: 'Purpose',
                                // hintText: "To",
                                // hintStyle: Theme.of(context)
                                //     .textTheme
                                //     .bodyText2!
                                //     .copyWith(color: Colors.grey),
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 16, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: widget.data['status'] == 1 ||
                                      widget.data['status'] == 4
                                  ? false
                                  : true,
                              cursorColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.02,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.02),
            widget.data['status'] == -1
                ? Container()
                : Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.05,
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Approval Status',
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
            widget.data['status'] == -1
                ? Container()
                : Container(
                    height: SizeVariables.getHeight(context) * 1,
                    child: Scrollbar(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // itemCount: approvalLog!.length,
                        itemCount:
                            conveyanceDetails['data']['reason_log'].length,

                        itemBuilder: (context, index) {
                          return Container(
                            height: 250,
                            child: TimelineTile(
                              endChild: Container(
                                padding: EdgeInsets.only(
                                  top: SizeVariables.getHeight(context) * 0.03,
                                ),
                                // color: Color.fromARGB(239, 228, 226, 226),
                                // height: 50,
                                child: Accordion(
                                  disableScrolling: true,
                                  // maxOpenSections: 1,
                                  headerBackgroundColorOpened:
                                      Color.fromARGB(239, 228, 226, 226),
                                  scaleWhenAnimating: true,
                                  openAndCloseAnimation: true,
                                  headerPadding: const EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 15),
                                  sectionOpeningHapticFeedback:
                                      SectionHapticFeedback.heavy,
                                  sectionClosingHapticFeedback:
                                      SectionHapticFeedback.light,
                                  children: [
                                    AccordionSection(
                                      contentBackgroundColor:
                                          Color.fromARGB(239, 228, 226, 226),
                                      // isO?pen: true,

                                      headerBackgroundColor:
                                          Color.fromARGB(239, 228, 226, 226),
                                      headerBackgroundColorOpened:
                                          Color.fromARGB(239, 228, 226, 226),
                                      contentBorderColor:
                                          Color.fromARGB(239, 228, 226, 226),
                                      header: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Icon(
                                                  Icons.currency_rupee_outlined,
                                                  color: Colors.black,
                                                  size: 18,
                                                ),
                                              ),
                                              FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  '₹${conveyanceDetails['data']['reason_log'][index]['sum']}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              color: Color(0xfffe2f6ed),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                  right: 5.0,
                                                  top: 2.5,
                                                  bottom: 2.5),
                                              child: Center(
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    conveyanceDetails['data']
                                                            ['reason_log']
                                                        [index]['status'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: Color(
                                                                0xfff26af48),
                                                            fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      content: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 3,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.54,
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      conveyanceDetails['data']
                                                              ['reason_log']
                                                          [index]['remarks'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  conveyanceDetails['data']
                                                          ['reason_log'][index]
                                                      ['emp_name'],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 2,
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.6,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.007,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      conveyanceDetails['data']
                                                                  ['reason_log']
                                                              [index]
                                                          ['approved_at'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                            color: Colors.black,
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
                                      contentHorizontalPadding: 20,
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
          ],
        ),
      ),
    );
  }

  _traveltab(List<String> modeOfTravel, Map<String, dynamic> providerLimit,
      String docNo, List<dynamic> travelDetails) {
    return Padding(
      //travel
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: SizeVariables.getHeight(context) * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: Colors.red,
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
              child: Container(
                // color: Colors.amber,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.04,
                            top: SizeVariables.getHeight(context) * 0.02,
                          ),
                          // color: Colors.amber,
                          child: Text(
                            'Travel itinerary',
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black, fontSize: 20),
                          ),
                        ),
                        widget.data['status'] == 1 || widget.data['status'] == 4
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  _upload("travel", context as BuildContext);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: SizeVariables.getWidth(context) * 0.4,
                                    top: SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  child: Icon(
                                    Icons.arrow_circle_up_outlined,
                                    size: 40,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.03,
                      ),
                      // color: Colors.amber,
                      child: ChipList(
                          listOfChipNames: modeOfTravel,
                          activeBgColorList: [Colors.black],
                          inactiveBgColorList: [Colors.white],
                          activeTextColorList: [Colors.white],
                          inactiveTextColorList: [Colors.black],
                          listOfChipIndicesCurrentlySeclected: [
                            _mode_of_travel
                          ],
                          inactiveBorderColorList: [Colors.black],
                          extraOnToggle: (val) {
                            setState(() {
                              _mode_of_travel = val;

                              print('MODE OF TRAVEL ID: $_mode_of_travel');

                              selected_mode = modeOfTravel[val];
                            });
                            for (int i = 0;
                                i < providerLimit['travel'].length;
                                i++) {
                              if (selected_mode ==
                                  providerLimit['travel'][i]
                                      ['component_name']) {
                                setState(() {
                                  travelLimit = providerLimit['travel'][i]
                                      ['limit_per_km'];
                                  travelModeId = providerLimit['travel'][i]
                                      ['conveyance_id'];
                                });
                                print('Travel Limit: $travelLimit');
                                print('Travel ID: $travelModeId');
                              }
                            }
                            print('Selected Mode Of Travel: $selected_mode');
                          }),
                    ),
                    selected_mode == 'Public Transport'
                        ? Container(
                            padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.05),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child: Icon(Icons.handshake_outlined),
                                    ),
                                    SizedBox(
                                      width: SizeVariables.getWidth(context) *
                                          0.02,
                                    ),
                                    Container(
                                      width: SizeVariables.getWidth(context) *
                                          0.78,
                                      // width: 300,
                                      // height: 200,
                                      child: TextFormField(
                                        controller: serviceprovider,
                                        keyboardType: TextInputType.text,
                                        readOnly: widget.data['status'] == 1 ||
                                                widget.data['status'] == 4
                                            ? true
                                            : false,
                                        decoration: InputDecoration(
                                          // focusColor: Colors.black,
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
                                          labelText: 'Name of Provider',
                                          // hintText: "To",
                                          // hintStyle: Theme.of(context)
                                          //     .textTheme
                                          //     .bodyText2!
                                          //     .copyWith(color: Colors.grey),
                                          labelStyle:
                                              Theme.of(context as BuildContext)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 20,
                                                      color: Colors.black),
                                        ),
                                        style: Theme.of(context as BuildContext)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(color: Colors.black),
                                        showCursor:
                                            widget.data['status'] == 1 ||
                                                    widget.data['status'] == 4
                                                ? false
                                                : true,
                                        cursorColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.location_on_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.3,
                                // width: 300,
                                // height: 200,
                                child: TextFormField(
                                  controller: from,
                                  keyboardType: TextInputType.text,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 167, 164, 164)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 194, 191, 191)),
                                    ),
                                    // border: InputBorder.none,
                                    labelText: 'From',
                                    // hintText: "From",
                                    // hintStyle: Theme.of(context)
                                    //     .textTheme
                                    //     .bodyText2!
                                    //     .copyWith(color: Colors.grey),
                                    labelStyle:
                                        Theme.of(context as BuildContext)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 18,
                                                color: Colors.black),
                                  ),
                                  onTap: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? () {}
                                      : () async {
                                          await PlacesAutocomplete.show(
                                            context: context as BuildContext,
                                            radius: 10000000,
                                            logo: Text(""),
                                            types: [],
                                            strictbounds: false,
                                            apiKey: kGoogleApiKey,
                                            mode: Mode.overlay,
                                            language: "en",
                                            components: [
                                              // Component(Component.country, "in"),
                                              // Component(Component.country, "in"),
                                            ],
                                          ).then((value) {
                                            String p =
                                                value!.placeId.toString();
                                            displayPrediction(p, from);
                                          });
                                        },
                                  style: Theme.of(context as BuildContext)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                  showCursor: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? false
                                      : true,
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              child: Icon(Icons.location_on_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.02,
                            ),
                            Container(
                              width: SizeVariables.getWidth(context) * 0.3,
                              // width: 300,
                              // height: 200,
                              child: TextFormField(
                                controller: to,
                                readOnly: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 167, 164, 164)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 194, 191, 191)),
                                  ),
                                  // border: InputBorder.none,
                                  labelText: 'To',
                                  // hintText: "To",
                                  // hintStyle: Theme.of(context)
                                  //     .textTheme
                                  //     .bodyText2!
                                  //     .copyWith(color: Colors.grey),
                                  labelStyle: Theme.of(context as BuildContext)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontSize: 18, color: Colors.black),
                                ),
                                onTap: widget.data['status'] == 1 ||
                                        widget.data['status'] == 4
                                    ? () {}
                                    : () async {
                                        await PlacesAutocomplete.show(
                                          context: context as BuildContext,
                                          radius: 10000000,
                                          logo: Text(""),
                                          types: [],
                                          strictbounds: false,
                                          apiKey: kGoogleApiKey,
                                          mode: Mode.overlay,
                                          language: "en",
                                          components: [
                                            Component(Component.country, "in")
                                          ],
                                        ).then((value) {
                                          String p = value!.placeId.toString();
                                          displayPrediction(p, to);
                                        });
                                      },
                                style: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(color: Colors.black),
                                showCursor: widget.data['status'] == 1 ||
                                        widget.data['status'] == 4
                                    ? false
                                    : true,
                                cursorColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        isClicked == false
                            ? Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Container(
                                  color: Colors.blue,
                                ))
                            : Container(
                                padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.1,
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDatePicker(
                                                builder: (context, child) =>
                                                    Theme(
                                                      data:
                                                          ThemeData().copyWith(
                                                        colorScheme:
                                                            ColorScheme.dark(
                                                          primary:
                                                              Color(0xffF59F23),
                                                          surface: Colors.black,
                                                          onSurface:
                                                              Colors.white,
                                                        ),
                                                        dialogBackgroundColor:
                                                            Color.fromARGB(255,
                                                                91, 91, 91),
                                                      ),
                                                      child: child!,
                                                    ),
                                                context:
                                                    context as BuildContext,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2015),
                                                lastDate: DateTime.now())
                                            .then((value) {
                                          setState(() {
                                            // _dateTimeStart = value;
                                            return_travel.text = dateFormat
                                                .format(DateTime.parse(
                                                    value.toString()));
                                          });
                                          // print('DATE START: $_dateTimeStart');
                                        });
                                      },
                                      child: Container(
                                        child:
                                            Icon(Icons.calendar_month_outlined),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeVariables.getWidth(context) *
                                          0.02,
                                    ),
                                    Container(
                                      width:
                                          SizeVariables.getWidth(context) * 0.3,
                                      // width: 300,
                                      // height: 200,
                                      child: TextFormField(
                                        onTap: () {
                                          showDatePicker(
                                                  builder: (context, child) =>
                                                      Theme(
                                                        data: ThemeData()
                                                            .copyWith(
                                                          colorScheme:
                                                              ColorScheme.dark(
                                                            primary: Color(
                                                                0xffF59F23),
                                                            surface:
                                                                Colors.black,
                                                            onSurface:
                                                                Colors.white,
                                                          ),
                                                          dialogBackgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  91,
                                                                  91,
                                                                  91),
                                                        ),
                                                        child: child!,
                                                      ),
                                                  context:
                                                      context as BuildContext,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2015),
                                                  lastDate: DateTime.now())
                                              .then((value) {
                                            setState(() {
                                              // _dateTimeStart = value;
                                              return_travel.text = dateFormat
                                                  .format(DateTime.parse(
                                                      value.toString()));
                                            });
                                            // print('DATE START: $_dateTimeStart');
                                          });
                                        },
                                        readOnly: true,
                                        controller: return_travel,
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
                                          labelText: 'Return',
                                          // hintText: "To",
                                          // hintStyle: Theme.of(context)
                                          //     .textTheme
                                          //     .bodyText2!
                                          //     .copyWith(color: Colors.grey),
                                          labelStyle:
                                              Theme.of(context as BuildContext)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                        ),
                                        style: Theme.of(context as BuildContext)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(color: Colors.black),
                                        showCursor: true,
                                        cursorColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.04,
                            top: SizeVariables.getHeight(context) * 0.02,
                          ),
                          // color: Colors.amber,
                          child: Text(
                            'Claim',
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.05,
                          ),
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.calendar_month_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.78,
                                // width: 300,
                                // height: 200,
                                child: TextFormField(
                                  // onTap: () {
                                  //   showDatePicker(
                                  //           builder: (context, child) => Theme(
                                  //                 data: ThemeData().copyWith(
                                  //                   colorScheme: ColorScheme.dark(
                                  //                     primary: Color(0xffF59F23),
                                  //                     surface: Colors.black,
                                  //                     onSurface: Colors.white,
                                  //                   ),
                                  //                   dialogBackgroundColor:
                                  //                       Color.fromARGB(
                                  //                           255, 91, 91, 91),
                                  //                 ),
                                  //                 child: child!,
                                  //               ),
                                  //           context: context,
                                  //           initialDate: DateTime.now(),
                                  //           firstDate: DateTime(2015),
                                  //           lastDate: DateTime.now()
                                  //               .add(const Duration(days: 365)))
                                  //       .then((value) {
                                  //     setState(() {
                                  //       // _dateTimeStart = value;
                                  //       tclaim_date.text = dateFormat
                                  //           .format(DateTime.parse(value.toString()));
                                  //     });
                                  //     // print('DATE START: $_dateTimeStart');
                                  //   });
                                  // },
                                  readOnly: true,
                                  controller: tclaim_date,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 167, 164, 164)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 194, 191, 191)),
                                    ),
                                    // border: InputBorder.none,
                                    labelText: 'Doc date',
                                    // hintText: "From",
                                    // hintStyle: Theme.of(context)
                                    //     .textTheme
                                    //     .bodyText2!
                                    //     .copyWith(color: Colors.grey),
                                    labelStyle:
                                        Theme.of(context as BuildContext)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 18,
                                                color: Colors.black),
                                  ),
                                  style: Theme.of(context as BuildContext)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                  showCursor: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? false
                                      : true,
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    selected_mode != 'Public Transport'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      child: const Icon(
                                          Icons.multiple_stop_outlined),
                                    ),
                                    SizedBox(
                                      width: SizeVariables.getWidth(context) *
                                          0.02,
                                    ),
                                    Container(
                                      width:
                                          SizeVariables.getWidth(context) * 0.3,
                                      // width: 300,
                                      // height: 200,
                                      child: TextFormField(
                                        controller: distanceTravelled,
                                        readOnly: widget.data['status'] == 1 ||
                                                widget.data['status'] == 4
                                            ? true
                                            : false,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(15),
                                        ],
                                        onChanged: (_) {
                                          if (distanceTravelled.text == '') {
                                            setState(() {
                                              tclaim_amount.text = '0.0';
                                              tbasic_amount.text = '';
                                            });
                                            setState(() {
                                              //_final_amount = double.parse(tclaim_amount.text);

                                              _finalSum(
                                                  "travel",
                                                  details.toString(),
                                                  tclaim_amount.text);
                                            });
                                          } else {
                                            setState(() {
                                              tclaim_amount.text =
                                                  (double.parse(
                                                              distanceTravelled
                                                                  .text) *
                                                          travelLimit)
                                                      .toString();
                                              tbasic_amount.text =
                                                  (double.parse(
                                                              distanceTravelled
                                                                  .text) *
                                                          travelLimit)
                                                      .toString();
                                            });
                                            setState(() {
                                              //_final_amount = double.parse(tclaim_amount.text);

                                              _finalSum(
                                                  "travel",
                                                  details.toString(),
                                                  tclaim_amount.text);
                                            });
                                          }
                                        },
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
                                          labelText: 'Distance In Km',
                                          // hintText: "From",
                                          // hintStyle: Theme.of(context)
                                          //     .textTheme
                                          //     .bodyText2!
                                          //     .copyWith(color: Colors.grey),
                                          labelStyle:
                                              Theme.of(context as BuildContext)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                        ),
                                        style: Theme.of(context as BuildContext)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(color: Colors.black),
                                        showCursor:
                                            widget.data['status'] == 1 ||
                                                    widget.data['status'] == 4
                                                ? false
                                                : true,
                                        cursorColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.currency_rupee_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.02,
                                  ),
                                  Container(
                                    width:
                                        SizeVariables.getWidth(context) * 0.3,
                                    // width: 300,
                                    // height: 200,
                                    child: TextFormField(
                                      controller: tbasic_amount,
                                      onChanged: (_) {
                                        if (tbasic_amount.text == '') {
                                          setState(() {
                                            tclaim_amount.text = '0.0';
                                          });
                                        } else {
                                          setState(() {
                                            tclaim_amount.text = (double.parse(
                                                        tbasic_amount.text) *
                                                    100.0)
                                                .toString();
                                          });
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      readOnly: widget.data['status'] == 1 ||
                                              widget.data['status'] == 4
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
                                        labelText: 'Claim Amount',
                                        // hintText: "To",
                                        // hintStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyText2!
                                        //     .copyWith(color: Colors.grey),
                                        labelStyle:
                                            Theme.of(context as BuildContext)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                      ),
                                      style: Theme.of(context as BuildContext)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(color: Colors.black),
                                      showCursor: widget.data['status'] == 1 ||
                                              widget.data['status'] == 4
                                          ? false
                                          : true,
                                      cursorColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Container(
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeVariables.getWidth(context) *
                                                  0.048),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: const Icon(Icons.receipt),
                                          ),
                                          SizedBox(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.02,
                                          ),
                                          Container(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.76,
                                            // width: 300,
                                            // height: 200,
                                            child: TextFormField(
                                              controller: tBillNo,
                                              readOnly: widget.data['status'] ==
                                                          1 ||
                                                      widget.data['status'] == 4
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
                                                labelText: 'Bill No',
                                                // hintText: "From",
                                                // hintStyle: Theme.of(context)
                                                //     .textTheme
                                                //     .bodyText2!
                                                //     .copyWith(color: Colors.grey),
                                                labelStyle: Theme.of(
                                                        context as BuildContext)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontSize: 18,
                                                        color: Colors.black),
                                              ),
                                              style: Theme.of(
                                                      context as BuildContext)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black),
                                              showCursor: true,
                                              cursorColor: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  // color: Colors.green,
                                  padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.05),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: const Icon(
                                            Icons.multiple_stop_outlined),
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
                                          controller: distanceTravelled,
                                          readOnly:
                                              widget.data['status'] == 1 ||
                                                      widget.data['status'] == 4
                                                  ? true
                                                  : false,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                15),
                                          ],
                                          onChanged: (_) {
                                            if (distanceTravelled.text == '') {
                                              setState(() {
                                                tclaim_amount.text = '0.0';
                                                tbasic_amount.text = '';
                                              });
                                              setState(() {
                                                //_final_amount = double.parse(tclaim_amount.text);

                                                _finalSum(
                                                    "travel",
                                                    details.toString(),
                                                    tclaim_amount.text);
                                              });
                                            } else if (distanceTravelled.text ==
                                                    '' &&
                                                tgst_amount.text != '') {
                                              setState(() {
                                                tclaim_amount.text =
                                                    double.parse(
                                                            tgst_amount.text)
                                                        .toString();
                                                tbasic_amount.text = '';
                                              });
                                              setState(() {
                                                //_final_amount = double.parse(tclaim_amount.text);

                                                _finalSum(
                                                    "travel",
                                                    details.toString(),
                                                    tclaim_amount.text);
                                              });
                                            } else {
                                              setState(() {
                                                tclaim_amount
                                                    .text = (double.parse(
                                                            distanceTravelled
                                                                .text) *
                                                        travelLimit)
                                                    .toString();
                                                tbasic_amount
                                                    .text = (double.parse(
                                                            distanceTravelled
                                                                .text) *
                                                        travelLimit)
                                                    .toString();
                                              });
                                              setState(() {
                                                //_final_amount = double.parse(tclaim_amount.text);

                                                _finalSum(
                                                    "travel",
                                                    details.toString(),
                                                    tclaim_amount.text);
                                              });
                                            }
                                          },
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
                                            labelText: 'Distance In Km',
                                            // hintText: "From",
                                            // hintStyle: Theme.of(context)
                                            //     .textTheme
                                            //     .bodyText2!
                                            //     .copyWith(color: Colors.grey),
                                            labelStyle: Theme.of(
                                                    context as BuildContext)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                          ),
                                          style:
                                              Theme.of(context as BuildContext)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black),
                                          showCursor:
                                              widget.data['status'] == 1 ||
                                                      widget.data['status'] == 4
                                                  ? false
                                                  : true,
                                          cursorColor: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Icon(Icons.book_online),
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
                                              controller: tgst_no,
                                              readOnly: widget.data['status'] ==
                                                          1 ||
                                                      widget.data['status'] == 4
                                                  ? true
                                                  : false,
                                              keyboardType: TextInputType.text,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    15),
                                              ],
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
                                                labelText: 'GST No',
                                                // hintText: "From",
                                                // hintStyle: Theme.of(context)
                                                //     .textTheme
                                                //     .bodyText2!
                                                //     .copyWith(color: Colors.grey),
                                                labelStyle: Theme.of(
                                                        context as BuildContext)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontSize: 18,
                                                        color: Colors.black),
                                              ),
                                              style: Theme.of(
                                                      context as BuildContext)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black),
                                              showCursor: widget
                                                              .data['status'] ==
                                                          1 ||
                                                      widget.data['status'] == 4
                                                  ? false
                                                  : true,
                                              cursorColor: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: Icon(
                                              Icons.currency_rupee_outlined),
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
                                            controller: tgst_amount,
                                            readOnly: widget.data['status'] ==
                                                        1 ||
                                                    widget.data['status'] == 4
                                                ? true
                                                : false,
                                            onChanged: (_) {
                                              if (tgst_amount.text == '') {
                                                setState(() {
                                                  tclaim_amount.text =
                                                      tbasic_amount.text;
                                                });
                                                setState(() {
                                                  //_final_amount = double.parse(tclaim_amount.text);

                                                  _finalSum(
                                                      "travel",
                                                      details.toString(),
                                                      tclaim_amount.text);
                                                });
                                              } else if (tbasic_amount.text ==
                                                      '' &&
                                                  distanceTravelled.text ==
                                                      '') {
                                                setState(() {
                                                  tclaim_amount.text =
                                                      double.parse(
                                                              tgst_amount.text)
                                                          .toString();
                                                });
                                                setState(() {
                                                  //_final_amount = double.parse(tclaim_amount.text);

                                                  _finalSum(
                                                      "travel",
                                                      details.toString(),
                                                      tclaim_amount.text);
                                                });
                                              } else {
                                                setState(() {
                                                  tclaim_amount.text =
                                                      (double.parse(tgst_amount
                                                                  .text) +
                                                              double.parse(
                                                                  tbasic_amount
                                                                      .text))
                                                          .toString();
                                                });

                                                setState(() {
                                                  //_final_amount = double.parse(tclaim_amount.text);

                                                  _finalSum(
                                                      "travel",
                                                      details.toString(),
                                                      tclaim_amount.text);
                                                });
                                              }
                                            },
                                            keyboardType: TextInputType.number,
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
                                              labelStyle: Theme.of(
                                                      context as BuildContext)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                            ),
                                            style: Theme.of(
                                                    context as BuildContext)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black),
                                            showCursor: widget.data['status'] ==
                                                        1 ||
                                                    widget.data['status'] == 4
                                                ? false
                                                : true,
                                            cursorColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Icon(
                                                Icons.currency_rupee_outlined),
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
                                              controller: tbasic_amount,
                                              readOnly: widget.data['status'] ==
                                                          1 ||
                                                      widget.data['status'] == 4
                                                  ? true
                                                  : false,
                                              onChanged: (content) {
                                                if (tgst_amount.text == '') {
                                                  setState(() {
                                                    tclaim_amount.text =
                                                        tbasic_amount.text;
                                                  });
                                                } else {
                                                  setState(() {
                                                    tclaim_amount
                                                        .text = (double.parse(
                                                                tbasic_amount
                                                                    .text) +
                                                            double.parse(
                                                                tgst_amount
                                                                    .text))
                                                        .toString();
                                                  });
                                                }
                                                setState(() {
                                                  //_final_amount = double.parse(tclaim_amount.text);

                                                  _finalSum(
                                                      "travel",
                                                      details.toString(),
                                                      tclaim_amount.text);
                                                });
                                              },
                                              keyboardType:
                                                  TextInputType.number,
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
                                                labelStyle: Theme.of(
                                                        context as BuildContext)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontSize: 18,
                                                        color: Colors.black),
                                              ),
                                              style: Theme.of(
                                                      context as BuildContext)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black),
                                              showCursor: widget
                                                              .data['status'] ==
                                                          1 ||
                                                      widget.data['status'] == 4
                                                  ? false
                                                  : true,
                                              cursorColor: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          child: Icon(
                                              Icons.currency_rupee_outlined),
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
                                            readOnly: true,
                                            controller: tclaim_amount,
                                            keyboardType: TextInputType.number,
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
                                              labelText: 'Claim Amount',
                                              // hintText: "To",
                                              // hintStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyText2!
                                              //     .copyWith(color: Colors.grey),
                                              labelStyle: Theme.of(
                                                      context as BuildContext)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                            ),
                                            style: Theme.of(
                                                    context as BuildContext)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.black),
                                            showCursor: widget.data['status'] ==
                                                        1 ||
                                                    widget.data['status'] == 4
                                                ? false
                                                : true,
                                            cursorColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height: SizeVariables.getHeight(context) * 0.3,
                              // color: Colors.red,
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.05,
                                  bottom:
                                      SizeVariables.getHeight(context) * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // padding: EdgeInsets.only(
                                    //     left: SizeVariables.getWidth(context) * 0.05),
                                    // color: Colors.yellow,
                                    margin: EdgeInsets.only(
                                        bottom:
                                            SizeVariables.getHeight(context) *
                                                0.02),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.visibility,
                                            color: Colors.black),
                                        SizedBox(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.02),
                                        Text(
                                            widget.data['status'] == 1 ||
                                                    widget.data['status'] == 4
                                                ? 'Invoice'
                                                : 'Upload Invoice',
                                            style: Theme.of(
                                                    context as BuildContext)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 18))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () => showDialog(
                                          context: context as BuildContext,
                                          builder: (context) => AlertDialog(
                                                content: Container(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.4,
                                                  width: double.infinity,
                                                  child: InteractiveViewer(
                                                    // clipBehavior: Clip.none,
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
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    20),
                                                            child: tfile_link !=
                                                                    ''
                                                                ? Image.network(
                                                                    tfile_link!,
                                                                    fit: BoxFit
                                                                        .cover)
                                                                : Image.file(
                                                                    File(_ie_file!
                                                                        .path),
                                                                    fit: BoxFit
                                                                        .cover))),
                                                  ),
                                                ),
                                              )),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        child: Container(
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.4,
                                          // color: Colors.yellow,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 2)),
                                          child: tfile_link == '' &&
                                                  tfile == null
                                              ? Center(
                                                  child: Text(
                                                      'Please Upload Invoice',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context
                                                              as BuildContext)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: Colors
                                                                  .black)),
                                                )
                                              : tfile_link != ''
                                                  ? Stack(
                                                      children: [
                                                        Container(
                                                          height:
                                                              double.infinity,
                                                          width:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  fit: BoxFit.fill,
                                                                  image: NetworkImage(
                                                                    tfile_link!,
                                                                  ))),
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
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    )
                                                  : Stack(
                                                      children: [
                                                        Container(
                                                          height:
                                                              double.infinity,
                                                          width:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  image: FileImage(
                                                                      File(tfile!
                                                                          .path)))),
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
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            widget.data['status'] == -1
                ? Container()
                : Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.05,
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Approval Status',
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
            widget.data['status'] == -1
                ? Container()
                : Container(
                    height: SizeVariables.getHeight(context) * 0.5,
                    // color: Colors.red,
                    child: Scrollbar(
                      child: Scrollbar(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          // itemCount: approvalLog!.length,
                          itemCount: travelDetails.length,

                          itemBuilder: (context, index) {
                            return Container(
                              height: 250,
                              child: TimelineTile(
                                endChild: Container(
                                  padding: EdgeInsets.only(
                                    top:
                                        SizeVariables.getHeight(context) * 0.03,
                                  ),
                                  // color: Color.fromARGB(239, 228, 226, 226),
                                  // height: 50,
                                  child: Accordion(
                                    disableScrolling: true,
                                    // maxOpenSections: 1,
                                    headerBackgroundColorOpened:
                                        Color.fromARGB(239, 228, 226, 226),
                                    scaleWhenAnimating: true,
                                    openAndCloseAnimation: true,
                                    headerPadding: const EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 15),
                                    sectionOpeningHapticFeedback:
                                        SectionHapticFeedback.heavy,
                                    sectionClosingHapticFeedback:
                                        SectionHapticFeedback.light,
                                    children: [
                                      AccordionSection(
                                        contentBackgroundColor:
                                            Color.fromARGB(239, 228, 226, 226),
                                        // isO?pen: true,

                                        headerBackgroundColor:
                                            Color.fromARGB(239, 228, 226, 226),
                                        headerBackgroundColorOpened:
                                            Color.fromARGB(239, 228, 226, 226),
                                        contentBorderColor:
                                            Color.fromARGB(239, 228, 226, 226),
                                        header: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons
                                                        .currency_rupee_outlined,
                                                    color: Colors.black,
                                                    size: 18,
                                                  ),
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    travelDetails[index]
                                                        ['claim_amount'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: Color(0xfffe2f6ed),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                    top: 2.5,
                                                    bottom: 2.5),
                                                child: Center(
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      travelDetails[index]
                                                          ['status'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: Color(
                                                                  0xfff26af48),
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 3,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    travelDetails[index]
                                                        ['emp_name'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 2,
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.6,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.007,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        travelDetails[index]
                                                            ['updated_at'],
                                                        style: Theme.of(context)
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
                                        contentHorizontalPadding: 20,
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
      ),
    );
  }

  _foodtab(Map<String, dynamic> food, String docNo, List<dynamic> foodDetails) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: SizeVariables.getHeight(context) * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // color: Colors.red,
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.03,
                ),
                child: Container(
                  // color: Colors.pink,
                  // height: SizeVariables.getHeight(context) * 0.83,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.02,
                              top: SizeVariables.getHeight(context) * 0.02,
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Food details',
                                style: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                          widget.data['status'] == 1 ||
                                  widget.data['status'] == 4
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    _upload("food", context as BuildContext);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.45,
                                      top: SizeVariables.getWidth(context) *
                                          0.01,
                                    ),
                                    child: Icon(
                                      Icons.arrow_circle_up_outlined,
                                      size: 40,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.048),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.account_circle_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.02,
                                ),
                                Container(
                                  width: SizeVariables.getWidth(context) * 0.76,
                                  // width: 300,
                                  // height: 200,
                                  child: TextFormField(
                                    controller: fserviceprovider,
                                    keyboardType: TextInputType.text,
                                    readOnly: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? true
                                        : false,
                                    decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 167, 164, 164)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
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
                                      labelStyle:
                                          Theme.of(context as BuildContext)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                    ),
                                    style: Theme.of(context as BuildContext)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                    showCursor: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? false
                                        : true,
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: SizeVariables.getWidth(context) * 0.02,
                              left: SizeVariables.getWidth(context) * 0.02,
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Claim',
                                style: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.05,
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? () {}
                                      : () {
                                          showDatePicker(
                                                  builder: (context, child) =>
                                                      Theme(
                                                        data: ThemeData()
                                                            .copyWith(
                                                          colorScheme:
                                                              ColorScheme.dark(
                                                            primary: Color(
                                                                0xffF59F23),
                                                            surface:
                                                                Colors.black,
                                                            onSurface:
                                                                Colors.white,
                                                          ),
                                                          dialogBackgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  91,
                                                                  91,
                                                                  91),
                                                        ),
                                                        child: child!,
                                                      ),
                                                  context:
                                                      context as BuildContext,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.now().add(
                                                      const Duration(
                                                          days: 365)))
                                              .then((value) {
                                            setState(() {
                                              // _dateTimeStart = value;
                                              fclaim_date.text = dateFormat
                                                  .format(DateTime.parse(
                                                      value.toString()));
                                            });
                                            // print('DATE START: $_dateTimeStart');
                                          });
                                        },
                                  child: Container(
                                    child: Icon(Icons.calendar_month_outlined),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.02,
                                ),
                                Container(
                                  width: SizeVariables.getWidth(context) * 0.78,
                                  // width: 300,
                                  // height: 200,
                                  child: TextFormField(
                                    onTap: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? () {}
                                        : () {
                                            showDatePicker(
                                                    builder: (context, child) =>
                                                        Theme(
                                                          data: ThemeData()
                                                              .copyWith(
                                                            colorScheme:
                                                                ColorScheme
                                                                    .dark(
                                                              primary: Color(
                                                                  0xffF59F23),
                                                              surface:
                                                                  Colors.black,
                                                              onSurface:
                                                                  Colors.white,
                                                            ),
                                                            dialogBackgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    91,
                                                                    91,
                                                                    91),
                                                          ),
                                                          child: child!,
                                                        ),
                                                    context:
                                                        context as BuildContext,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.now()
                                                        .add(const Duration(
                                                            days: 365)))
                                                .then((value) {
                                              setState(() {
                                                // _dateTimeStart = value;
                                                fclaim_date.text = dateFormat
                                                    .format(DateTime.parse(
                                                        value.toString()));
                                              });
                                              // print('DATE START: $_dateTimeStart');
                                            });
                                          },
                                    readOnly: true,
                                    controller: fclaim_date,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 167, 164, 164)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 194, 191, 191)),
                                      ),
                                      // border: InputBorder.none,
                                      labelText: 'Doc. date',
                                      // hintText: "From",
                                      // hintStyle: Theme.of(context)
                                      //     .textTheme
                                      //     .bodyText2!
                                      //     .copyWith(color: Colors.grey),
                                      labelStyle:
                                          Theme.of(context as BuildContext)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                    ),
                                    style: Theme.of(context as BuildContext)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                    showCursor: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? false
                                        : true,
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Container(
                          //   child: Row(
                          //     children: [
                          //       Container(
                          //         child: Icon(Icons.account_balance_wallet_sharp),
                          //       ),
                          //       SizedBox(
                          //         width: SizeVariables.getWidth(context) * 0.02,
                          //       ),
                          //       Container(
                          //         width: SizeVariables.getWidth(context) * 0.3,
                          //         // width: 300,
                          //         // height: 200,
                          //         child: TextFormField(
                          //           controller: fexchangerate,
                          //           keyboardType: TextInputType.number,
                          //           decoration: InputDecoration(
                          //             enabledBorder: const UnderlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   width: 2,
                          //                   color:
                          //                       Color.fromARGB(255, 167, 164, 164)),
                          //             ),
                          //             focusedBorder: const UnderlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   width: 2,
                          //                   color:
                          //                       Color.fromARGB(255, 194, 191, 191)),
                          //             ),
                          //             // border: InputBorder.none,
                          //             labelText: 'Exchange rate',
                          //             // hintText: "From",
                          //             // hintStyle: Theme.of(context)
                          //             //     .textTheme
                          //             //     .bodyText2!
                          //             //     .copyWith(color: Colors.grey),
                          //             labelStyle: Theme.of(context)
                          //                 .textTheme
                          //                 .bodyText1!
                          //                 .copyWith(
                          //                     fontSize: 18, color: Colors.black),
                          //           ),
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .bodyText2!
                          //               .copyWith(color: Colors.black),
                          //           showCursor: true,
                          //           cursorColor: Colors.black,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.048),
                            child: Row(
                              children: [
                                Container(
                                  child: const Icon(Icons.receipt),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.02,
                                ),
                                Container(
                                  width: SizeVariables.getWidth(context) * 0.76,
                                  // width: 300,
                                  // height: 200,
                                  child: TextFormField(
                                    controller: fBillNo,
                                    keyboardType: TextInputType.text,
                                    readOnly: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? true
                                        : false,
                                    decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 167, 164, 164)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 194, 191, 191)),
                                      ),
                                      // border: InputBorder.none,
                                      labelText: 'Bill No',
                                      // hintText: "From",
                                      // hintStyle: Theme.of(context)
                                      //     .textTheme
                                      //     .bodyText2!
                                      //     .copyWith(color: Colors.grey),
                                      labelStyle:
                                          Theme.of(context as BuildContext)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                    ),
                                    style: Theme.of(context as BuildContext)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                    showCursor: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? false
                                        : true,
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.book_online),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.02,
                                ),
                                Container(
                                  width: SizeVariables.getWidth(context) * 0.3,
                                  // width: 300,
                                  // height: 200,
                                  child: TextFormField(
                                    controller: fgst_no,
                                    keyboardType: TextInputType.text,
                                    readOnly: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? true
                                        : false,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(15),
                                    ],
                                    decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 167, 164, 164)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 194, 191, 191)),
                                      ),
                                      // border: InputBorder.none,
                                      labelText: 'GST No',
                                      // hintText: "From",
                                      // hintStyle: Theme.of(context)
                                      //     .textTheme
                                      //     .bodyText2!
                                      //     .copyWith(color: Colors.grey),
                                      labelStyle:
                                          Theme.of(context as BuildContext)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                    ),
                                    style: Theme.of(context as BuildContext)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                    showCursor: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? false
                                        : true,
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.3,
                                // width: 300,
                                // height: 200,
                                child: TextFormField(
                                  controller: fgst_amount,
                                  readOnly: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? true
                                      : false,
                                  onChanged: (_) {
                                    print('FOOD LIMIT: $foodLimit');
                                    // if (double.parse(fgst_amount.text) +
                                    //         double.parse(fbasic_amount.text) >
                                    //     double.parse(foodLimit['food'][0]['limit'])) {
                                    //   setState(() {
                                    //     fclaim_amount.text =
                                    //         foodLimit['food'][0]['limit'].toString();
                                    //   });

                                    //   setState(() {
                                    //     //_final_amount = double.parse(tclaim_amount.text);

                                    //     _finalSum("food", details.toString(),
                                    //         fclaim_amount.text);
                                    //   });
                                    // }
                                    if (fgst_amount.text == '' &&
                                        fbasic_amount.text != '') {
                                      setState(() {
                                        fclaim_amount.text =
                                            double.parse(fbasic_amount.text)
                                                .toString();
                                      });
                                      setState(() {
                                        //_final_amount = double.parse(tclaim_amount.text);

                                        _finalSum("food", details.toString(),
                                            fclaim_amount.text);
                                      });
                                    } else if (fgst_amount.text == '' &&
                                        fbasic_amount.text == '') {
                                      setState(() {
                                        fclaim_amount.text = '0.0';
                                      });
                                      setState(() {
                                        //_final_amount = double.parse(tclaim_amount.text);

                                        _finalSum("food", details.toString(),
                                            fclaim_amount.text);
                                      });
                                    } else if (fgst_amount.text == '') {
                                      setState(() {
                                        fclaim_amount.text = '0.0';
                                      });
                                      setState(() {
                                        //_final_amount = double.parse(tclaim_amount.text);

                                        _finalSum("food", details.toString(),
                                            fclaim_amount.text);
                                      });
                                    } else if (fbasic_amount.text == '') {
                                      setState(() {
                                        fclaim_amount.text =
                                            double.parse(fgst_amount.text)
                                                .toString();
                                      });
                                      setState(() {
                                        //_final_amount = double.parse(tclaim_amount.text);

                                        _finalSum("food", details.toString(),
                                            fclaim_amount.text);
                                      });
                                    } else {
                                      setState(() {
                                        fclaim_amount.text =
                                            (double.parse(fgst_amount.text) +
                                                    double.parse(
                                                        fbasic_amount.text))
                                                .toString();
                                      });

                                      setState(() {
                                        //_final_amount = double.parse(tclaim_amount.text);

                                        _finalSum("food", details.toString(),
                                            fclaim_amount.text);
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 167, 164, 164)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
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
                                    labelStyle:
                                        Theme.of(context as BuildContext)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 18,
                                                color: Colors.black),
                                  ),
                                  style: Theme.of(context as BuildContext)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                  showCursor: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? false
                                      : true,
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.currency_rupee_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.02,
                                ),
                                Container(
                                  width: SizeVariables.getWidth(context) * 0.3,
                                  // width: 300,
                                  // height: 200,
                                  child: TextFormField(
                                    controller: fbasic_amount,
                                    readOnly: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? true
                                        : false,
                                    onChanged: (content) {
                                      print('FOOD LIMIT: $foodLimit');

                                      if (fgst_amount.text == '' &&
                                          fbasic_amount.text != '') {
                                        setState(() {
                                          fclaim_amount.text =
                                              double.parse(fbasic_amount.text)
                                                  .toString();
                                        });
                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum("food", details.toString(),
                                              fclaim_amount.text);
                                        });
                                      } else if (fgst_amount.text == '' &&
                                          fbasic_amount.text == '') {
                                        setState(() {
                                          fclaim_amount.text = '';
                                        });
                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum("food", details.toString(),
                                              fclaim_amount.text);
                                        });
                                      } else if (fgst_amount.text == '') {
                                        setState(() {
                                          fclaim_amount.text = '';
                                        });
                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum("food", details.toString(),
                                              fclaim_amount.text);
                                        });
                                      } else if (fbasic_amount.text == '') {
                                        setState(() {
                                          fclaim_amount.text =
                                              double.parse(fgst_amount.text)
                                                  .toString();
                                        });
                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum("food", details.toString(),
                                              fclaim_amount.text);
                                        });
                                      } else if (double.parse(
                                                  fbasic_amount.text) +
                                              double.parse(fgst_amount.text) >
                                          foodLimit) {
                                        setState(() {
                                          fclaim_amount.text =
                                              double.parse(foodLimit)
                                                  .toString();
                                        });

                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum("food", details.toString(),
                                              fclaim_amount.text);
                                        });
                                      } else if (double.parse(
                                              fclaim_amount.text) >
                                          foodLimit) {
                                        setState(() {
                                          fclaim_amount.text =
                                              double.parse(foodLimit)
                                                  .toString();
                                        });

                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum("food", details.toString(),
                                              fclaim_amount.text);
                                        });
                                      } else {
                                        setState(() {
                                          fclaim_amount.text =
                                              (double.parse(fgst_amount.text) +
                                                      double.parse(
                                                          fbasic_amount.text))
                                                  .toString();
                                        });

                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum("food", details.toString(),
                                              fclaim_amount.text);
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 167, 164, 164)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
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
                                      labelStyle:
                                          Theme.of(context as BuildContext)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                    ),
                                    style: Theme.of(context as BuildContext)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                    showCursor: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? false
                                        : true,
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.3,
                                // width: 300,
                                // height: 200,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: fclaim_amount,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 167, 164, 164)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 194, 191, 191)),
                                    ),
                                    // border: InputBorder.none,
                                    labelText: 'Claim Amount',
                                    // hintText: "To",
                                    // hintStyle: Theme.of(context)
                                    //     .textTheme
                                    //     .bodyText2!
                                    //     .copyWith(color: Colors.grey),
                                    labelStyle:
                                        Theme.of(context as BuildContext)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 18,
                                                color: Colors.black),
                                  ),
                                  style: Theme.of(context as BuildContext)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                  showCursor: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? false
                                      : true,
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                height: SizeVariables.getHeight(context) * 0.3,
                                // color: Colors.red,
                                padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.05,
                                    bottom: SizeVariables.getHeight(context) *
                                        0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // padding: EdgeInsets.only(
                                      //     left: SizeVariables.getWidth(context) * 0.05),
                                      // color: Colors.yellow,
                                      margin: EdgeInsets.only(
                                          bottom:
                                              SizeVariables.getHeight(context) *
                                                  0.02),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.visibility,
                                              color: Colors.black),
                                          SizedBox(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.02),
                                          Text(
                                              widget.data['status'] == 1 ||
                                                      widget.data['status'] == 4
                                                  ? 'Invoice'
                                                  : 'Upload Invoice',
                                              style: Theme.of(
                                                      context as BuildContext)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 18))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () => showDialog(
                                            context: context as BuildContext,
                                            builder: (context) => AlertDialog(
                                                  content: Container(
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.4,
                                                    width: double.infinity,
                                                    child: InteractiveViewer(
                                                      // clipBehavior: Clip.none,
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
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              child: ffile_link != ''
                                                                  ? Image.network(
                                                                      ffile_link!,
                                                                      fit: BoxFit
                                                                          .cover)
                                                                  : Image.file(
                                                                      File(_ie_file!
                                                                          .path),
                                                                      fit: BoxFit
                                                                          .cover))),
                                                    ),
                                                  ),
                                                )),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          child: Container(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.4,
                                            // color: Colors.yellow,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2)),
                                            child:
                                                ffile_link == '' &&
                                                        ffile == null
                                                    ? Center(
                                                        child: Text(
                                                            'Please Upload Invoice',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(context
                                                                    as BuildContext)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black)),
                                                      )
                                                    : ffile_link != ''
                                                        ? Stack(
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
                                                                        image: NetworkImage(
                                                                            ffile_link!))),
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
                                                                            File(ffile!.path)))),
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
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            widget.data['status'] == -1
                ? Container()
                : Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.05,
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Approval Status',
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
            widget.data['status'] == -1
                ? Container()
                : Container(
                    height: SizeVariables.getHeight(context) * 0.5,
                    // color: Colors.red,
                    child: Scrollbar(
                      child: Scrollbar(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          // itemCount: approvalLog!.length,
                          itemCount: foodDetails.length,

                          itemBuilder: (context, index) {
                            return Container(
                              height: 250,
                              child: TimelineTile(
                                endChild: Container(
                                  padding: EdgeInsets.only(
                                    top:
                                        SizeVariables.getHeight(context) * 0.03,
                                  ),
                                  // color: Color.fromARGB(239, 228, 226, 226),
                                  // height: 50,
                                  child: Accordion(
                                    disableScrolling: true,
                                    // maxOpenSections: 1,
                                    headerBackgroundColorOpened:
                                        Color.fromARGB(239, 228, 226, 226),
                                    scaleWhenAnimating: true,
                                    openAndCloseAnimation: true,
                                    headerPadding: const EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 15),
                                    sectionOpeningHapticFeedback:
                                        SectionHapticFeedback.heavy,
                                    sectionClosingHapticFeedback:
                                        SectionHapticFeedback.light,
                                    children: [
                                      AccordionSection(
                                        contentBackgroundColor:
                                            Color.fromARGB(239, 228, 226, 226),
                                        // isO?pen: true,

                                        headerBackgroundColor:
                                            Color.fromARGB(239, 228, 226, 226),
                                        headerBackgroundColorOpened:
                                            Color.fromARGB(239, 228, 226, 226),
                                        contentBorderColor:
                                            Color.fromARGB(239, 228, 226, 226),
                                        header: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons
                                                        .currency_rupee_outlined,
                                                    color: Colors.black,
                                                    size: 18,
                                                  ),
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    foodDetails[index]
                                                        ['claim_amount'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: Color(0xfffe2f6ed),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                    top: 2.5,
                                                    bottom: 2.5),
                                                child: Center(
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      foodDetails[index]
                                                          ['status'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: Color(
                                                                  0xfff26af48),
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 3,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    foodDetails[index]
                                                        ['emp_name'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 2,
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.6,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.007,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        foodDetails[index]
                                                            ['updated_at'],
                                                        style: Theme.of(context)
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
                                        contentHorizontalPadding: 20,
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
      ),
    );
  }

  _incidentaltab(Map<String, dynamic> incidental, String docNo,
      List<dynamic> incidentalDetails) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: SizeVariables.getHeight(context) * 0.02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.03,
                ),
                child: Container(
                  // color: Colors.pink,
                  // height: SizeVariables.getHeight(context) * 0.83,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.02,
                              top: SizeVariables.getHeight(context) * 0.02,
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Incidental details',
                                style: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                          widget.data['status'] == 1 ||
                                  widget.data['status'] == 4
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    _upload(
                                        "incidental", context as BuildContext);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.34,
                                      top: SizeVariables.getWidth(context) *
                                          0.01,
                                    ),
                                    child: Icon(
                                      Icons.arrow_circle_up_outlined,
                                      size: 40,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.048),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.account_circle_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.02,
                                ),
                                Container(
                                  width: SizeVariables.getWidth(context) * 0.76,
                                  // width: 300,
                                  // height: 200,
                                  child: TextFormField(
                                    controller: iserviceprovider,
                                    readOnly: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? true
                                        : false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 167, 164, 164)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
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
                                      labelStyle:
                                          Theme.of(context as BuildContext)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                    ),
                                    style: Theme.of(context as BuildContext)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                    showCursor: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? false
                                        : true,
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: SizeVariables.getWidth(context) * 0.02,
                              left: SizeVariables.getWidth(context) * 0.02,
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Claim',
                                style: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.05,
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? () {}
                                      : () {
                                          showDatePicker(
                                                  builder: (context, child) =>
                                                      Theme(
                                                        data: ThemeData()
                                                            .copyWith(
                                                          colorScheme:
                                                              ColorScheme.dark(
                                                            primary: Color(
                                                                0xffF59F23),
                                                            surface:
                                                                Colors.black,
                                                            onSurface:
                                                                Colors.white,
                                                          ),
                                                          dialogBackgroundColor:
                                                              Color.fromARGB(
                                                                  255,
                                                                  91,
                                                                  91,
                                                                  91),
                                                        ),
                                                        child: child!,
                                                      ),
                                                  context:
                                                      context as BuildContext,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime.now().add(
                                                      const Duration(
                                                          days: 365)))
                                              .then((value) {
                                            setState(() {
                                              // _dateTimeStart = value;
                                              iclaim_date.text = dateFormat
                                                  .format(DateTime.parse(
                                                      value.toString()));
                                            });
                                            // print('DATE START: $_dateTimeStart');
                                          });
                                        },
                                  child: Container(
                                    child: Icon(Icons.calendar_month_outlined),
                                  ),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.02,
                                ),
                                Container(
                                  width: SizeVariables.getWidth(context) * 0.76,
                                  // width: 300,
                                  // height: 200,
                                  child: TextFormField(
                                    onTap: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? () {}
                                        : () {
                                            showDatePicker(
                                                    builder: (context, child) =>
                                                        Theme(
                                                          data: ThemeData()
                                                              .copyWith(
                                                            colorScheme:
                                                                ColorScheme
                                                                    .dark(
                                                              primary: Color(
                                                                  0xffF59F23),
                                                              surface:
                                                                  Colors.black,
                                                              onSurface:
                                                                  Colors.white,
                                                            ),
                                                            dialogBackgroundColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    91,
                                                                    91,
                                                                    91),
                                                          ),
                                                          child: child!,
                                                        ),
                                                    context:
                                                        context as BuildContext,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now(),
                                                    lastDate: DateTime.now()
                                                        .add(const Duration(
                                                            days: 365)))
                                                .then((value) {
                                              setState(() {
                                                // _dateTimeStart = value;
                                                iclaim_date.text = dateFormat
                                                    .format(DateTime.parse(
                                                        value.toString()));
                                              });
                                              // print('DATE START: $_dateTimeStart');
                                            });
                                          },
                                    readOnly: true,
                                    controller: iclaim_date,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 167, 164, 164)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 194, 191, 191)),
                                      ),
                                      // border: InputBorder.none,
                                      labelText: 'Doc. date',
                                      // hintText: "From",
                                      // hintStyle: Theme.of(context)
                                      //     .textTheme
                                      //     .bodyText2!
                                      //     .copyWith(color: Colors.grey),
                                      labelStyle:
                                          Theme.of(context as BuildContext)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                    ),
                                    style: Theme.of(context as BuildContext)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                    showCursor: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? false
                                        : true,
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   child: Row(
                          //     children: [
                          //       Container(
                          //         child: Icon(Icons.account_balance_wallet_sharp),
                          //       ),
                          //       SizedBox(
                          //         width: SizeVariables.getWidth(context) * 0.02,
                          //       ),
                          //       Container(
                          //         width: SizeVariables.getWidth(context) * 0.3,
                          //         // width: 300,
                          //         // height: 200,
                          //         child: TextFormField(
                          //           controller: iexchangerate,
                          //           keyboardType: TextInputType.number,
                          //           decoration: InputDecoration(
                          //             enabledBorder: const UnderlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   width: 2,
                          //                   color:
                          //                       Color.fromARGB(255, 167, 164, 164)),
                          //             ),
                          //             focusedBorder: const UnderlineInputBorder(
                          //               borderSide: BorderSide(
                          //                   width: 2,
                          //                   color:
                          //                       Color.fromARGB(255, 194, 191, 191)),
                          //             ),
                          //             // border: InputBorder.none,
                          //             labelText: 'Exchange rate',
                          //             // hintText: "From",
                          //             // hintStyle: Theme.of(context)
                          //             //     .textTheme
                          //             //     .bodyText2!
                          //             //     .copyWith(color: Colors.grey),
                          //             labelStyle: Theme.of(context)
                          //                 .textTheme
                          //                 .bodyText1!
                          //                 .copyWith(
                          //                     fontSize: 18, color: Colors.black),
                          //           ),
                          //           style: Theme.of(context)
                          //               .textTheme
                          //               .bodyText2!
                          //               .copyWith(color: Colors.black),
                          //           showCursor: true,
                          //           cursorColor: Colors.black,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.048),
                            child: Row(
                              children: [
                                Container(
                                  child: const Icon(Icons.receipt),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.02,
                                ),
                                Container(
                                  width: SizeVariables.getWidth(context) * 0.76,
                                  // width: 300,
                                  // height: 200,
                                  child: TextFormField(
                                    controller: iBillNo,
                                    readOnly: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? true
                                        : false,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 167, 164, 164)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 194, 191, 191)),
                                      ),
                                      // border: InputBorder.none,
                                      labelText: 'Bill No',
                                      // hintText: "From",
                                      // hintStyle: Theme.of(context)
                                      //     .textTheme
                                      //     .bodyText2!
                                      //     .copyWith(color: Colors.grey),
                                      labelStyle:
                                          Theme.of(context as BuildContext)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                    ),
                                    style: Theme.of(context as BuildContext)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                    showCursor: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? false
                                        : true,
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.book_online),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.02,
                                ),
                                Container(
                                  width: SizeVariables.getWidth(context) * 0.3,
                                  // width: 300,
                                  // height: 200,
                                  child: TextFormField(
                                    controller: igst_no,
                                    readOnly: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? true
                                        : false,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(15),
                                    ],
                                    decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 167, 164, 164)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 194, 191, 191)),
                                      ),
                                      // border: InputBorder.none,
                                      labelText: 'GST No',
                                      // hintText: "From",
                                      // hintStyle: Theme.of(context)
                                      //     .textTheme
                                      //     .bodyText2!
                                      //     .copyWith(color: Colors.grey),
                                      labelStyle:
                                          Theme.of(context as BuildContext)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                    ),
                                    style: Theme.of(context as BuildContext)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                    showCursor: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? false
                                        : true,
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                child:
                                    const Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.3,
                                // width: 300,
                                // height: 200,
                                child: TextFormField(
                                  controller: igst_amount,
                                  readOnly: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? true
                                      : false,
                                  onChanged: (_) {
                                    // if (igst_amount.text == '') {
                                    //   setState(() {
                                    //     iclaim_amount.text = ibasic_amount.text;
                                    //   });
                                    // } else {
                                    //   iclaim_amount.text =
                                    //       double.parse(igst_amount.text).toString();
                                    // }
                                    // print(
                                    //     'FOOD LIMIT: $foodLimit');
                                    // if (double.parse(fgst_amount.text) +
                                    //         double.parse(fbasic_amount.text) >
                                    //     double.parse(foodLimit['food'][0]['limit'])) {
                                    //   setState(() {
                                    //     fclaim_amount.text =
                                    //         foodLimit['food'][0]['limit'].toString();
                                    //   });

                                    //   setState(() {
                                    //     //_final_amount = double.parse(tclaim_amount.text);

                                    //     _finalSum("food", details.toString(),
                                    //         fclaim_amount.text);
                                    //   });
                                    // }
                                    if (igst_amount.text == '' &&
                                        ibasic_amount.text != '') {
                                      setState(() {
                                        iclaim_amount.text =
                                            double.parse(ibasic_amount.text)
                                                .toString();
                                      });
                                      setState(() {
                                        //_final_amount = double.parse(tclaim_amount.text);

                                        _finalSum(
                                            "incidental",
                                            details.toString(),
                                            iclaim_amount.text);
                                      });
                                    } else if (igst_amount.text == '' &&
                                        ibasic_amount.text == '') {
                                      setState(() {
                                        iclaim_amount.text = '0.0';
                                      });
                                      setState(() {
                                        //_final_amount = double.parse(tclaim_amount.text);

                                        _finalSum(
                                            "incidental",
                                            details.toString(),
                                            fclaim_amount.text);
                                      });
                                    } else if (igst_amount.text == '') {
                                      setState(() {
                                        iclaim_amount.text = '0.0';
                                      });
                                      setState(() {
                                        //_final_amount = double.parse(tclaim_amount.text);

                                        _finalSum(
                                            "incidental",
                                            details.toString(),
                                            iclaim_amount.text);
                                      });
                                    } else if (ibasic_amount.text == '') {
                                      setState(() {
                                        iclaim_amount.text =
                                            double.parse(igst_amount.text)
                                                .toString();
                                      });
                                      setState(() {
                                        //_final_amount = double.parse(tclaim_amount.text);

                                        _finalSum(
                                            "incidental",
                                            details.toString(),
                                            iclaim_amount.text);
                                      });
                                    } else {
                                      setState(() {
                                        iclaim_amount.text =
                                            (double.parse(igst_amount.text) +
                                                    double.parse(
                                                        ibasic_amount.text))
                                                .toString();
                                      });

                                      setState(() {
                                        //_final_amount = double.parse(tclaim_amount.text);

                                        _finalSum(
                                            "incidental",
                                            details.toString(),
                                            iclaim_amount.text);
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 167, 164, 164)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
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
                                    labelStyle:
                                        Theme.of(context as BuildContext)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 18,
                                                color: Colors.black),
                                  ),
                                  style: Theme.of(context as BuildContext)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                  showCursor: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? false
                                      : true,
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.currency_rupee_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.02,
                                ),
                                Container(
                                  width: SizeVariables.getWidth(context) * 0.3,
                                  // width: 300,
                                  // height: 200,
                                  child: TextFormField(
                                    controller: ibasic_amount,
                                    readOnly: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? true
                                        : false,
                                    onChanged: (_) {
                                      // if (igst_amount.text == '') {
                                      //   setState(() {
                                      //     iclaim_amount.text = ibasic_amount.text;
                                      //   });
                                      // } else {
                                      //   setState(() {
                                      //     iclaim_amount.text =
                                      //         (double.parse(ibasic_amount.text) +
                                      //                 double.parse(igst_amount.text))
                                      //             .toString();
                                      //   });
                                      // }
                                      // setState(() {
                                      //   //_final_amount = double.parse(tclaim_amount.text);

                                      //   _finalSum("incidental", idetails.toString(),
                                      //       iclaim_amount.text);
                                      // });
                                      if (igst_amount.text == '' &&
                                          ibasic_amount.text != '') {
                                        setState(() {
                                          iclaim_amount.text =
                                              double.parse(ibasic_amount.text)
                                                  .toString();
                                        });
                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum(
                                              "incidental",
                                              details.toString(),
                                              iclaim_amount.text);
                                        });
                                      } else if (igst_amount.text == '' &&
                                          ibasic_amount.text == '') {
                                        setState(() {
                                          iclaim_amount.text = '';
                                        });
                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum(
                                              "incidental",
                                              details.toString(),
                                              iclaim_amount.text);
                                        });
                                      } else if (igst_amount.text == '') {
                                        setState(() {
                                          iclaim_amount.text = '';
                                        });
                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum(
                                              "incidental",
                                              details.toString(),
                                              iclaim_amount.text);
                                        });
                                      } else if (ibasic_amount.text == '') {
                                        setState(() {
                                          iclaim_amount.text =
                                              double.parse(igst_amount.text)
                                                  .toString();
                                        });
                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum(
                                              "incidental",
                                              details.toString(),
                                              iclaim_amount.text);
                                        });
                                      } else if (double.parse(
                                                  ibasic_amount.text) +
                                              double.parse(igst_amount.text) >
                                          foodLimit) {
                                        setState(() {
                                          iclaim_amount.text =
                                              double.parse(foodLimit)
                                                  .toString();
                                        });

                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum(
                                              "incidental",
                                              details.toString(),
                                              iclaim_amount.text);
                                        });
                                      } else if (double.parse(
                                              iclaim_amount.text) >
                                          foodLimit) {
                                        setState(() {
                                          iclaim_amount.text =
                                              double.parse(foodLimit)
                                                  .toString();
                                        });

                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum(
                                              "incidental",
                                              details.toString(),
                                              iclaim_amount.text);
                                        });
                                      } else {
                                        setState(() {
                                          iclaim_amount.text =
                                              (double.parse(igst_amount.text) +
                                                      double.parse(
                                                          ibasic_amount.text))
                                                  .toString();
                                        });

                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);

                                          _finalSum(
                                              "incidental",
                                              details.toString(),
                                              iclaim_amount.text);
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Color.fromARGB(
                                                255, 167, 164, 164)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
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
                                      labelStyle:
                                          Theme.of(context as BuildContext)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                    ),
                                    style: Theme.of(context as BuildContext)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                    showCursor: widget.data['status'] == 1 ||
                                            widget.data['status'] == 4
                                        ? false
                                        : true,
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                child: Icon(Icons.currency_rupee_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.3,
                                // width: 300,
                                // height: 200,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: iclaim_amount,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 167, 164, 164)),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2,
                                          color: Color.fromARGB(
                                              255, 194, 191, 191)),
                                    ),
                                    // border: InputBorder.none,
                                    labelText: 'Claim Amount',
                                    // hintText: "To",
                                    // hintStyle: Theme.of(context)
                                    //     .textTheme
                                    //     .bodyText2!
                                    //     .copyWith(color: Colors.grey),
                                    labelStyle:
                                        Theme.of(context as BuildContext)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 18,
                                                color: Colors.black),
                                  ),
                                  style: Theme.of(context as BuildContext)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.black),
                                  showCursor: widget.data['status'] == 1 ||
                                          widget.data['status'] == 4
                                      ? false
                                      : true,
                                  cursorColor: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Container(
                                height: SizeVariables.getHeight(context) * 0.3,
                                // color: Colors.red,
                                padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.05,
                                    bottom: SizeVariables.getHeight(context) *
                                        0.02),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // padding: EdgeInsets.only(
                                      //     left: SizeVariables.getWidth(context) * 0.05),
                                      // color: Colors.yellow,
                                      margin: EdgeInsets.only(
                                          bottom:
                                              SizeVariables.getHeight(context) *
                                                  0.02),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.visibility,
                                              color: Colors.black),
                                          SizedBox(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.02),
                                          Text(
                                              widget.data['status'] == 1 ||
                                                      widget.data['status'] == 4
                                                  ? 'Invoice'
                                                  : 'Upload Invoice',
                                              style: Theme.of(
                                                      context as BuildContext)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 18))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () => showDialog(
                                            context: context as BuildContext,
                                            builder: (context) => AlertDialog(
                                                  content: Container(
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.4,
                                                    width: double.infinity,
                                                    child: InteractiveViewer(
                                                      // clipBehavior: Clip.none,
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
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              child: ifile_link != ''
                                                                  ? Image.network(
                                                                      ifile_link!,
                                                                      fit: BoxFit
                                                                          .cover)
                                                                  : Image.file(
                                                                      File(_ie_file!
                                                                          .path),
                                                                      fit: BoxFit
                                                                          .cover))),
                                                    ),
                                                  ),
                                                )),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          child: Container(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.4,
                                            // color: Colors.yellow,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2)),
                                            child:
                                                ifile_link == '' &&
                                                        ifile == null
                                                    ? Center(
                                                        child: Text(
                                                            'Please Upload Invoice',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(context
                                                                    as BuildContext)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black)),
                                                      )
                                                    : ifile_link != ''
                                                        ? Stack(
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
                                                                        image: NetworkImage(
                                                                            ifile_link!))),
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
                                                                            File(ifile!.path)))),
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
                              )),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Container(
                      //       padding: EdgeInsets.only(
                      //           right: SizeVariables.getWidth(context) * 0.05),
                      //       child: AnimatedButton(
                      //         height: 45,
                      //         width: 100,
                      //         text: 'Save',
                      //         isReverse: true,
                      //         selectedTextColor: Colors.black,
                      //         transitionType: TransitionType.LEFT_TO_RIGHT,
                      //         textStyle: TextStyle(fontSize: 13),
                      //         backgroundColor: Colors.black,
                      //         borderColor: Colors.white,
                      //         borderRadius: 8,
                      //         borderWidth: 2,
                      //         onPress: () {},
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            widget.data['status'] == -1
                ? Container()
                : Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.05,
                        ),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Approval Status',
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),

            widget.data['status'] == -1
                ? Container()
                : Container(
                    height: SizeVariables.getHeight(context) * 0.5,
                    // color: Colors.red,
                    child: Scrollbar(
                      child: Scrollbar(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          // itemCount: approvalLog!.length,
                          itemCount: incidentalDetails.length,

                          itemBuilder: (context, index) {
                            return Container(
                              height: 250,
                              child: TimelineTile(
                                endChild: Container(
                                  padding: EdgeInsets.only(
                                    top:
                                        SizeVariables.getHeight(context) * 0.03,
                                  ),
                                  // color: Color.fromARGB(239, 228, 226, 226),
                                  // height: 50,
                                  child: Accordion(
                                    disableScrolling: true,
                                    // maxOpenSections: 1,
                                    headerBackgroundColorOpened:
                                        Color.fromARGB(239, 228, 226, 226),
                                    scaleWhenAnimating: true,
                                    openAndCloseAnimation: true,
                                    headerPadding: const EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 15),
                                    sectionOpeningHapticFeedback:
                                        SectionHapticFeedback.heavy,
                                    sectionClosingHapticFeedback:
                                        SectionHapticFeedback.light,
                                    children: [
                                      AccordionSection(
                                        contentBackgroundColor:
                                            Color.fromARGB(239, 228, 226, 226),
                                        // isO?pen: true,

                                        headerBackgroundColor:
                                            Color.fromARGB(239, 228, 226, 226),
                                        headerBackgroundColorOpened:
                                            Color.fromARGB(239, 228, 226, 226),
                                        contentBorderColor:
                                            Color.fromARGB(239, 228, 226, 226),
                                        header: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  child: Icon(
                                                    Icons
                                                        .currency_rupee_outlined,
                                                    color: Colors.black,
                                                    size: 18,
                                                  ),
                                                ),
                                                FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    incidentalDetails[index]
                                                        ['claim_amount'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                color: Color(0xfffe2f6ed),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0,
                                                    right: 5.0,
                                                    top: 2.5,
                                                    bottom: 2.5),
                                                child: Center(
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      incidentalDetails[index]
                                                          ['status'],
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color: Color(
                                                                  0xfff26af48),
                                                              fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        content: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 3,
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Text(
                                                    incidentalDetails[index]
                                                        ['emp_name'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 15,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 2,
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.6,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.007,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        incidentalDetails[index]
                                                            ['updated_at'],
                                                        style: Theme.of(context)
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
                                        contentHorizontalPadding: 20,
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
            // Container(
            //   height: SizeVariables.getHeight(context) * 1,
            //   child: Scrollbar(
            //     child: ListView.builder(
            //       physics: NeverScrollableScrollPhysics(),
            //       // itemCount: approvalLog!.length,
            //       itemCount: incidentalDetails.length,

            //       itemBuilder: (context, index) {
            //         return Container(
            //           height: 250,
            //           child: TimelineTile(
            //             endChild: Container(
            //               padding: EdgeInsets.only(
            //                 top: SizeVariables.getHeight(context) * 0.03,
            //               ),
            //               // color: Color.fromARGB(239, 228, 226, 226),
            //               // height: 50,
            //               child: Accordion(
            //                 disableScrolling: true,
            //                 // maxOpenSections: 1,
            //                 headerBackgroundColorOpened:
            //                     Color.fromARGB(239, 228, 226, 226),
            //                 scaleWhenAnimating: true,
            //                 openAndCloseAnimation: true,
            //                 headerPadding: const EdgeInsets.symmetric(
            //                     vertical: 7, horizontal: 15),
            //                 sectionOpeningHapticFeedback:
            //                     SectionHapticFeedback.heavy,
            //                 sectionClosingHapticFeedback:
            //                     SectionHapticFeedback.light,
            //                 children: [
            //                   AccordionSection(
            //                     contentBackgroundColor:
            //                         Color.fromARGB(239, 228, 226, 226),
            //                     // isO?pen: true,

            //                     headerBackgroundColor:
            //                         Color.fromARGB(239, 228, 226, 226),
            //                     headerBackgroundColorOpened:
            //                         Color.fromARGB(239, 228, 226, 226),
            //                     contentBorderColor:
            //                         Color.fromARGB(239, 228, 226, 226),
            //                     header: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Row(
            //                           children: [
            //                             Container(
            //                               child: Icon(
            //                                 Icons.currency_rupee_outlined,
            //                                 color: Colors.black,
            //                                 size: 18,
            //                               ),
            //                             ),
            //                             FittedBox(
            //                               fit: BoxFit.contain,
            //                               child: Text(
            //                                 '₹${incidentalDetails[index]['sum']}',
            //                                 style: Theme.of(context)
            //                                     .textTheme
            //                                     .bodyText2!
            //                                     .copyWith(
            //                                         color: Colors.black,
            //                                         fontSize: 20),
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         Container(
            //                           width:
            //                               SizeVariables.getWidth(context) * 0.3,
            //                           decoration: BoxDecoration(
            //                             borderRadius:
            //                                 BorderRadius.circular(5.0),
            //                             color: Color(0xfffe2f6ed),
            //                           ),
            //                           child: Padding(
            //                             padding: const EdgeInsets.only(
            //                                 left: 5.0,
            //                                 right: 5.0,
            //                                 top: 2.5,
            //                                 bottom: 2.5),
            //                             child: Center(
            //                               child: FittedBox(
            //                                 fit: BoxFit.contain,
            //                                 child: Text(
            //                                   incidentalDetails[index]['status'],
            //                                   style: Theme.of(context)
            //                                       .textTheme
            //                                       .bodyText1!
            //                                       .copyWith(
            //                                           color: Color(0xfff26af48),
            //                                           fontSize: 12),
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     content: Container(
            //                       decoration: BoxDecoration(
            //                         borderRadius: BorderRadius.circular(8),
            //                         border: Border.all(
            //                           color: Colors.grey,
            //                           width: 3,
            //                         ),
            //                       ),
            //                       child: Column(
            //                         children: [
            //                           Row(
            //                             children: [
            //                               Container(
            //                                 width: SizeVariables.getWidth(
            //                                         context) *
            //                                     0.54,
            //                                 child: FittedBox(
            //                                   fit: BoxFit.contain,
            //                                   child: Text(
            //                                     incidentalDetails[index]
            //                                                 ['remarks'] ==
            //                                             null
            //                                         ? ''
            //                                         : incidentalDetails[index]
            //                                             ['remarks'],
            //                                     style: Theme.of(context)
            //                                         .textTheme
            //                                         .bodyText1!
            //                                         .copyWith(
            //                                             color: Colors.black,
            //                                             fontSize: 15),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                           Container(
            //                             child: FittedBox(
            //                               fit: BoxFit.contain,
            //                               child: Text(
            //                                 incidentalDetails[index]['emp_name'],
            //                                 style: Theme.of(context)
            //                                     .textTheme
            //                                     .bodyText2!
            //                                     .copyWith(
            //                                         color: Colors.black,
            //                                         fontSize: 15,
            //                                         fontStyle:
            //                                             FontStyle.italic),
            //                               ),
            //                             ),
            //                           ),
            //                           Container(
            //                             height: 2,
            //                             width: SizeVariables.getWidth(context) *
            //                                 0.6,
            //                             color: Colors.black,
            //                           ),
            //                           SizedBox(
            //                             height:
            //                                 SizeVariables.getHeight(context) *
            //                                     0.007,
            //                           ),
            //                           Row(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.spaceAround,
            //                             children: [
            //                               Container(
            //                                 child: FittedBox(
            //                                   fit: BoxFit.contain,
            //                                   child: Text(
            //                                     incidentalDetails[index]
            //                                         ['updated_at'],
            //                                     style: Theme.of(context)
            //                                         .textTheme
            //                                         .bodyText1!
            //                                         .copyWith(
            //                                           color: Colors.black,
            //                                         ),
            //                                   ),
            //                                 ),
            //                               ),
            //                               // Container(
            //                               //   child: FittedBox(
            //                               //     fit: BoxFit.contain,
            //                               //     child: Text(
            //                               //       '12:02:03',
            //                               //       style: Theme.of(context)
            //                               //           .textTheme
            //                               //           .bodyText1!
            //                               //           .copyWith(
            //                               //               color: Colors.black),
            //                               //     ),
            //                               //   ),
            //                               // ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     contentHorizontalPadding: 20,
            //                     contentBorderWidth: 1,
            //                     // onOpenSection: () => print('onOpenSection ...'),
            //                     // onCloseSection: () => print('onCloseSection ...'),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             isLast: true,
            //             isFirst: true,
            //             indicatorStyle: IndicatorStyle(
            //               height: 100,
            //               width: 25,
            //               color: Colors.green,
            //               iconStyle: IconStyle(
            //                 iconData: Icons.download_done,
            //                 fontSize: 20,
            //               ),
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
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

  void _imageCaptured(BuildContext context) {
    Flushbar(
      message: "Image has been captured !",
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue,
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.blue,
    )..show(context);
  }

  _upload(String type, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 103, 103, 101),
        title: Container(
          child: Column(
            children: [
              Container(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Upload your document',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 18),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.1,
                  top: SizeVariables.getHeight(context) * 0.06,
                  // bottom: SizeVariables.getHeight(context) * 0.1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (type == "travel") {
                                      // var imagePath = await EdgeDetection
                                      //     .detectEdge
                                      //     .then((value) {
                                      //   print(value.toString());
                                      //   if (value == null) {
                                      //     _errorVal(context);
                                      //   } else {
                                      //     _imageCaptured(context);
                                      //   }
                                      //   return value;
                                      // });

                                      // setState(() {
                                      //   tfile = XFile(
                                      //       File(imagePath.toString()).path);
                                      // });
                                      String imagePath = join(
                                          (await getApplicationSupportDirectory())
                                              .path,
                                          "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                      bool success =
                                          await EdgeDetection.detectEdge(
                                        imagePath,
                                        canUseGallery: true,
                                        androidScanTitle:
                                            'Scanning', // use custom localizations for android
                                        androidCropTitle: 'Crop',
                                        androidCropBlackWhiteTitle:
                                            'Black White',
                                        androidCropReset: 'Reset',
                                      );

                                      setState(() {
                                        tfile = new XFile(
                                            new File(imagePath.toString())
                                                .path);
                                        // aorgfile_link = null;
                                      });
                                    } else if (type == "food") {
                                      // var imagePath = await EdgeDetection
                                      //     .detectEdge
                                      //     .then((value) {
                                      //   print(value.toString());
                                      //   if (value == null) {
                                      //     _errorVal(context);
                                      //   } else {
                                      //     _imageCaptured(context);
                                      //   }
                                      //   return value;
                                      // });
                                      // setState(() {
                                      //   ffile = XFile(
                                      //       File(imagePath.toString()).path);
                                      // });
                                      String imagePath = join(
                                          (await getApplicationSupportDirectory())
                                              .path,
                                          "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                      bool success =
                                          await EdgeDetection.detectEdge(
                                        imagePath,
                                        canUseGallery: true,
                                        androidScanTitle:
                                            'Scanning', // use custom localizations for android
                                        androidCropTitle: 'Crop',
                                        androidCropBlackWhiteTitle:
                                            'Black White',
                                        androidCropReset: 'Reset',
                                      );

                                      setState(() {
                                        ffile = new XFile(
                                            new File(imagePath.toString())
                                                .path);
                                        // aorgfile_link = null;
                                      });
                                    } else if (type == "incidental") {
                                      // var imagePath = await EdgeDetection
                                      //     .detectEdge
                                      //     .then((value) {
                                      //   print(value.toString());
                                      //   if (value == null) {
                                      //     _errorVal(context);
                                      //   } else {
                                      //     _imageCaptured(context);
                                      //   }
                                      //   return value;
                                      // });

                                      // setState(() {
                                      //   ifile = XFile(
                                      //       File(imagePath.toString()).path);
                                      // });
                                      String imagePath = join(
                                          (await getApplicationSupportDirectory())
                                              .path,
                                          "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                      bool success =
                                          await EdgeDetection.detectEdge(
                                        imagePath,
                                        canUseGallery: true,
                                        androidScanTitle:
                                            'Scanning', // use custom localizations for android
                                        androidCropTitle: 'Crop',
                                        androidCropBlackWhiteTitle:
                                            'Black White',
                                        androidCropReset: 'Reset',
                                      );

                                      setState(() {
                                        ifile = new XFile(
                                            new File(imagePath.toString())
                                                .path);
                                        // aorgfile_link = null;
                                      });
                                    }
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                InkWell(
                                  onTap: () async {
                                    // tfile = (await FilePicker.platform
                                    //     .pickFiles()) as i.XFile?;
                                  },
                                  child: Icon(
                                    Icons.file_copy_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Invoice',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: const Color.fromARGB(
                                            255, 230, 217, 217)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _finalSum(String type, String paytype, String individual_claimamt) {
    if (type == "travel") {
      if (tclaim_amount.text == "") {
        _final_amount = 0.0 +
            // double.parse(aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
            double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text) +
            // double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
            double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
      } else {
        _final_amount = double.parse(tclaim_amount.text) +
            // double.parse(aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
            double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text) +
            // double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
            double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
      }
    } else if (type == "food") {
      if (fclaim_amount.text == "") {
        _final_amount = 0.0 +
            double.parse(tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
            // double.parse(aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
            // double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
            double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
      } else {
        _final_amount = double.parse(fclaim_amount.text) +
            double.parse(tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
            // double.parse(aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
            // double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
            double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
      }
      // if (paytype == "Paid by self") {
      //   if (fclaim_amount.text == "") {
      //     _final_amount = 0.0 +
      //         double.parse(
      //             tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
      //         double.parse(
      //             aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
      //         double.parse(
      //             lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
      //         double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
      //   } else {
      //     _final_amount = double.parse(fclaim_amount.text) +
      //         double.parse(
      //             tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
      //         double.parse(
      //             aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
      //         double.parse(
      //             lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
      //         double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
      //   }
      // } else {
      //   _final_amount = double.parse(
      //           tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
      //       double.parse(aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
      //       double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
      //       double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
      // }
    } else if (type == "incidental") {
      if (iclaim_amount.text == "") {
        _final_amount = 0.0 +
            double.parse(tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
            // double.parse(aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
            // double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
            double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text);
      } else {
        _final_amount = double.parse(iclaim_amount.text) +
            double.parse(tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
            // double.parse(aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
            // double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
            double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text);
      }
      // if (paytype == "Paid by self") {
      //   if (iclaim_amount.text == "") {
      //     _final_amount = 0.0 +
      //         double.parse(
      //             tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
      //         double.parse(
      //             aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
      //         double.parse(
      //             lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
      //         double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text);
      //   } else {
      //     _final_amount = double.parse(iclaim_amount.text) +
      //         double.parse(
      //             tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
      //         double.parse(
      //             aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
      //         double.parse(
      //             lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
      //         double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text);
      //   }
      // } else {
      //   _final_amount = double.parse(
      //           tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
      //       double.parse(aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
      //       double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
      //       double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text);
      // }
    }
  }

  Future<Null> displayPrediction(
      String place_id, TextEditingController field) async {
    if (place_id != null) {
      GoogleMapsPlaces googleplace = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail =
          await googleplace.getDetailsByPlaceId(place_id);

      field.text = detail.result.formattedAddress.toString();
    }
  }

  _submitpopup(String type, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 103, 103, 101),
        title: Container(
          child: Column(
            children: [
              Container(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Are You Sure You Want To Submit This Claim?',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.03,
              ),
            ],
          ),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              // color: Color.fromARGB(168, 94, 92, 92),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 74, 74, 70),
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(168, 94, 92, 92),
              ),
              //     disabledColor: Colors.red,
              // disabledTextColor: Colors.black,
              // padding: const EdgeInsets.all(8),
              // textColor: Color(0xffF59F23),
              // color: Color.fromARGB(168, 81, 80, 80),
              onPressed: () => Provider.of<ClaimzFormIndividualViewModel>(
                      context,
                      listen: false)
                  .conveyanceFinalSubmit(context, widget.data['doc_no']),
              child: Text('Ok ',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Color(0xffF59F23),
                      )),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              // color: Color.fromARGB(168, 94, 92, 92),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 74, 74, 70),
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(168, 94, 92, 92),
              ),
              //     disabledColor: Colors.red,
              // disabledTextColor: Colors.black,
              // padding: const EdgeInsets.all(8),
              // textColor: Color(0xffF59F23),
              // color: Color.fromARGB(168, 81, 80, 80),
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No',
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Color(0xffF59F23),
                      )),
            ),
          ),
        ],
      ),
    );
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
