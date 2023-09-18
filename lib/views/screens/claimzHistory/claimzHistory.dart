import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/models/claimz_HistoryModel.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/viewModel/claimzHistoryViewModel.dart';
import 'package:claimz/views/screens/claimzHistory/travelHistoryForm.dart';
import 'package:claimz/views/widgets/clamizHistroyWidget/clamizStyle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/geolocation.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:sizer/sizer.dart';
import '../../../provider/theme_provider.dart';
import '../../../res/components/bottomNavigationBar.dart';
import '../../../res/components/content_dialog.dart';
import '../../../res/components/date_range_picker.dart';
import '../../../utils/routes/routeNames.dart';
import '../../../viewModel/claimzViewModel.dart';
import '../../config/mediaQuery.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

import '../../config/mediaQuery.dart';
import '../claimz_categoryScreen.dart';
import '../conveyanceCamera.dart';
import 'claimzHistoryShimmer.dart';
import 'convenyanceClaimFrom.dart';

class ClaimzHistory extends StatefulWidget {
  // const ClaimzHistory({Key? key}) : super(key: key);

  @override
  State<ClaimzHistory> createState() => _ClaimzHistoryState();
}

class _ClaimzHistoryState extends State<ClaimzHistory> {
  var myYears = "2022";
  List<String> year = ["2022", "2021", "2020", "2019", "2018"];
  var current_mon;
  bool isClicked = false;
  bool isInFocus = false;
  Map<String, dynamic> dateData = {};
  var kGoogleApiKey = "AIzaSyDJJ7rw4YTPHxvD1KuReHoQ-ja2VT3Sp18";

  DateTime? _dateTime;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DateFormat dateFormat = DateFormat('yyyy');
  DateFormat monthFormat = DateFormat('MMM');
  ClaimzHistoryViewModel claimz_list = ClaimzHistoryViewModel();
  ClaimzViewModel claimz_detail = ClaimzViewModel();

  var _selected_month = 0;
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );
  bool isLoading = true;
  late LatLng myLocation;
  String _duration = "";
  String _distance = "";
  Key _key0fripple = GlobalKey();

  String docId = "";

  // final selectedItem = GlobalKey();
  // ItemScrollController listScrollController = ItemScrollController();
  ScrollController scrollController = ScrollController();

  List<Map<String, dynamic>> months = [
    {
      'month': 'Jan',
      'onclick': false,
    },
    {
      'month': 'Feb',
      'onclick': false,
    },
    {
      'month': 'Mar',
      'onclick': false,
    },
    {
      'month': 'Apr',
      'onclick': false,
    },
    {
      'month': 'May',
      'onclick': false,
    },
    {
      'month': 'Jun',
      'onclick': false,
    },
    {
      'month': 'Jul',
      'onclick': false,
    },
    {
      'month': 'Aug',
      'onclick': false,
    },
    {
      'month': 'Sep',
      'onclick': false,
    },
    {
      'month': 'Oct',
      'onclick': false,
    },
    {
      'month': 'Nov',
      'onclick': false,
    },
    {
      'month': 'Dec',
      'onclick': false,
    },
  ];

  TextEditingController _place = TextEditingController();
  TextEditingController _purpose = TextEditingController();
  TextEditingController _meetToWhom = TextEditingController();
  TextEditingController _remarks = TextEditingController();

  List<String> options = ['Meeting', 'Other than Meeting'];
  var _selectedItem;

  late Position _currentPosition;

  String _currentAddress = '';
  String _currentAddress_locality = '';

  String _to_lat = "";
  String _to_long = "";

  late ExpandedTileController _controller;

  List<Map<String, dynamic>> _items = [
    {
      'date': '19-OCT-2022',
      'docId': '4556688722',
      'status': 'Pending',
      'fromTime': '02:19',
      'toTime': '03:00',
      'duration': '00:41',
      'amount': '400',
      'waitTime': '05:00',
      'meetingTime': '06:00',
      'suggested': 'Data 1',
      'actual': 'Data 2',
      'intelligence': 'Data 3'
    },
    {
      'date': '20-OCT-2022',
      'docId': '4556688722',
      'status': 'Approved',
      'fromTime': '02:19',
      'toTime': '03:00',
      'duration': '00:41',
      'amount': '400',
      'waitTime': '05:00',
      'meetingTime': '06:00',
      'suggested': 'Data 1',
      'actual': 'Data 2',
      'intelligence': 'Data 3'
    }
  ];

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

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() async {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        myLocation = LatLng(position.latitude, position.longitude);
        _getAddress2();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddress2() async {
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

  @override
  void initState() {
    // TODO: implement initState
    var now = new DateTime.now();
    current_mon = now.month.toString();

    print(
        'CURRENT MONTH: ${monthFormat.format(DateTime.parse(now.toString()))}');

    // for (int i = 0; i < months.length; i++) {
    //   if (months[i]['month'] ==
    //       monthFormat.format(DateTime.parse(now.toString()))) {
    //     setState(() {
    //       months[i]['onclick'] = true;

    //       if (months[i]['onclick'] == true) {
    //         // scrollToItem(i);
    //         print('DEFAULT INDEX $i');
    //         months.insert(0, months[i]);
    //       }
    //       // months.toSet().toList();
    //       months.remove(months[i]);
    //     });
    //   }
    // }
    _getCurrentLocation();

    dateData = {
      'from_date': dateRange.start.toString().split(" ")[0].toString(),
      'all': 1,
      'to_date': dateRange.end.toString().split(" ")[0].toString(),
    };

    print('DATAAAAA: $dateData');

    // claimz_list.postClaimzHistoryList(context, data);
    Provider.of<ClaimzHistoryViewModel>(context, listen: false)
        .getClaimList(dateData, context)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final start = dateRange.start;
    final end = dateRange.end;
    final provider = Provider.of<ClaimzHistoryViewModel>(context).claimList;

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Stack(
        children: [
          Scaffold(
            key: _scaffoldKey,

            floatingActionButton: FloatingActionButton(
              onPressed: () => showDialog(
                  context: _scaffoldKey.currentContext!,
                  builder: (context) => ContainerDialog(
                        title: 'Provide Destination',
                        subtitle:
                            "search for the destination and press 'ok' to start your travel",
                        onOk: () {
                          print('TO LAT: $_to_lat & TO LNG: $_to_long');
                          if (_to_lat == '' && _to_long == '') {
                            Flushbar(
                              leftBarIndicatorColor: Colors.red,
                              icon: const Icon(Icons.warning,
                                  color: Colors.white),
                              message: 'Please Enter Address To Continue',
                              duration: const Duration(seconds: 10),
                            ).show(context);
                          } else if (_meetToWhom.text == '') {
                            Flushbar(
                              leftBarIndicatorColor: Colors.red,
                              icon: const Icon(Icons.warning,
                                  color: Colors.white),
                              message: 'Please Mention Whom To Meet',
                              duration: const Duration(seconds: 10),
                            ).show(context);
                          } else if (_purpose.text == '') {
                            Flushbar(
                              leftBarIndicatorColor: Colors.red,
                              icon: const Icon(Icons.warning,
                                  color: Colors.white),
                              message: 'Please Specify Purpose',
                              duration: const Duration(seconds: 10),
                            ).show(context);
                          } else {
                            Map<String, dynamic> data = {
                              'lat': myLocation.latitude.toString(),
                              'lng': myLocation.longitude.toString(),
                              'destination_lat': _to_lat,
                              't_start_origin_address':
                                  _currentAddress_locality,
                              'destination_lng': _to_long,
                              'suggested_destination_address':
                                  _place.text.toString(),
                              'suggested_duration': '0.0',
                              'suggested_distance': '0.0',
                              'met_to_whom': _meetToWhom.text,
                              'travel_purpose': _purpose.text
                            };
                            if (kDebugMode) {
                              print('MEETING DATA $data');
                            }
                            Provider.of<ClaimzViewModel>(
                                    _scaffoldKey.currentContext!,
                                    listen: false)
                                .claimzExecute(
                                    _scaffoldKey.currentContext!, data)
                                .then((value) {
                              setState(() {
                                docId = value['doc'].toString();
                              });

                              print('DOCCCCCCCC IDDDDDD: $docId');

                              _key0fripple = UniqueKey();
                              // Navigator.pop(context);

                              showDialog(
                                  context: context,
                                  builder: (context) => ContainerDialog(
                                        title: 'Meeting Remarks',
                                        subtitle:
                                            'Select Meeting Type and Enter Meeting Remarks',
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
                                            'doc': docId,
                                          };

                                          print('REMAAAAARKS: $data');

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ConveyanceCamera(data)));
                                        },
                                        onCancel: () =>
                                            Navigator.of(context).pop(),
                                        container: Container(
                                          // height: 200.sp,
                                          child: ContainerDetailsTwo(),
                                        ),
                                      ));
                            });
                          }
                        },
                        onCancel: () => Navigator.of(context).pop(),
                        container: Container(
                          // height: 200.sp,
                          child: ContainerDetails(),
                        ),
                      )),
              backgroundColor: (themeProvider.darkTheme)
                  ? Colors.grey
                  : Theme.of(context).colorScheme.onPrimary,
              child: Icon(Icons.add,
                  color:
                      (themeProvider.darkTheme) ? Colors.white : Colors.black),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            // floatingActionButton: FloatingActionButton(
            //     backgroundColor:
            //         (themeProvider.darkTheme) ? Colors.grey : Colors.amber,
            //     onPressed: () {
            //       // Navigator.pushNamed(context, RouteNames.postAnnouncement);
            //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomBottomNavigation()));
            //     },
            //     child: Icon(
            //       Icons.add,
            //       color: Theme.of(context).accentColor,
            //     ),
            //   ),
            body: Container(
              padding: EdgeInsets.only(
                left: SizeVariables.getWidth(context) * 0.025,
                right: SizeVariables.getWidth(context) * 0.025,
              ),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: SizeVariables.getHeight(context) * 0.02),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) =>
                            //         CustomBottomNavigation(4)));
                          },
                          child: SvgPicture.asset(
                            "assets/icons/back button.svg",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Claimz History',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontSize: 20),
                            ),
                          ),
                        ),
                        // Container(
                        //   height: SizeVariables.getHeight(context) * 0.046,
                        //   child: DropdownButton<String>(
                        //     underline: Container(),
                        //     iconSize: 30,
                        //     icon: Icon(
                        //       Icons.expand_more,
                        //       color: Colors.white,
                        //     ),
                        //     dropdownColor: Colors.black87,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         myYears = value!;
                        //       });
                        //       Map data = {
                        //         "month": current_mon.toString(),
                        //         "all": 1,
                        //         "year": myYears.toString(),
                        //       };
                        //       claimz_list.postClaimzHistoryList(context, data);
                        //     },
                        //     value: myYears,
                        //     items: year.map((item) {
                        //       return DropdownMenuItem(
                        //           value: item,
                        //           child: Padding(
                        //             padding: EdgeInsets.only(
                        //                 left: SizeVariables.getWidth(context) *
                        //                     0.04),
                        //             child: Text(
                        //               item,
                        //               style: TextStyle(
                        //                   color: Theme.of(context).accentColor),
                        //             ),
                        //           ));
                        //     }).toList(),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: SizeVariables.getHeight(context) * 0.02,
                  // ),
                  // HorizontalHisWidget(),
                  Container(
                    // width: SizeVariables.getWidth(context)*0.6,
                    // height: SizeVariables.getHeight(context) * 0.1,
                    // color: Colors.red,
                    child: DateRangePicker(
                      onPressed: pickDateRange,
                      end: end,
                      start: start,
                    ),
                    // ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.03,
                  ),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : provider['data'].isEmpty
                          ? const Center(
                              child: Text('No Claims Raised'),
                            )
                          : Container(
                              padding: const EdgeInsets.all(5),
                              child: ExpandedTileList.builder(
                                itemCount: provider['data'].length,
                                maxOpened: 1,
                                reverse: true,
                                itemBuilder: (context, index, controller) {
                                  return ExpandedTile(
                                    // contentSeperator: 0,
                                    contentseparator: 0,
                                    trailing: null,
                                    theme: const ExpandedTileThemeData(
                                      // headerColor: Colors.green,
                                      headerRadius: 0,
                                      // headerPadding: EdgeInsets.all(24.0),
                                      headerColor: Colors.transparent,
                                      headerPadding: EdgeInsets.all(0.0),
                                      titlePadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      // leadingPadding: EdgeInsets.symmetric(horizontal: 0),
                                      trailingPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      headerSplashColor: Colors.grey,
                                      //

                                      contentBackgroundColor:
                                          Colors.transparent,
                                      contentPadding: EdgeInsets.all(0.0),

                                      contentRadius: 0,
                                    ),
                                    controller: index == 2
                                        ? controller.copyWith(isExpanded: true)
                                        : controller,
                                    title: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          // height: 25,
                                          // color: const Color.fromARGB(255, 107, 106, 106),
                                          child: Row(
                                            children: [
                                              Text(
                                                  '${provider['data'][index]['claim_day']}-${provider['data'][index]['claim_month']}-${provider['data'][index]['claim_year']} |'),
                                              Text(provider['data'][index]
                                                  ['doc_no']),
                                            ],
                                          ),
                                        ),
                                        Card(
                                          elevation: 20,
                                          child: Container(
                                            // width: double.infinity,
                                            height: 70,
                                            decoration: BoxDecoration(
                                                color: (themeProvider.darkTheme)
                                                    ? const Color.fromARGB(
                                                        255, 72, 70, 70)
                                                    : Theme.of(context)
                                                        .scaffoldBackgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            // child: Row(
                                            //   children: [
                                            //     Text('${_items[index]['date']} |'),
                                            //     Text(_items[index]['docId']),
                                            //   ],
                                            // ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Container(
                                                    height: double.infinity,
                                                    // color: Colors.pink,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            provider['data']
                                                                    [index][
                                                                't_start_origin_address'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        232,
                                                                        175,
                                                                        175),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                        Text(
                                                            provider['data']
                                                                    [index][
                                                                'travel_start_time'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    //                 color: const Color.fromARGB(
                                                                    // 255, 232, 175, 175),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  fit: FlexFit.tight,
                                                  child: Container(
                                                    height: double.infinity,
                                                    // color: Colors.yellow,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(Icons.bike_scooter,
                                                            color: Colors.amber,
                                                            size: 20),
                                                        Container(
                                                          height: 20,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white)),
                                                          child: Center(
                                                              child: Text(
                                                                  provider['data']
                                                                          [
                                                                          index]
                                                                      [
                                                                      'actual_duration'],
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(
                                                                          //                 color: const Color.fromARGB(
                                                                          // 255, 232, 175, 175),
                                                                          fontWeight:
                                                                              FontWeight.normal))),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text('₹',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        //                 color: const Color.fromARGB(
                                                                        // 255, 232, 175, 175),
                                                                        color: Colors
                                                                            .amber,
                                                                        fontWeight:
                                                                            FontWeight.normal)),
                                                            Text(
                                                                provider['data']
                                                                        [index]
                                                                    ['amount'],
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .copyWith(
                                                                        //                 color: const Color.fromARGB(
                                                                        // 255, 232, 175, 175),
                                                                        fontWeight:
                                                                            FontWeight.normal)),
                                                          ],
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
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                            provider['data']
                                                                    [index][
                                                                't_end_origin_address'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        164,
                                                                        236,
                                                                        166),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                        Text(
                                                            provider['data']
                                                                    [index][
                                                                'travel_end_time'],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    //                 color: const Color.fromARGB(
                                                                    // 255, 232, 175, 175),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    content: InkWell(
                                      onTap: () {
                                        Map<String, dynamic> data = {
                                          "doc_no": provider['data'][index]
                                              ['doc_no'],
                                          "from": provider['data'][index]
                                              ['t_start_origin_address'],
                                          "date": provider['data'][index]
                                              ['travel_start_date'],
                                          "to": provider['data'][index]
                                              ['t_end_origin_address'],
                                          'flag': 0,
                                          'remarks': provider['data'][index]
                                              ['remarks'],
                                          'status': provider['data'][index]
                                              ['approval_status'],
                                          // 'meet_to_whom': _meetToWhom.text,
                                          'purpose': provider['data'][index]
                                                  ['purpose'] ??
                                              'Meeting',
                                          'met_to_whom': provider['data'][index]
                                              ['met_to_whom'],
                                          'travel_purpose': provider['data']
                                              [index]['travel_purpose']
                                        };

                                        print('DATAAAAA: $data');

                                        // Navigator.pop(context);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ConvenyanceClaimFrom(data,
                                                        dateData, {}, true)));

                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             TravelHistoryForm(data)));
                                      },
                                      child: Card(
                                        elevation: 20,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10))),
                                        child: Stack(
                                          children: [
                                            Container(
                                              // height: 150,
                                              padding: const EdgeInsets.all(10),
                                              // color: const Color.fromARGB(
                                              //           255, 72, 70, 70),
                                              decoration: BoxDecoration(
                                                  color: (themeProvider
                                                          .darkTheme)
                                                      ? Color.fromARGB(
                                                          255, 72, 70, 70)
                                                      : Theme.of(context)
                                                          .scaffoldBackgroundColor,
                                                  //color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight: Radius
                                                              .circular(10))),
                                              // decoration: BoxDecoration(
                                              //     // borderRadius: BorderRadius.only(
                                              //     //   bottomLeft: Radius.circular(20),
                                              //     //   bottomRight: Radius.circular(20),
                                              //     // )
                                              //     ),
                                              child: Container(
                                                // color: Colors.red,
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      flex: 1,
                                                      fit: FlexFit.tight,
                                                      child: Container(
                                                        // color: Colors.yellow,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .timer_outlined,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          167,
                                                                          146,
                                                                          81),
                                                                ),
                                                                Text(
                                                                    'Wait Time:',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight:
                                                                                FontWeight.normal)),
                                                                // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                // Text('Wait Time: ${_items[index]['waitTime']}'),
                                                                Icon(
                                                                  Icons
                                                                      .handshake_outlined,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          167,
                                                                          146,
                                                                          81),
                                                                ),
                                                                Text(
                                                                    'Meeting Time:',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight:
                                                                                FontWeight.normal)),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(Icons.star,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            167,
                                                                            146,
                                                                            81)),
                                                                Text(
                                                                    'Suggested:',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight:
                                                                                FontWeight.normal)),
                                                                // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                    Icons.check,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            167,
                                                                            146,
                                                                            81)),
                                                                Text('Actual:',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight:
                                                                                FontWeight.normal)),
                                                                // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .computer,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            167,
                                                                            146,
                                                                            81)),
                                                                Text(
                                                                    'Intelligence:',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight:
                                                                                FontWeight.normal)),
                                                                // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 1,
                                                      fit: FlexFit.tight,
                                                      child: Container(
                                                        // color: Colors.green,
                                                        height: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.15,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    provider['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'waiting_time'],
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color: Colors.grey)),
                                                                // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    provider['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'meeting_time'],
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color: Colors.grey)),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    '${provider['data'][index]['suggested_distance']} || ${provider['data'][index]['suggested_duration']}',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color: Colors.grey)),
                                                                // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    '${provider['data'][index]['actual_distance']} || ${provider['data'][index]['actual_duration']}',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color: Colors.grey)),
                                                                // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    '${provider['data'][index]['intelligence_distance']} || ${provider['data'][index]['intelligence_duration']}',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                            //                 color: const Color.fromARGB(
                                                                            // 255, 232, 175, 175),

                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            color: Colors.grey)),
                                                                // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                        flex: 1,
                                                        fit: FlexFit.tight,
                                                        child: Container(
                                                          // color: Colors.blue,
                                                          child: Center(
                                                            child: provider['data']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'approval_status'] ==
                                                                    0
                                                                ? InkWell(
                                                                    onTap: () {
                                                                      Map<String,
                                                                              dynamic>
                                                                          data =
                                                                          {
                                                                        "doc_no":
                                                                            provider['data'][index]['doc_no'],
                                                                        "from": provider['data'][index]
                                                                            [
                                                                            't_start_origin_address'],
                                                                        "date": provider['data'][index]
                                                                            [
                                                                            'travel_start_date'],
                                                                        "to": provider['data'][index]
                                                                            [
                                                                            't_end_origin_address'],
                                                                        'flag':
                                                                            0,
                                                                        'remarks':
                                                                            provider['data'][index]['remarks'],
                                                                        'status':
                                                                            provider['data'][index]['approval_status'],
                                                                        // 'meet_to_whom': _meetToWhom.text,
                                                                        'purpose':
                                                                            provider['data'][index]['purpose'] ??
                                                                                'Meeting',
                                                                        'met_to_whom':
                                                                            provider['data'][index]['met_to_whom'],
                                                                        'travel_purpose':
                                                                            provider['data'][index]['travel_purpose']
                                                                      };
                                                                      Navigator.of(context).push(MaterialPageRoute(
                                                                          builder: (context) => ConvenyanceClaimFrom(
                                                                              data,
                                                                              dateData,
                                                                              {},
                                                                              true)));
                                                                    },
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                                                      children: [
                                                                        RippleAnimation(
                                                                            repeat:
                                                                                true,
                                                                            color: Colors
                                                                                .grey,
                                                                            minRadius:
                                                                                30,
                                                                            ripplesCount:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                bottom: 10,
                                                                                left: 5,
                                                                              ),
                                                                              child: Container(
                                                                                height: SizeVariables.getHeight(context) * 0.05,
                                                                                width: SizeVariables.getWidth(context) * 0.1,
                                                                                child: Image.asset('assets/icons/claim_logo.png'),
                                                                              ),
                                                                            )),
                                                                        Text(
                                                                            provider['data'][index][
                                                                                'status'],
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyText1)
                                                                      ],
                                                                    ),
                                                                  )
                                                                : provider['data'][index]
                                                                            [
                                                                            'approval_status'] ==
                                                                        -1
                                                                    ? InkWell(
                                                                        onTap:
                                                                            () {
                                                                          Map<String, dynamic>
                                                                              data =
                                                                              {
                                                                            "doc_no":
                                                                                provider['data'][index]['doc_no'],
                                                                            "from":
                                                                                provider['data'][index]['t_start_origin_address'],
                                                                            "date":
                                                                                provider['data'][index]['travel_start_date'],
                                                                            "to":
                                                                                provider['data'][index]['t_end_origin_address'],
                                                                            'flag':
                                                                                0,
                                                                            'remarks':
                                                                                provider['data'][index]['remarks'],
                                                                            'status':
                                                                                provider['data'][index]['approval_status'],
                                                                            // 'meet_to_whom': _meetToWhom.text,
                                                                            'purpose':
                                                                                provider['data'][index]['purpose'] ?? 'Meeting',
                                                                            'met_to_whom':
                                                                                provider['data'][index]['met_to_whom'],
                                                                            'travel_purpose':
                                                                                provider['data'][index]['travel_purpose']
                                                                          };

                                                                          print(
                                                                              'DATAAAAA: $data');

                                                                          Navigator.of(context)
                                                                              .push(MaterialPageRoute(builder: (context) => ConvenyanceClaimFrom(data, dateData, {}, true)));
                                                                        },
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            RippleAnimation(
                                                                                repeat: true,
                                                                                color: Colors.grey,
                                                                                minRadius: 20,
                                                                                ripplesCount: 2,
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(
                                                                                    bottom: 10,
                                                                                    left: 5,
                                                                                  ),
                                                                                  child: Container(
                                                                                    height: SizeVariables.getHeight(context) * 0.05,
                                                                                    width: SizeVariables.getWidth(context) * 0.1,
                                                                                    child: Image.asset('assets/icons/claim_logo.png'),
                                                                                  ),
                                                                                )),
                                                                            Text(provider['data'][index]['status'],
                                                                                textAlign: TextAlign.center,
                                                                                style: Theme.of(context).textTheme.bodyText1)
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : FittedBox(
                                                                        child:
                                                                            Container(
                                                                          // color: Colors.red,
                                                                          height:
                                                                              SizeVariables.getHeight(context) * 0.07,
                                                                          width:
                                                                              SizeVariables.getWidth(context) * 0.15,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.end,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(provider['data'][index]['status'], textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      debugPrint("tapped!!");
                                    },
                                    onLongTap: () {
                                      debugPrint("looooooooooong tapped!!");
                                    },
                                  );
                                },
                              ),
                            )
                ],
              ),
            ),
          ),
        ],
      ),
    );
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

  ContainerDetailsTwo() {
    return Column(
      children: [
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
      ],
    );
  }

  _ListRecord(Data claimData) {
    return ExpandedTileList.builder(
      itemCount: _items.length,
      maxOpened: 1,
      reverse: true,
      itemBuilder: (context, index, controller) {
        return ExpandedTile(
          // contentSeperator: 0,
          contentseparator: 0,
          trailing: null,
          theme: const ExpandedTileThemeData(
            // headerColor: Colors.green,
            headerRadius: 0,
            // headerPadding: EdgeInsets.all(24.0),
            headerColor: Colors.transparent,
            headerPadding: EdgeInsets.all(0.0),
            titlePadding: EdgeInsets.symmetric(horizontal: 0),
            // leadingPadding: EdgeInsets.symmetric(horizontal: 0),
            trailingPadding: EdgeInsets.symmetric(horizontal: 0),
            headerSplashColor: Colors.grey,
            //

            contentBackgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(0.0),

            contentRadius: 0,
          ),
          controller:
              index == 2 ? controller.copyWith(isExpanded: true) : controller,
          title: Column(
            children: [
              Container(
                width: double.infinity,
                // height: 25,
                // color: const Color.fromARGB(255, 107, 106, 106),
                child: Row(
                  children: [
                    Text('${_items[index]['date']} |'),
                    Text(_items[index]['docId']),
                  ],
                ),
              ),
              Card(
                elevation: 20,
                child: Container(
                  // width: double.infinity,
                  height: 70,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 72, 70, 70),
                      borderRadius: BorderRadius.circular(4)),
                  // child: Row(
                  //   children: [
                  //     Text('${_items[index]['date']} |'),
                  //     Text(_items[index]['docId']),
                  //   ],
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          height: double.infinity,
                          // color: Colors.pink,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Location',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: const Color.fromARGB(
                                              255, 232, 175, 175),
                                          fontWeight: FontWeight.normal)),
                              Text(_items[index]['fromTime'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          //                 color: const Color.fromARGB(
                                          // 255, 232, 175, 175),
                                          fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          height: double.infinity,
                          // color: Colors.yellow,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.bike_scooter,
                                  color: Colors.amber, size: 20),
                              Container(
                                height: 20,
                                width: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Center(
                                    child: Text(_items[index]['duration'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                //                 color: const Color.fromARGB(
                                                // 255, 232, 175, 175),
                                                fontWeight:
                                                    FontWeight.normal))),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('₹',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              //                 color: const Color.fromARGB(
                                              // 255, 232, 175, 175),
                                              color: Colors.amber,
                                              fontWeight: FontWeight.normal)),
                                  Text(_items[index]['amount'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              //                 color: const Color.fromARGB(
                                              // 255, 232, 175, 175),
                                              fontWeight: FontWeight.normal)),
                                ],
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Location',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: const Color.fromARGB(
                                              255, 164, 236, 166),
                                          fontWeight: FontWeight.normal)),
                              Text(_items[index]['fromTime'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          //                 color: const Color.fromARGB(
                                          // 255, 232, 175, 175),
                                          fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          content: InkWell(
            onTap: () {
              // Map data = {
              //                 "doc_no":
              //                     claimData[index]
              //                         .docNo
              //                         .toString(),
              //                 "from": claimData[index]
              //                     .tStartOriginAddress
              //                     .toString(),
              //                 "date": claimData[index]
              //                     .travelStartDate
              //                     .toString(),
              //                 "to": claimData[index]
              //                     .tEndOriginAddress
              //                     .toString(),
              //                 'flag': 0
              //               };

              //               Navigator.pushNamed(
              //                   context,
              //                   RouteNames
              //                       .historyclaim,
              //                   arguments: data);
            },
            child: Card(
              elevation: 20,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Container(
                // height: 150,
                padding: const EdgeInsets.all(10),
                // color: const Color.fromARGB(
                //           255, 72, 70, 70),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 72, 70, 70),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                // decoration: BoxDecoration(
                //     // borderRadius: BorderRadius.only(
                //     //   bottomLeft: Radius.circular(20),
                //     //   bottomRight: Radius.circular(20),
                //     // )
                //     ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: Color.fromARGB(255, 167, 146, 81),
                        ),
                        Text('Wait Time: ${_items[index]['waitTime']}',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                //                 color: const Color.fromARGB(
                                // 255, 232, 175, 175),

                                fontWeight: FontWeight.normal)),
                        // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text('Wait Time: ${_items[index]['waitTime']}'),
                        Icon(
                          Icons.handshake_outlined,
                          color: Color.fromARGB(255, 167, 146, 81),
                        ),
                        Text('Meeting Time: ${_items[index]['meetingTime']}',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                //                 color: const Color.fromARGB(
                                // 255, 232, 175, 175),

                                fontWeight: FontWeight.normal)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RippleAnimation(
                            repeat: true,
                            color: Colors.grey,
                            minRadius: 60,
                            ripplesCount: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                                left: 5,
                              ),
                              child: Text('Status Goes Here'),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.star,
                            color: Color.fromARGB(255, 167, 146, 81)),
                        Text('Suggested: ${_items[index]['suggested']}',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                //                 color: const Color.fromARGB(
                                // 255, 232, 175, 175),

                                fontWeight: FontWeight.normal)),
                        // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.check,
                            color: Color.fromARGB(255, 167, 146, 81)),
                        Text('Actual: ${_items[index]['suggested']}',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                //                 color: const Color.fromARGB(
                                // 255, 232, 175, 175),

                                fontWeight: FontWeight.normal)),
                        // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.computer,
                            color: Color.fromARGB(255, 167, 146, 81)),
                        Text('Intelligence: ${_items[index]['suggested']}',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                //                 color: const Color.fromARGB(
                                // 255, 232, 175, 175),

                                fontWeight: FontWeight.normal)),
                        // Text('Meeting Time: ${_items[index]['meetingTime']}'),
                      ],
                    ),

                    //Section For Managers

                    Container(
                      height: 20,
                      // color: Colors.green,
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Transform.scale(
                          //   scale: 1,
                          //   child: Switch.adaptive(
                          //       thumbColor:
                          //           MaterialStateProperty.all(
                          //               Colors.red),
                          //       trackColor:
                          //           MaterialStateProperty.all(
                          //               const Color.fromARGB(
                          //                   255,
                          //                   248,
                          //                   109,
                          //                   109)),
                          //       value: rejected,
                          //       onChanged: (value) {
                          //         // setState(() {
                          //         //   // rejected = value;
                          //         // });
                          //         rejectAlert(
                          //             value,
                          //             provider[index]
                          //                 ['doc_no'],
                          //             provider[index]);
                          //       }),
                          // ),
                          // const Text('Reject')
                          InkWell(
                            onTap: () {},
                            child: const Icon(Icons.check_box,
                                color: Colors.orangeAccent, size: 30),
                          ),
                          InkWell(
                              onTap: () {},
                              child: const Icon(Icons.cancel,
                                  color: Colors.orangeAccent, size: 30)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            debugPrint("tapped!!");
          },
          onLongTap: () {
            debugPrint("looooooooooong tapped!!");
          },
        );
      },
    );
  }

  Future<String> _getAddress(String? lat, String? lng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(lat.toString()), double.parse(lng.toString()));

    return placemarks[0].locality.toString();
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        saveText: 'SET',
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xffF59F23),
                  surface: Colors.grey,
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: Color.fromARGB(255, 91, 91, 91),
              ),
              child: child!,
            ),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDateRange: dateRange);

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
      isLoading = true;

      print(dateRange.start.month.toString());

      Map<String, dynamic> data = {
        'from_date': dateRange.start.toString().split(" ")[0].toString(),
        'all': 1,
        'to_date': dateRange.end.toString().split(" ")[0].toString(),
      };

      print('DATAAAAAAAA: $data');

      // claimz_list.postClaimzHistoryList(context, _data);
      Provider.of<ClaimzHistoryViewModel>(context, listen: false)
          .getClaimList(data, context)
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });

    print('dateRange: $dateRange');
    return dateRange;
  }
}
