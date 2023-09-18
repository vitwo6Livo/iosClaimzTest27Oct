import 'dart:io';
import 'dart:math';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:chip_list/chip_list.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/models/iternaryModel.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/buttonStyle.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/res/components/content_dialog.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/travelViewModel.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart' as i;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';
// import 'package:path/path.dart';
import '../../viewModel/claimzViewModel.dart';
import '../config/mediaQuery.dart';
import '../widgets/claimzfromWidget/claimzHeader.dart';
import '../widgets/incidentalExpenseWidget/approvedIncidental.dart';
import '../widgets/incidentalExpenseWidget/pendingIncidental.dart';
import '../widgets/incidentalExpenseWidget/rejectedIncidental.dart';

class TravelClaimForm extends StatefulWidget {
  final Map<dynamic, dynamic> args;

  TravelClaimForm(Map this.args);

  // const TravelClaimForm({Key? key}) : super(key: key);

  @override
  State<TravelClaimForm> createState() => _TravelClaimFormState();
}

class _TravelClaimFormState extends State<TravelClaimForm> {
  final ImagePicker _picker = ImagePicker();

  File? image;
  bool isLoading = true;
  bool? isGallery;

  Future takePhoto() async {
    // final imageTemporary;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      // imageTemporary = cropSquareImage(File(image.path));

      File? imageTemporary = File(image.path);

      imageTemporary = await cropImage(imageTemporary);

      setState(() {
        this.image = imageTemporary;
        isLoading = false;
        isGallery = false;
      });

      // Provider.of<ProfileViewModel>(context, listen: false)
      //     .postImage(context, imageTemporary);
    } on PlatformException catch (e) {
      print('Failed To Pick Image: $e');
    }
  }

  Future chooseImage() async {
    // final imageTemporary;

    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // imageTemporary = cropSquareImage(File(image.path));

      File? imageTemporary = File(image.path);

      imageTemporary = await cropImage(imageTemporary);

      setState(() {
        this.image = imageTemporary;
        isLoading = false;
        isGallery = true;
      });

      // Provider.of<ProfileViewModel>(context, listen: false)
      //     .postImage(context, imageTemporary);
    } on PlatformException catch (e) {
      print('Failed To Pick Image: $e');
    }
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

  Future<XFile?> cropImageTwo(XFile imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        compressFormat: ImageCompressFormat.jpg);
    if (croppedImage == null) return null;
    return XFile(croppedImage.path);
  }

  bool checkIfExceed = false;

  dynamic Limit_travel;
  dynamic Limit_acco;
  dynamic Limit_food;
  dynamic Limit_incidental;
  dynamic Limit_local;

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
  //XFile? tfile;
  var tfile;
  var torgfile;
  String? tfile_link;
  String? torgfile_link;
  TextEditingController _place = TextEditingController();
  // bool tClicked = false;
  double? tCheckValue;
  bool? tCheck;

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
  var afile;
  var aorgfile;
  String? afile_link;
  String? aorgfile_link;
  bool aClicked = false;
  double? aCheckValue;
  bool? aCheck;

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
  var ffile;
  var forgfile;
  String? ffile_link;
  String? forgfile_link;
  bool fClicked = false;
  double? fCheckValue;
  bool? fCheck;

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
  var lfile;
  var lorgfile;
  String? lfile_link;
  String? lorgfile_link;
  bool lClicked = false;
  double? lCheckValue;
  bool? lCheck;

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
  var ifile;
  var iorgfile;
  String? ifile_link;
  String? iorgfile_link;
  bool iClicked = false;
  double? iCheckValue;
  bool? iCheck;

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
  var uploadCounter = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('INIIIIIIIITT: ${widget.args}');

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
  final List<String> clipstyle_value = [
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

  final List<String> cliphotel_value = [
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
    print('tfile: $tfile');
    print('tfile_link: ${tfile_link}');
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.of(context).pushNamed(RouteNames.travelClaimsList);
        return false;
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      clipstyle_value.clear();
                      cliphotel.clear();
                      cliphotel_value.clear();

                      for (int k = 0;
                          k < value.iternaryDetails.data!.data!.limit!.length;
                          k++) {
                        if (value.iternaryDetails.data!.data!.limit![k]
                                .travelName ==
                            "travel") {
                          Limit_travel = value
                              .iternaryDetails.data!.data!.limit![k].limit!;
                        }
                        if (value.iternaryDetails.data!.data!.limit![k]
                                .travelName ==
                            "accomodation") {
                          Limit_acco = value
                              .iternaryDetails.data!.data!.limit![k].limit!;
                        }
                        if (value.iternaryDetails.data!.data!.limit![k]
                                .travelName ==
                            "food") {
                          Limit_food = value
                              .iternaryDetails!.data!.data!.limit![k].limit!;
                        }
                        if (value.iternaryDetails!.data!.data!.limit![k]
                                .travelName ==
                            "local") {
                          Limit_local = value
                              .iternaryDetails!.data!.data!.limit![k].limit!;
                        }
                        if (value.iternaryDetails!.data!.data!.limit![k]
                                .travelName ==
                            "incidental") {
                          Limit_incidental = value
                              .iternaryDetails.data!.data!.limit![k].limit!;
                        }
                      }

                      for (int i = 0;
                          i <
                              value.iternaryDetails.data!.data!.modeOfTravels!
                                  .length;
                          i++) {
                        clipstyle.add(value
                            .iternaryDetails.data!.data!.modeOfTravels![i].name
                            .toString());
                        clipstyle_value.add(value
                            .iternaryDetails.data!.data!.modeOfTravels![i].id
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
                        cliphotel_value.add(value
                            .iternaryDetails.data!.data!.accommodations![i].id
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
                                    if (valuex.iternaryDetails.data!.data!
                                        .meetingDetails!.isNotEmpty) {
                                      meet_to.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .meetingDetails![0]
                                          .metWhom
                                          .toString();
                                      feedback.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .meetingDetails![0]
                                          .feedback
                                          .toString();
                                      purpose.text = valuex
                                          .iternaryDetails!
                                          .data!
                                          .data!
                                          .meetingDetails![0]
                                          .purposeOfVisit
                                          .toString();
                                    }
                                    if (valuex.iternaryDetails.data!.data!
                                            .travel !=
                                        null) {
                                      tfile = valuex.iternaryDetails.data!.data!
                                          .travel!.document
                                          .toString();

                                      tfile_link = valuex.iternaryDetails.data!
                                          .data!.travel!.document
                                          .toString();

                                      torgfile = valuex.iternaryDetails.data!
                                          .data!.travel!.original_document
                                          .toString();

                                      torgfile_link = valuex.iternaryDetails
                                          .data!.data!.travel!.original_document
                                          .toString();

                                      if (torgfile_link != null) {
                                        if (valuex
                                                .iternaryDetails
                                                .data!
                                                .data!
                                                .travel!
                                                .original_document_status ==
                                            "0") {
                                          torgfile = null;
                                          torgfile_link = null;
                                        }
                                      }

                                      _mode_of_travel = clipstyle.indexOf(valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .travel!
                                          .modOfTravel
                                          .toString());
                                      selected_mode = valuex.iternaryDetails
                                          .data!.data!.travel!.tripWay
                                          .toString();

                                      details = valuex.iternaryDetails.data!
                                          .data!.travel!.paymentType
                                          .toString();
                                      serviceprovider.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .travel!
                                          .serviceProvider
                                          .toString();
                                      from.text = valuex.iternaryDetails.data!
                                          .data!.travel!.fromPlace
                                          .toString();
                                      to.text = valuex.iternaryDetails.data!
                                          .data!.travel!.toPlace
                                          .toString();
                                      departure.text = valuex.iternaryDetails
                                          .data!.data!.travel!.serviceProvider
                                          .toString();
                                      return_travel.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .travel!
                                          .serviceProvider
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
                                      tfrom_time.text = valuex.iternaryDetails
                                          .data!.data!.travel!.fromTime
                                          .toString();
                                      tto_time.text = valuex.iternaryDetails
                                          .data!.data!.travel!.toTime
                                          .toString();
                                      tgst_no.text = valuex.iternaryDetails
                                          .data!.data!.travel!.gstNo
                                          .toString();
                                      tgst_amount.text = valuex.iternaryDetails
                                          .data!.data!.travel!.gstAmount
                                          .toString();
                                      tbasic_amount.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .travel!
                                          .basicAmount
                                          .toString();
                                      tclaim_amount.text = valuex
                                          .iternaryDetails!
                                          .data!
                                          .data!
                                          .travel!
                                          .claimAmount
                                          .toString();
                                      texchangerate.text = valuex
                                          .iternaryDetails!
                                          .data!
                                          .data!
                                          .travel!
                                          .exchangeRate
                                          .toString();
                                    }
                                    if (valuex.iternaryDetails.data!.data!
                                            .accomodation !=
                                        null) {
                                      afile = valuex.iternaryDetails.data!.data!
                                          .accomodation!.document
                                          .toString();

                                      afile_link = valuex.iternaryDetails.data!
                                          .data!.accomodation!.document
                                          .toString();

                                      aorgfile = valuex.iternaryDetails.data!
                                          .data!.accomodation!.original_document
                                          .toString();

                                      aorgfile_link = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .accomodation!
                                          .original_document
                                          .toString();

                                      if (aorgfile_link != null) {
                                        if (valuex
                                                .iternaryDetails
                                                .data!
                                                .data!
                                                .accomodation!
                                                .original_document_status ==
                                            "0") {
                                          aorgfile = null;
                                          aorgfile_link = null;
                                        }
                                      }

                                      _mode_of_acco = clipstyle.indexOf(valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .accomodation!
                                          .modOfAcco
                                          .toString());

                                      // print("okdata"+valuex.iternaryDetails.data!
                                      //         .data!.accomodation!.paymentType
                                      //         .toString()
                                      //          );

                                      adetails = valuex.iternaryDetails.data!
                                          .data!.accomodation!.paymentType
                                          .toString();

                                      aserviceprovider.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .accomodation!
                                          .serviceProvider
                                          .toString();
                                      afrom.text = valuex.iternaryDetails.data!
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
                                      aclaim_date.text = valuex.iternaryDetails
                                          .data!.data!.accomodation!.claimDate
                                          .toString();
                                      aftime.text = valuex.iternaryDetails.data!
                                          .data!.accomodation!.fromTime
                                          .toString();
                                      attime.text = valuex.iternaryDetails.data!
                                          .data!.accomodation!.toTime
                                          .toString();
                                      afrom_time.text = valuex.iternaryDetails
                                          .data!.data!.accomodation!.fromTime
                                          .toString();
                                      ato_time.text = valuex.iternaryDetails
                                          .data!.data!.accomodation!.toTime
                                          .toString();
                                      agst_no.text = valuex.iternaryDetails
                                          .data!.data!.accomodation!.gstNo
                                          .toString();
                                      agst_amount.text = valuex.iternaryDetails!
                                          .data!.data!.accomodation!.gstAmount
                                          .toString();
                                      abasic_amount.text = valuex
                                          .iternaryDetails!
                                          .data!
                                          .data!
                                          .accomodation!
                                          .basicAmount
                                          .toString();
                                      aclaim_amount.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .accomodation!
                                          .claimAmount
                                          .toString();
                                      aexchangerate.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .accomodation!
                                          .exchangeRate
                                          .toString();
                                    }

                                    if (valuex
                                            .iternaryDetails.data!.data!.food !=
                                        null) {
                                      ffile = valuex.iternaryDetails.data!.data!
                                          .food!.document
                                          .toString();

                                      ffile_link = valuex.iternaryDetails.data!
                                          .data!.food!.document
                                          .toString();

                                      forgfile = valuex.iternaryDetails.data!
                                          .data!.food!.original_document
                                          .toString();

                                      forgfile_link = valuex.iternaryDetails
                                          .data!.data!.food!.original_document
                                          .toString();

                                      if (forgfile_link != null) {
                                        if (forgfile_link!.length <= 38) {
                                          forgfile = null;
                                          forgfile_link = null;
                                        }
                                      }

                                      fdetails = valuex.iternaryDetails.data!
                                          .data!.food!.paymentType
                                          .toString();

                                      fserviceprovider.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .food!
                                          .serviceProvider
                                          .toString();
                                      fclaim_date.text = valuex.iternaryDetails
                                          .data!.data!.food!.claimDate
                                          .toString();
                                      fgst_no.text = valuex.iternaryDetails
                                          .data!.data!.food!.gstNo
                                          .toString();
                                      fgst_amount.text = valuex.iternaryDetails
                                          .data!.data!.food!.gstAmount
                                          .toString();
                                      fbasic_amount.text = valuex
                                          .iternaryDetails!
                                          .data!
                                          .data!
                                          .food!
                                          .basicAmount
                                          .toString();
                                      fclaim_amount.text = valuex
                                          .iternaryDetails!
                                          .data!
                                          .data!
                                          .food!
                                          .claimAmount
                                          .toString();
                                      fexchangerate.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .food!
                                          .exchangeRate
                                          .toString();
                                    }
                                    if (valuex.iternaryDetails.data!.data!
                                            .local !=
                                        null) {
                                      lfile = valuex.iternaryDetails.data!.data!
                                          .local!.document
                                          .toString();

                                      lfile_link = valuex.iternaryDetails.data!
                                          .data!.local!.document
                                          .toString();

                                      lorgfile = valuex.iternaryDetails.data!
                                          .data!.local!.original_document
                                          .toString();

                                      lorgfile_link = valuex.iternaryDetails
                                          .data!.data!.local!.original_document
                                          .toString();

                                      if (lorgfile_link != null) {
                                        if (lorgfile_link!.length <= 38) {
                                          lorgfile = null;
                                          lorgfile_link = null;
                                        }
                                      }
                                      ldetails = valuex.iternaryDetails!.data!
                                          .data!.travel!.paymentType
                                          .toString();

                                      lserviceprovider.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .local!
                                          .serviceProvider
                                          .toString();
                                      lclaim_date.text = valuex.iternaryDetails
                                          .data!.data!.local!.claimDate
                                          .toString();
                                      lgst_no.text = valuex.iternaryDetails
                                          .data!.data!.local!.gstNo
                                          .toString();
                                      lgst_amount.text = valuex.iternaryDetails
                                          .data!.data!.local!.gstAmount
                                          .toString();
                                      lbasic_amount.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .local!
                                          .basicAmount
                                          .toString();
                                      lclaim_amount.text = valuex
                                          .iternaryDetails!
                                          .data!
                                          .data!
                                          .local!
                                          .claimAmount
                                          .toString();
                                      lexchangerate.text = valuex
                                          .iternaryDetails!
                                          .data!
                                          .data!
                                          .local!
                                          .exchangeRate
                                          .toString();
                                    }
                                    if (valuex.iternaryDetails.data!.data!
                                            .incidental !=
                                        null) {
                                      ifile = valuex.iternaryDetails.data!.data!
                                          .incidental!.document
                                          .toString();

                                      ifile_link = valuex.iternaryDetails.data!
                                          .data!.incidental!.document
                                          .toString();

                                      iorgfile = valuex.iternaryDetails.data!
                                          .data!.incidental!.original_document
                                          .toString();

                                      iorgfile_link = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .incidental!
                                          .original_document
                                          .toString();

                                      if (iorgfile_link != null) {
                                        if (iorgfile_link!.length <= 38) {
                                          iorgfile = null;
                                          iorgfile_link = null;
                                        }
                                      }
                                      idetails = valuex.iternaryDetails!.data!
                                          .data!.incidental!.paymentType
                                          .toString();

                                      iserviceprovider.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .incidental!
                                          .serviceProvider
                                          .toString();
                                      iclaim_date.text = valuex.iternaryDetails
                                          .data!.data!.incidental!.claimDate
                                          .toString();
                                      igst_no.text = valuex.iternaryDetails
                                          .data!.data!.incidental!.gstNo
                                          .toString();
                                      igst_amount.text = valuex.iternaryDetails
                                          .data!.data!.incidental!.gstAmount
                                          .toString();
                                      ibasic_amount.text = valuex
                                          .iternaryDetails
                                          .data!
                                          .data!
                                          .incidental!
                                          .basicAmount
                                          .toString();
                                      iclaim_amount.text = valuex
                                          .iternaryDetails!
                                          .data!
                                          .data!
                                          .incidental!
                                          .claimAmount
                                          .toString();
                                      iexchangerate.text = valuex
                                          .iternaryDetails!
                                          .data!
                                          .data!
                                          .incidental!
                                          .exchangeRate
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
                                List<ApprovalLog>? blank_data = [];

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
                                                  Navigator.pop(context);
                                                  Navigator.of(context)
                                                      .pushNamed(RouteNames
                                                          .travelClaimsList);
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
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorLight,
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
                                            height: SizeVariables.getWidth(
                                                    context) *
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.03,
                                                          ),
                                                          child: const Text(
                                                            '₹',
                                                            style: TextStyle(
                                                              fontSize: 35,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color: Color(
                                                                  0xffF59F23),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            _final_amount
                                                                .toString(),
                                                            style: Theme.of(
                                                                    context)
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
                                                  widget.args['status'] ==
                                                              'Saved as Draft' ||
                                                          widget.args[
                                                                  'status'] ==
                                                              'Submit'
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              // color:
                                                              //     Colors.amber,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                right: SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.017,
                                                              ),
                                                              // width: SizeVariables
                                                              //         .getHeight(
                                                              //             context) *
                                                              //     0.04,
                                                              height: SizeVariables
                                                                      .getHeight(
                                                                          context) *
                                                                  0.05,
                                                              child: InkWell(
                                                                onTap: tCheck == true ||
                                                                        aCheck ==
                                                                            true ||
                                                                        fCheck ==
                                                                            true ||
                                                                        lCheck ==
                                                                            true ||
                                                                        iCheck ==
                                                                            true
                                                                    ? () =>
                                                                        Flushbar(
                                                                          leftBarIndicatorColor:
                                                                              Colors.red,
                                                                          icon: const Icon(
                                                                              Icons.warning,
                                                                              color: Colors.white),
                                                                          message:
                                                                              'Please Ensure that the GST Value hasn\'t exceeded by more than 28% of the basic amount',
                                                                          duration:
                                                                              const Duration(seconds: 5),
                                                                        ).show(
                                                                            context)
                                                                    : () {
                                                                        _submitpopup(
                                                                            "submit",
                                                                            context);
                                                                      },
                                                                child: Lottie.asset(
                                                                    'assets/json/final_submit.json',
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: SizeVariables.getHeight(
                                                    context) *
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: SvgPicture
                                                                .asset(
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
                                                          shape: BoxShape
                                                              .rectangle,
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
                                                                child:
                                                                    SvgPicture
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
                                                      width: SizeVariables
                                                              .getHeight(
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
                                                          shape: BoxShape
                                                              .rectangle,
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
                                                                child:
                                                                    SvgPicture
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
                                                      width: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.025,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape: CircleBorder(),
                                                        padding:
                                                            EdgeInsets.all(3),
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
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors.black,
                                                          shape: BoxShape
                                                              .rectangle,
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
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "assets/travelIcon/Food.svg",
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
                                                      width: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.025,
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        shape: CircleBorder(),
                                                        padding:
                                                            EdgeInsets.all(3),
                                                        primary: _selection == 4
                                                            ? Colors.amber
                                                            : Colors.black,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _selection = 4;
                                                          Map data = {
                                                            "month": "",
                                                            "type": "Local",
                                                            "year": "",
                                                            "user_id": "",
                                                            "all": "4" //self
                                                          };
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            new BoxDecoration(
                                                          color: Colors.black,
                                                          shape: BoxShape
                                                              .rectangle,
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
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "assets/travelIcon/Local Travel.svg",
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
                                                      width: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.025,
                                                    ),
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
                                                            "type":
                                                                "incidental",
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
                                                          shape: BoxShape
                                                              .rectangle,
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
                                                                child:
                                                                    SvgPicture
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
                                      height: SizeVariables.getHeight(context) *
                                          0.02,
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
                                                  _infotab(
                                                      value
                                                          .iternaryDetails
                                                          .data!
                                                          .data!
                                                          .meetingDetails,
                                                      valuex
                                                          .iternaryDetails!
                                                          .data!
                                                          .data!
                                                          .reasonLog)
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
      ),
    );
  }

  _infotab(List<MeetingDetails>? meetingDetails, List<ReasonLog>? approvalLog) {
    final themeProvider = Provider.of<ThemeProvider>(context as BuildContext);
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
                                  readOnly: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
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
                                  showCursor: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
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
                                  readOnly: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
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
                                  showCursor: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
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
                            child: const Icon(Icons.handshake_outlined),
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
                              readOnly:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
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
                              showCursor:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
                              cursorColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.02,
                    ),
                    widget.args['status'] == 'Saved as Draft' ||
                            widget.args['status'] == 'Submit'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: SizeVariables.getWidth(context) *
                                          0.05),
                                  child: AnimatedButton(
                                    height: 45,
                                    width: 100,
                                    text: 'Save',
                                    isReverse: true,
                                    selectedTextColor: Colors.black,
                                    transitionType:
                                        TransitionType.LEFT_TO_RIGHT,
                                    textStyle: TextStyle(
                                        fontSize: 13,
                                        color: (themeProvider.darkTheme)
                                            ? Colors.white
                                            : Colors.black),
                                    backgroundColor: (themeProvider.darkTheme)
                                        ? Colors.black
                                        : Theme.of(context as BuildContext)
                                            .colorScheme
                                            .onPrimary,
                                    borderColor: (themeProvider.darkTheme)
                                        ? Colors.white
                                        : Theme.of(context as BuildContext)
                                            .colorScheme
                                            .onPrimary,
                                    borderRadius: 8,
                                    borderWidth: 2,
                                    onPress: () {
                                      if (purpose.text.toString() == "") {
                                        Flushbar(
                                          message:
                                              "please provide a valid purpose",
                                          icon: Icon(
                                            Icons.info_outline,
                                            size: 28.0,
                                            color: Colors.blue,
                                          ),
                                          duration: Duration(seconds: 3),
                                          leftBarIndicatorColor: Colors.blue,
                                        )..show(context as BuildContext);
                                      } else {
                                        Map request_data = {
                                          "met_whom": meet_to.text.toString(),
                                          "purpose_of_visit":
                                              purpose.text.toString(),
                                          "feedback": feedback.text.toString(),
                                          "doc_no": widget.args["doc"] ??= "",
                                        };
                                        Provider.of<TravelViewModel>(
                                                context as BuildContext,
                                                listen: false)
                                            .postPurposeDetails(
                                                context as BuildContext,
                                                request_data)
                                            .then((value) {
                                          setState(() {
                                            print("DOCNO " + value["doc_no"]);
                                            doc_no = value["doc_no"];
                                            _selection = 0;
                                          });
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.02),
            widget.args['status'] == 'Saved as Draft' ||
                    widget.args['status'] == 'Submit'
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
            widget.args['status'] == 'Saved as Draft' ||
                    widget.args['status'] == 'Submit'
                ? Container()
                : widget.args['status'] != 'Saved as Draft' ||
                        widget.args['status'] != 'Submit'
                    // ||
                    // !approvalLog!.isEmpty
                    ? Container(
                        height: SizeVariables.getHeight(context) * 0.5,
                        child: Scrollbar(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            // itemCount: approvalLog!.length,
                            itemCount: approvalLog!.length,

                            itemBuilder: (context, index) {
                              return Container(
                                height: 250,
                                child: TimelineTile(
                                  endChild: Container(
                                    padding: EdgeInsets.only(
                                      top: SizeVariables.getHeight(context) *
                                          0.03,
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
                                              Color.fromARGB(
                                                  239, 228, 226, 226),
                                          // isO?pen: true,

                                          headerBackgroundColor: Color.fromARGB(
                                              239, 228, 226, 226),
                                          headerBackgroundColorOpened:
                                              Color.fromARGB(
                                                  239, 228, 226, 226),
                                          contentBorderColor: Color.fromARGB(
                                              239, 228, 226, 226),
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
                                                      approvalLog[index]
                                                          .sum
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
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
                                                      BorderRadius.circular(
                                                          5.0),
                                                  color: Color(0xfffe2f6ed),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0,
                                                          right: 5.0,
                                                          top: 2.5,
                                                          bottom: 2.5),
                                                  child: Center(
                                                    child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Text(
                                                        approvalLog[index]
                                                            .status
                                                            .toString(),
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
                                                      // width: SizeVariables.getWidth(
                                                      //         context) *
                                                      //     0.54,
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          approvalLog[index]
                                                                      .remarks
                                                                      .toString() ==
                                                                  "null"
                                                              ? "No Remarks"
                                                              : approvalLog[
                                                                      index]
                                                                  .remarks
                                                                  .toString(),
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
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
                                                      approvalLog[index]
                                                          .empName
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontStyle:
                                                                  FontStyle
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
                                                  height:
                                                      SizeVariables.getHeight(
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
                                                          approvalLog[index]
                                                              .approvedAt
                                                              .toString()
                                                              .split(" ")[0],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                          approvalLog[index]
                                                              .approvedAt
                                                              .toString()
                                                              .split(" ")[1],
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
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
                                  isLast: index == approvalLog.length
                                      ? true
                                      : false,
                                  isFirst: index == 0 ? true : false,
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
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }

  _traveltab() {
    final themeProvider = Provider.of<ThemeProvider>(context as BuildContext);
    final height = MediaQuery.of(context as BuildContext).size.height;
    final width = MediaQuery.of(context as BuildContext).size.width;
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
                      style: Theme.of(context as BuildContext)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black, fontSize: 20),
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
                        selected_mode = clipstyle_value[val];
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.02),
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
                          print(value);
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
                ],
              ),
              Container(
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
                          width: SizeVariables.getWidth(context) * 0.02,
                        ),
                        Container(
                          width: SizeVariables.getWidth(context) * 0.78,
                          // width: 300,
                          // height: 200,
                          child: TextFormField(
                            controller: serviceprovider,
                            keyboardType: TextInputType.text,
                            readOnly:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? false
                                    : true,
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
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 20, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? true
                                    : false,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                            readOnly:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? false
                                    : true,
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
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            onTap: widget.args['status'] == 'Saved as Draft' ||
                                    widget.args['status'] == 'Submit'
                                ? () async {
                                    await PlacesAutocomplete.show(
                                      context: context as BuildContext,
                                      radius: 10000000,
                                      logo: const Text(""),
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
                                      String p = value!.placeId.toString();
                                      displayPrediction(p, from);
                                    });
                                  }
                                : () {},
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
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
                        child: const Icon(Icons.location_on_outlined),
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
                          readOnly: widget.args['status'] == 'Saved as Draft' ||
                                  widget.args['status'] == 'Submit'
                              ? false
                              : true,
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
                            labelStyle: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18, color: Colors.black),
                          ),
                          onTap: widget.args['status'] == 'Saved as Draft' ||
                                  widget.args['status'] == 'Submit'
                              ? () async {
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
                                }
                              : () {},
                          style: Theme.of(context as BuildContext)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                          showCursor: false,
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
                  Container(
                    padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.055,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                    builder: (context, child) => Theme(
                                          data: ThemeData().copyWith(
                                            colorScheme: ColorScheme.dark(
                                              primary: Color(0xffF59F23),
                                              surface: Colors.black,
                                              onSurface: Colors.white,
                                            ),
                                            dialogBackgroundColor:
                                                Color.fromARGB(255, 91, 91, 91),
                                          ),
                                          child: child!,
                                        ),
                                    context: context as BuildContext,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime.now())
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
                            onTap: widget.args['status'] == 'Saved as Draft' ||
                                    widget.args['status'] == 'Submit'
                                ? () {
                                    showDatePicker(
                                            builder: (context, child) => Theme(
                                                  data: ThemeData().copyWith(
                                                    colorScheme:
                                                        ColorScheme.dark(
                                                      primary:
                                                          Color(0xffF59F23),
                                                      surface: Colors.black,
                                                      onSurface: Colors.white,
                                                    ),
                                                    dialogBackgroundColor:
                                                        Color.fromARGB(
                                                            255, 91, 91, 91),
                                                  ),
                                                  child: child!,
                                                ),
                                            context: context as BuildContext,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2015),
                                            lastDate: DateTime.now())
                                        .then((value) {
                                      setState(() {
                                        // _dateTimeStart = value;
                                        departure.text = dateFormat.format(
                                            DateTime.parse(value.toString()));
                                      });
                                      // print('DATE START: $_dateTimeStart');
                                    });
                                  }
                                : () {},
                            showCursor: false,

                            readOnly: true,
                            controller: departure,
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
                              labelText: 'Departure',
                              // hintText: "From",
                              // hintStyle: Theme.of(context)
                              //     .textTheme
                              //     .bodyText2!
                              //     .copyWith(color: Colors.grey),
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            // showCursor: true,
                            // autofocus: false,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                                          builder: (context, child) => Theme(
                                                data: ThemeData().copyWith(
                                                  colorScheme: ColorScheme.dark(
                                                    primary: Color(0xffF59F23),
                                                    surface: Colors.black,
                                                    onSurface: Colors.white,
                                                  ),
                                                  dialogBackgroundColor:
                                                      Color.fromARGB(
                                                          255, 91, 91, 91),
                                                ),
                                                child: child!,
                                              ),
                                          context: context as BuildContext,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2015),
                                          lastDate: DateTime.now())
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
                                  onTap: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? () {
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
                                        }
                                      : () {},
                                  readOnly: true,
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
                                  showCursor: false,
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
                        InkWell(
                          onTap: widget.args['status'] == 'Saved as Draft' ||
                                  widget.args['status'] == 'Submit'
                              ? () {
                                  showDatePicker(
                                          builder: (context, child) => Theme(
                                                data: ThemeData().copyWith(
                                                  colorScheme: ColorScheme.dark(
                                                    primary: Color(0xffF59F23),
                                                    surface: Colors.black,
                                                    onSurface: Colors.white,
                                                  ),
                                                  dialogBackgroundColor:
                                                      Color.fromARGB(
                                                          255, 91, 91, 91),
                                                ),
                                                child: child!,
                                              ),
                                          context: context as BuildContext,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2015),
                                          lastDate: DateTime.now())
                                      .then((value) {
                                    setState(() {
                                      // _dateTimeStart = value;
                                      tclaim_date.text = dateFormat.format(
                                          DateTime.parse(value.toString()));
                                    });
                                    // print('DATE START: $_dateTimeStart');
                                  });
                                }
                              : () {},
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
                            onTap: widget.args['status'] == 'Saved as Draft' ||
                                    widget.args['status'] == 'Submit'
                                ? () {
                                    showDatePicker(
                                            builder: (context, child) => Theme(
                                                  data: ThemeData().copyWith(
                                                    colorScheme:
                                                        ColorScheme.dark(
                                                      primary:
                                                          Color(0xffF59F23),
                                                      surface: Colors.black,
                                                      onSurface: Colors.white,
                                                    ),
                                                    dialogBackgroundColor:
                                                        Color.fromARGB(
                                                            255, 91, 91, 91),
                                                  ),
                                                  child: child!,
                                                ),
                                            context: context as BuildContext,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2015),
                                            lastDate: DateTime.now())
                                        .then((value) {
                                      setState(() {
                                        // _dateTimeStart = value;
                                        tclaim_date.text = dateFormat.format(
                                            DateTime.parse(value.toString()));
                                      });
                                      // print('DATE START: $_dateTimeStart');
                                    });
                                  }
                                : () {},
                            readOnly: true,
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
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? true
                                    : false,
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
                            readOnly:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? false
                                    : true,
                            controller: tgst_no,
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              new LengthLimitingTextInputFormatter(15),
                            ],
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
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? true
                                    : false,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        child: const Icon(Icons.currency_rupee_outlined),
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
                          readOnly: widget.args['status'] == 'Saved as Draft' ||
                                  widget.args['status'] == 'Submit'
                              ? false
                              : true,
                          // readOnly: tCheckValue
                          //bool? tCheck;== false ? true : false,
                          onChanged: (content) {
                            print('Travel LIMIT: $Limit_travel');
                            print(
                                'Travel LIMIT DATA TYPE: ${Limit_travel.runtimeType}');

                            print(
                                'CONTENTTTTTT Runtimetype: ${content.runtimeType}');

                            if (content == '') {
                              setState(() {
                                tclaim_amount.text = '0.0';
                              });

                              setState(() {
                                _finalSum("travel", details.toString(),
                                    tclaim_amount.text);
                              });
                            }

                            if (content != '') {
                              setState(() {
                                tclaim_amount.text = content;
                              });
                              setState(() {
                                _finalSum("travel", details.toString(),
                                    tclaim_amount.text);
                              });
                            }

                            if (content == '' && tgst_amount.text != '') {
                              setState(() {
                                tclaim_amount.text = tgst_amount.text;
                              });
                              setState(() {
                                _finalSum("travel", details.toString(),
                                    tclaim_amount.text);
                              });
                            }

                            if (content == '' && tgst_amount.text == '') {
                              setState(() {
                                tclaim_amount.text = '0.0';
                              });

                              setState(() {
                                _finalSum("travel", details.toString(),
                                    tclaim_amount.text);
                              });
                            }

                            if (double.parse(content) >
                                int.parse(Limit_travel)) {
                              setState(() {
                                tbasic_amount.text = Limit_travel.toString();
                                tclaim_amount.text = Limit_travel.toString();
                              });
                              setState(() {
                                _finalSum("travel", details.toString(),
                                    tclaim_amount.text);
                              });
                            }

                            if (content != '' && tgst_amount.text != '') {
                              setState(() {
                                tclaim_amount.text = (double.parse(content) +
                                        double.parse(tgst_amount.text))
                                    .toString();
                              });
                              setState(() {
                                _finalSum("travel", details.toString(),
                                    tclaim_amount.text);
                              });
                            }
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
                            labelText: 'Basic Amount',
                            // hintText: "From",
                            // hintStyle: Theme.of(context)
                            //     .textTheme
                            //     .bodyText2!
                            //     .copyWith(color: Colors.grey),
                            labelStyle: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18, color: Colors.black),
                          ),
                          style: Theme.of(context as BuildContext)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
                          showCursor:
                              widget.args['status'] == 'Saved as Draft' ||
                                      widget.args['status'] == 'Submit'
                                  ? true
                                  : false,
                          cursorColor: Colors.black,
                        ),
                      )
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
                            controller: tgst_amount,
                            readOnly:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? false
                                    : true,
                            showCursor:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? true
                                    : false,
                            // readOnly: tClicked == false
                            // //  || tCheck == false
                            //     ? true
                            //     : false,
                            onChanged: (gstContent) {
                              if (gstContent == '' &&
                                  tbasic_amount.text != '') {
                                setState(() {
                                  tclaim_amount.text = tbasic_amount.text;
                                });

                                setState(() {
                                  _finalSum("travel", details.toString(),
                                      tclaim_amount.text);
                                });
                              }

                              if (gstContent == '' &&
                                  tbasic_amount.text == '') {
                                setState(() {
                                  tclaim_amount.text = '0.0';
                                });

                                setState(() {
                                  _finalSum("travel", details.toString(),
                                      tclaim_amount.text);
                                });
                              }

                              if (gstContent != '') {
                                setState(() {
                                  tclaim_amount.text = gstContent;
                                });
                                setState(() {
                                  _finalSum("travel", details.toString(),
                                      tclaim_amount.text);
                                });
                              }

                              if (tgst_amount.text != '') {
                                setState(() {
                                  tCheckValue = checkGST(
                                      double.parse(tbasic_amount.text),
                                      double.parse(tgst_amount.text),
                                      context as BuildContext);
                                });
                              }

                              if (double.parse(gstContent) > tCheckValue!) {
                                Flushbar(
                                  leftBarIndicatorColor: Colors.red,
                                  icon: const Icon(Icons.warning,
                                      color: Colors.white),
                                  message: 'GST EXCEEDED',
                                  duration: const Duration(seconds: 2),
                                ).show(context as BuildContext);
                                setState(() {
                                  tCheck = true;
                                  print('FCHECKKKKKK: $tCheck');
                                  // fbasic_amount.clear();
                                  tbasic_amount.text = '';
                                  tclaim_amount.text = '0.0';
                                });
                                setState(() {
                                  _finalSum("travel", details.toString(),
                                      tclaim_amount.text);
                                });
                              }

                              if (double.parse(gstContent) <= tCheckValue!) {
                                setState(() {
                                  tCheck = false;
                                  print('FCHECKKKKKK: $tCheck');
                                });
                              }

                              if (double.parse(gstContent) +
                                      double.parse(tbasic_amount.text) >
                                  int.parse(Limit_travel)) {
                                tclaim_amount.text = Limit_travel;

                                tbasic_amount.text = (int.parse(Limit_travel) -
                                        double.parse(gstContent == ''
                                            ? '0'
                                            : gstContent))
                                    .toString();
                              }

                              if (gstContent != '' && tgst_amount.text != '') {
                                setState(() {
                                  tclaim_amount.text =
                                      (double.parse(gstContent) +
                                              double.parse(tbasic_amount.text))
                                          .toString();
                                });
                                setState(() {
                                  _finalSum("travel", details.toString(),
                                      tclaim_amount.text);
                                });
                              }
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
                              labelText: 'GST Amount',
                              // hintText: "To",
                              // hintStyle: Theme.of(context)
                              //     .textTheme
                              //     .bodyText2!
                              //     .copyWith(color: Colors.grey),
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),

                            // showCursor: tClicked == false ? false : true,
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
                          controller: tclaim_amount,
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
                            labelStyle: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 18, color: Colors.black),
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
                        style: Theme.of(context as BuildContext)
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
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Container(
                // color: Colors.red,
                height: height > 750
                    ? 27.4.h
                    : height < 650
                        ? 40.h
                        : 39.h,
                // width: 220,
                child: Container(
                  // height: SizeVariables.getHeight(context) * 0.2,
                  width: double.infinity,
                  // color: Colors.pink,
                  // padding: EdgeInsets.all(SizeVariables.getWidth(context) * 0.02),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeVariables.getWidth(context) * 0.04,
                      vertical: SizeVariables.getHeight(context) * 0.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Container(
                          // color: Colors.pink,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                              color: Colors.black),
                                          SizedBox(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.02),
                                          Container(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.3,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text('Uploaded Invoice',
                                                  style: Theme.of(context
                                                          as BuildContext)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 18)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          const Icon(Icons.visibility,
                                              color: Colors.black),
                                          SizedBox(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.02),
                                          Container(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.35,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                  'Uploaded Org. Invoice',
                                                  style: Theme.of(context
                                                          as BuildContext)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 18)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.015),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        SizeVariables.getWidth(context) * 0.4,
                                    child: Container(
                                      child: InkWell(
                                        onTap: () {},
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          child: Container(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.1,
                                            height: 200,
                                            // color: Colors.yellow,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2)),
                                            child: tfile == null
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
                                                : (tfile_link != null)
                                                    ? ((tfile_link!
                                                            .contains('pdf'))
                                                        ? Stack(
                                                            children: [
                                                              Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(Icons
                                                                        .arrow_downward),
                                                                    Text(
                                                                      'File has been captured.',
                                                                      style: Theme.of(context
                                                                              as BuildContext)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                              color: Colors.black),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          openFileNetworkFile(
                                                                              fileLink: tfile_link!,
                                                                              fileName: 'inv.pdf');
                                                                        },
                                                                        child: Text(
                                                                            'Click to open'))
                                                                  ],
                                                                ),
                                                                // decoration:
                                                                //     BoxDecoration(
                                                                //   image:
                                                                //       DecorationImage(
                                                                //     fit: BoxFit.fill,
                                                                //     image: FileImage(
                                                                //       File(tfile!
                                                                //           .path),
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                              ),
                                                            ],
                                                          )
                                                        : Stack(
                                                            children: [
                                                              Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                child: Image
                                                                    .network(
                                                                  tfile_link!,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  loadingBuilder: (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                    if (loadingProgress ==
                                                                        null)
                                                                      return child;
                                                                    return Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                                        value: loadingProgress.expectedTotalBytes !=
                                                                                null
                                                                            ? loadingProgress.cumulativeBytesLoaded /
                                                                                loadingProgress.expectedTotalBytes!
                                                                            : null,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                // decoration:
                                                                //     BoxDecoration(
                                                                //   image:
                                                                //       DecorationImage(
                                                                //     fit: BoxFit
                                                                //         .fill,
                                                                //     image: NetworkImage(
                                                                //         tfile_link!),
                                                                //   ),
                                                                // ),
                                                              ),
                                                            ],
                                                          ))
                                                    : (tfile.path
                                                            .toString()
                                                            .contains('pdf'))
                                                        ? Stack(
                                                            children: [
                                                              Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(Icons
                                                                        .arrow_downward),
                                                                    Text(
                                                                      'File has been captured.',
                                                                      style: Theme.of(context
                                                                              as BuildContext)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                              color: Colors.black),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          openFile(
                                                                              tfile);
                                                                        },
                                                                        child: Text(
                                                                            'Click to open'))
                                                                  ],
                                                                ),
                                                                // decoration:
                                                                //     BoxDecoration(
                                                                //   image:
                                                                //       DecorationImage(
                                                                //     fit: BoxFit.fill,
                                                                //     image: FileImage(
                                                                //       File(tfile!
                                                                //           .path),
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                              ),
                                                            ],
                                                          )
                                                        : Stack(
                                                            children: [
                                                              Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    image:
                                                                        FileImage(
                                                                      File(tfile!
                                                                          .path),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              // const Positioned(
                                                              //   top: 2,
                                                              //   right: 5,
                                                              //   child: Icon(
                                                              //       Icons.expand_sharp,
                                                              //       color: Colors.white),
                                                              // )
                                                            ],
                                                          ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    width:
                                        SizeVariables.getWidth(context) * 0.4,
                                    child: Container(
                                      child: InkWell(
                                        onTap: () {},
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          child: Container(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.3,
                                            height: 200,
                                            // color: Colors.yellow,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 2)),
                                            child: torgfile == null
                                                ? Center(
                                                    child: Text(
                                                        'Please Upload Original Invoice',
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
                                                : (torgfile_link != null)
                                                    ? ((torgfile_link!.contains(
                                                                'pdf'))
                                                            ? Stack(
                                                                children: [
                                                                  Container(
                                                                    height: double
                                                                        .infinity,
                                                                    width: double
                                                                        .infinity,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(Icons
                                                                            .arrow_downward),
                                                                        Text(
                                                                          'File has been captured.',
                                                                          style: Theme.of(context as BuildContext)
                                                                              .textTheme
                                                                              .bodyText1!
                                                                              .copyWith(color: Colors.black),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              openFileNetworkFile(fileLink: torgfile_link!, fileName: 'original_inv.pdf');
                                                                            },
                                                                            child:
                                                                                Text('Click to open'))
                                                                      ],
                                                                    ),
                                                                    // decoration:
                                                                    //     BoxDecoration(
                                                                    //   image:
                                                                    //       DecorationImage(
                                                                    //     fit: BoxFit.fill,
                                                                    //     image: FileImage(
                                                                    //       File(tfile!
                                                                    //           .path),
                                                                    //     ),
                                                                    //   ),
                                                                    // ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Stack(
                                                                children: [
                                                                  Container(
                                                                    height: double
                                                                        .infinity,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        image: NetworkImage(
                                                                            torgfile_link!),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                        // Stack(
                                                        //     children: [
                                                        //       Container(
                                                        //         height: double
                                                        //             .infinity,
                                                        //         width: double
                                                        //             .infinity,
                                                        //         child: Image
                                                        //             .network(
                                                        //           torgfile_link!,
                                                        //           fit: BoxFit
                                                        //               .fill,
                                                        //           loadingBuilder: (BuildContext
                                                        //                   context,
                                                        //               Widget
                                                        //                   child,
                                                        //               ImageChunkEvent?
                                                        //                   loadingProgress) {
                                                        //             if (loadingProgress ==
                                                        //                 null)
                                                        //               return child;
                                                        //             return Center(
                                                        //               child:
                                                        //                   CircularProgressIndicator(
                                                        //                 value: loadingProgress.expectedTotalBytes !=
                                                        //                         null
                                                        //                     ? loadingProgress.cumulativeBytesLoaded /
                                                        //                         loadingProgress.expectedTotalBytes!
                                                        //                     : null,
                                                        //               ),
                                                        //             );
                                                        //           },
                                                        //         ),
                                                        //         // decoration:
                                                        //         //     BoxDecoration(
                                                        //         //   image:
                                                        //         //       DecorationImage(
                                                        //         //     fit: BoxFit
                                                        //         //         .fill,
                                                        //         //     image: NetworkImage(
                                                        //         //         torgfile_link!),
                                                        //         //   ),
                                                        //         // ),
                                                        //       ),
                                                        //     ],
                                                        //   )
                                                        )
                                                    : (torgfile.path
                                                            .toString()
                                                            .contains('pdf'))
                                                        ? Stack(
                                                            children: [
                                                              Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(Icons
                                                                        .arrow_downward),
                                                                    Text(
                                                                      'File has been captured.',
                                                                      style: Theme.of(context
                                                                              as BuildContext)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                              color: Colors.black),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          openFile(
                                                                              torgfile);
                                                                        },
                                                                        child: Text(
                                                                            'Click to open'))
                                                                  ],
                                                                ),
                                                                // decoration:
                                                                //     BoxDecoration(
                                                                //   image:
                                                                //       DecorationImage(
                                                                //     fit: BoxFit.fill,
                                                                //     image: FileImage(
                                                                //       File(tfile!
                                                                //           .path),
                                                                //     ),
                                                                //   ),
                                                                // ),
                                                              ),
                                                            ],
                                                          )
                                                        : Stack(
                                                            children: [
                                                              Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    image:
                                                                        FileImage(
                                                                      File(torgfile!
                                                                          .path),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              // const Positioned(
                                                              //   top: 2,
                                                              //   right: 5,
                                                              //   child: Icon(
                                                              //       Icons.expand_sharp,
                                                              //       color: Colors.white),
                                                              // )
                                                            ],
                                                          ),
                                          ),
                                        ),
                                      ),
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
              widget.args['status'] == 'Saved as Draft' ||
                      widget.args['status'] == 'Submit'
                  ? Container(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.03,
                        right: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: SizeVariables.getWidth(context) * 0.35,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Container(
                                          width: 2,
                                          // height: screenWidth * 0.2,
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.05,
                                          color: Colors.white,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          // if (type == "travel") {
                                          // var imagePath = await EdgeDetection
                                          //     .detectEdge
                                          //     .then((value) {
                                          //   print(value.toString());
                                          //   if (value == null) {
                                          //     _errorVal(
                                          //         context as BuildContext);
                                          //   } else {
                                          //     _imageCaptured(
                                          //         context as BuildContext);
                                          //   }
                                          //   return value;
                                          // });

                                          // setState(() {
                                          //   tfile = new XFile(
                                          //       new File(imagePath.toString())
                                          //           .path);
                                          //   tfile_link = null;
                                          // });

                                          //NEW CODEEEEEEEEEEEEEEEEEEE

                                          // String imagePath = join(
                                          //     (await getApplicationSupportDirectory())
                                          //         .path,
                                          //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                          // bool success =
                                          //     await EdgeDetection.detectEdge(
                                          //   imagePath,
                                          //   canUseGallery: true,
                                          //   androidScanTitle:
                                          //       'Scanning', // use custom localizations for android
                                          //   androidCropTitle: 'Crop',
                                          //   androidCropBlackWhiteTitle:
                                          //       'Black White',
                                          //   androidCropReset: 'Reset',
                                          // );

                                          // setState(() {
                                          //   tfile = new XFile(
                                          //       new File(imagePath.toString())
                                          //           .path);
                                          //   tfile_link = null;
                                          // });

                                          final image = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          if (image == null) return;

                                          // imageTemporary = cropSquareImage(File(image.path));

                                          XFile? imageTemporary =
                                              XFile(image.path);

                                          imageTemporary = await cropImageTwo(
                                              imageTemporary);

                                          setState(() {
                                            // tfile = new XFile(new File(
                                            //         imageTemporary.toString())
                                            //     .path);
                                            tfile = imageTemporary;

                                            print('TRAVEL FILE: $tfile');
                                            print(
                                                'TRAVEL FILE FORMAT: ${tfile.runtimeType}');

                                            isLoading = false;
                                            isGallery = true;
                                          });
                                        },
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        child: Container(
                                          width: 2,
                                          // height: screenWidth * 0.2,
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.05,
                                          color: Colors.white,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          // tfile = (await FilePicker.platform
                                          //     .pickFiles()) as i.XFile?;
                                          // if (type == 'travel') {
                                          // final result = await FilePicker
                                          //     .platform
                                          //     .pickFiles();
                                          // if (result == null) return;

                                          // tfile = result.files.first;
                                          // //openFile(tfile);
                                          // final tfilePath = tfile.path;
                                          // print(
                                          //     'file-path: ${tfilePath}'); //opens the file

                                          // setState(() {
                                          //   tfile = new XFile(
                                          //       new File(tfilePath.toString())
                                          //           .path);
                                          //   tfile_link = null;
                                          // });

                                          final image = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          if (image == null) return;

                                          // imageTemporary = cropSquareImage(File(image.path));

                                          // File? imageTemporary =
                                          //     File(image.path);

                                          // imageTemporary =
                                          //     await cropImage(imageTemporary);

                                          XFile? imageTemporary =
                                              XFile(image.path);

                                          imageTemporary = await cropImageTwo(
                                              imageTemporary);

                                          setState(() {
                                            // tfile = imageTemporary as XFile;
                                            // tfile = new XFile(new File(
                                            //         imageTemporary.toString())
                                            //     .path);

                                            tfile = imageTemporary;

                                            print('TRAVEL FILE: $tfile');

                                            isLoading = false;
                                            isGallery = true;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.file_copy_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        child: Container(
                                          width: 2,
                                          // height: screenWidth * 0.2,
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.05,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.05,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: SizeVariables.getWidth(context) * 0.36,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        child: Container(
                                          width: 2,
                                          // height: screenWidth * 0.2,
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.05,
                                          color: Colors.white,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          // if (type == 'travel') {
                                          // var imagePath = await EdgeDetection
                                          //     .detectEdge
                                          //     .then((value) {
                                          //   print(value.toString());
                                          //   if (value == null) {
                                          //     _errorVal(context as BuildContext);
                                          //   } else {
                                          //     _imageCaptured(context as BuildContext);
                                          //   }
                                          //   return value;
                                          // });

                                          // setState(() {
                                          //   torgfile = new XFile(
                                          //       new File(imagePath.toString())
                                          //           .path);
                                          //   torgfile_link = null;
                                          // });

                                          //NEW CODEEEEEEEEEE

                                          // String imagePath = join(
                                          //     (await getApplicationSupportDirectory())
                                          //         .path,
                                          //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                          // bool success =
                                          //     await EdgeDetection.detectEdge(
                                          //   imagePath,
                                          //   canUseGallery: true,
                                          //   androidScanTitle:
                                          //       'Scanning', // use custom localizations for android
                                          //   androidCropTitle: 'Crop',
                                          //   androidCropBlackWhiteTitle:
                                          //       'Black White',
                                          //   androidCropReset: 'Reset',
                                          // );

                                          // setState(() {
                                          //   torgfile = new XFile(
                                          //       new File(imagePath.toString())
                                          //           .path);
                                          //   torgfile_link = null;
                                          // });

                                          // }

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
                                          //   torgfile = new XFile(
                                          //       new File(imagePath.toString()).path);
                                          // });

                                          final image = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.camera);
                                          if (image == null) return;

                                          // imageTemporary = cropSquareImage(File(image.path));

                                          // File? imageTemporary =
                                          //     File(image.path);

                                          // imageTemporary =
                                          //     await cropImage(imageTemporary);

                                          XFile? imageTemporary =
                                              XFile(image.path);

                                          imageTemporary = await cropImageTwo(
                                              imageTemporary);

                                          setState(() {
                                            torgfile = imageTemporary;

                                            isLoading = false;
                                            isGallery = true;
                                          });
                                        },
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        child: Container(
                                          width: 2,
                                          // height: screenWidth * 0.2,
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.05,
                                          color: Colors.white,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          // tfile = (await FilePicker.platform
                                          //     .pickFiles()) as i.XFile?;
                                          // if (type == 'travel') {

                                          final image = await ImagePicker()
                                              .pickImage(
                                                  source: ImageSource.gallery);
                                          if (image == null) return;

                                          // imageTemporary = cropSquareImage(File(image.path));

                                          // File? imageTemporary =
                                          //     File(image.path);

                                          // imageTemporary =
                                          //     await cropImage(imageTemporary);

                                          XFile? imageTemporary =
                                              XFile(image.path);

                                          imageTemporary = await cropImageTwo(
                                              imageTemporary);

                                          setState(() {
                                            torgfile = imageTemporary;
                                            // torgfile = new XFile(new File(
                                            //         imageTemporary.toString())
                                            //     .path);

                                            isLoading = false;
                                            isGallery = true;
                                          });

                                          // final result = await FilePicker
                                          //     .platform
                                          //     .pickFiles();
                                          // if (result == null) return;

                                          // torgfile = result.files.first;
                                          // //openFile(tfile);
                                          // final torgfilePath = torgfile.path;
                                          // print(
                                          //     'file-path: ${torgfilePath}'); //opens the file

                                          // setState(() {
                                          //   torgfile = new XFile(new File(
                                          //           torgfilePath.toString())
                                          //       .path);
                                          //   torgfile_link = null;
                                          // });
                                          // }

                                          // final result =
                                          //     await FilePicker.platform.pickFiles();
                                          // if (result == null) return;

                                          // torgfile = result.files.first;
                                          // //openFile(tfile);
                                          // final torgfilePath = torgfile.path;
                                          // print(
                                          //     'file-path: ${torgfilePath}'); //opens the file

                                          // setState(() {
                                          //   torgfile = new XFile(
                                          //       new File(torgfilePath.toString())
                                          //           .path);
                                          // });
                                        },
                                        child: const Icon(
                                          Icons.file_copy_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        child: Container(
                                          width: 2,
                                          // height: screenWidth * 0.2,
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.05,
                                          color: Colors.white,
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
                    )
                  : Container(),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.03,
              ),
              widget.args['status'] == 'Saved as Draft' ||
                      widget.args['status'] == 'Submit'
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: AnimatedButton(
                          height: 45,
                          width: 100,
                          text: 'Save',
                          isReverse: true,
                          selectedTextColor: Colors.black,
                          transitionType: TransitionType.LEFT_TO_RIGHT,
                          textStyle: TextStyle(
                              fontSize: 13,
                              color: (themeProvider.darkTheme)
                                  ? Colors.white
                                  : Colors.black),
                          backgroundColor: (themeProvider.darkTheme)
                              ? Colors.black
                              : Theme.of(context as BuildContext)
                                  .colorScheme
                                  .onPrimary,
                          borderColor: (themeProvider.darkTheme)
                              ? Colors.white
                              : Theme.of(context as BuildContext)
                                  .colorScheme
                                  .onPrimary,
                          borderRadius: 8,
                          borderWidth: 2,
                          onPress: tCheck == true
                              ? () => Flushbar(
                                    leftBarIndicatorColor: Colors.red,
                                    icon: const Icon(Icons.warning,
                                        color: Colors.white),
                                    message:
                                        'Please Ensure that the GST Value hasn\'t exceeded by more than 28% of the basic amount',
                                    duration: const Duration(seconds: 5),
                                  ).show(context as BuildContext)
                              : () {
                                  Map request_filename = {
                                    "file_name": "document",
                                    // "original_file_name": "original_document",
                                  };
                                  Map request_filename2 = {
                                    "file_name": "document",
                                    "original_file_name": "original_document",
                                  };
                                  if (tfile == null) {
                                    _errorVal(context as BuildContext);
                                  } else {
                                    Map<String, String> request_data = {
                                      "claim_type": "travel",
                                      "mod_of_travel": selected_mode.toString(),
                                      "trip_way": mydata,
                                      "from_place": from.text.toString(),
                                      "to_place": to.text.toString(),
                                      "service_provider":
                                          serviceprovider.text.toString(),
                                      "travel_type":
                                          texchangerate.text.toString() == ''
                                              ? "domestic"
                                              : "international",
                                      "from_date": tfrom_date.text.toString(),
                                      "from_time": departure.text.toString(),
                                      "to_date": return_travel.text.toString(),
                                      "to_time": tto_time.text.toString(),
                                      "date": tclaim_date.text.toString(),
                                      "gst_no": tgst_no.text.toString(),
                                      "gst_amount": tgst_amount.text.toString(),
                                      "claim_amount":
                                          tclaim_amount.text.toString(),
                                      "basic_amount":
                                          tbasic_amount.text.toString(),
                                      "payment_type": details.toString(),
                                      "exchange_rate":
                                          texchangerate.text.toString(),
                                      "doc_no": doc_no,
                                    };
                                    (torgfile == null)
                                        ? Provider.of<TravelViewModel>(context,
                                                listen: false)
                                            .postTravelFormSubmit(
                                                context,
                                                request_filename,
                                                tfile!,
                                                request_data)
                                            .then((_) {
                                            setState(() {
                                              _selection = 2;
                                            });
                                          })
                                        : Provider.of<TravelViewModel>(context,
                                                listen: false)
                                            .postTravelFormSubmit2(
                                                context,
                                                request_filename2,
                                                tfile!,
                                                torgfile!,
                                                request_data)
                                            .then((_) {
                                            setState(() {
                                              _selection = 2;
                                            });
                                          });
                                  }
                                },
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  _accomondationtab() {
    final themeProvider = Provider.of<ThemeProvider>(context as BuildContext);
    final height = MediaQuery.of(context as BuildContext).size.height;
    final width = MediaQuery.of(context as BuildContext).size.width;
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
                          style: Theme.of(context as BuildContext)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     _upload("accomodation", context);
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.only(
                    //       left: SizeVariables.getWidth(context) * 0.4,
                    //       top: SizeVariables.getWidth(context) * 0.01,
                    //     ),
                    //     child: Icon(
                    //       Icons.arrow_circle_up_outlined,
                    //       size: 40,
                    //     ),
                    //   ),
                    // ),
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
                            selected_accomondation = cliphotel_value[val];
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
                              readOnly:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
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
                      padding: EdgeInsets.only(),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Claim',
                          style: Theme.of(context as BuildContext)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black),
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
                            onTap: () {
                              showDatePicker(
                                      builder: (context, child) => Theme(
                                            data: ThemeData().copyWith(
                                              colorScheme: ColorScheme.dark(
                                                primary: Color(0xffF59F23),
                                                surface: Colors.black,
                                                onSurface: Colors.white,
                                              ),
                                              dialogBackgroundColor:
                                                  Color.fromARGB(
                                                      255, 91, 91, 91),
                                            ),
                                            child: child!,
                                          ),
                                      context: context as BuildContext,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2015),
                                      lastDate: DateTime.now())
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
                            width: SizeVariables.getWidth(context) * 0.78,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              onTap: widget.args['status'] ==
                                          'Saved as Draft' ||
                                      widget.args['status'] == 'Submit'
                                  ? () {
                                      showDatePicker(
                                              builder: (context, child) =>
                                                  Theme(
                                                    data: ThemeData().copyWith(
                                                      colorScheme:
                                                          ColorScheme.dark(
                                                        primary:
                                                            Color(0xffF59F23),
                                                        surface: Colors.black,
                                                        onSurface: Colors.white,
                                                      ),
                                                      dialogBackgroundColor:
                                                          const Color.fromARGB(
                                                              255, 91, 91, 91),
                                                    ),
                                                    child: child!,
                                                  ),
                                              context: context as BuildContext,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2015),
                                              lastDate: DateTime.now())
                                          .then((value) {
                                        setState(() {
                                          // _dateTimeStart = value;
                                          aclaim_date.text = dateFormat.format(
                                              DateTime.parse(value.toString()));
                                        });
                                        // print('DATE START: $_dateTimeStart');
                                      });
                                    }
                                  : () {},
                              readOnly: true,
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
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
                              readOnly:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(15),
                              ],
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
                              cursorColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        // Container(
                        //   child: Icon(Icons.currency_rupee_outlined),
                        // ),
                        // SizedBox(
                        //   width: SizeVariables.getWidth(context) * 0.02,
                        // ),
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
                                  readOnly: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
                                  // readOnly: tCheckValue
                                  //bool? tCheck;== false ? true : false,
                                  onChanged: (content) {
                                    if (content == '') {
                                      setState(() {
                                        aclaim_amount.text = '0.0';
                                      });

                                      setState(() {
                                        _finalSum(
                                            "accomodation",
                                            details.toString(),
                                            aclaim_amount.text);
                                      });
                                    }

                                    if (content != '') {
                                      setState(() {
                                        aclaim_amount.text = content;
                                      });
                                      setState(() {
                                        _finalSum(
                                            "accomodation",
                                            details.toString(),
                                            aclaim_amount.text);
                                      });
                                    }

                                    if (content == '' &&
                                        agst_amount.text != '') {
                                      setState(() {
                                        aclaim_amount.text = agst_amount.text;
                                      });
                                      setState(() {
                                        _finalSum(
                                            "accomodation",
                                            details.toString(),
                                            aclaim_amount.text);
                                      });
                                    }

                                    if (content == '' &&
                                        agst_amount.text == '') {
                                      setState(() {
                                        aclaim_amount.text = '0.0';
                                      });

                                      setState(() {
                                        _finalSum(
                                            "accomodation",
                                            details.toString(),
                                            aclaim_amount.text);
                                      });
                                    }

                                    if (double.parse(content) >
                                        int.parse(Limit_acco)) {
                                      setState(() {
                                        abasic_amount.text =
                                            Limit_acco.toString();
                                        aclaim_amount.text =
                                            Limit_acco.toString();
                                      });
                                      setState(() {
                                        _finalSum(
                                            "accomodation",
                                            details.toString(),
                                            aclaim_amount.text);
                                      });
                                    }

                                    if (content != '' &&
                                        agst_amount.text != '') {
                                      setState(() {
                                        aclaim_amount
                                            .text = (double.parse(content) +
                                                double.parse(agst_amount.text))
                                            .toString();
                                      });
                                      setState(() {
                                        _finalSum(
                                            "accomodation",
                                            details.toString(),
                                            aclaim_amount.text);
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
                                  showCursor: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                            readOnly:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? false
                                    : true,
                            // readOnly: aClicked == false
                            //     // || aCheck == false
                            //     ? true
                            //     : false,
                            onChanged: (gstContent) {
                              if (gstContent == '' &&
                                  abasic_amount.text != '') {
                                setState(() {
                                  aclaim_amount.text = abasic_amount.text;
                                });

                                setState(() {
                                  _finalSum("accomodation", details.toString(),
                                      aclaim_amount.text);
                                });
                              }

                              if (gstContent == '' &&
                                  abasic_amount.text == '') {
                                setState(() {
                                  aclaim_amount.text = '0.0';
                                });

                                setState(() {
                                  _finalSum("accomodation", details.toString(),
                                      aclaim_amount.text);
                                });
                              }

                              if (gstContent != '') {
                                setState(() {
                                  aclaim_amount.text = gstContent;
                                });
                                setState(() {
                                  _finalSum("accommodation", details.toString(),
                                      aclaim_amount.text);
                                });
                              }

                              if (agst_amount.text != '') {
                                setState(() {
                                  aCheckValue = checkGST(
                                      double.parse(abasic_amount.text),
                                      double.parse(agst_amount.text),
                                      context as BuildContext);
                                });
                              }

                              if (double.parse(gstContent) > aCheckValue!) {
                                Flushbar(
                                  leftBarIndicatorColor: Colors.red,
                                  icon: const Icon(Icons.warning,
                                      color: Colors.white),
                                  message: 'GST EXCEEDED',
                                  duration: const Duration(seconds: 2),
                                ).show(context as BuildContext);
                                setState(() {
                                  aCheck = true;
                                  print('FCHECKKKKKK: $aCheck');
                                  // fbasic_amount.clear();
                                  abasic_amount.text = '';
                                  aclaim_amount.text = '0.0';
                                });
                                setState(() {
                                  _finalSum("accomodation", details.toString(),
                                      aclaim_amount.text);
                                });
                              }

                              if (double.parse(gstContent) <= aCheckValue!) {
                                setState(() {
                                  aCheck = false;
                                  print('FCHECKKKKKK: $aCheck');
                                });
                              }

                              if (double.parse(gstContent) +
                                      double.parse(abasic_amount.text) >
                                  int.parse(Limit_acco)) {
                                aclaim_amount.text = Limit_acco;

                                abasic_amount.text = (int.parse(Limit_acco) -
                                        double.parse(gstContent == ''
                                            ? '0'
                                            : gstContent))
                                    .toString();
                              }

                              if (gstContent != '' && agst_amount.text != '') {
                                setState(() {
                                  aclaim_amount.text =
                                      (double.parse(gstContent) +
                                              double.parse(abasic_amount.text))
                                          .toString();
                                });
                                setState(() {
                                  _finalSum("accomodation", details.toString(),
                                      aclaim_amount.text);
                                });
                              }
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
                              labelText: 'GST Amount',
                              // hintText: "To",
                              // hintStyle: Theme.of(context)
                              //     .textTheme
                              //     .bodyText2!
                              //     .copyWith(color: Colors.grey),
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? true
                                    : false,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
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
                            controller: aclaim_amount,
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
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: false,
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
                          style: Theme.of(context as BuildContext)
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
                Container(
                  // color: Colors.pink,
                  height: height > 750
                      ? 27.7.h
                      : height < 650
                          ? 40.h
                          : 39.h,
                  // width: 220,
                  child: Container(
                    // height: SizeVariables.getHeight(context) * 0.2,
                    width: double.infinity,
                    // color: Colors.pink,
                    // padding: EdgeInsets.all(SizeVariables.getWidth(context) * 0.02),
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeVariables.getWidth(context) * 0.04,
                        vertical: SizeVariables.getHeight(context) * 0.0),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                            // color: Colors.pink,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                color: Colors.black),
                                            SizedBox(
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.02),
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.3,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text('Uploaded Invoice',
                                                    style: Theme.of(context
                                                            as BuildContext)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 18)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            const Icon(Icons.visibility,
                                                color: Colors.black),
                                            SizedBox(
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.02),
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.35,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                    'Uploaded Org. Invoice',
                                                    style: Theme.of(context
                                                            as BuildContext)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 18)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: SizeVariables.getHeight(context) *
                                        0.015),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          SizeVariables.getWidth(context) * 0.4,
                                      child: Container(
                                        child: InkWell(
                                          onTap: () {},
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            child: Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.1,
                                              height: 200,
                                              // color: Colors.yellow,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 2)),
                                              child: afile == null
                                                  ? Center(
                                                      child: Text(
                                                          'Please Upload Invoice',
                                                          style: Theme.of(context
                                                                  as BuildContext)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black)),
                                                    )
                                                  : (afile_link != null)
                                                      ? ((afile_link!
                                                              .contains('pdf'))
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(Icons
                                                                          .arrow_downward),
                                                                      Text(
                                                                        'File has been captured.',
                                                                        style: Theme.of(context
                                                                                as BuildContext)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            openFileNetworkFile(
                                                                                fileLink: afile_link!,
                                                                                fileName: 'inv.pdf');
                                                                          },
                                                                          child:
                                                                              Text('Click to open'))
                                                                    ],
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit.fill,
                                                                  //     image: FileImage(
                                                                  //       File(tfile!
                                                                  //           .path),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image: NetworkImage(
                                                                          afile_link!),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ))
                                                      : (afile.path
                                                              .toString()
                                                              .contains('pdf'))
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(Icons
                                                                          .arrow_downward),
                                                                      Text(
                                                                        'File has been captured.',
                                                                        style: Theme.of(context
                                                                                as BuildContext)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            openFile(afile);
                                                                          },
                                                                          child:
                                                                              Text('Click to open'))
                                                                    ],
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit.fill,
                                                                  //     image: FileImage(
                                                                  //       File(tfile!
                                                                  //           .path),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image:
                                                                          FileImage(
                                                                        File(afile!
                                                                            .path),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.red,
                                      width:
                                          SizeVariables.getWidth(context) * 0.4,
                                      child: Container(
                                        child: InkWell(
                                          onTap: () {},
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            child: Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.3,
                                              height: 200,
                                              // color: Colors.yellow,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 2)),
                                              child: aorgfile == null
                                                  ? Center(
                                                      child: Text(
                                                          'Please Upload Original Invoice',
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
                                                  : (aorgfile_link != null)
                                                      ? ((aorgfile_link!
                                                              .contains('pdf'))
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(Icons
                                                                          .arrow_downward),
                                                                      Text(
                                                                        'File has been captured.',
                                                                        style: Theme.of(context
                                                                                as BuildContext)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            openFileNetworkFile(
                                                                                fileLink: aorgfile_link!,
                                                                                fileName: 'original_inv.pdf');
                                                                          },
                                                                          child:
                                                                              Text('Click to open'))
                                                                    ],
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit.fill,
                                                                  //     image: FileImage(
                                                                  //       File(tfile!
                                                                  //           .path),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image: NetworkImage(
                                                                          aorgfile_link!),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ))
                                                      : (aorgfile.path
                                                              .toString()
                                                              .contains('pdf'))
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(Icons
                                                                          .arrow_downward),
                                                                      Text(
                                                                        'File has been captured.',
                                                                        style: Theme.of(context
                                                                                as BuildContext)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            openFile(aorgfile);
                                                                          },
                                                                          child:
                                                                              Text('Click to open'))
                                                                    ],
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit.fill,
                                                                  //     image: FileImage(
                                                                  //       File(tfile!
                                                                  //           .path),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image:
                                                                          FileImage(
                                                                        File(aorgfile!
                                                                            .path),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // const Positioned(
                                                                //   top: 2,
                                                                //   right: 5,
                                                                //   child: Icon(
                                                                //       Icons.expand_sharp,
                                                                //       color: Colors.white),
                                                                // )
                                                              ],
                                                            ),
                                            ),
                                          ),
                                        ),
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
                widget.args['status'] == 'Saved as Draft' ||
                        widget.args['status'] == 'Submit'
                    ? Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.03,
                          right: SizeVariables.getWidth(context) * 0.06,
                          // bottom: SizeVariables.getHeight(context) * 0.1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // color: Colors.amber,
                                // height: 5,
                                width: SizeVariables.getWidth(context) * 0.35,

                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: Container(
                                            width: 2,
                                            // height: screenWidth * 0.2,
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.05,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          //  width: SizeVariables.getWidth(context)*0.15,
                                          // color: Colors.amber,
                                          child: InkWell(
                                            onTap: () async {
                                              // if (type == "accomodation") {
                                              // var imagePath =
                                              //     await EdgeDetection.detectEdge
                                              //         .then((value) {
                                              //   print(value.toString());
                                              //   if (value == null) {
                                              //     _errorVal(context as BuildContext);
                                              //   } else {
                                              //     _imageCaptured(context as BuildContext);
                                              //   }
                                              //   return value;
                                              // });
                                              // setState(() {
                                              //   afile = new XFile(new File(
                                              //           imagePath.toString())
                                              //       .path);
                                              //   afile_link = null;
                                              // });
                                              // }

                                              //NEW CODEEEEE
                                              // String imagePath = join(
                                              //     (await getApplicationSupportDirectory())
                                              //         .path,
                                              //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                              // bool success = await EdgeDetection
                                              //     .detectEdge(
                                              //   imagePath,
                                              //   canUseGallery: true,
                                              //   androidScanTitle:
                                              //       'Scanning', // use custom localizations for android
                                              //   androidCropTitle: 'Crop',
                                              //   androidCropBlackWhiteTitle:
                                              //       'Black White',
                                              //   androidCropReset: 'Reset',
                                              // );

                                              // setState(() {
                                              //   afile = new XFile(new File(
                                              //           imagePath.toString())
                                              //       .path);
                                              //   afile_link = null;
                                              // });

                                              final image = await ImagePicker()
                                                  .pickImage(
                                                      source:
                                                          ImageSource.camera);
                                              if (image == null) return;

                                              // imageTemporary = cropSquareImage(File(image.path));

                                              // File? imageTemporary =
                                              //     File(image.path);

                                              // imageTemporary = await cropImage(
                                              //     imageTemporary);

                                              XFile? imageTemporary =
                                                  XFile(image.path);

                                              imageTemporary =
                                                  await cropImageTwo(
                                                      imageTemporary);

                                              setState(() {
                                                afile = imageTemporary;
                                                isLoading = false;
                                                isGallery = true;
                                              });
                                            },
                                            child: Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: Container(
                                            width: 2,
                                            // height: screenWidth * 0.2,
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.05,
                                            color: Colors.white,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            // if (type == 'accomodation') {
                                            // final result = await FilePicker
                                            //     .platform
                                            //     .pickFiles();
                                            // if (result == null) return;

                                            // afile = result.files.first;
                                            // //openFile(tfile);
                                            // final afilePath = afile.path;
                                            // print(
                                            //     'file-path: ${afilePath}'); //opens the file

                                            // setState(() {
                                            //   afile = new XFile(
                                            //       new File(afilePath.toString())
                                            //           .path);
                                            //   afile_link = null;
                                            // });
                                            // }

                                            final image = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (image == null) return;

                                            // imageTemporary = cropSquareImage(File(image.path));

                                            // File? imageTemporary =
                                            //     File(image.path);

                                            // imageTemporary =
                                            //     await cropImage(imageTemporary);

                                            XFile? imageTemporary =
                                                XFile(image.path);

                                            imageTemporary = await cropImageTwo(
                                                imageTemporary);

                                            setState(() {
                                              afile = imageTemporary;
                                              isLoading = false;
                                              isGallery = true;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.file_copy_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        SizedBox(
                                          child: Container(
                                            width: 2,
                                            // height: screenWidth * 0.2,
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.05,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.05,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: SizeVariables.getWidth(context) * 0.35,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: Container(
                                            width: 2,
                                            // height: screenWidth * 0.2,
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.05,
                                            color: Colors.white,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            // if (type == 'accomodation') {
                                            // var imagePath = await EdgeDetection
                                            //     .detectEdge
                                            //     .then((value) {
                                            //   print(value.toString());
                                            //   if (value == null) {
                                            //     _errorVal(context as BuildContext);
                                            //   } else {
                                            //     _imageCaptured(context as BuildContext);
                                            //   }
                                            //   return value;
                                            // });

                                            // setState(() {
                                            //   aorgfile = new XFile(
                                            //       new File(imagePath.toString())
                                            //           .path);
                                            // });
                                            // }

                                            //NEW CODEEEEE
                                            // String imagePath = join(
                                            //     (await getApplicationSupportDirectory())
                                            //         .path,
                                            //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                            // bool success =
                                            //     await EdgeDetection.detectEdge(
                                            //   imagePath,
                                            //   canUseGallery: true,
                                            //   androidScanTitle:
                                            //       'Scanning', // use custom localizations for android
                                            //   androidCropTitle: 'Crop',
                                            //   androidCropBlackWhiteTitle:
                                            //       'Black White',
                                            //   androidCropReset: 'Reset',
                                            // );

                                            // setState(() {
                                            //   aorgfile = new XFile(
                                            //       new File(imagePath.toString())
                                            //           .path);
                                            // });

                                            final image = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource.camera);
                                            if (image == null) return;

                                            // imageTemporary = cropSquareImage(File(image.path));

                                            // File? imageTemporary =
                                            //     File(image.path);

                                            // imageTemporary =
                                            //     await cropImage(imageTemporary);

                                            XFile? imageTemporary =
                                                XFile(image.path);

                                            imageTemporary = await cropImageTwo(
                                                imageTemporary);

                                            setState(() {
                                              aorgfile = imageTemporary;
                                              isLoading = false;
                                              isGallery = true;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        SizedBox(
                                          child: Container(
                                            width: 2,
                                            // height: screenWidth * 0.2,
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.05,
                                            color: Colors.white,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            // if (type == 'accomodation') {
                                            // final result = await FilePicker
                                            //     .platform
                                            //     .pickFiles();
                                            // if (result == null) return;

                                            // aorgfile = result.files.first;
                                            // //openFile(tfile);
                                            // final torgfilePath = torgfile.path;
                                            // print(
                                            //     'file-path: ${torgfilePath}'); //opens the file

                                            // setState(() {
                                            //   torgfile = new XFile(new File(
                                            //           torgfilePath.toString())
                                            //       .path);
                                            // });
                                            // }

                                            final image = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (image == null) return;

                                            // imageTemporary = cropSquareImage(File(image.path));

                                            // File? imageTemporary =
                                            //     File(image.path);

                                            // imageTemporary =
                                            //     await cropImage(imageTemporary);

                                            XFile? imageTemporary =
                                                XFile(image.path);

                                            imageTemporary = await cropImageTwo(
                                                imageTemporary);

                                            setState(() {
                                              aorgfile = imageTemporary;
                                              isLoading = false;
                                              isGallery = true;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.file_copy_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        SizedBox(
                                          child: Container(
                                            width: 2,
                                            // height: screenWidth * 0.2,
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.05,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 2,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.03,
                ),
                widget.args['status'] == 'Saved as Draft' ||
                        widget.args['status'] == 'Submit'
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.only(
                              right: SizeVariables.getWidth(context) * 0.05),
                          child: AnimatedButton(
                            height: 45,
                            width: 100,
                            text: 'Save',
                            isReverse: true,
                            selectedTextColor: Colors.black,
                            transitionType: TransitionType.LEFT_TO_RIGHT,
                            textStyle: TextStyle(
                                fontSize: 13,
                                color: (themeProvider.darkTheme)
                                    ? Colors.white
                                    : Colors.black),
                            backgroundColor: (themeProvider.darkTheme)
                                ? Colors.black
                                : Theme.of(context as BuildContext)
                                    .colorScheme
                                    .onPrimary,
                            borderColor: (themeProvider.darkTheme)
                                ? Colors.white
                                : Theme.of(context as BuildContext)
                                    .colorScheme
                                    .onPrimary,
                            borderRadius: 8,
                            borderWidth: 2,
                            onPress: aCheck == true
                                ? () => Flushbar(
                                      leftBarIndicatorColor: Colors.red,
                                      icon: const Icon(Icons.warning,
                                          color: Colors.white),
                                      message:
                                          'Please Ensure that the GST Value hasn\'t exceeded by more than 28% of the basic amount',
                                      duration: const Duration(seconds: 5),
                                    ).show(context as BuildContext)
                                : () {
                                    Map request_filename = {
                                      "file_name": "document",
                                      // "original_file_name": "original_document",
                                    };
                                    Map request_filename2 = {
                                      "file_name": "document",
                                      "original_file_name": "original_document",
                                    };
                                    if (afile == null) {
                                      _errorVal(context as BuildContext);
                                    } else {
                                      Map<String, String> request_data = {
                                        "claim_type": "accomodation",
                                        "accomodation":
                                            selected_accomondation.toString(),
                                        "mod_of_travel": "",
                                        "trip_way": "",
                                        "from_place": afrom.text.toString(),
                                        "to_place": ato.text.toString(),
                                        "service_provider":
                                            aserviceprovider.text.toString(),
                                        "travel_type":
                                            aexchangerate.text.toString() == ''
                                                ? "domestic"
                                                : "international",
                                        "from_date": afrom_date.text.toString(),
                                        "from_time": afrom_time.text.toString(),
                                        "to_date": ato_date.text.toString(),
                                        "to_time": ato_time.text.toString(),
                                        "date": aclaim_date.text.toString(),
                                        "gst_no": agst_no.text.toString(),
                                        "gst_amount":
                                            agst_amount.text.toString(),
                                        "claim_amount":
                                            aclaim_amount.text.toString(),
                                        "basic_amount":
                                            abasic_amount.text.toString(),
                                        "payment_type": adetails.toString(),
                                        "exchange_rate": "",
                                        "doc_no": doc_no,
                                      };
                                      (aorgfile == null)
                                          ? Provider.of<TravelViewModel>(
                                                  context as BuildContext,
                                                  listen: false)
                                              .postTravelFormSubmit(
                                                  context as BuildContext,
                                                  request_filename,
                                                  afile!,
                                                  request_data)
                                              .then((_) {
                                              setState(() {
                                                _selection = 3;
                                              });
                                            })
                                          : Provider.of<TravelViewModel>(
                                                  context as BuildContext,
                                                  listen: false)
                                              .postTravelFormSubmit2(
                                                  context as BuildContext,
                                                  request_filename2,
                                                  afile!,
                                                  aorgfile!,
                                                  request_data)
                                              .then((_) {
                                              setState(() {
                                                _selection = 3;
                                              });
                                            });
                                    }
                                  },
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _foodtab() {
    final themeProvider = Provider.of<ThemeProvider>(context as BuildContext);
    final height = MediaQuery.of(context as BuildContext).size.height;
    final width = MediaQuery.of(context as BuildContext).size.width;
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
                          style: Theme.of(context as BuildContext)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     _upload("food", context);
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.only(
                    //       left: SizeVariables.getWidth(context) * 0.45,
                    //       top: SizeVariables.getWidth(context) * 0.01,
                    //     ),
                    //     child: Icon(
                    //       Icons.arrow_circle_up_outlined,
                    //       size: 40,
                    //     ),
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
                              readOnly:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
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
                            onTap: widget.args['status'] == 'Saved as Draft' ||
                                    widget.args['status'] == 'Submit'
                                ? () {
                                    showDatePicker(
                                            builder: (context, child) => Theme(
                                                  data: ThemeData().copyWith(
                                                    colorScheme:
                                                        const ColorScheme.dark(
                                                      primary:
                                                          Color(0xffF59F23),
                                                      surface: Colors.black,
                                                      onSurface: Colors.white,
                                                    ),
                                                    dialogBackgroundColor:
                                                        Color.fromARGB(
                                                            255, 91, 91, 91),
                                                  ),
                                                  child: child!,
                                                ),
                                            context: context as BuildContext,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2015),
                                            lastDate: DateTime.now())
                                        .then((value) {
                                      setState(() {
                                        // _dateTimeStart = value;
                                        fclaim_date.text = dateFormat.format(
                                            DateTime.parse(value.toString()));
                                      });
                                      // print('DATE START: $_dateTimeStart');
                                    });
                                  }
                                : () {},
                            child: Container(
                              child: const Icon(Icons.calendar_month_outlined),
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
                              onTap: widget.args['status'] ==
                                          'Saved as Draft' ||
                                      widget.args['status'] == 'Submit'
                                  ? () {
                                      showDatePicker(
                                              builder: (context, child) =>
                                                  Theme(
                                                    data: ThemeData().copyWith(
                                                      colorScheme:
                                                          ColorScheme.dark(
                                                        primary:
                                                            Color(0xffF59F23),
                                                        surface: Colors.black,
                                                        onSurface: Colors.white,
                                                      ),
                                                      dialogBackgroundColor:
                                                          Color.fromARGB(
                                                              255, 91, 91, 91),
                                                    ),
                                                    child: child!,
                                                  ),
                                              context: context as BuildContext,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2015),
                                              lastDate: DateTime.now())
                                          .then((value) {
                                        setState(() {
                                          // _dateTimeStart = value;
                                          fclaim_date.text = dateFormat.format(
                                              DateTime.parse(value.toString()));
                                        });
                                        // print('DATE START: $_dateTimeStart');
                                      });
                                    }
                                  : () {},
                              readOnly: true,
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
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
                              readOnly:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
                              keyboardType: TextInputType.text,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                              ],
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
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
                          child: Row(
                            children: [
                              // Container(
                              //   child: Icon(Icons.currency_rupee_outlined),
                              // ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.3,
                                // width: 300,
                                // height: 200,
                                child: TextFormField(
                                  controller: fbasic_amount,
                                  // readOnly: tCheckValue
                                  //bool? tCheck;== false ? true : false,
                                  readOnly: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
                                  onChanged: (content) {
                                    if (content == '') {
                                      setState(() {
                                        fclaim_amount.text = '0.0';
                                      });

                                      setState(() {
                                        _finalSum("food", details.toString(),
                                            fclaim_amount.text);
                                      });
                                    }

                                    if (content != '') {
                                      setState(() {
                                        fclaim_amount.text = content;
                                      });
                                      setState(() {
                                        _finalSum("food", details.toString(),
                                            fclaim_amount.text);
                                      });
                                    }

                                    if (content == '' &&
                                        fgst_amount.text != '') {
                                      setState(() {
                                        fclaim_amount.text = fgst_amount.text;
                                      });
                                      setState(() {
                                        _finalSum("food", details.toString(),
                                            fclaim_amount.text);
                                      });
                                    }

                                    if (content == '' &&
                                        fgst_amount.text == '') {
                                      setState(() {
                                        fclaim_amount.text = '0.0';
                                      });

                                      setState(() {
                                        _finalSum("food", details.toString(),
                                            fclaim_amount.text);
                                      });
                                    }

                                    if (double.parse(content) >
                                        int.parse(Limit_food)) {
                                      setState(() {
                                        fbasic_amount.text =
                                            Limit_food.toString();
                                        fclaim_amount.text =
                                            Limit_food.toString();
                                      });
                                      setState(() {
                                        _finalSum("food", details.toString(),
                                            fclaim_amount.text);
                                      });
                                    }

                                    if (content != '' &&
                                        fgst_amount.text != '') {
                                      setState(() {
                                        fclaim_amount
                                            .text = (double.parse(content) +
                                                double.parse(fgst_amount.text))
                                            .toString();
                                      });
                                      setState(() {
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
                                  showCursor: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                            // readOnly: fClicked == false ? true : false,
                            readOnly:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? false
                                    : true,
                            onChanged: (gstContent) {
                              if (gstContent == '' &&
                                  fbasic_amount.text != '') {
                                setState(() {
                                  fclaim_amount.text = fbasic_amount.text;
                                });

                                setState(() {
                                  _finalSum("food", details.toString(),
                                      fclaim_amount.text);
                                });
                              }

                              if (gstContent == '' &&
                                  fbasic_amount.text == '') {
                                setState(() {
                                  fclaim_amount.text = '0.0';
                                });

                                setState(() {
                                  _finalSum("food", details.toString(),
                                      fclaim_amount.text);
                                });
                              }

                              if (gstContent != '') {
                                setState(() {
                                  fclaim_amount.text = gstContent;
                                });
                                setState(() {
                                  _finalSum("food", details.toString(),
                                      fclaim_amount.text);
                                });
                              }

                              if (fgst_amount.text != '') {
                                setState(() {
                                  fCheckValue = checkGST(
                                      double.parse(fbasic_amount.text),
                                      double.parse(fgst_amount.text),
                                      context as BuildContext);
                                });
                              }

                              if (double.parse(gstContent) > fCheckValue!) {
                                Flushbar(
                                  leftBarIndicatorColor: Colors.red,
                                  icon: const Icon(Icons.warning,
                                      color: Colors.white),
                                  message: 'GST EXCEEDED',
                                  duration: const Duration(seconds: 2),
                                ).show(context as BuildContext);
                                setState(() {
                                  fCheck = true;
                                  print('FCHECKKKKKK: $fCheck');
                                  // fbasic_amount.clear();
                                  fbasic_amount.text = '';
                                  fclaim_amount.text = '0.0';
                                });
                                setState(() {
                                  _finalSum("food", details.toString(),
                                      fclaim_amount.text);
                                });
                              }

                              if (double.parse(gstContent) <= fCheckValue!) {
                                setState(() {
                                  fCheck = false;
                                  print('FCHECKKKKKK: $fCheck');
                                });
                              }

                              if (double.parse(gstContent) +
                                      double.parse(fbasic_amount.text) >
                                  int.parse(Limit_food)) {
                                fclaim_amount.text = Limit_food;

                                fbasic_amount.text = (int.parse(Limit_food) -
                                        double.parse(gstContent == ''
                                            ? '0'
                                            : gstContent))
                                    .toString();
                              }

                              if (gstContent != '' && fgst_amount.text != '') {
                                setState(() {
                                  fclaim_amount.text =
                                      (double.parse(gstContent) +
                                              double.parse(fbasic_amount.text))
                                          .toString();
                                });
                                setState(() {
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
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? true
                                    : false,
                            // showCursor: tClicked == false ? false : true,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
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
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: false,
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
                          style: Theme.of(context as BuildContext)
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
                Container(
                  height: height > 750
                      ? 32.h
                      : height < 650
                          ? 40.h
                          : 39.h,
                  // width: 220,
                  child: Container(
                    // height: SizeVariables.getHeight(context) * 0.2,
                    width: double.infinity,
                    // color: Colors.pink,
                    // padding: EdgeInsets.all(SizeVariables.getWidth(context) * 0.02),
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeVariables.getWidth(context) * 0.04,
                        vertical: SizeVariables.getHeight(context) * 0.02),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                            // color: Colors.pink,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                color: Colors.black),
                                            SizedBox(
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.02),
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.3,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text('Uploaded Invoice',
                                                    style: Theme.of(context
                                                            as BuildContext)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 18)),
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
                                    height: SizeVariables.getHeight(context) *
                                        0.015),
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          SizeVariables.getWidth(context) * 0.4,
                                      child: Container(
                                        child: InkWell(
                                          onTap: () {},
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            child: Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.1,
                                              height: 200,
                                              // color: Colors.yellow,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 2)),
                                              child: ffile == null
                                                  ? Center(
                                                      child: Text(
                                                          'Please Upload Invoice',
                                                          style: Theme.of(context
                                                                  as BuildContext)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black)),
                                                    )
                                                  : (ffile_link != null)
                                                      ? ((ffile_link!
                                                              .contains('pdf'))
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(Icons
                                                                          .arrow_downward),
                                                                      Text(
                                                                        'File has been captured.',
                                                                        style: Theme.of(context
                                                                                as BuildContext)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            openFileNetworkFile(
                                                                                fileLink: ffile_link!,
                                                                                fileName: 'inv.pdf');
                                                                          },
                                                                          child:
                                                                              Text('Click to open'))
                                                                    ],
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit.fill,
                                                                  //     image: FileImage(
                                                                  //       File(tfile!
                                                                  //           .path),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Image
                                                                      .network(
                                                                    ffile_link!,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    loadingBuilder: (BuildContext
                                                                            context,
                                                                        Widget
                                                                            child,
                                                                        ImageChunkEvent?
                                                                            loadingProgress) {
                                                                      if (loadingProgress ==
                                                                          null)
                                                                        return child;
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          value: loadingProgress.expectedTotalBytes != null
                                                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                              : null,
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit
                                                                  //         .fill,
                                                                  //     image: NetworkImage(
                                                                  //         ffile_link!),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            ))
                                                      : (ffile.path
                                                              .toString()
                                                              .contains('pdf'))
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(Icons
                                                                          .arrow_downward),
                                                                      Text(
                                                                        'File has been captured.',
                                                                        style: Theme.of(context
                                                                                as BuildContext)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            openFile(ffile);
                                                                          },
                                                                          child:
                                                                              Text('Click to open'))
                                                                    ],
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit.fill,
                                                                  //     image: FileImage(
                                                                  //       File(tfile!
                                                                  //           .path),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image:
                                                                          FileImage(
                                                                        File(ffile!
                                                                            .path),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //   // color: Colors.red,
                                    //   width: SizeVariables.getWidth(context) *
                                    //       0.4,
                                    //   child: Expanded(
                                    //     child: InkWell(
                                    //       onTap: () {},
                                    //       child: ClipRRect(
                                    //         borderRadius:
                                    //             const BorderRadius.all(
                                    //                 Radius.circular(20)),
                                    //         child: Container(
                                    //           width: SizeVariables.getWidth(
                                    //                   context) *
                                    //               0.3,
                                    //           height: 200,
                                    //           // color: Colors.yellow,
                                    //           decoration: BoxDecoration(
                                    //               border: Border.all(
                                    //                   color: Colors.grey,
                                    //                   width: 2)),
                                    //           child: Center(
                                    //             child: Icon(
                                    //               Icons.download,
                                    //               color: Colors.grey,
                                    //               size: 80,
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),

                                    widget.args['status'] == 'Saved as Draft' ||
                                            widget.args['status'] == 'Submit'
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      child: Container(
                                                        height: 2,
                                                        // height: screenWidth * 0.2,
                                                        width: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.05,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.05,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          final image =
                                                              await ImagePicker()
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .camera);
                                                          if (image == null)
                                                            return;

                                                          // imageTemporary = cropSquareImage(File(image.path));

                                                          XFile?
                                                              imageTemporary =
                                                              XFile(image.path);

                                                          // imageTemporary =
                                                          //     await cropImage(
                                                          //         imageTemporary);

                                                          imageTemporary =
                                                              await cropImageTwo(
                                                                  imageTemporary);

                                                          setState(() {
                                                            ffile =
                                                                imageTemporary;

                                                            isLoading = false;
                                                            isGallery = true;
                                                            print(
                                                                'FOOD FILE: $ffile');
                                                            print(
                                                                'FFILE FORMAT: ${ffile.runtimeType}');
                                                            isLoading = false;
                                                            isGallery = true;
                                                          });
                                                        },
                                                        // if (type == "food") {
                                                        // final image =
                                                        //     await ImagePicker()
                                                        //         .pickImage(
                                                        //             source: ImageSource
                                                        //                 .camera);

                                                        //NEW CODEEEE
                                                        // String imagePath = join(
                                                        //     (await getApplicationSupportDirectory())
                                                        //         .path,
                                                        //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                                        // bool success =
                                                        //     await EdgeDetection
                                                        //         .detectEdge(
                                                        //   imagePath,
                                                        //   canUseGallery: true,
                                                        //   androidScanTitle:
                                                        //       'Scanning', // use custom localizations for android
                                                        //   androidCropTitle:
                                                        //       'Crop',
                                                        //   androidCropBlackWhiteTitle:
                                                        //       'Black White',
                                                        //   androidCropReset:
                                                        //       'Reset',
                                                        // );

                                                        // setState(() {
                                                        //   ffile = new XFile(
                                                        //       new File(imagePath
                                                        //               .toString())
                                                        //           .path);
                                                        //   ffile_link = null;
                                                        // });

                                                        // var imagePath =
                                                        //     await EdgeDetection
                                                        //         .detectEdge(
                                                        //   image!.path,
                                                        //   canUseGallery: true,
                                                        //   androidScanTitle:
                                                        //       'Scanning', // use custom localizations for android
                                                        //   androidCropTitle:
                                                        //       'Crop',
                                                        //   androidCropBlackWhiteTitle:
                                                        //       'Black White',
                                                        //   androidCropReset:
                                                        //       'Reset',
                                                        // );
                                                        //     await EdgeDetection
                                                        //         .detectEdge
                                                        //         .then(
                                                        //             (value) {
                                                        //   print(value
                                                        //       .toString());
                                                        //   if (value == null) {
                                                        //     _errorVal(
                                                        //         context);
                                                        //   } else {
                                                        //     _imageCaptured(
                                                        //         context);
                                                        //   }
                                                        //   return value;
                                                        // });
                                                        // setState(() {
                                                        //   ffile = new XFile(
                                                        //       new File(imagePath
                                                        //               .toString())
                                                        //           .path);
                                                        //   ffile_link = null;
                                                        // });
                                                        // }

                                                        child: Icon(
                                                          Icons.camera_alt,
                                                          color: Colors.white,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      child: Container(
                                                        height: 2,
                                                        // height: screenWidth * 0.2,
                                                        width: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.05,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.05,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          // if (type == 'food') {
                                                          // final result =
                                                          //     await FilePicker
                                                          //         .platform
                                                          //         .pickFiles();
                                                          // if (result == null)
                                                          //   return;

                                                          // ffile = result
                                                          //     .files.first;
                                                          // //openFile(tfile);
                                                          // final ffilePath =
                                                          //     ffile.path;
                                                          // print(
                                                          //     'file-path: ${ffilePath}'); //opens the file

                                                          // setState(() {
                                                          //   ffile = new XFile(
                                                          //       new File(ffilePath
                                                          //               .toString())
                                                          //           .path);
                                                          //   ffile_link = null;
                                                          // });
                                                          // }

                                                          final image =
                                                              await ImagePicker()
                                                                  .pickImage(
                                                                      source: ImageSource
                                                                          .gallery);
                                                          if (image == null)
                                                            return;

                                                          // imageTemporary = cropSquareImage(File(image.path));

                                                          XFile?
                                                              imageTemporary =
                                                              XFile(image.path);

                                                          // imageTemporary =
                                                          //     await cropImage(
                                                          //         imageTemporary);

                                                          imageTemporary =
                                                              await cropImageTwo(
                                                                  imageTemporary);

                                                          setState(() {
                                                            ffile =
                                                                imageTemporary;
                                                            isLoading = false;
                                                            isGallery = true;
                                                          });
                                                        },
                                                        child: const Icon(
                                                          Icons
                                                              .file_copy_outlined,
                                                          color: Colors.white,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      child: Container(
                                                        height: 2,
                                                        // height: screenWidth * 0.2,
                                                        width: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.05,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
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
                widget.args['status'] == 'Saved as Draft' ||
                        widget.args['status'] == 'Submit'
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.only(
                              right: SizeVariables.getWidth(context) * 0.05),
                          child: AnimatedButton(
                            height: 45,
                            width: 100,
                            text: 'Save',
                            isReverse: true,
                            selectedTextColor: Colors.black,
                            transitionType: TransitionType.LEFT_TO_RIGHT,
                            textStyle: TextStyle(
                                fontSize: 13,
                                color: (themeProvider.darkTheme)
                                    ? Colors.white
                                    : Colors.black),
                            backgroundColor: (themeProvider.darkTheme)
                                ? Colors.black
                                : Theme.of(context as BuildContext)
                                    .colorScheme
                                    .onPrimary,
                            borderColor: (themeProvider.darkTheme)
                                ? Colors.white
                                : Theme.of(context as BuildContext)
                                    .colorScheme
                                    .onPrimary,
                            borderRadius: 8,
                            borderWidth: 2,
                            onPress: fCheck == true
                                ? () => Flushbar(
                                      leftBarIndicatorColor: Colors.red,
                                      icon: const Icon(Icons.warning,
                                          color: Colors.white),
                                      message:
                                          'Please Ensure that the GST Value hasn\'t exceeded by more than 28% of the basic amount',
                                      duration: const Duration(seconds: 5),
                                    ).show(context as BuildContext)
                                : () {
                                    Map request_filename = {
                                      "file_name": "document",
                                    };
                                    if (ffile == null) {
                                      _errorVal(context as BuildContext);
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
                                            fexchangerate.text.toString() == ''
                                                ? "domestic"
                                                : "international",
                                        "from_date": "",
                                        "from_time": "",
                                        "to_date": "",
                                        "to_time": "",
                                        "date": fclaim_date.text.toString(),
                                        "gst_no": fgst_no.text.toString(),
                                        "gst_amount":
                                            fgst_amount.text.toString(),
                                        "claim_amount":
                                            fclaim_amount.text.toString(),
                                        "basic_amount":
                                            fbasic_amount.text.toString(),
                                        "payment_type": fdetails.toString(),
                                        "exchange_rate":
                                            fexchangerate.text.toString(),
                                        "doc_no": doc_no,
                                      };
                                      Provider.of<TravelViewModel>(
                                              context as BuildContext,
                                              listen: false)
                                          .postTravelFormSubmit(
                                              context as BuildContext,
                                              request_filename,
                                              ffile! as XFile,
                                              request_data)
                                          .then((_) {
                                        setState(() {
                                          _selection = 4;
                                        });
                                      });
                                    }
                                  },
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _incidentaltab() {
    final themeProvider = Provider.of<ThemeProvider>(context as BuildContext);
    final height = MediaQuery.of(context as BuildContext).size.height;
    final width = MediaQuery.of(context as BuildContext).size.width;
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
                          style: Theme.of(context as BuildContext)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     _upload("incidental", context);
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.only(
                    //       left: SizeVariables.getWidth(context) * 0.34,
                    //       top: SizeVariables.getWidth(context) * 0.01,
                    //     ),
                    //     child: Icon(
                    //       Icons.arrow_circle_up_outlined,
                    //       size: 40,
                    //     ),
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
                              readOnly:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
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
                              readOnly:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
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
                            onTap: widget.args['status'] == 'Saved as Draft' ||
                                    widget.args['status'] == 'Submit'
                                ? () {
                                    showDatePicker(
                                            builder: (context, child) => Theme(
                                                  data: ThemeData().copyWith(
                                                    colorScheme:
                                                        ColorScheme.dark(
                                                      primary:
                                                          Color(0xffF59F23),
                                                      surface: Colors.black,
                                                      onSurface: Colors.white,
                                                    ),
                                                    dialogBackgroundColor:
                                                        Color.fromARGB(
                                                            255, 91, 91, 91),
                                                  ),
                                                  child: child!,
                                                ),
                                            context: context as BuildContext,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2015),
                                            lastDate: DateTime.now())
                                        .then((value) {
                                      setState(() {
                                        // _dateTimeStart = value;
                                        iclaim_date.text = dateFormat.format(
                                            DateTime.parse(value.toString()));
                                      });
                                      // print('DATE START: $_dateTimeStart');
                                    });
                                  }
                                : () {},
                            child: Container(
                              child: const Icon(Icons.calendar_month_outlined),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(
                                    context as BuildContext) *
                                0.02,
                          ),
                          Container(
                            width: SizeVariables.getWidth(
                                    context as BuildContext) *
                                0.76,
                            // width: 300,
                            // height: 200,
                            child: TextFormField(
                              onTap: widget.args['status'] ==
                                          'Saved as Draft' ||
                                      widget.args['status'] == 'Submit'
                                  ? () {
                                      showDatePicker(
                                              builder: (context, child) =>
                                                  Theme(
                                                    data: ThemeData().copyWith(
                                                      colorScheme:
                                                          ColorScheme.dark(
                                                        primary:
                                                            Color(0xffF59F23),
                                                        surface: Colors.black,
                                                        onSurface: Colors.white,
                                                      ),
                                                      dialogBackgroundColor:
                                                          Color.fromARGB(
                                                              255, 91, 91, 91),
                                                    ),
                                                    child: child!,
                                                  ),
                                              context: context as BuildContext,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2015),
                                              lastDate: DateTime.now())
                                          .then((value) {
                                        setState(() {
                                          // _dateTimeStart = value;
                                          iclaim_date.text = dateFormat.format(
                                              DateTime.parse(value.toString()));
                                        });
                                        // print('DATE START: $_dateTimeStart');
                                      });
                                    }
                                  : () {},
                              readOnly: true,
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
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
                              readOnly:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(15),
                              ],
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
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
                          child: Row(
                            children: [
                              // Container(
                              //   child: Icon(Icons.currency_rupee_outlined),
                              // ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.3,
                                // width: 300,
                                // height: 200,
                                child: TextFormField(
                                  controller: ibasic_amount,
                                  readOnly: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
                                  // readOnly: tCheckValue
                                  //bool? tCheck;== false ? true : false,
                                  onChanged: (content) {
                                    if (content == '') {
                                      setState(() {
                                        iclaim_amount.text = '0.0';
                                      });

                                      setState(() {
                                        _finalSum(
                                            "incidental",
                                            details.toString(),
                                            iclaim_amount.text);
                                      });
                                    }

                                    if (content != '') {
                                      setState(() {
                                        iclaim_amount.text = content;
                                      });
                                      setState(() {
                                        _finalSum(
                                            "incidental",
                                            details.toString(),
                                            iclaim_amount.text);
                                      });
                                    }

                                    if (content == '' &&
                                        igst_amount.text != '') {
                                      setState(() {
                                        iclaim_amount.text = igst_amount.text;
                                      });
                                      setState(() {
                                        _finalSum("travel", details.toString(),
                                            tclaim_amount.text);
                                      });
                                    }

                                    if (content == '' &&
                                        igst_amount.text == '') {
                                      setState(() {
                                        iclaim_amount.text = '0.0';
                                      });

                                      setState(() {
                                        _finalSum("travel", details.toString(),
                                            iclaim_amount.text);
                                      });
                                    }

                                    if (double.parse(content) >
                                        int.parse(Limit_incidental)) {
                                      setState(() {
                                        ibasic_amount.text =
                                            Limit_incidental.toString();
                                        iclaim_amount.text =
                                            Limit_incidental.toString();
                                      });
                                      setState(() {
                                        _finalSum(
                                            "incidental",
                                            details.toString(),
                                            iclaim_amount.text);
                                      });
                                    }

                                    if (content != '' &&
                                        igst_amount.text != '') {
                                      setState(() {
                                        iclaim_amount
                                            .text = (double.parse(content) +
                                                double.parse(igst_amount.text))
                                            .toString();
                                      });
                                      setState(() {
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
                                  showCursor: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                            readOnly:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? false
                                    : true,
                            // readOnly:
                            //     iClicked == false || iCheck == false ? true : false,
                            onChanged: (gstContent) {
                              if (gstContent == '' &&
                                  ibasic_amount.text != '') {
                                setState(() {
                                  iclaim_amount.text = ibasic_amount.text;
                                });

                                setState(() {
                                  _finalSum("incidental", details.toString(),
                                      iclaim_amount.text);
                                });
                              }

                              if (gstContent == '' &&
                                  ibasic_amount.text == '') {
                                setState(() {
                                  iclaim_amount.text = '0.0';
                                });

                                setState(() {
                                  _finalSum("incidental", details.toString(),
                                      iclaim_amount.text);
                                });
                              }

                              if (gstContent != '') {
                                setState(() {
                                  iclaim_amount.text = gstContent;
                                });
                                setState(() {
                                  _finalSum("incidental", details.toString(),
                                      iclaim_amount.text);
                                });
                              }

                              if (igst_amount.text != '') {
                                setState(() {
                                  iCheckValue = checkGST(
                                      double.parse(ibasic_amount.text),
                                      double.parse(igst_amount.text),
                                      context as BuildContext);
                                });
                              }

                              if (double.parse(gstContent) > iCheckValue!) {
                                Flushbar(
                                  leftBarIndicatorColor: Colors.red,
                                  icon: const Icon(Icons.warning,
                                      color: Colors.white),
                                  message: 'GST EXCEEDED',
                                  duration: const Duration(seconds: 2),
                                ).show(context as BuildContext);
                                setState(() {
                                  iCheck = true;
                                  print('FCHECKKKKKK: $iCheck');
                                  // fbasic_amount.clear();
                                  ibasic_amount.text = '';
                                  iclaim_amount.text = '0.0';
                                });
                                setState(() {
                                  _finalSum("incidental", details.toString(),
                                      iclaim_amount.text);
                                });
                              }

                              if (double.parse(gstContent) <= iCheckValue!) {
                                setState(() {
                                  iCheck = false;
                                  print('FCHECKKKKKK: $iCheck');
                                });
                              }

                              if (double.parse(gstContent) +
                                      double.parse(ibasic_amount.text) >
                                  int.parse(Limit_incidental)) {
                                iclaim_amount.text = Limit_incidental;

                                ibasic_amount.text =
                                    (int.parse(Limit_incidental) -
                                            double.parse(gstContent == ''
                                                ? '0'
                                                : gstContent))
                                        .toString();
                              }

                              if (gstContent != '' && igst_amount.text != '') {
                                setState(() {
                                  iclaim_amount.text =
                                      (double.parse(gstContent) +
                                              double.parse(ibasic_amount.text))
                                          .toString();
                                });
                                setState(() {
                                  _finalSum("incidental", details.toString(),
                                      iclaim_amount.text);
                                });
                              }
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
                              labelText: 'GST Amount',
                              // hintText: "To",
                              // hintStyle: Theme.of(context)
                              //     .textTheme
                              //     .bodyText2!
                              //     .copyWith(color: Colors.grey),
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? true
                                    : false,
                            // showCursor: tClicked == false ? false : true,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
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
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: false,
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
                          style: Theme.of(context as BuildContext)
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
                            child: const Icon(Icons.book_online),
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
                Container(
                  height: height > 750
                      ? 32.h
                      : height < 650
                          ? 40.h
                          : 39.h,
                  // width: 220,
                  child: Container(
                    // height: SizeVariables.getHeight(context) * 0.2,
                    width: double.infinity,
                    // color: Colors.pink,
                    // padding: EdgeInsets.all(SizeVariables.getWidth(context) * 0.02),
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeVariables.getWidth(context) * 0.04,
                        vertical: SizeVariables.getHeight(context) * 0.02),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                            // color: Colors.pink,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                color: Colors.black),
                                            SizedBox(
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.02),
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.3,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text('Uploaded Invoice',
                                                    style: Theme.of(context
                                                            as BuildContext)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 18)),
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
                                    height: SizeVariables.getHeight(context) *
                                        0.015),
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          SizeVariables.getWidth(context) * 0.4,
                                      child: Container(
                                        child: InkWell(
                                          onTap: () {},
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            child: Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.1,
                                              height: 200,
                                              // color: Colors.yellow,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 2)),
                                              child: ifile == null
                                                  ? Center(
                                                      child: Text(
                                                          'Please Upload Invoice',
                                                          style: Theme.of(context
                                                                  as BuildContext)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black)),
                                                    )
                                                  : (ifile_link != null)
                                                      ? ((ifile_link!
                                                              .contains('pdf'))
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(Icons
                                                                          .arrow_downward),
                                                                      Text(
                                                                        'File has been captured.',
                                                                        style: Theme.of(context
                                                                                as BuildContext)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            openFileNetworkFile(
                                                                                fileLink: ifile_link!,
                                                                                fileName: 'inv.pdf');
                                                                          },
                                                                          child:
                                                                              Text('Click to open'))
                                                                    ],
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit.fill,
                                                                  //     image: FileImage(
                                                                  //       File(tfile!
                                                                  //           .path),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Image
                                                                      .network(
                                                                    ifile_link!,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    loadingBuilder: (BuildContext
                                                                            context,
                                                                        Widget
                                                                            child,
                                                                        ImageChunkEvent?
                                                                            loadingProgress) {
                                                                      if (loadingProgress ==
                                                                          null)
                                                                        return child;
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          value: loadingProgress.expectedTotalBytes != null
                                                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                              : null,
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit
                                                                  //         .fill,
                                                                  //     image: NetworkImage(
                                                                  //         ifile_link!),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            ))
                                                      : (ifile.path
                                                              .toString()
                                                              .contains('pdf'))
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(Icons
                                                                          .arrow_downward),
                                                                      Text(
                                                                        'File has been captured.',
                                                                        style: Theme.of(context
                                                                                as BuildContext)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            openFile(ifile);
                                                                          },
                                                                          child:
                                                                              Text('Click to open'))
                                                                    ],
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit.fill,
                                                                  //     image: FileImage(
                                                                  //       File(tfile!
                                                                  //           .path),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image:
                                                                          FileImage(
                                                                        File(ifile!
                                                                            .path),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    widget.args['status'] == 'Saved as Draft' ||
                                            widget.args['status'] == 'Submit'
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  child: Container(
                                                    height: 2,
                                                    // height: screenWidth * 0.2,
                                                    width:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.05,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.05,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      // if (type == "incidental") {
                                                      // var imagePath =
                                                      //     await EdgeDetection
                                                      //         .detectEdge
                                                      //         .then((value) {
                                                      //   print(value.toString());
                                                      //   if (value == null) {
                                                      //     _errorVal(context
                                                      //         as BuildContext);
                                                      //   } else {
                                                      //     _imageCaptured(context
                                                      //         as BuildContext);
                                                      //   }
                                                      //   return value;
                                                      // });
                                                      // setState(() {
                                                      //   ifile = new XFile(
                                                      //       new File(imagePath
                                                      //               .toString())
                                                      //           .path);
                                                      //   ifile_link = null;
                                                      // });
                                                      //NEW CODEEEEE
                                                      // String imagePath = join(
                                                      //     (await getApplicationSupportDirectory())
                                                      //         .path,
                                                      //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                                      // bool success =
                                                      //     await EdgeDetection
                                                      //         .detectEdge(
                                                      //   imagePath,
                                                      //   canUseGallery: true,
                                                      //   androidScanTitle:
                                                      //       'Scanning', // use custom localizations for android
                                                      //   androidCropTitle:
                                                      //       'Crop',
                                                      //   androidCropBlackWhiteTitle:
                                                      //       'Black White',
                                                      //   androidCropReset:
                                                      //       'Reset',
                                                      // );

                                                      // setState(() {
                                                      //   ifile = new XFile(
                                                      //       new File(imagePath
                                                      //               .toString())
                                                      //           .path);
                                                      //   ifile_link = null;
                                                      // });

                                                      final image =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera);
                                                      if (image == null) return;

                                                      // imageTemporary = cropSquareImage(File(image.path));

                                                      // File? imageTemporary =
                                                      //     File(image.path);

                                                      // imageTemporary =
                                                      //     await cropImage(
                                                      //         imageTemporary);

                                                      XFile? imageTemporary =
                                                          XFile(image.path);

                                                      // imageTemporary =
                                                      //     await cropImage(
                                                      //         imageTemporary);

                                                      imageTemporary =
                                                          await cropImageTwo(
                                                              imageTemporary);

                                                      setState(() {
                                                        ifile = imageTemporary;
                                                        isLoading = false;
                                                        isGallery = true;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: Container(
                                                    height: 2,
                                                    // height: screenWidth * 0.2,
                                                    width:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.05,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.05,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      // if (type == 'incidental') {
                                                      // final result =
                                                      //     await FilePicker
                                                      //         .platform
                                                      //         .pickFiles();
                                                      // if (result == null)
                                                      //   return;

                                                      // ifile =
                                                      //     result.files.first;
                                                      // //openFile(tfile);
                                                      // final ifilePath =
                                                      //     ifile.path;
                                                      // print(
                                                      //     'file-path: ${ifilePath}'); //opens the file

                                                      // setState(() {
                                                      //   ifile = new XFile(
                                                      //       new File(ifilePath
                                                      //               .toString())
                                                      //           .path);
                                                      //   ifile_link = null;
                                                      // });
                                                      // }

                                                      final image =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source: ImageSource
                                                                      .gallery);
                                                      if (image == null) return;

                                                      // imageTemporary = cropSquareImage(File(image.path));

                                                      XFile? imageTemporary =
                                                          XFile(image.path);

                                                      // imageTemporary =
                                                      //     await cropImage(
                                                      //         imageTemporary);

                                                      imageTemporary =
                                                          await cropImageTwo(
                                                              imageTemporary);

                                                      setState(() {
                                                        ifile = imageTemporary;
                                                        isLoading = false;
                                                        isGallery = true;
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.file_copy_outlined,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: Container(
                                                    height: 2,
                                                    // height: screenWidth * 0.2,
                                                    width:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.05,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
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
                widget.args['status'] == 'Saved as Draft' ||
                        widget.args['status'] == 'Submit'
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.only(
                              right: SizeVariables.getWidth(context) * 0.05),
                          child: AnimatedButton(
                            height: 45,
                            width: 100,
                            text: 'Save',
                            isReverse: true,
                            selectedTextColor: Colors.black,
                            transitionType: TransitionType.LEFT_TO_RIGHT,
                            textStyle: TextStyle(
                                fontSize: 13,
                                color: (themeProvider.darkTheme)
                                    ? Colors.white
                                    : Colors.black),
                            backgroundColor: (themeProvider.darkTheme)
                                ? Colors.black
                                : Theme.of(context as BuildContext)
                                    .colorScheme
                                    .onPrimary,
                            borderColor: (themeProvider.darkTheme)
                                ? Colors.white
                                : Theme.of(context as BuildContext)
                                    .colorScheme
                                    .onPrimary,
                            borderRadius: 8,
                            borderWidth: 2,
                            onPress: iCheck == true
                                ? () => Flushbar(
                                      leftBarIndicatorColor: Colors.red,
                                      icon: const Icon(Icons.warning,
                                          color: Colors.white),
                                      message:
                                          'Please Ensure that the GST Value hasn\'t exceeded by more than 28% of the basic amount',
                                      duration: const Duration(seconds: 5),
                                    ).show(context as BuildContext)
                                : () {
                                    Map request_filename = {
                                      "file_name": "document",
                                    };
                                    if (ifile == null) {
                                      _errorVal(context as BuildContext);
                                    } else {
                                      Map<String, String> request_data = {
                                        "claim_type": "incidental",
                                        "mod_of_travel": "",
                                        "trip_way": "",
                                        "from_place": "",
                                        "to_place": "",
                                        "acco_type": "",
                                        "payment_details":
                                            ipurchase.text.toString(),
                                        "service_provider":
                                            iserviceprovider.text.toString(),
                                        "travel_type":
                                            iexchangerate.text.toString() == ''
                                                ? "domestic"
                                                : "international",
                                        "from_date": "",
                                        "from_time": "",
                                        "to_date": "",
                                        "to_time": "",
                                        "date": iclaim_date.text.toString(),
                                        "gst_no": igst_no.text.toString(),
                                        "gst_amount":
                                            igst_amount.text.toString(),
                                        "claim_amount":
                                            iclaim_amount.text.toString(),
                                        "basic_amount":
                                            ibasic_amount.text.toString(),
                                        "payment_type": idetails.toString(),
                                        "exchange_rate":
                                            iexchangerate.text.toString(),
                                        "doc_no": doc_no,
                                      };
                                      Provider.of<TravelViewModel>(
                                              context as BuildContext,
                                              listen: false)
                                          .postTravelFormSubmit(
                                              context as BuildContext,
                                              request_filename,
                                              ifile!,
                                              request_data)
                                          .then((_) {
                                        setState(() {
                                          _selection = 5;
                                        });
                                      });
                                    }
                                  },
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _localtab() {
    final themeProvider = Provider.of<ThemeProvider>(context as BuildContext);
    final height = MediaQuery.of(context as BuildContext).size.height;
    final width = MediaQuery.of(context as BuildContext).size.width;
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
                          style: Theme.of(context as BuildContext)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     _upload("local", context);
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.only(
                    //       left: SizeVariables.getWidth(context) * 0.45,
                    //       top: SizeVariables.getWidth(context) * 0.01,
                    //     ),
                    //     child: Icon(
                    //       Icons.arrow_circle_up_outlined,
                    //       size: 40,
                    //     ),
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
                              readOnly:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
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
                            onTap: widget.args['status'] == 'Saved as Draft' ||
                                    widget.args['status'] == 'Submit'
                                ? () {
                                    showDatePicker(
                                            builder: (context, child) => Theme(
                                                  data: ThemeData().copyWith(
                                                    colorScheme:
                                                        const ColorScheme.dark(
                                                      primary:
                                                          Color(0xffF59F23),
                                                      surface: Colors.black,
                                                      onSurface: Colors.white,
                                                    ),
                                                    dialogBackgroundColor:
                                                        Color.fromARGB(
                                                            255, 91, 91, 91),
                                                  ),
                                                  child: child!,
                                                ),
                                            context: context as BuildContext,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2015),
                                            lastDate: DateTime.now())
                                        .then((value) {
                                      setState(() {
                                        // _dateTimeStart = value;
                                        lclaim_date.text = dateFormat.format(
                                            DateTime.parse(value.toString()));
                                      });
                                      // print('DATE START: $_dateTimeStart');
                                    });
                                  }
                                : () {},
                            child: Container(
                              child: const Icon(Icons.calendar_month_outlined),
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
                              onTap: widget.args['status'] ==
                                          'Saved as Draft' ||
                                      widget.args['status'] == 'Submit'
                                  ? () {
                                      showDatePicker(
                                              builder: (context, child) =>
                                                  Theme(
                                                    data: ThemeData().copyWith(
                                                      colorScheme:
                                                          const ColorScheme
                                                              .dark(
                                                        primary:
                                                            Color(0xffF59F23),
                                                        surface: Colors.black,
                                                        onSurface: Colors.white,
                                                      ),
                                                      dialogBackgroundColor:
                                                          const Color.fromARGB(
                                                              255, 91, 91, 91),
                                                    ),
                                                    child: child!,
                                                  ),
                                              context: context as BuildContext,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2015),
                                              lastDate: DateTime.now())
                                          .then((value) {
                                        setState(() {
                                          // _dateTimeStart = value;
                                          lclaim_date.text = dateFormat.format(
                                              DateTime.parse(value.toString()));
                                        });
                                        // print('DATE START: $_dateTimeStart');
                                      });
                                    }
                                  : () {},
                              readOnly: true,
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
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
                              readOnly:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
                              inputFormatters: [
                                new LengthLimitingTextInputFormatter(15),
                              ],
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
                                labelStyle: Theme.of(context as BuildContext)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontSize: 18, color: Colors.black),
                              ),
                              style: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black),
                              showCursor:
                                  widget.args['status'] == 'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
                              cursorColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          child: const Icon(Icons.currency_rupee_outlined),
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.02,
                        ),
                        Container(
                          child: Row(
                            children: [
                              // Container(
                              //   child: Icon(Icons.currency_rupee_outlined),
                              // ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02,
                              ),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.3,
                                // width: 300,
                                // height: 200,
                                child: TextFormField(
                                  controller: lbasic_amount,
                                  readOnly: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? false
                                      : true,
                                  // readOnly: tCheckValue
                                  //bool? tCheck;== false ? true : false,
                                  onChanged: (content) {
                                    if (content == '') {
                                      setState(() {
                                        lclaim_amount.text = '0.0';
                                      });

                                      setState(() {
                                        _finalSum("local", details.toString(),
                                            lclaim_amount.text);
                                      });
                                    }

                                    if (content != '') {
                                      setState(() {
                                        lclaim_amount.text = content;
                                      });
                                      setState(() {
                                        _finalSum("local", details.toString(),
                                            lclaim_amount.text);
                                      });
                                    }

                                    if (content == '' &&
                                        lgst_amount.text != '') {
                                      setState(() {
                                        lclaim_amount.text = lgst_amount.text;
                                      });
                                      setState(() {
                                        _finalSum("local", details.toString(),
                                            lclaim_amount.text);
                                      });
                                    }

                                    if (content == '' &&
                                        lgst_amount.text == '') {
                                      setState(() {
                                        lclaim_amount.text = '0.0';
                                      });

                                      setState(() {
                                        _finalSum("local", details.toString(),
                                            lclaim_amount.text);
                                      });
                                    }

                                    if (double.parse(content) >
                                        int.parse(Limit_local)) {
                                      setState(() {
                                        lbasic_amount.text =
                                            Limit_local.toString();
                                        lclaim_amount.text =
                                            Limit_local.toString();
                                      });
                                      setState(() {
                                        _finalSum("local", details.toString(),
                                            lclaim_amount.text);
                                      });
                                    }

                                    if (content != '' &&
                                        lgst_amount.text != '') {
                                      setState(() {
                                        lclaim_amount
                                            .text = (double.parse(content) +
                                                double.parse(lgst_amount.text))
                                            .toString();
                                      });
                                      setState(() {
                                        _finalSum("local", details.toString(),
                                            lclaim_amount.text);
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
                                  showCursor: widget.args['status'] ==
                                              'Saved as Draft' ||
                                          widget.args['status'] == 'Submit'
                                      ? true
                                      : false,
                                  cursorColor: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                            readOnly:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? false
                                    : true,
                            // readOnly: lClicked == false
                            //     // || lCheck == false
                            //     ? true
                            //     : false,
                            onChanged: (gstContent) {
                              if (gstContent == '' &&
                                  lbasic_amount.text != '') {
                                setState(() {
                                  lclaim_amount.text = lbasic_amount.text;
                                });

                                setState(() {
                                  _finalSum("local", details.toString(),
                                      lclaim_amount.text);
                                });
                              }

                              if (gstContent == '' &&
                                  lbasic_amount.text == '') {
                                setState(() {
                                  lclaim_amount.text = '0.0';
                                });

                                setState(() {
                                  _finalSum("local", details.toString(),
                                      lclaim_amount.text);
                                });
                              }

                              if (gstContent != '') {
                                setState(() {
                                  lclaim_amount.text = gstContent;
                                });
                                setState(() {
                                  _finalSum("local", details.toString(),
                                      lclaim_amount.text);
                                });
                              }

                              if (lgst_amount.text != '') {
                                setState(() {
                                  lCheckValue = checkGST(
                                      double.parse(lbasic_amount.text),
                                      double.parse(lgst_amount.text),
                                      context as BuildContext);
                                });
                              }

                              if (double.parse(gstContent) > lCheckValue!) {
                                Flushbar(
                                  leftBarIndicatorColor: Colors.red,
                                  icon: const Icon(Icons.warning,
                                      color: Colors.white),
                                  message: 'GST EXCEEDED',
                                  duration: const Duration(seconds: 2),
                                ).show(context as BuildContext);
                                setState(() {
                                  lCheck = true;
                                  print('FCHECKKKKKK: $lCheck');
                                  // fbasic_amount.clear();
                                  lbasic_amount.text = '';
                                  lclaim_amount.text = '0.0';
                                });
                                setState(() {
                                  _finalSum("local", details.toString(),
                                      lclaim_amount.text);
                                });
                              }

                              if (double.parse(gstContent) <= lCheckValue!) {
                                setState(() {
                                  lCheck = false;
                                  print('FCHECKKKKKK: $lCheck');
                                });
                              }

                              if (double.parse(gstContent) +
                                      double.parse(lbasic_amount.text) >
                                  int.parse(Limit_local)) {
                                lclaim_amount.text = Limit_local;

                                lbasic_amount.text = (int.parse(Limit_local) -
                                        double.parse(gstContent == ''
                                            ? '0'
                                            : gstContent))
                                    .toString();
                              }

                              if (gstContent != '' && lgst_amount.text != '') {
                                setState(() {
                                  lclaim_amount.text =
                                      (double.parse(gstContent) +
                                              double.parse(lbasic_amount.text))
                                          .toString();
                                });
                                setState(() {
                                  _finalSum("local", details.toString(),
                                      lclaim_amount.text);
                                });
                              }
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
                              labelText: 'GST Amount',
                              // hintText: "To",
                              // hintStyle: Theme.of(context)
                              //     .textTheme
                              //     .bodyText2!
                              //     .copyWith(color: Colors.grey),
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor:
                                widget.args['status'] == 'Saved as Draft' ||
                                        widget.args['status'] == 'Submit'
                                    ? true
                                    : false,
                            // showCursor: tClicked == false ? false : true,
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
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
                            controller: lclaim_amount,
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
                              labelStyle: Theme.of(context as BuildContext)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 18, color: Colors.black),
                            ),
                            style: Theme.of(context as BuildContext)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.black),
                            showCursor: false,
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
                          style: Theme.of(context as BuildContext)
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
                            child: const Icon(Icons.book_online),
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
                                        style: const TextStyle(
                                            color: Colors.black),
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
                Container(
                  height: height > 750
                      ? 32.h
                      : height < 650
                          ? 40.h
                          : 39.h,
                  // width: 220,
                  child: Container(
                    // height: SizeVariables.getHeight(context) * 0.2,
                    width: double.infinity,
                    // color: Colors.pink,
                    // padding: EdgeInsets.all(SizeVariables.getWidth(context) * 0.02),
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeVariables.getWidth(context) * 0.04,
                        vertical: SizeVariables.getHeight(context) * 0.02),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Container(
                            // color: Colors.pink,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                color: Colors.black),
                                            SizedBox(
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.02),
                                            Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.3,
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text('Uploaded Invoice',
                                                    style: Theme.of(context
                                                            as BuildContext)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: Colors.black,
                                                            fontSize: 18)),
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
                                    height: SizeVariables.getHeight(context) *
                                        0.015),
                                Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width:
                                          SizeVariables.getWidth(context) * 0.4,
                                      child: Container(
                                        child: InkWell(
                                          onTap: () {},
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            child: Container(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.1,
                                              height: 200,
                                              // color: Colors.yellow,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: 2)),
                                              child: lfile == null
                                                  ? Center(
                                                      child: Text(
                                                          'Please Upload Invoice',
                                                          style: Theme.of(context
                                                                  as BuildContext)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black)),
                                                    )
                                                  : (lfile_link != null)
                                                      ? ((lfile_link!
                                                              .contains('pdf'))
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(Icons
                                                                          .arrow_downward),
                                                                      Text(
                                                                        'File has been captured.',
                                                                        style: Theme.of(context
                                                                                as BuildContext)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            openFileNetworkFile(
                                                                                fileLink: lfile_link!,
                                                                                fileName: 'inv.pdf');
                                                                          },
                                                                          child:
                                                                              Text('Click to open'))
                                                                    ],
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit.fill,
                                                                  //     image: FileImage(
                                                                  //       File(tfile!
                                                                  //           .path),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Image
                                                                      .network(
                                                                    lfile_link!,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    loadingBuilder: (BuildContext
                                                                            context,
                                                                        Widget
                                                                            child,
                                                                        ImageChunkEvent?
                                                                            loadingProgress) {
                                                                      if (loadingProgress ==
                                                                          null)
                                                                        return child;
                                                                      return Center(
                                                                        child:
                                                                            CircularProgressIndicator(
                                                                          value: loadingProgress.expectedTotalBytes != null
                                                                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                                              : null,
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit
                                                                  //         .fill,
                                                                  //     image: NetworkImage(
                                                                  //         lfile_link!),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            ))
                                                      : (lfile.path
                                                              .toString()
                                                              .contains('pdf'))
                                                          ? Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(Icons
                                                                          .arrow_downward),
                                                                      Text(
                                                                        'File has been captured.',
                                                                        style: Theme.of(context
                                                                                as BuildContext)
                                                                            .textTheme
                                                                            .bodyText1!
                                                                            .copyWith(color: Colors.black),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            openFile(lfile);
                                                                          },
                                                                          child:
                                                                              Text('Click to open'))
                                                                    ],
                                                                  ),
                                                                  // decoration:
                                                                  //     BoxDecoration(
                                                                  //   image:
                                                                  //       DecorationImage(
                                                                  //     fit: BoxFit.fill,
                                                                  //     image: FileImage(
                                                                  //       File(tfile!
                                                                  //           .path),
                                                                  //     ),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                              ],
                                                            )
                                                          : Stack(
                                                              children: [
                                                                Container(
                                                                  height: double
                                                                      .infinity,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        DecorationImage(
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      image:
                                                                          FileImage(
                                                                        File(lfile!
                                                                            .path),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    widget.args['status'] == 'Saved as Draft' ||
                                            widget.args['status'] == 'Submit'
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  child: Container(
                                                    height: 2,
                                                    // height: screenWidth * 0.2,
                                                    width:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.05,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.05,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      //  if (type == "local") {
                                                      // var imagePath =
                                                      //     await EdgeDetection
                                                      //         .detectEdge
                                                      //         .then((value) {
                                                      //   print(value.toString());
                                                      //   if (value == null) {
                                                      //     _errorVal(context
                                                      //         as BuildContext);
                                                      //   } else {
                                                      //     _imageCaptured(context
                                                      //         as BuildContext);
                                                      //   }
                                                      //   return value;
                                                      // });
                                                      // setState(() {
                                                      //   lfile = new XFile(
                                                      //       new File(imagePath
                                                      //               .toString())
                                                      //           .path);
                                                      //   lfile_link = null;
                                                      // });

                                                      //NEW CODEEEEEEEEE
                                                      // String imagePath = join(
                                                      //     (await getApplicationSupportDirectory())
                                                      //         .path,
                                                      //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                                      // bool success =
                                                      //     await EdgeDetection
                                                      //         .detectEdge(
                                                      //   imagePath,
                                                      //   canUseGallery: true,
                                                      //   androidScanTitle:
                                                      //       'Scanning', // use custom localizations for android
                                                      //   androidCropTitle:
                                                      //       'Crop',
                                                      //   androidCropBlackWhiteTitle:
                                                      //       'Black White',
                                                      //   androidCropReset:
                                                      //       'Reset',
                                                      // );

                                                      // setState(() {
                                                      //   lfile = new XFile(
                                                      //       new File(imagePath
                                                      //               .toString())
                                                      //           .path);
                                                      //   lfile_link = null;
                                                      // });

                                                      final image =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source:
                                                                      ImageSource
                                                                          .camera);
                                                      if (image == null) return;

                                                      // imageTemporary = cropSquareImage(File(image.path));

                                                      // File? imageTemporary =
                                                      //     File(image.path);

                                                      // imageTemporary =
                                                      //     await cropImage(
                                                      //         imageTemporary);

                                                      XFile? imageTemporary =
                                                          XFile(image.path);

                                                      // imageTemporary =
                                                      //     await cropImage(
                                                      //         imageTemporary);

                                                      imageTemporary =
                                                          await cropImageTwo(
                                                              imageTemporary);

                                                      setState(() {
                                                        lfile = imageTemporary;
                                                        isLoading = false;
                                                        isGallery = true;
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: Container(
                                                    height: 2,
                                                    // height: screenWidth * 0.2,
                                                    width:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.05,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Container(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.05,
                                                  child: InkWell(
                                                    onTap: () async {
                                                      // if (type == 'local') {
                                                      // final result =
                                                      //     await FilePicker
                                                      //         .platform
                                                      //         .pickFiles();
                                                      // if (result == null)
                                                      //   return;

                                                      // lfile =
                                                      //     result.files.first;
                                                      // //openFile(tfile);
                                                      // final lfilePath =
                                                      //     lfile.path;
                                                      // print(
                                                      //     'file-path: ${lfilePath}'); //opens the file

                                                      // setState(() {
                                                      //   lfile = new XFile(
                                                      //       new File(lfilePath
                                                      //               .toString())
                                                      //           .path);
                                                      //   lfile_link = null;
                                                      // });
                                                      // }

                                                      final image =
                                                          await ImagePicker()
                                                              .pickImage(
                                                                  source: ImageSource
                                                                      .gallery);
                                                      if (image == null) return;

                                                      // imageTemporary = cropSquareImage(File(image.path));

                                                      XFile? imageTemporary =
                                                          XFile(image.path);

                                                      // imageTemporary =
                                                      //     await cropImage(
                                                      //         imageTemporary);

                                                      imageTemporary =
                                                          await cropImageTwo(
                                                              imageTemporary);

                                                      setState(() {
                                                        lfile = imageTemporary;
                                                        isLoading = false;
                                                        isGallery = true;
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.file_copy_outlined,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: Container(
                                                    height: 2,
                                                    // height: screenWidth * 0.2,
                                                    width:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.05,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
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
                widget.args['status'] == 'Saved as Draft' ||
                        widget.args['status'] == 'Submit'
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.only(
                              right: SizeVariables.getWidth(context) * 0.05),
                          child: AnimatedButton(
                            height: 45,
                            width: 100,
                            text: 'Save',
                            isReverse: true,
                            selectedTextColor: Colors.black,
                            transitionType: TransitionType.LEFT_TO_RIGHT,
                            textStyle: TextStyle(
                                fontSize: 13,
                                color: (themeProvider.darkTheme)
                                    ? Colors.white
                                    : Colors.black),
                            backgroundColor: (themeProvider.darkTheme)
                                ? Colors.black
                                : Theme.of(context as BuildContext)
                                    .colorScheme
                                    .onPrimary,
                            borderColor: (themeProvider.darkTheme)
                                ? Colors.white
                                : Theme.of(context as BuildContext)
                                    .colorScheme
                                    .onPrimary,
                            borderRadius: 8,
                            borderWidth: 2,
                            onPress: lCheck == true
                                ? () => Flushbar(
                                      leftBarIndicatorColor: Colors.red,
                                      icon: const Icon(Icons.warning,
                                          color: Colors.white),
                                      message:
                                          'Please Ensure that the GST Value hasn\'t exceeded by more than 28% of the basic amount',
                                      duration: const Duration(seconds: 5),
                                    ).show(context as BuildContext)
                                : () {
                                    Map request_filename = {
                                      "file_name": "document",
                                    };
                                    if (lfile == null) {
                                      _errorVal(context as BuildContext);
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
                                            lexchangerate.text.toString() == ''
                                                ? "domestic"
                                                : "international",
                                        "from_date": "",
                                        "from_time": "",
                                        "to_date": "",
                                        "to_time": "",
                                        "date": lclaim_date.text.toString(),
                                        "gst_no": lgst_no.text.toString(),
                                        "gst_amount":
                                            lgst_amount.text.toString(),
                                        "claim_amount":
                                            lclaim_amount.text.toString(),
                                        "basic_amount":
                                            lbasic_amount.text.toString(),
                                        "payment_type": ldetails.toString(),
                                        "exchange_rate":
                                            lexchangerate.text.toString(),
                                        "doc_no": doc_no,
                                      };
                                      Provider.of<TravelViewModel>(
                                              context as BuildContext,
                                              listen: false)
                                          .postTravelFormSubmit(
                                              context as BuildContext,
                                              request_filename,
                                              lfile!,
                                              request_data);
                                    }
                                  },
                          ),
                        ),
                      )
                    : Container(),
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
      builder: (context) => CupertinoAlertDialog(
        content: Container(
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
                        .copyWith(fontSize: 18, color: Colors.black),
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
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.camera);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        tfile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });

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
                                      //   tfile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   tfile_link = null;
                                      // });
                                      //NEW CODEEEE
                                      // String imagePath = join(
                                      //     (await getApplicationSupportDirectory())
                                      //         .path,
                                      //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                      // bool success =
                                      //     await EdgeDetection.detectEdge(
                                      //   imagePath,
                                      //   canUseGallery: true,
                                      //   androidScanTitle:
                                      //       'Scanning', // use custom localizations for android
                                      //   androidCropTitle: 'Crop',
                                      //   androidCropBlackWhiteTitle:
                                      //       'Black White',
                                      //   androidCropReset: 'Reset',
                                      // );

                                      // setState(() {
                                      //   tfile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   tfile_link = null;
                                      // });
                                    } else if (type == "accomodation") {
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.camera);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        afile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });

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
                                      //   afile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   afile_link = null;
                                      // });
                                      //NEW CODEEEE

                                      // String imagePath = join(
                                      //     (await getApplicationSupportDirectory())
                                      //         .path,
                                      //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                      // bool success =
                                      //     await EdgeDetection.detectEdge(
                                      //   imagePath,
                                      //   canUseGallery: true,
                                      //   androidScanTitle:
                                      //       'Scanning', // use custom localizations for android
                                      //   androidCropTitle: 'Crop',
                                      //   androidCropBlackWhiteTitle:
                                      //       'Black White',
                                      //   androidCropReset: 'Reset',
                                      // );

                                      // setState(() {
                                      //   afile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   afile_link = null;
                                      // });
                                    } else if (type == "food") {
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.camera);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        ffile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });

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
                                      //   ffile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   ffile_link = null;
                                      // });
                                      //NEW CODEEEE

                                      // String imagePath = join(
                                      //     (await getApplicationSupportDirectory())
                                      //         .path,
                                      //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                      // bool success =
                                      //     await EdgeDetection.detectEdge(
                                      //   imagePath,
                                      //   canUseGallery: true,
                                      //   androidScanTitle:
                                      //       'Scanning', // use custom localizations for android
                                      //   androidCropTitle: 'Crop',
                                      //   androidCropBlackWhiteTitle:
                                      //       'Black White',
                                      //   androidCropReset: 'Reset',
                                      // );

                                      // setState(() {
                                      //   ffile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   ffile_link = null;
                                      // });
                                    } else if (type == "local") {
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.camera);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        lfile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });

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
                                      //   lfile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   lfile_link = null;
                                      // });

                                      //NEW CODEEEE

                                      // String imagePath = join(
                                      //     (await getApplicationSupportDirectory())
                                      //         .path,
                                      //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                      // bool success =
                                      //     await EdgeDetection.detectEdge(
                                      //   imagePath,
                                      //   canUseGallery: true,
                                      //   androidScanTitle:
                                      //       'Scanning', // use custom localizations for android
                                      //   androidCropTitle: 'Crop',
                                      //   androidCropBlackWhiteTitle:
                                      //       'Black White',
                                      //   androidCropReset: 'Reset',
                                      // );

                                      // setState(() {
                                      //   lfile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   lfile_link = null;
                                      // });
                                    } else if (type == "incidental") {
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.camera);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        ifile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });

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
                                      //   ifile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   ifile_link = null;
                                      // });

                                      //NEW CODEEEE

                                      // String imagePath = join(
                                      //     (await getApplicationSupportDirectory())
                                      //         .path,
                                      //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                      // bool success =
                                      //     await EdgeDetection.detectEdge(
                                      //   imagePath,
                                      //   canUseGallery: true,
                                      //   androidScanTitle:
                                      //       'Scanning', // use custom localizations for android
                                      //   androidCropTitle: 'Crop',
                                      //   androidCropBlackWhiteTitle:
                                      //       'Black White',
                                      //   androidCropReset: 'Reset',
                                      // );

                                      // setState(() {
                                      //   ifile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   ifile_link = null;
                                      // });
                                    }
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.black,
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
                                    if (type == 'travel') {
                                      // final result =
                                      //     await FilePicker.platform.pickFiles();
                                      // if (result == null) return;

                                      // tfile = result.files.first;
                                      // //openFile(tfile);
                                      // final tfilePath = tfile.path;
                                      // print(
                                      //     'file-path: ${tfilePath}'); //opens the file

                                      // setState(() {
                                      //   tfile = new XFile(
                                      //       new File(tfilePath.toString())
                                      //           .path);
                                      //   tfile_link = null;
                                      // });

                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        tfile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });
                                    }
                                    if (type == 'accomodation') {
                                      // final result =
                                      //     await FilePicker.platform.pickFiles();
                                      // if (result == null) return;

                                      // afile = result.files.first;
                                      // //openFile(tfile);
                                      // final afilePath = afile.path;
                                      // print(
                                      //     'file-path: ${afilePath}'); //opens the file

                                      // setState(() {
                                      //   afile = new XFile(
                                      //       new File(afilePath.toString())
                                      //           .path);
                                      //   afile_link = null;
                                      // });
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        afile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });
                                    }
                                    if (type == 'local') {
                                      // final result =
                                      //     await FilePicker.platform.pickFiles();
                                      // if (result == null) return;

                                      // lfile = result.files.first;
                                      // //openFile(tfile);
                                      // final lfilePath = lfile.path;
                                      // print(
                                      //     'file-path: ${lfilePath}'); //opens the file

                                      // setState(() {
                                      //   lfile = new XFile(
                                      //       new File(lfilePath.toString())
                                      //           .path);
                                      //   lfile_link = null;
                                      // });
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        lfile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });
                                    }
                                    if (type == 'food') {
                                      // final result =
                                      //     await FilePicker.platform.pickFiles();
                                      // if (result == null) return;

                                      // ffile = result.files.first;
                                      // //openFile(tfile);
                                      // final ffilePath = ffile.path;
                                      // print(
                                      //     'file-path: ${ffilePath}'); //opens the file

                                      // setState(() {
                                      //   ffile = new XFile(
                                      //       new File(ffilePath.toString())
                                      //           .path);
                                      //   ffile_link = null;
                                      // });
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        ffile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });
                                    }
                                    if (type == 'incidental') {
                                      // final result =
                                      //     await FilePicker.platform.pickFiles();
                                      // if (result == null) return;

                                      // ifile = result.files.first;
                                      // //openFile(tfile);
                                      // final ifilePath = ifile.path;
                                      // print(
                                      //     'file-path: ${ifilePath}'); //opens the file

                                      // setState(() {
                                      //   ifile = new XFile(
                                      //       new File(ifilePath.toString())
                                      //           .path);
                                      //   ifile_link = null;
                                      // });
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        ifile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });
                                    }
                                    // final result =
                                    //     await FilePicker.platform.pickFiles();
                                    // if (result == null) return;

                                    // tfile = result.files.first;
                                    // //openFile(tfile);
                                    // final tfilePath = tfile.path;
                                    // print(
                                    //     'file-path: ${tfilePath}'); //opens the file

                                    // setState(() {
                                    //   tfile = new XFile(
                                    //       new File(tfilePath.toString()).path);
                                    // });
                                  },
                                  child: const Icon(
                                    Icons.file_copy_outlined,
                                    color: Colors.black,
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
                                    .copyWith(color: Colors.black),
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
                                    if (type == 'travel') {
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
                                      //   torgfile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   torgfile_link = null;
                                      // });

                                      //NEW CODEEEE

                                      // String imagePath = join(
                                      //     (await getApplicationSupportDirectory())
                                      //         .path,
                                      //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                      // bool success =
                                      //     await EdgeDetection.detectEdge(
                                      //   imagePath,
                                      //   canUseGallery: true,
                                      //   androidScanTitle:
                                      //       'Scanning', // use custom localizations for android
                                      //   androidCropTitle: 'Crop',
                                      //   androidCropBlackWhiteTitle:
                                      //       'Black White',
                                      //   androidCropReset: 'Reset',
                                      // );

                                      // setState(() {
                                      //   torgfile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   torgfile_link = null;
                                      // });

                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.camera);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        torgfile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });
                                    }
                                    if (type == 'accomodation') {
                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.camera);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        aorgfile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });

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
                                      //   aorgfile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      // });

                                      //NEW CODEEEE

                                      // String imagePath = join(
                                      //     (await getApplicationSupportDirectory())
                                      //         .path,
                                      //     "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

                                      // bool success =
                                      //     await EdgeDetection.detectEdge(
                                      //   imagePath,
                                      //   canUseGallery: true,
                                      //   androidScanTitle:
                                      //       'Scanning', // use custom localizations for android
                                      //   androidCropTitle: 'Crop',
                                      //   androidCropBlackWhiteTitle:
                                      //       'Black White',
                                      //   androidCropReset: 'Reset',
                                      // );

                                      // setState(() {
                                      //   aorgfile = new XFile(
                                      //       new File(imagePath.toString())
                                      //           .path);
                                      //   aorgfile_link = null;
                                      // });
                                    }
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
                                    //   torgfile = new XFile(
                                    //       new File(imagePath.toString()).path);
                                    // });
                                  },
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.black,
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
                                    if (type == 'travel') {
                                      // final result =
                                      //     await FilePicker.platform.pickFiles();
                                      // if (result == null) return;

                                      // torgfile = result.files.first;
                                      // //openFile(tfile);
                                      // final torgfilePath = torgfile.path;
                                      // print(
                                      //     'file-path: ${torgfilePath}'); //opens the file

                                      // setState(() {
                                      //   torgfile = new XFile(
                                      //       new File(torgfilePath.toString())
                                      //           .path);
                                      //   torgfile_link = null;
                                      // });

                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        torgfile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });
                                    }
                                    if (type == 'accomodation') {
                                      // final result =
                                      //     await FilePicker.platform.pickFiles();
                                      // if (result == null) return;

                                      // aorgfile = result.files.first;
                                      // //openFile(tfile);
                                      // final torgfilePath = torgfile.path;
                                      // print(
                                      //     'file-path: ${torgfilePath}'); //opens the file

                                      // setState(() {
                                      //   torgfile = new XFile(
                                      //       new File(torgfilePath.toString())
                                      //           .path);
                                      // });

                                      final image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery);
                                      if (image == null) return;

                                      // imageTemporary = cropSquareImage(File(image.path));

                                      File? imageTemporary = File(image.path);

                                      imageTemporary =
                                          await cropImage(imageTemporary);

                                      setState(() {
                                        aorgfile = imageTemporary;
                                        isLoading = false;
                                        isGallery = true;
                                      });
                                    }
                                    // final result =
                                    //     await FilePicker.platform.pickFiles();
                                    // if (result == null) return;

                                    // torgfile = result.files.first;
                                    // //openFile(tfile);
                                    // final torgfilePath = torgfile.path;
                                    // print(
                                    //     'file-path: ${torgfilePath}'); //opens the file

                                    // setState(() {
                                    //   torgfile = new XFile(
                                    //       new File(torgfilePath.toString())
                                    //           .path);
                                    // });
                                  },
                                  child: const Icon(
                                    Icons.file_copy_outlined,
                                    color: Colors.black,
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
                                    .copyWith(color: Colors.black),
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
                  // Container(
                  //   child: FittedBox(
                  //     fit: BoxFit.contain,
                  //     child: Text(
                  //       'Invoice url:',
                  //       style: Theme.of(context).textTheme.bodyText2,
                  //     ),
                  //   ),
                  // ),
                  Container(
                      // child: FittedBox(
                      //   fit: BoxFit.contain,
                      //   child: Flexible(
                      //     child: Text(
                      //       tfile==null?"no image given !":"File picked !",
                      //       style: Theme.of(context).textTheme.bodyText1,
                      //     ),
                      //   ),
                      // ),
                      ),
                ],
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Container(
              //       child: FittedBox(
              //         fit: BoxFit.contain,
              //         child: Text(
              //           'Org. url:',
              //           style: Theme.of(context).textTheme.bodyText2,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       child: FittedBox(
              //         fit: BoxFit.contain,
              //         child: Text(
              //           'C:/download/joy.jpg:',
              //           style: Theme.of(context).textTheme.bodyText1,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Yes',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.black),
              )),
          TextButton(
            onPressed: () {
              Navigator.pop(context); //close Dialog
            },
            child: Text(
              'Close',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black),
            ),
          )
        ],
      ),

      // AlertDialog(
      //   backgroundColor: Color.fromARGB(255, 103, 103, 101),
      //   title: Container(
      //     child: Column(
      //       children: [
      //         Container(
      //           child: FittedBox(
      //             fit: BoxFit.contain,
      //             child: Text(
      //               'Upload your document',
      //               style: Theme.of(context)
      //                   .textTheme
      //                   .bodyText2!
      //                   .copyWith(fontSize: 18, color: Colors.white),
      //             ),
      //           ),
      //         ),
      //         Container(
      //           padding: EdgeInsets.only(
      //             left: SizeVariables.getWidth(context) * 0.1,
      //             top: SizeVariables.getHeight(context) * 0.06,
      //             // bottom: SizeVariables.getHeight(context) * 0.1,
      //           ),
      //           child: Row(
      //             children: [
      //               Container(
      //                 child: Column(
      //                   children: [
      //                     Container(
      //                       child: Row(
      //                         children: [
      //                           InkWell(
      //                             onTap: () async {
      //                               if (type == "travel") {
      //                                 var imagePath = await EdgeDetection
      //                                     .detectEdge
      //                                     .then((value) {
      //                                   print(value.toString());
      //                                   if (value == null) {
      //                                     _errorVal(context);
      //                                   } else {
      //                                     _imageCaptured(context);
      //                                   }
      //                                   return value;
      //                                 });

      //                                 setState(() {
      //                                   tfile = new XFile(
      //                                       new File(imagePath.toString())
      //                                           .path);
      //                                 });
      //                               } else if (type == "accomodation") {
      //                                 var imagePath = await EdgeDetection
      //                                     .detectEdge
      //                                     .then((value) {
      //                                   print(value.toString());
      //                                   if (value == null) {
      //                                     _errorVal(context);
      //                                   } else {
      //                                     _imageCaptured(context);
      //                                   }
      //                                   return value;
      //                                 });
      //                                 setState(() {
      //                                   afile = new XFile(
      //                                       new File(imagePath.toString())
      //                                           .path);
      //                                 });
      //                               } else if (type == "food") {
      //                                 var imagePath = await EdgeDetection
      //                                     .detectEdge
      //                                     .then((value) {
      //                                   print(value.toString());
      //                                   if (value == null) {
      //                                     _errorVal(context);
      //                                   } else {
      //                                     _imageCaptured(context);
      //                                   }
      //                                   return value;
      //                                 });
      //                                 setState(() {
      //                                   ffile = new XFile(
      //                                       new File(imagePath.toString())
      //                                           .path);
      //                                 });
      //                               } else if (type == "local") {
      //                                 var imagePath = await EdgeDetection
      //                                     .detectEdge
      //                                     .then((value) {
      //                                   print(value.toString());
      //                                   if (value == null) {
      //                                     _errorVal(context);
      //                                   } else {
      //                                     _imageCaptured(context);
      //                                   }
      //                                   return value;
      //                                 });
      //                                 setState(() {
      //                                   lfile = new XFile(
      //                                       new File(imagePath.toString())
      //                                           .path);
      //                                 });
      //                               } else if (type == "incidental") {
      //                                 var imagePath = await EdgeDetection
      //                                     .detectEdge
      //                                     .then((value) {
      //                                   print(value.toString());
      //                                   if (value == null) {
      //                                     _errorVal(context);
      //                                   } else {
      //                                     _imageCaptured(context);
      //                                   }
      //                                   return value;
      //                                 });
      //                                 setState(() {
      //                                   ifile = new XFile(
      //                                       new File(imagePath.toString())
      //                                           .path);
      //                                 });
      //                               }
      //                             },
      //                             child: Icon(
      //                               Icons.camera_alt,
      //                               color: Colors.white,
      //                               size: 30,
      //                             ),
      //                           ),
      //                           SizedBox(
      //                             width: SizeVariables.getWidth(context) * 0.01,
      //                           ),
      //                           InkWell(
      //                             onTap: () async {
      //                               // tfile = (await FilePicker.platform
      //                               //     .pickFiles()) as i.XFile?;
      //                             },
      //                             child: const Icon(
      //                               Icons.file_copy_outlined,
      //                               color: Colors.white,
      //                               size: 30,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     Container(
      //                       child: FittedBox(
      //                         fit: BoxFit.contain,
      //                         child: Text(
      //                           'Invoice',
      //                           style: Theme.of(context)
      //                               .textTheme
      //                               .bodyText1!
      //                               .copyWith(
      //                                   color:
      //                                       Color.fromARGB(255, 230, 217, 217)),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 width: SizeVariables.getWidth(context) * 0.05,
      //               ),
      //               SizedBox(
      //                 width: SizeVariables.getWidth(context) * 0.05,
      //               ),
      //               Container(
      //                 child: Column(
      //                   children: [
      //                     Container(
      //                       child: Row(
      //                         children: [
      //                           InkWell(
      //                             onTap: () async {
      //                               // torgfile = (await EdgeDetection.detectEdge)
      //                               //     as i.XFile?;
      //                             },
      //                             child: const Icon(
      //                               Icons.camera_alt,
      //                               color: Colors.white,
      //                               size: 30,
      //                             ),
      //                           ),
      //                           SizedBox(
      //                             width: SizeVariables.getWidth(context) * 0.01,
      //                           ),
      //                           InkWell(
      //                             onTap: () async {
      //                               // torgfile = (await FilePicker.platform
      //                               //     .pickFiles()) as i.XFile?;
      //                             },
      //                             child: Icon(
      //                               Icons.file_copy_outlined,
      //                               color: Colors.white,
      //                               size: 30,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                     Container(
      //                       child: FittedBox(
      //                         fit: BoxFit.contain,
      //                         child: Text(
      //                           'Org. Invoice',
      //                           style: Theme.of(context)
      //                               .textTheme
      //                               .bodyText1!
      //                               .copyWith(
      //                                   color:
      //                                       Color.fromARGB(255, 230, 217, 217)),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         SizedBox(
      //           height: SizeVariables.getHeight(context) * 0.03,
      //         ),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: [
      //             // Container(
      //             //   child: FittedBox(
      //             //     fit: BoxFit.contain,
      //             //     child: Text(
      //             //       'Invoice url:',
      //             //       style: Theme.of(context).textTheme.bodyText2,
      //             //     ),
      //             //   ),
      //             // ),
      //             Container(
      //                 // child: FittedBox(
      //                 //   fit: BoxFit.contain,
      //                 //   child: Flexible(
      //                 //     child: Text(
      //                 //       tfile==null?"no image given !":"File picked !",
      //                 //       style: Theme.of(context).textTheme.bodyText1,
      //                 //     ),
      //                 //   ),
      //                 // ),
      //                 ),
      //           ],
      //         ),
      //         SizedBox(
      //           height: SizeVariables.getHeight(context) * 0.01,
      //         ),
      //         // Row(
      //         //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         //   children: [
      //         //     Container(
      //         //       child: FittedBox(
      //         //         fit: BoxFit.contain,
      //         //         child: Text(
      //         //           'Org. url:',
      //         //           style: Theme.of(context).textTheme.bodyText2,
      //         //         ),
      //         //       ),
      //         //     ),
      //         //     Container(
      //         //       child: FittedBox(
      //         //         fit: BoxFit.contain,
      //         //         child: Text(
      //         //           'C:/download/joy.jpg:',
      //         //           style: Theme.of(context).textTheme.bodyText1,
      //         //         ),
      //         //       ),
      //         //     ),
      //         //   ],
      //         // ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  void openFile(XFile file) {
    OpenFile.open(file.path);
  }

  void openFileNetworkFile(
      {required String fileLink, required String? fileName}) async {
    final file = await downloadFile(fileLink, fileName!);
    if (file == null) return;

    print('Path: ${file.path}');

    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String fileName) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$fileName');

    try {
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${localStorage.getString('token')}'
              },
              followRedirects: false,
              receiveTimeout: 0));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
      // return null;
    }
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
      } else if (paytype == "Paid by company") {
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
                  onPressed: () {
                    Map data = {
                      "doc_no": doc_no,
                    };
                    Provider.of<TravelViewModel>(context, listen: false)
                        .postFinalSubmit(context, data);
                  },
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
}

double checkGST(double basic, double gst, BuildContext context) {
  print('GST AMOUNT: $gst');

  double gst_amt_t = basic * 0.28;

  print('GST AMOUNT LIMIT: $gst_amt_t');

  return gst_amt_t;
}
