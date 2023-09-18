import 'dart:io';
import 'dart:math';
import 'package:another_flushbar/flushbar.dart';
import 'package:chip_list/chip_list.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/models/iternaryModel.dart';
import 'package:claimz/res/components/buttonStyle.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/res/components/content_dialog.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/travelViewModel.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart' as i;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../../config/mediaQuery.dart';
import '../../../viewModel/claimzViewModel.dart';
import '../../config/mediaQuery.dart';
import '../../widgets/claimzfromWidget/claimzHeader.dart';
import '../../widgets/incidentalExpenseWidget/approvedIncidental.dart';
import '../../widgets/incidentalExpenseWidget/pendingIncidental.dart';
import '../../widgets/incidentalExpenseWidget/rejectedIncidental.dart';

class TravelHistoryForm extends StatefulWidget {
  final Map<dynamic, dynamic> args;

  TravelHistoryForm(Map this.args);

  // const TravelHistoryForm({Key? key}) : super(key: key);

  @override
  State<TravelHistoryForm> createState() => _TravelHistoryFormState();
}

class _TravelHistoryFormState extends State<TravelHistoryForm> {
  final ImagePicker _picker = ImagePicker();

  TextEditingController meet_to = new TextEditingController();
  TextEditingController feedback = new TextEditingController();
  TextEditingController purpose = new TextEditingController();

  TextEditingController serviceprovider = new TextEditingController();
  TextEditingController from = new TextEditingController();
  TextEditingController to = new TextEditingController();
  TextEditingController departure = new TextEditingController();
  TextEditingController return_travel = new TextEditingController();
  TextEditingController tfrom_date = new TextEditingController();
  TextEditingController tto_date = new TextEditingController();
  TextEditingController tclaim_date = new TextEditingController();
  TextEditingController tfrom_time = new TextEditingController();
  TextEditingController tto_time = new TextEditingController();
  TextEditingController tgst_no = new TextEditingController();
  TextEditingController tgst_amount = new TextEditingController();
  TextEditingController tbasic_amount = new TextEditingController();
  TextEditingController tclaim_amount = new TextEditingController();
  TextEditingController texchangerate = new TextEditingController();
  XFile? tfile;
  XFile? torgfile;
  TextEditingController _place = TextEditingController();

  TextEditingController aserviceprovider = new TextEditingController();
  TextEditingController afrom = new TextEditingController();
  TextEditingController ato = new TextEditingController();
  TextEditingController afrom_date = new TextEditingController();
  TextEditingController ato_date = new TextEditingController();
  TextEditingController aclaim_date = new TextEditingController();
  TextEditingController aftime = new TextEditingController();
  TextEditingController attime = new TextEditingController();
  TextEditingController afrom_time = new TextEditingController();
  TextEditingController ato_time = new TextEditingController();
  TextEditingController agst_no = new TextEditingController();
  TextEditingController agst_amount = new TextEditingController();
  TextEditingController abasic_amount = new TextEditingController();
  TextEditingController aclaim_amount = new TextEditingController();
  TextEditingController aexchangerate = new TextEditingController();
  XFile? afile;
  XFile? aorgfile;

  TextEditingController fserviceprovider = new TextEditingController();
  TextEditingController ffrom = new TextEditingController();
  TextEditingController fto = new TextEditingController();
  TextEditingController ffrom_date = new TextEditingController();
  TextEditingController fto_date = new TextEditingController();
  TextEditingController fclaim_date = new TextEditingController();
  TextEditingController ffrom_time = new TextEditingController();
  TextEditingController fto_time = new TextEditingController();
  TextEditingController fgst_no = new TextEditingController();
  TextEditingController fgst_amount = new TextEditingController();
  TextEditingController fbasic_amount = new TextEditingController();
  TextEditingController fclaim_amount = new TextEditingController();
  TextEditingController fexchangerate = new TextEditingController();
  XFile? ffile;
  XFile? forgfile;

  TextEditingController lserviceprovider = new TextEditingController();
  TextEditingController lfrom = new TextEditingController();
  TextEditingController lto = new TextEditingController();
  TextEditingController lfrom_date = new TextEditingController();
  TextEditingController lto_date = new TextEditingController();
  TextEditingController lclaim_date = new TextEditingController();
  TextEditingController lfrom_time = new TextEditingController();
  TextEditingController lto_time = new TextEditingController();
  TextEditingController lgst_no = new TextEditingController();
  TextEditingController lgst_amount = new TextEditingController();
  TextEditingController lbasic_amount = new TextEditingController();
  TextEditingController lclaim_amount = new TextEditingController();
  TextEditingController lexchangerate = new TextEditingController();
  XFile? lfile;
  XFile? lorgfile;

  TextEditingController iserviceprovider = new TextEditingController();
  TextEditingController ipurchase = new TextEditingController();
  TextEditingController ifrom = new TextEditingController();
  TextEditingController ito = new TextEditingController();
  TextEditingController ifrom_date = new TextEditingController();
  TextEditingController ito_date = new TextEditingController();
  TextEditingController iclaim_date = new TextEditingController();
  TextEditingController ifrom_time = new TextEditingController();
  TextEditingController ito_time = new TextEditingController();
  TextEditingController igst_no = new TextEditingController();
  TextEditingController igst_amount = new TextEditingController();
  TextEditingController ibasic_amount = new TextEditingController();
  TextEditingController iclaim_amount = new TextEditingController();
  TextEditingController iexchangerate = new TextEditingController();
  XFile? ifile;
  XFile? iorgfile;

  i.XFile? _ie_file;
  int _selection = 1;
  String selected_mode = '', selected_accomondation = '';
  TravelViewModel _iternaryDetails = new TravelViewModel();
  TravelViewModel _travel_details = new TravelViewModel();

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

  get _currentAddress_locality => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Map data_iternary = {
      "doc_no": widget.args["doc"].toString(),
      "all": widget.args["all"].toString(),
    };
    print(data_iternary);
    _iternaryDetails.postTravelIternary(data_iternary);

    if (widget.args["doc"].toString() != null) {
      _travel_details.postTravelDoc(data_iternary);
    }

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

    doc_no = widget.args["doc"].toString();

    // if (doc_no != "null") {
    //   _travel_details.postTravelDoc(widget.args);
    // }

    Map data = {
      "month": "",
      "type": "",
      "year": "",
      "user_id": "",
      "Info": "1" //self
    };
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

  var details = "Paid by self";
  var adetails = "Paid by self";
  var fdetails = "Paid by self";
  var idetails = "Paid by self";
  var ldetails = "Paid by self";

  List<String> detail = [
    "Paid by company",
    "Paid by self",
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          body: ChangeNotifierProvider<TravelViewModel>(
            create: (_) => _iternaryDetails,
            child: Consumer<TravelViewModel>(
              builder: (context, value, child) {
                switch (value.iternaryDetails.status) {
                  case Status.LOADING:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.COMPLETED:
                    clipstyle.clear();
                    cliphotel.clear();

                    for (int i = 0;
                        i <
                            value.iternaryDetails.data!.data!.modeOfTravels!
                                .length;
                        i++) {
                      clipstyle.add(value
                          .iternaryDetails.data!.data!.modeOfTravels![i].name
                          .toString());
                    }
                    for (int i = 0;
                        i <
                            value.iternaryDetails.data!.data!.accommodations!
                                .length;
                        i++) {
                      cliphotel.add(value
                          .iternaryDetails.data!.data!.accommodations![i].name
                          .toString());
                    }
                    return
                        // FutureBuilder(
                        //   future: myFuture,
                        //   builder: (ctx, snapshot){
                        //
                        //   }),
                        ChangeNotifierProvider<TravelViewModel>(
                      create: (_) => _travel_details,
                      child: Consumer<TravelViewModel>(
                        builder: (context, valuex, child) {
                          switch (valuex.iternaryDetails.status) {
                            case Status.LOADING:
                              return Center(
                                child: CircularProgressIndicator(),
                              );

                            case Status.COMPLETED:
                              if (doc_no != "null") {
                                if (page_load == 0) {
                                  if (valuex.iternaryDetails!.data!.data!
                                      .meetingDetails!.isNotEmpty) {
                                    meet_to.text = valuex.iternaryDetails!.data!
                                        .data!.meetingDetails![0].metWhom
                                        .toString();
                                    feedback.text = valuex.iternaryDetails!
                                        .data!.data!.meetingDetails![0].feedback
                                        .toString();
                                    purpose.text = valuex.iternaryDetails!.data!
                                        .data!.meetingDetails![0].purposeOfVisit
                                        .toString();
                                  }

                                  if (valuex.iternaryDetails!.data!.data!
                                          .travel !=
                                      null) {
                                    serviceprovider.text = valuex
                                        .iternaryDetails!
                                        .data!
                                        .data!
                                        .travel!
                                        .serviceProvider
                                        .toString();
                                    from.text = valuex.iternaryDetails!.data!
                                        .data!.travel!.fromPlace
                                        .toString();
                                    to.text = valuex.iternaryDetails!.data!
                                        .data!.travel!.toPlace
                                        .toString();
                                    departure.text = valuex.iternaryDetails!
                                        .data!.data!.travel!.serviceProvider
                                        .toString();
                                    return_travel.text = valuex.iternaryDetails!
                                        .data!.data!.travel!.serviceProvider
                                        .toString();
                                    tfrom_date.text = valuex.iternaryDetails!
                                        .data!.data!.travel!.fromDate
                                        .toString();
                                    tto_date.text = valuex.iternaryDetails!
                                        .data!.data!.travel!.toDate
                                        .toString();
                                    tclaim_date.text = valuex.iternaryDetails!
                                        .data!.data!.travel!.claimDate
                                        .toString();
                                    tfrom_time.text = valuex.iternaryDetails!
                                        .data!.data!.travel!.fromTime
                                        .toString();
                                    tto_time.text = valuex.iternaryDetails!
                                        .data!.data!.travel!.toTime
                                        .toString();
                                    tgst_no.text = valuex.iternaryDetails!.data!
                                        .data!.travel!.gstNo
                                        .toString();
                                    tgst_amount.text = valuex.iternaryDetails!
                                        .data!.data!.travel!.gstAmount
                                        .toString();
                                    tbasic_amount.text = valuex.iternaryDetails!
                                        .data!.data!.travel!.basicAmount
                                        .toString();
                                    tclaim_amount.text = valuex.iternaryDetails!
                                        .data!.data!.travel!.claimAmount
                                        .toString();
                                    texchangerate.text = valuex.iternaryDetails!
                                        .data!.data!.travel!.exchangeRate
                                        .toString();
                                  }
                                  if (valuex.iternaryDetails!.data!.data!
                                          .accomodation !=
                                      null) {
                                    aserviceprovider.text = valuex
                                        .iternaryDetails!
                                        .data!
                                        .data!
                                        .accomodation!
                                        .serviceProvider
                                        .toString();
                                    afrom.text = valuex.iternaryDetails!.data!
                                        .data!.accomodation!.fromPlace
                                        .toString();
                                    ato.text = valuex.iternaryDetails!.data!
                                        .data!.accomodation!.toPlace
                                        .toString();
                                    afrom_date.text = valuex.iternaryDetails!
                                        .data!.data!.accomodation!.fromDate
                                        .toString();
                                    ato_date.text = valuex.iternaryDetails!
                                        .data!.data!.accomodation!.toDate
                                        .toString();
                                    aclaim_date.text = valuex.iternaryDetails!
                                        .data!.data!.accomodation!.claimDate
                                        .toString();
                                    aftime.text = valuex.iternaryDetails!.data!
                                        .data!.accomodation!.fromTime
                                        .toString();
                                    attime.text = valuex.iternaryDetails!.data!
                                        .data!.accomodation!.toTime
                                        .toString();
                                    afrom_time.text = valuex.iternaryDetails!
                                        .data!.data!.accomodation!.fromTime
                                        .toString();
                                    ato_time.text = valuex.iternaryDetails!
                                        .data!.data!.accomodation!.toTime
                                        .toString();
                                    agst_no.text = valuex.iternaryDetails!.data!
                                        .data!.accomodation!.gstNo
                                        .toString();
                                    agst_amount.text = valuex.iternaryDetails!
                                        .data!.data!.accomodation!.gstAmount
                                        .toString();
                                    abasic_amount.text = valuex.iternaryDetails!
                                        .data!.data!.accomodation!.basicAmount
                                        .toString();
                                    aclaim_amount.text = valuex.iternaryDetails!
                                        .data!.data!.accomodation!.claimAmount
                                        .toString();
                                    aexchangerate.text = valuex.iternaryDetails!
                                        .data!.data!.accomodation!.exchangeRate
                                        .toString();
                                  }
                                  if (valuex
                                          .iternaryDetails!.data!.data!.food !=
                                      null) {
                                    fserviceprovider.text = valuex
                                        .iternaryDetails!
                                        .data!
                                        .data!
                                        .food!
                                        .serviceProvider
                                        .toString();
                                    fclaim_date.text = valuex.iternaryDetails!
                                        .data!.data!.food!.claimDate
                                        .toString();
                                    fgst_no.text = valuex.iternaryDetails!.data!
                                        .data!.food!.gstNo
                                        .toString();
                                    fgst_amount.text = valuex.iternaryDetails!
                                        .data!.data!.food!.gstAmount
                                        .toString();
                                    fbasic_amount.text = valuex.iternaryDetails!
                                        .data!.data!.food!.basicAmount
                                        .toString();
                                    fclaim_amount.text = valuex.iternaryDetails!
                                        .data!.data!.food!.claimAmount
                                        .toString();
                                    fexchangerate.text = valuex.iternaryDetails!
                                        .data!.data!.food!.exchangeRate
                                        .toString();
                                  }
                                  if (valuex
                                          .iternaryDetails!.data!.data!.local !=
                                      null) {
                                    lserviceprovider.text = valuex
                                        .iternaryDetails!
                                        .data!
                                        .data!
                                        .local!
                                        .serviceProvider
                                        .toString();
                                    lclaim_date.text = valuex.iternaryDetails!
                                        .data!.data!.local!.claimDate
                                        .toString();
                                    lgst_no.text = valuex.iternaryDetails!.data!
                                        .data!.local!.gstNo
                                        .toString();
                                    lgst_amount.text = valuex.iternaryDetails!
                                        .data!.data!.local!.gstAmount
                                        .toString();
                                    lbasic_amount.text = valuex.iternaryDetails!
                                        .data!.data!.local!.basicAmount
                                        .toString();
                                    lclaim_amount.text = valuex.iternaryDetails!
                                        .data!.data!.local!.claimAmount
                                        .toString();
                                    lexchangerate.text = valuex.iternaryDetails!
                                        .data!.data!.local!.exchangeRate
                                        .toString();
                                  }
                                  if (valuex.iternaryDetails!.data!.data!
                                          .incidental !=
                                      null) {
                                    iserviceprovider.text = valuex
                                        .iternaryDetails!
                                        .data!
                                        .data!
                                        .incidental!
                                        .serviceProvider
                                        .toString();
                                    iclaim_date.text = valuex.iternaryDetails!
                                        .data!.data!.incidental!.claimDate
                                        .toString();
                                    igst_no.text = valuex.iternaryDetails!.data!
                                        .data!.incidental!.gstNo
                                        .toString();
                                    igst_amount.text = valuex.iternaryDetails!
                                        .data!.data!.incidental!.gstAmount
                                        .toString();
                                    ibasic_amount.text = valuex.iternaryDetails!
                                        .data!.data!.incidental!.basicAmount
                                        .toString();
                                    iclaim_amount.text = valuex.iternaryDetails!
                                        .data!.data!.incidental!.claimAmount
                                        .toString();
                                    iexchangerate.text = valuex.iternaryDetails!
                                        .data!.data!.incidental!.exchangeRate
                                        .toString();
                                  }
                                  _final_amount = double.parse(
                                          tclaim_amount.text == ""
                                              ? "0"
                                              : tclaim_amount.text) +
                                      double.parse(aclaim_amount.text == ""
                                          ? "0"
                                          : aclaim_amount.text) +
                                      double.parse(fclaim_amount.text == ""
                                          ? "0"
                                          : fclaim_amount.text) +
                                      double.parse(lclaim_amount.text == ""
                                          ? "0"
                                          : lclaim_amount.text) +
                                      double.parse(iclaim_amount.text == ""
                                          ? "0"
                                          : iclaim_amount.text);
                                  page_load += 1;
                                }
                              }
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    //box
                                    padding: EdgeInsets.only(
                                      top: SizeVariables.getHeight(context) *
                                          0.05,
                                      left: SizeVariables.getWidth(context) *
                                          0.04,
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
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.02,
                                            ),
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                'Travel Claim Form',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: SizeVariables.getWidth(
                                                        context) *
                                                    0.13,
                                              ),
                                              child: doc_no != "null"
                                                  ? Row(
                                                      children: [
                                                        FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Icon(
                                                            Icons
                                                                .file_open_rounded,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            width: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.02),
                                                        FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Text(
                                                            doc_no,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .amber,
                                                                    fontSize:
                                                                        16),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : SizedBox(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              SizeVariables.getWidth(context) *
                                                  0.02,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: SizeVariables.getWidth(
                                                    context) *
                                                0.05,
                                            right: SizeVariables.getWidth(
                                                    context) *
                                                0.1,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                                    left:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.03,
                                                  ),
                                                  child: const Text(
                                                    '₹',
                                                    style: TextStyle(
                                                      fontSize: 35,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.1,
                                                  ),
                                                  child: Container(
                                                    // color: Colors.amber,
                                                    padding: EdgeInsets.only(
                                                        // left: SizeVariables.getWidth(
                                                        //     context) *
                                                        //     0.07,
                                                        ),
                                                    width:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.04,
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.05,
                                                    child: InkWell(
                                                      onTap: () {
                                                        _submitpopup(
                                                            "submit", context);
                                                      },
                                                      child: Lottie.asset(
                                                          'assets/json/final_submit.json',
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.02,
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
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/travelIcon/Information.svg",
                                                            height: SizeVariables
                                                                    .getHeight(
                                                                        context) *
                                                                0.03,
                                                            width: SizeVariables
                                                                    .getWidth(
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
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.045),
                                            Container(
                                              // color: Colors.pink,
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.77,
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.1,
                                              // color: Colors.pink,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: _selection == 0
                                                          ? Colors.amber
                                                          : Colors.black,
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(3),
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
                                                      decoration:
                                                          new BoxDecoration(
                                                        color: Colors.black,
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            // color: Colors.orangeAccent,
                                                            blurRadius: 2.0,
                                                            offset:
                                                                const Offset(
                                                                    0.0, 2.0),
                                                          ),
                                                        ],
                                                      ),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white24,
                                                        radius: 30,
                                                        // color: Colors.pink,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.015,
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/travelIcon/flightbus.svg",
                                                                height: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.035,
                                                                width: SizeVariables
                                                                        .getWidth(
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
                                                    width:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.025,
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(3),
                                                      primary: _selection == 2
                                                          ? Colors.amber
                                                          : Colors.black,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        _selection = 2;
                                                        Map data = {
                                                          "month": "",
                                                          "type": "Hotel",
                                                          "year": "",
                                                          "user_id": "",
                                                          "all": "2",
                                                        };
                                                      });
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          new BoxDecoration(
                                                        color: Colors.black,
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            // color: Colors.orangeAccent,
                                                            blurRadius: 2.0,
                                                            offset:
                                                                const Offset(
                                                                    0.0, 2.0),
                                                          ),
                                                        ],
                                                      ),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white24,
                                                        radius: 30,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.015,
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/travelIcon/Hotel.svg",
                                                                height: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.035,
                                                                width: SizeVariables
                                                                        .getWidth(
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
                                                    width:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.025,
                                                  ),
                                                  // ElevatedButton(
                                                  //   style: ElevatedButton
                                                  //       .styleFrom(
                                                  //     shape: CircleBorder(),
                                                  //     padding:
                                                  //         EdgeInsets.all(3),
                                                  //     primary: _selection == 3
                                                  //         ? Colors.amber
                                                  //         : Colors.black,
                                                  //   ),
                                                  //   onPressed: () {
                                                  //     setState(() {
                                                  //       _selection = 3;
                                                  //       Map data = {
                                                  //         "month": "",
                                                  //         "type": "Food",
                                                  //         "year": "",
                                                  //         "user_id": "",
                                                  //         "all": "3" //self
                                                  //       };
                                                  //     });
                                                  //   },
                                                  //   child: Container(
                                                  //     decoration:
                                                  //         new BoxDecoration(
                                                  //       color: Colors.black,
                                                  //       shape:
                                                  //           BoxShape.rectangle,
                                                  //       borderRadius:
                                                  //           BorderRadius
                                                  //               .circular(50),
                                                  //       boxShadow: [
                                                  //         BoxShadow(
                                                  //           // color: Colors.orangeAccent,
                                                  //           blurRadius: 2.0,
                                                  //           offset:
                                                  //               const Offset(
                                                  //                   0.0, 2.0),
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  //     child: CircleAvatar(
                                                  //       backgroundColor:
                                                  //           Colors.white24,
                                                  //       radius: 30,
                                                  //       child: Column(
                                                  //         children: [
                                                  //           Container(
                                                  //             padding:
                                                  //                 EdgeInsets
                                                  //                     .only(
                                                  //               top: SizeVariables
                                                  //                       .getHeight(
                                                  //                           context) *
                                                  //                   0.015,
                                                  //             ),
                                                  //             child: SvgPicture
                                                  //                 .asset(
                                                  //               "assets/travelIcon/Food.svg",
                                                  //               height: SizeVariables
                                                  //                       .getHeight(
                                                  //                           context) *
                                                  //                   0.035,
                                                  //               width: SizeVariables
                                                  //                       .getWidth(
                                                  //                           context) *
                                                  //                   0.05,
                                                  //             ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // SizedBox(
                                                  //   width:
                                                  //       SizeVariables.getHeight(
                                                  //               context) *
                                                  //           0.025,
                                                  // ),
                                                  // ElevatedButton(
                                                  //   style: ElevatedButton
                                                  //       .styleFrom(
                                                  //     shape: CircleBorder(),
                                                  //     padding:
                                                  //         EdgeInsets.all(3),
                                                  //     primary: _selection == 4
                                                  //         ? Colors.amber
                                                  //         : Colors.black,
                                                  //   ),
                                                  //   onPressed: () {
                                                  //     setState(() {
                                                  //       _selection = 4;
                                                  //       Map data = {
                                                  //         "month": "",
                                                  //         "type": "Local",
                                                  //         "year": "",
                                                  //         "user_id": "",
                                                  //         "all": "4" //self
                                                  //       };
                                                  //     });
                                                  //   },
                                                  //   child: Container(
                                                  //     decoration:
                                                  //         new BoxDecoration(
                                                  //       color: Colors.black,
                                                  //       shape:
                                                  //           BoxShape.rectangle,
                                                  //       borderRadius:
                                                  //           BorderRadius
                                                  //               .circular(50),
                                                  //       boxShadow: [
                                                  //         BoxShadow(
                                                  //           // color: Colors.orangeAccent,
                                                  //           blurRadius: 2.0,
                                                  //           offset:
                                                  //               const Offset(
                                                  //                   0.0, 2.0),
                                                  //         ),
                                                  //       ],
                                                  //     ),
                                                  //     child: CircleAvatar(
                                                  //       backgroundColor:
                                                  //           Colors.white24,
                                                  //       radius: 30,
                                                  //       child: Column(
                                                  //         children: [
                                                  //           Container(
                                                  //             padding:
                                                  //                 EdgeInsets
                                                  //                     .only(
                                                  //               top: SizeVariables
                                                  //                       .getHeight(
                                                  //                           context) *
                                                  //                   0.016,
                                                  //             ),
                                                  //             child: SvgPicture
                                                  //                 .asset(
                                                  //               "assets/travelIcon/Local Travel.svg",
                                                  //               height: SizeVariables
                                                  //                       .getHeight(
                                                  //                           context) *
                                                  //                   0.035,
                                                  //               width: SizeVariables
                                                  //                       .getWidth(
                                                  //                           context) *
                                                  //                   0.05,
                                                  //             ),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // // ),
                                                  // SizedBox(
                                                  //   width:
                                                  //       SizeVariables.getHeight(
                                                  //               context) *
                                                  //           0.025,
                                                  // ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      padding:
                                                          EdgeInsets.all(3),
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
                                                      decoration:
                                                          new BoxDecoration(
                                                        color: Colors.black,
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            // color: Colors.orangeAccent,
                                                            blurRadius: 2.0,
                                                            offset:
                                                                const Offset(
                                                                    0.0, 2.0),
                                                          ),
                                                        ],
                                                      ),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white24,
                                                        radius: 30,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.016,
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/travelIcon/incidentals.svg",
                                                                height: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.035,
                                                                width: SizeVariables
                                                                        .getWidth(
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
                                    height:
                                        SizeVariables.getHeight(context) * 0.02,
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
                                            color: Color.fromARGB(
                                                239, 228, 226, 226)),
                                        child: ListView(
                                          children: [
                                            _selection == 1
                                                ?
                                                // _infotab(valuex.iternaryDetails!.data!.data!.meetingDetails,
                                                //     valuex.iternaryDetails!.data!.data!.approvalLog)
                                                _infotab()
                                                : SizedBox(),
                                            _selection == 0
                                                ? _traveltab()
                                                : SizedBox(),
                                            _selection == 2
                                                ? _accomondationtab()
                                                : SizedBox(),
                                            _selection == 3
                                                ? _foodtab()
                                                : SizedBox(),
                                            _selection == 4
                                                ? _localtab()
                                                : SizedBox(),
                                            _selection == 5
                                                ? _incidentaltab()
                                                : SizedBox(),
                                            SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );

                            default:
                              return Container();
                          }
                        },
                        child: Container(),
                      ),
                    );
                  case Status.ERROR:
                    return Center(
                      child: Text(value.iternaryDetails.message.toString()),
                    );
                }

                return Container();
              },
            ),
          ),
        ),
      ],
    );
  }

  _infotab() {
    if (doc_no != null) {
      // List<MeetingDetails>? meetingDetails,List<ApprovalLog>? approvalLog
      // meet_to.text = meetingDetails![0].metWhom.toString();
    }
    return Padding(
      // info
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
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
                      style: Theme.of(context)
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
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'Meet to whom',
                              // hintText: "From",
                              // hintStyle: Theme.of(context)
                              //     .textTheme
                              //     .bodyText2!
                              //     .copyWith(color: Colors.grey),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 16, color: Colors.black),
                            ),
                            style: Theme.of(context)
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
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'Feedback',
                              // hintText: "To",
                              // hintStyle: Theme.of(context)
                              //     .textTheme
                              //     .bodyText2!
                              //     .copyWith(color: Colors.grey),
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 16, color: Colors.black),
                            ),
                            style: Theme.of(context)
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
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 167, 164, 164)),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 194, 191, 191)),
                          ),
                          // border: InputBorder.none,
                          labelText: 'Purpose',
                          // hintText: "To",
                          // hintStyle: Theme.of(context)
                          //     .textTheme
                          //     .bodyText2!
                          //     .copyWith(color: Colors.grey),
                          labelStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 16, color: Colors.black),
                        ),
                        style: Theme.of(context)
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
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.05),
                    child: AnimatedButton(
                      height: 45,
                      width: 100,
                      text: 'Save as Draft',
                      isReverse: true,
                      selectedTextColor: Colors.black,
                      transitionType: TransitionType.LEFT_TO_RIGHT,
                      textStyle: TextStyle(fontSize: 13),
                      backgroundColor: Colors.black,
                      borderColor: Colors.white,
                      borderRadius: 8,
                      borderWidth: 2,
                      onPress: () {
                        if (purpose.text.toString() == "") {
                          Flushbar(
                            message: "please provide a valid purpose",
                            icon: Icon(
                              Icons.info_outline,
                              size: 28.0,
                              color: Colors.blue,
                            ),
                            duration: Duration(seconds: 3),
                            leftBarIndicatorColor: Colors.blue,
                          )..show(context);
                        } else {
                          Map request_data = {
                            "met_whom": meet_to.text.toString(),
                            "purpose_of_visit": purpose.text.toString(),
                            "feedback": feedback.text.toString(),
                            "doc_no": widget.args["doc"] ??= "",
                          };
                          Provider.of<TravelViewModel>(context, listen: false)
                              .postPurposeDetails(context, request_data)
                              .then((value) {
                            setState(() {
                              print("DOCNO " + value["doc_no"]);
                              doc_no = value["doc_no"];
                            });
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _traveltab() {
    return Padding(
      //travel
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _upload("travel", context);
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

              // TextFormField(
              //   controller: invisible_travel,
              //   keyboardType: TextInputType.text,
              //   decoration: InputDecoration(
              //     // focusColor: Colors.black,
              //     enabledBorder: const UnderlineInputBorder(
              //       borderSide: BorderSide(
              //           width: 2,
              //           color: Color.fromARGB(255, 167, 164, 164)),
              //     ),
              //     focusedBorder: const UnderlineInputBorder(
              //       borderSide: BorderSide(
              //           width: 2,
              //           color: Color.fromARGB(255, 194, 191, 191)),
              //     ),
              //     // border: InputBorder.none,
              //     labelText: 'Name of Provider',
              //     // hintText: "To",
              //     // hintStyle: Theme.of(context)
              //     //     .textTheme
              //     //     .bodyText2!
              //     //     .copyWith(color: Colors.grey),
              //     labelStyle: Theme.of(context)
              //         .textTheme
              //         .bodyText1!
              //         .copyWith(fontSize: 20, color: Colors.black),
              //   ),
              //   style: Theme.of(context)
              //       .textTheme
              //       .bodyText1!
              //       .copyWith(color: Colors.black),
              //   showCursor: true,
              //   cursorColor: Colors.black,
              // ),

              Container(
                padding: EdgeInsets.only(
                  left: SizeVariables.getWidth(context) * 0.03,
                ),
                // color: Colors.amber,

                child: ChipList(
                    listOfChipNames: clipstyle,
                    activeBgColorList: [Colors.black],
                    inactiveBgColorList: [Colors.white],
                    activeTextColorList: [Colors.white],
                    inactiveTextColorList: [Colors.black],
                    listOfChipIndicesCurrentlySeclected: [_mode_of_travel],
                    inactiveBorderColorList: [Colors.black],
                    extraOnToggle: (val) {
                      setState(() {
                        _mode_of_travel = val;
                        selected_mode = clipstyle[val];
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.12),
                    height: SizeVariables.getHeight(context) * 0.045,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(10),
                    //   border: Border.all(
                    //     color: Colors.grey,
                    //     width: 3,
                    //   ),
                    // ),
                    child: DropdownButton<String>(
                      underline: Container(),
                      iconSize: 30,
                      icon: const Icon(
                        Icons.expand_more,
                        color: Colors.black,
                      ),
                      dropdownColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          mydata = value!;
                          print('SELECTEEEEED VALUEEEEEE $value');

                          if (mydata == 'Roundtrip') {
                            setState(() {
                              isClicked = true;
                            });
                          } else {
                            setState(() {
                              isClicked = false;
                            });
                          }
                        });
                      },
                      value: mydata,
                      items: datatrip.map((item) {
                        return DropdownMenuItem(
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.03),
                              child: Text(
                                item,
                                style: TextStyle(color: Colors.black),
                              ),
                            ));
                      }).toList(),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        child: Icon(Icons.handshake_outlined),
                      ),
                      SizedBox(
                        width: SizeVariables.getWidth(context) * 0.02,
                      ),
                      Container(
                        width: SizeVariables.getWidth(context) * 0.3,
                        // width: 300,
                        // height: 200,
                        child: TextFormField(
                          controller: serviceprovider,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            // focusColor: Colors.black,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 167, 164, 164)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 194, 191, 191)),
                            ),
                            // border: InputBorder.none,
                            labelText: 'Name of Provider',
                            // hintText: "To",
                            // hintStyle: Theme.of(context)
                            //     .textTheme
                            //     .bodyText2!
                            //     .copyWith(color: Colors.grey),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20, color: Colors.black),
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                          showCursor: true,
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
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'From',
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
                                  Component(Component.country, "in")
                                ],
                              ).then((value) {
                                String p = value!.placeId.toString();
                                displayPrediction(p, from);
                              });
                            },
                            style: Theme.of(context)
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
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 167, 164, 164)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 194, 191, 191)),
                            ),
                            // border: InputBorder.none,
                            labelText: 'To',
                            // hintText: "To",
                            // hintStyle: Theme.of(context)
                            //     .textTheme
                            //     .bodyText2!
                            //     .copyWith(color: Colors.grey),
                            labelStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18, color: Colors.black),
                          ),
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
                              components: [Component(Component.country, "in")],
                            ).then((value) {
                              String p = value!.placeId.toString();
                              displayPrediction(p, to);
                            });
                          },
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                          showCursor: true,
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
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      color: Colors.red,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)))
                                  .then((value) {
                                setState(() {
                                  // _dateTimeStart = value;
                                  departure.text = dateFormat
                                      .format(DateTime.parse(value.toString()));
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
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              // readOnly: true,
                              controller: departure,
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
                                labelText: 'Departure',
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
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: true,
                              cursorColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  isClicked == false
                      ? Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            color: Colors.blue,
                          ))
                      : Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            color: Colors.green,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2015),
                                            lastDate: DateTime.now()
                                                .add(const Duration(days: 365)))
                                        .then((value) {
                                      setState(() {
                                        // _dateTimeStart = value;
                                        return_travel.text = dateFormat.format(
                                            DateTime.parse(value.toString()));
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
                                  width: SizeVariables.getWidth(context) * 0.3,
                                  // width: 300,
                                  // height: 200,
                                  child: TextFormField(
                                    // readOnly: true,
                                    controller: return_travel,
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
                                      labelText: 'Return',
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
                                        .bodyText2!
                                        .copyWith(color: Colors.black),
                                    showCursor: true,
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
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
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                          ),
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
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)))
                                .then((value) {
                              setState(() {
                                // _dateTimeStart = value;
                                tfrom_date.text = dateFormat
                                    .format(DateTime.parse(value.toString()));
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
                          width: SizeVariables.getWidth(context) * 0.3,
                          // width: 300,
                          // height: 200,
                          child: TextFormField(
                            // readOnly: true,
                            controller: tfrom_date,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'From date',
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
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2015),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)))
                              .then((value) {
                            setState(() {
                              // _dateTimeStart = value;
                              tto_date.text = dateFormat
                                  .format(DateTime.parse(value.toString()));
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
                        width: SizeVariables.getWidth(context) * 0.3,
                        // width: 300,
                        // height: 200,
                        child: TextFormField(
                          // readOnly: true,
                          controller: tto_date,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 167, 164, 164)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 194, 191, 191)),
                            ),
                            // border: InputBorder.none,
                            labelText: 'To date',
                            // hintText: "To",
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
                              .bodyText2!
                              .copyWith(color: Colors.black),
                          showCursor: true,
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
                        InkWell(
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: timeFrom,
                            ).then((value) {
                              setState(() {
                                timeFrom = value!;
                                tfrom_time.text = timeFrom.format(context);
                                print(time_day);
                              });
                            });
                          },
                          child: Container(
                            child: Icon(Icons.watch_later_outlined),
                          ),
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.02,
                        ),
                        Container(
                          width: SizeVariables.getWidth(context) * 0.3,
                          // width: 300,
                          // height: 200,
                          child: TextFormField(
                            controller: tfrom_time,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'From time',
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
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showTimePicker(
                            context: context,
                            initialTime: timeFrom,
                          ).then((value) {
                            setState(() {
                              timeFrom = value!;
                              tto_time.text = timeFrom.format(context);
                              print(time_day);
                            });
                          });
                        },
                        child: Container(
                          child: Icon(Icons.watch_later_outlined),
                        ),
                      ),
                      SizedBox(
                        width: SizeVariables.getWidth(context) * 0.02,
                      ),
                      Container(
                        width: SizeVariables.getWidth(context) * 0.3,
                        // width: 300,
                        // height: 200,
                        child: TextFormField(
                          controller: tto_time,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 167, 164, 164)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 194, 191, 191)),
                            ),
                            // border: InputBorder.none,
                            labelText: 'To time',
                            // hintText: "To",
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
                              .bodyText2!
                              .copyWith(color: Colors.black),
                          showCursor: true,
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
                    // padding: EdgeInsets.only(
                    //   left: SizeVariables.getWidth(context) * 0.05,
                    // ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)))
                                .then((value) {
                              setState(() {
                                // _dateTimeStart = value;
                                tclaim_date.text = dateFormat
                                    .format(DateTime.parse(value.toString()));
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
                          width: SizeVariables.getWidth(context) * 0.3,
                          // width: 300,
                          // height: 200,
                          child: TextFormField(
                            // readOnly: true,
                            controller: tclaim_date,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'Doc date',
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
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Icon(Icons.account_balance_wallet_sharp),
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.02,
                        ),
                        Container(
                          width: SizeVariables.getWidth(context) * 0.3,
                          // width: 300,
                          // height: 200,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'Exchange rate',
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
                            controller: tgst_no,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'GST No',
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
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
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
                          controller: tgst_amount,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 167, 164, 164)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 194, 191, 191)),
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
                                .copyWith(fontSize: 18, color: Colors.black),
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                          showCursor: true,
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
                            controller: tbasic_amount,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
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
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context)
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
                          controller: tclaim_amount,
                          onChanged: (content) {
                            setState(() {
                              //_final_amount = double.parse(tclaim_amount.text);

                              _finalSum("travel", details.toString(),
                                  tclaim_amount.text);
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 167, 164, 164)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 194, 191, 191)),
                            ),
                            // border: InputBorder.none,
                            labelText: 'Claim Amount',
                            // hintText: "To",
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
                              .bodyText2!
                              .copyWith(color: Colors.black),
                          showCursor: true,
                          cursorColor: Colors.black,
                        ),
                      ),
                    ],
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
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Payment type',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.04),
                    child: Row(
                      children: [
                        Container(
                          child: Icon(Icons.book_online),
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.02,
                        ),
                        Container(
                          height: SizeVariables.getHeight(context) * 0.045,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(10),
                          //   border: Border.all(
                          //     color: Colors.grey,
                          //     width: 3,
                          //   ),
                          // ),
                          child: DropdownButton<String>(
                            underline: Container(),
                            iconSize: 30,
                            icon: const Icon(
                              Icons.expand_more,
                              color: Colors.black,
                            ),
                            dropdownColor: Colors.white,
                            onChanged: (value) {
                              setState(() {
                                details = value!;
                                print(value);
                                _finalSum("travel", details.toString(),
                                    tclaim_amount.text);
                              });
                            },
                            value: details,
                            items: detail.map((item) {
                              return DropdownMenuItem(
                                  value: item,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeVariables.getWidth(context) *
                                            0.03),
                                    child: Text(
                                      item,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ));
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        right: SizeVariables.getWidth(context) * 0.05),
                    child: AnimatedButton(
                      height: 45,
                      width: 100,
                      text: 'Save as Draft',
                      isReverse: true,
                      selectedTextColor: Colors.black,
                      transitionType: TransitionType.LEFT_TO_RIGHT,
                      textStyle: TextStyle(fontSize: 13),
                      backgroundColor: Colors.black,
                      borderColor: Colors.white,
                      borderRadius: 8,
                      borderWidth: 2,
                      onPress: () {
                        Map request_filename = {
                          "file_name": "document",
                        };
                        if (tfile == null) {
                          _errorVal(context);
                        } else {
                          Map<String, String> request_data = {
                            "claim_type": "travel",
                            "mod_of_travel": selected_mode,
                            "trip_way": mydata,
                            "from_place": from.text.toString(),
                            "to_place": to.text.toString(),
                            "service_provider": serviceprovider.text.toString(),
                            "travel_type":
                                texchangerate.text.toString() == "null"
                                    ? "domestic"
                                    : "international",
                            "from_date": tfrom_date.text.toString(),
                            "from_time": tfrom_time.text.toString(),
                            "to_date": tto_date.text.toString(),
                            "to_time": tto_time.text.toString(),
                            "date": tclaim_date.text.toString(),
                            "gst_no": tgst_no.text.toString(),
                            "gst_amount": tgst_amount.text.toString(),
                            "claim_amount": tclaim_amount.text.toString(),
                            "basic_amount": tbasic_amount.text.toString(),
                            "payment_type": details.toString(),
                            "exchange_rate": texchangerate.text.toString(),
                            "doc_no": doc_no,
                          };
                          Provider.of<TravelViewModel>(context, listen: false)
                              .postTravelFormSubmit(context, request_filename,
                                  tfile!, request_data);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _accomondationtab() {
    return Padding(
      //Accomodation
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
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
            // height: SizeVariables.getHeight(context) * 0.88,
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
                          'Accomodation',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _upload("accomodation", context);
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
                Row(
                  children: [
                    Container(
                      // color: Colors.amber,

                      child: ChipList(
                        listOfChipNames: cliphotel,
                        activeBgColorList: [Colors.black],
                        inactiveBgColorList: [Colors.white],
                        activeTextColorList: [Colors.white],
                        inactiveTextColorList: [Colors.black],
                        listOfChipIndicesCurrentlySeclected: [_mode_of_acco],
                        inactiveBorderColorList: [Colors.black],
                        extraOnToggle: (val) {
                          setState(() {
                            _mode_of_acco = val;
                            selected_accomondation = cliphotel[val];
                          });
                        },
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
                              controller: aserviceprovider,
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
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context)
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)))
                                  .then((value) {
                                setState(() {
                                  // _dateTimeStart = value;
                                  afrom_date.text = dateFormat
                                      .format(DateTime.parse(value.toString()));
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
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              controller: afrom_date,
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
                                labelText: 'From date',
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
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: true,
                              cursorColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)))
                                .then((value) {
                              setState(() {
                                // _dateTimeStart = value;
                                ato_date.text = dateFormat
                                    .format(DateTime.parse(value.toString()));
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
                          width: SizeVariables.getWidth(context) * 0.3,
                          // width: 300,
                          // height: 200,
                          child: TextFormField(
                            controller: ato_date,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'To date',
                              // hintText: "To",
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
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
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
                          InkWell(
                            onTap: () {
                              showTimePicker(
                                context: context,
                                initialTime: timeFrom,
                              ).then((value) {
                                setState(() {
                                  timeFrom = value!;
                                  afrom_time.text = timeFrom.format(context);
                                  print(time_day);
                                });
                              });
                            },
                            child: Container(
                              child: Icon(Icons.watch_later_outlined),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              // controller: aftime,
                              controller: afrom_time,
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
                                labelText: 'From time',
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
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: true,
                              cursorColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: timeFrom,
                            ).then((value) {
                              setState(() {
                                timeFrom = value!;
                                ato_time.text = timeFrom.format(context);
                                print(time_day);
                              });
                            });
                          },
                          child: Container(
                            child: Icon(Icons.watch_later_outlined),
                          ),
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.02,
                        ),
                        Container(
                          width: SizeVariables.getWidth(context) * 0.3,
                          // width: 300,
                          // height: 200,
                          child: TextFormField(
                            // controller: attime,
                            controller: ato_time,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'To time',
                              // hintText: "To",
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
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Claim',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(
                      //   left: SizeVariables.getWidth(context) * 0.05,
                      // ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)))
                                  .then((value) {
                                setState(() {
                                  // _dateTimeStart = value;
                                  aclaim_date.text = dateFormat
                                      .format(DateTime.parse(value.toString()));
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
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              controller: aclaim_date,
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
                                labelText: 'Doc date',
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
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: true,
                              cursorColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.account_balance_wallet_sharp),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              controller: aexchangerate,
                              keyboardType: TextInputType.number,
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
                                labelText: 'Exchange rate',
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
                              controller: agst_no,
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
                                labelText: 'GST No',
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
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: true,
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
                            controller: agst_amount,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
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
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
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
                              controller: abasic_amount,
                              keyboardType: TextInputType.number,
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
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context)
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
                            controller: aclaim_amount,
                            onChanged: (content) {
                              setState(() {
                                //_final_amount = double.parse(tclaim_amount.text);

                                _finalSum("accomodation", adetails.toString(),
                                    aclaim_amount.text);
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'Claim Amount',
                              // hintText: "To",
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
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
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
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Payment type',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.book_online),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            height: SizeVariables.getHeight(context) * 0.045,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(10),
                            //   border: Border.all(
                            //     color: Colors.grey,
                            //     width: 3,
                            //   ),
                            // ),
                            child: DropdownButton<String>(
                              underline: Container(),
                              iconSize: 30,
                              icon: const Icon(
                                Icons.expand_more,
                                color: Colors.black,
                              ),
                              dropdownColor: Colors.white,
                              onChanged: (value) {
                                setState(() {
                                  adetails = value!;
                                  print(value);
                                  _finalSum("accomodation", adetails.toString(),
                                      aclaim_amount.text);
                                });
                              },
                              value: adetails,
                              items: detail.map((item) {
                                return DropdownMenuItem(
                                    value: item,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeVariables.getWidth(context) *
                                                  0.03),
                                      child: Text(
                                        item,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.05),
                      child: AnimatedButton(
                        height: 45,
                        width: 100,
                        text: 'Save as Draft',
                        isReverse: true,
                        selectedTextColor: Colors.black,
                        transitionType: TransitionType.LEFT_TO_RIGHT,
                        textStyle: TextStyle(fontSize: 13),
                        backgroundColor: Colors.black,
                        borderColor: Colors.white,
                        borderRadius: 8,
                        borderWidth: 2,
                        onPress: () {
                          Map request_filename = {
                            "file_name": "document",
                          };
                          if (afile == null) {
                            _errorVal(context);
                          } else {
                            Map<String, String> request_data = {
                              "claim_type": "accomodation",
                              "mod_of_travel": "",
                              "trip_way": "",
                              "from_place": "",
                              "to_place": "",
                              "acco_type": selected_accomondation,
                              "service_provider":
                                  aserviceprovider.text.toString(),
                              "travel_type":
                                  aexchangerate.text.toString() == "null"
                                      ? "domestic"
                                      : "international",
                              "from_date": afrom_date.text.toString(),
                              "from_time": afrom_time.text.toString(),
                              "to_date": ato_date.text.toString(),
                              "to_time": ato_time.text.toString(),
                              "date": aclaim_date.text.toString(),
                              "gst_no": agst_no.text.toString(),
                              "gst_amount": agst_amount.text.toString(),
                              "claim_amount": aclaim_amount.text.toString(),
                              "basic_amount": abasic_amount.text.toString(),
                              "payment_type": adetails.toString(),
                              "exchange_rate": aexchangerate.text.toString(),
                              "doc_no": doc_no,
                            };
                            Provider.of<TravelViewModel>(context, listen: false)
                                .postTravelFormSubmit(context, request_filename,
                                    afile!, request_data);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _foodtab() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
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
                          'Food details',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _upload("food", context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.45,
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
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context)
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
                        top: SizeVariables.getWidth(context) * 0.02,
                        left: SizeVariables.getWidth(context) * 0.02,
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Claim',
                          style: Theme.of(context)
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(
                      //   left: SizeVariables.getWidth(context) * 0.05,
                      // ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)))
                                  .then((value) {
                                setState(() {
                                  // _dateTimeStart = value;
                                  fclaim_date.text = dateFormat
                                      .format(DateTime.parse(value.toString()));
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
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              controller: fclaim_date,
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
                                labelText: 'Doc. date',
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
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: true,
                              cursorColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.account_balance_wallet_sharp),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              controller: fexchangerate,
                              keyboardType: TextInputType.number,
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
                                labelText: 'Exchange rate',
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
                                labelText: 'GST No',
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
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: true,
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
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
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
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
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
                              keyboardType: TextInputType.number,
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
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context)
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
                            controller: fclaim_amount,
                            onChanged: (content) {
                              setState(() {
                                //_final_amount = double.parse(tclaim_amount.text);

                                _finalSum("food", fdetails.toString(),
                                    fclaim_amount.text);
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'Claim Amount',
                              // hintText: "To",
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
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
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
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Payment type',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.book_online),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            height: SizeVariables.getHeight(context) * 0.045,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(10),
                            //   border: Border.all(
                            //     color: Colors.grey,
                            //     width: 3,
                            //   ),
                            // ),
                            child: DropdownButton<String>(
                              underline: Container(),
                              iconSize: 30,
                              icon: const Icon(
                                Icons.expand_more,
                                color: Colors.black,
                              ),
                              dropdownColor: Colors.white,
                              onChanged: (value) {
                                setState(() {
                                  fdetails = value!;
                                  print(value);
                                  _finalSum("food", fdetails.toString(),
                                      fclaim_amount.text);
                                });
                              },
                              value: fdetails,
                              items: detail.map((item) {
                                return DropdownMenuItem(
                                    value: item,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeVariables.getWidth(context) *
                                                  0.03),
                                      child: Text(
                                        item,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.05),
                      child: AnimatedButton(
                        height: 45,
                        width: 100,
                        text: 'Save as Draft',
                        isReverse: true,
                        selectedTextColor: Colors.black,
                        transitionType: TransitionType.LEFT_TO_RIGHT,
                        textStyle: TextStyle(fontSize: 13),
                        backgroundColor: Colors.black,
                        borderColor: Colors.white,
                        borderRadius: 8,
                        borderWidth: 2,
                        onPress: () {
                          Map request_filename = {
                            "file_name": "document",
                          };
                          if (ffile == null) {
                            _errorVal(context);
                          } else {
                            Map<String, String> request_data = {
                              "claim_type": "food",
                              "mod_of_travel": "",
                              "trip_way": "",
                              "from_place": "",
                              "to_place": "",
                              "acco_type": "",
                              "service_provider":
                                  fserviceprovider.text.toString(),
                              "travel_type":
                                  fexchangerate.text.toString() == "null"
                                      ? "domestic"
                                      : "international",
                              "from_date": "",
                              "from_time": "",
                              "to_date": "",
                              "to_time": "",
                              "date": fclaim_date.text.toString(),
                              "gst_no": fgst_no.text.toString(),
                              "gst_amount": fgst_amount.text.toString(),
                              "claim_amount": fclaim_amount.text.toString(),
                              "basic_amount": fbasic_amount.text.toString(),
                              "payment_type": fdetails.toString(),
                              "exchange_rate": fexchangerate.text.toString(),
                              "doc_no": doc_no,
                            };
                            Provider.of<TravelViewModel>(context, listen: false)
                                .postTravelFormSubmit(context, request_filename,
                                    ffile!, request_data);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _incidentaltab() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _upload("incidental", context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.34,
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
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context)
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
                          left: SizeVariables.getWidth(context) * 0.048),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.details_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            width: SizeVariables.getWidth(context) * 0.76,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              controller: ipurchase,
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
                                labelText: 'Purchase details',
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
                        top: SizeVariables.getWidth(context) * 0.02,
                        left: SizeVariables.getWidth(context) * 0.02,
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Claim',
                          style: Theme.of(context)
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(
                      //   left: SizeVariables.getWidth(context) * 0.05,
                      // ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)))
                                  .then((value) {
                                setState(() {
                                  // _dateTimeStart = value;
                                  iclaim_date.text = dateFormat
                                      .format(DateTime.parse(value.toString()));
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
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              controller: iclaim_date,
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
                                labelText: 'Doc. date',
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
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: true,
                              cursorColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.account_balance_wallet_sharp),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              controller: iexchangerate,
                              keyboardType: TextInputType.number,
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
                                labelText: 'Exchange rate',
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
                                labelText: 'GST No',
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
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: true,
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
                            controller: igst_amount,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
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
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
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
                              keyboardType: TextInputType.number,
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
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context)
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
                            controller: iclaim_amount,
                            onChanged: (content) {
                              setState(() {
                                //_final_amount = double.parse(tclaim_amount.text);

                                _finalSum("incidental", idetails.toString(),
                                    iclaim_amount.text);
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'Claim Amount',
                              // hintText: "To",
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
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
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
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Payment type',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.book_online),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            height: SizeVariables.getHeight(context) * 0.045,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(10),
                            //   border: Border.all(
                            //     color: Colors.grey,
                            //     width: 3,
                            //   ),
                            // ),
                            child: DropdownButton<String>(
                              underline: Container(),
                              iconSize: 30,
                              icon: const Icon(
                                Icons.expand_more,
                                color: Colors.black,
                              ),
                              dropdownColor: Colors.white,
                              onChanged: (value) {
                                setState(() {
                                  idetails = value!;
                                  _finalSum("incidental", idetails.toString(),
                                      iclaim_amount.text);
                                });
                              },
                              value: idetails,
                              items: detail.map((item) {
                                return DropdownMenuItem(
                                    value: item,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeVariables.getWidth(context) *
                                                  0.03),
                                      child: Text(
                                        item,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.05),
                      child: AnimatedButton(
                        height: 45,
                        width: 100,
                        text: 'Save as Draft',
                        isReverse: true,
                        selectedTextColor: Colors.black,
                        transitionType: TransitionType.LEFT_TO_RIGHT,
                        textStyle: TextStyle(fontSize: 13),
                        backgroundColor: Colors.black,
                        borderColor: Colors.white,
                        borderRadius: 8,
                        borderWidth: 2,
                        onPress: () {
                          Map request_filename = {
                            "file_name": "document",
                          };
                          if (ifile == null) {
                            _errorVal(context);
                          } else {
                            Map<String, String> request_data = {
                              "claim_type": "incidental",
                              "mod_of_travel": "",
                              "trip_way": "",
                              "from_place": "",
                              "to_place": "",
                              "acco_type": "",
                              "payment_details": ipurchase.text.toString(),
                              "service_provider":
                                  iserviceprovider.text.toString(),
                              "travel_type":
                                  iexchangerate.text.toString() == "null"
                                      ? "domestic"
                                      : "international",
                              "from_date": "",
                              "from_time": "",
                              "to_date": "",
                              "to_time": "",
                              "date": iclaim_date.text.toString(),
                              "gst_no": igst_no.text.toString(),
                              "gst_amount": igst_amount.text.toString(),
                              "claim_amount": iclaim_amount.text.toString(),
                              "basic_amount": ibasic_amount.text.toString(),
                              "payment_type": idetails.toString(),
                              "exchange_rate": iexchangerate.text.toString(),
                              "doc_no": doc_no,
                            };
                            Provider.of<TravelViewModel>(context, listen: false)
                                .postTravelFormSubmit(context, request_filename,
                                    ifile!, request_data);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _localtab() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
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
                          'Local details',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _upload("local", context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.45,
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
                              controller: lserviceprovider,
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
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context)
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
                        top: SizeVariables.getWidth(context) * 0.02,
                        left: SizeVariables.getWidth(context) * 0.02,
                      ),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Claim',
                          style: Theme.of(context)
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(
                      //   left: SizeVariables.getWidth(context) * 0.05,
                      // ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime.now()
                                          .add(const Duration(days: 365)))
                                  .then((value) {
                                setState(() {
                                  // _dateTimeStart = value;
                                  lclaim_date.text = dateFormat
                                      .format(DateTime.parse(value.toString()));
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
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              controller: lclaim_date,
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
                                labelText: 'Doc. date',
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
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: true,
                              cursorColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.account_balance_wallet_sharp),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            width: SizeVariables.getWidth(context) * 0.3,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              controller: lexchangerate,
                              keyboardType: TextInputType.number,
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
                                labelText: 'Exchange rate',
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
                              controller: lgst_no,
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
                                labelText: 'GST No',
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
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor: true,
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
                            controller: lgst_amount,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
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
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
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
                              controller: lbasic_amount,
                              keyboardType: TextInputType.number,
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
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context)
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
                            controller: lclaim_amount,
                            onChanged: (content) {
                              setState(() {
                                //_final_amount = double.parse(tclaim_amount.text);

                                _finalSum("local", ldetails.toString(),
                                    lclaim_amount.text);
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 167, 164, 164)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 194, 191, 191)),
                              ),
                              // border: InputBorder.none,
                              labelText: 'Claim Amount',
                              // hintText: "To",
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
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: true,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
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
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Payment type',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.04),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.book_online),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.02,
                          ),
                          Container(
                            height: SizeVariables.getHeight(context) * 0.045,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(10),
                            //   border: Border.all(
                            //     color: Colors.grey,
                            //     width: 3,
                            //   ),
                            // ),
                            child: DropdownButton<String>(
                              underline: Container(),
                              iconSize: 30,
                              icon: const Icon(
                                Icons.expand_more,
                                color: Colors.black,
                              ),
                              dropdownColor: Colors.white,
                              onChanged: (value) {
                                setState(() {
                                  ldetails = value!;
                                  print(value);
                                  _finalSum("local", ldetails.toString(),
                                      lclaim_amount.text);
                                });
                              },
                              value: ldetails,
                              items: detail.map((item) {
                                return DropdownMenuItem(
                                    value: item,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeVariables.getWidth(context) *
                                                  0.03),
                                      child: Text(
                                        item,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.05),
                      child: AnimatedButton(
                        height: 45,
                        width: 100,
                        text: 'Save as Draft',
                        isReverse: true,
                        selectedTextColor: Colors.black,
                        transitionType: TransitionType.LEFT_TO_RIGHT,
                        textStyle: TextStyle(fontSize: 13),
                        backgroundColor: Colors.black,
                        borderColor: Colors.white,
                        borderRadius: 8,
                        borderWidth: 2,
                        onPress: () {
                          Map request_filename = {
                            "file_name": "document",
                          };
                          if (lfile == null) {
                            _errorVal(context);
                          } else {
                            Map<String, String> request_data = {
                              "claim_type": "local",
                              "mod_of_travel": "",
                              "trip_way": "",
                              "from_place": "",
                              "to_place": "",
                              "acco_type": "",
                              "service_provider":
                                  lserviceprovider.text.toString(),
                              "travel_type":
                                  lexchangerate.text.toString() == "null"
                                      ? "domestic"
                                      : "international",
                              "from_date": "",
                              "from_time": "",
                              "to_date": "",
                              "to_time": "",
                              "date": lclaim_date.text.toString(),
                              "gst_no": lgst_no.text.toString(),
                              "gst_amount": lgst_amount.text.toString(),
                              "claim_amount": lclaim_amount.text.toString(),
                              "basic_amount": lbasic_amount.text.toString(),
                              "payment_type": ldetails.toString(),
                              "exchange_rate": lexchangerate.text.toString(),
                              "doc_no": doc_no,
                            };
                            Provider.of<TravelViewModel>(context, listen: false)
                                .postTravelFormSubmit(context, request_filename,
                                    lfile!, request_data);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
                                      var imagePath =
                                          await EdgeDetection.detectEdge;
                                      tfile = new XFile(
                                          new File(imagePath.toString()).path);
                                    } else if (type == "accomodation") {
                                      var imagePath =
                                          await EdgeDetection.detectEdge;
                                      afile = new XFile(
                                          new File(imagePath.toString()).path);
                                    } else if (type == "food") {
                                      var imagePath =
                                          await EdgeDetection.detectEdge;
                                      ffile = new XFile(
                                          new File(imagePath.toString()).path);
                                    } else if (type == "local") {
                                      var imagePath =
                                          await EdgeDetection.detectEdge;
                                      lfile = new XFile(
                                          new File(imagePath.toString()).path);
                                    } else if (type == "incidental") {
                                      var imagePath =
                                          await EdgeDetection.detectEdge;
                                      ifile = new XFile(
                                          new File(imagePath.toString()).path);
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
                                    tfile = (await FilePicker.platform
                                        .pickFiles()) as i.XFile?;
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
                                        color:
                                            Color.fromARGB(255, 230, 217, 217)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: SizeVariables.getWidth(context) * 0.05,
                    ),
                    SizedBox(
                      width: SizeVariables.getWidth(context) * 0.05,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    torgfile = (await EdgeDetection.detectEdge)
                                        as i.XFile?;
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
                                    torgfile = (await FilePicker.platform
                                        .pickFiles()) as i.XFile?;
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
                                'Org. Invoice',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color:
                                            Color.fromARGB(255, 230, 217, 217)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Invoice url:',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                  Container(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'C:/download/abc.jpg:',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Org. url:',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ),
                  Container(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'C:/download/joy.jpg:',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _finalSum(String type, String paytype, String individual_claimamt) {
    if (type == "travel") {
      if (paytype == "Paid by self") {
        if (tclaim_amount.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
              double.parse(
                  fclaim_amount.text == "" ? "0" : fclaim_amount.text) +
              double.parse(
                  lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
              double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
        } else {
          _final_amount = double.parse(tclaim_amount.text) +
              double.parse(
                  aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
              double.parse(
                  fclaim_amount.text == "" ? "0" : fclaim_amount.text) +
              double.parse(
                  lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
              double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
        }
      } else {
        _final_amount = double.parse(
                aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
            double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text) +
            double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
            double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
      }
    } else if (type == "accomodation") {
      if (paytype == "Paid by self") {
        if (aclaim_amount.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
              double.parse(
                  fclaim_amount.text == "" ? "0" : fclaim_amount.text) +
              double.parse(
                  lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
              double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
        } else {
          _final_amount = double.parse(aclaim_amount.text) +
              double.parse(
                  tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
              double.parse(
                  fclaim_amount.text == "" ? "0" : fclaim_amount.text) +
              double.parse(
                  lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
              double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
        }
      } else {
        _final_amount = double.parse(
                tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
            double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text) +
            double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
            double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
      }
    } else if (type == "food") {
      if (paytype == "Paid by self") {
        if (fclaim_amount.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
              double.parse(
                  aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
              double.parse(
                  lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
              double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
        } else {
          _final_amount = double.parse(fclaim_amount.text) +
              double.parse(
                  tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
              double.parse(
                  aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
              double.parse(
                  lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
              double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
        }
      } else {
        _final_amount = double.parse(
                tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
            double.parse(aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
            double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
            double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
      }
    } else if (type == "local") {
      if (paytype == "Paid by self") {
        if (lclaim_amount.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
              double.parse(
                  aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
              double.parse(
                  fclaim_amount.text == "" ? "0" : fclaim_amount.text) +
              double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
        } else {
          _final_amount = double.parse(lclaim_amount.text) +
              double.parse(
                  tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
              double.parse(
                  aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
              double.parse(
                  fclaim_amount.text == "" ? "0" : fclaim_amount.text) +
              double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
        }
      } else {
        _final_amount = double.parse(
                tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
            double.parse(aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
            double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text) +
            double.parse(iclaim_amount.text == "" ? "0" : iclaim_amount.text);
      }
    } else if (type == "incidental") {
      if (paytype == "Paid by self") {
        if (iclaim_amount.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
              double.parse(
                  aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
              double.parse(
                  lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
              double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text);
        } else {
          _final_amount = double.parse(iclaim_amount.text) +
              double.parse(
                  tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
              double.parse(
                  aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
              double.parse(
                  lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
              double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text);
        }
      } else {
        _final_amount = double.parse(
                tclaim_amount.text == "" ? "0" : tclaim_amount.text) +
            double.parse(aclaim_amount.text == "" ? "0" : aclaim_amount.text) +
            double.parse(lclaim_amount.text == "" ? "0" : lclaim_amount.text) +
            double.parse(fclaim_amount.text == "" ? "0" : fclaim_amount.text);
      }
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
                  'Do you confirm your submition?',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.03,
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
                onPressed: () {},
                child: Text('Ok ',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Color(0xffF59F23),
                        )),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
