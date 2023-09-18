import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ManagerConvenyanceClaim extends StatefulWidget {
  // const ManagerConvenyanceClaim({Key? key}) : super(key: key);

  @override
  State<ManagerConvenyanceClaim> createState() =>
      _ManagerConvenyanceClaimState();
}

class _ManagerConvenyanceClaimState extends State<ManagerConvenyanceClaim> {
  int _selection = 1;

  Map data = {
    "month": "",
    "type": "",
    "year": "",
    "user_id": "",
    "Info": "1" //self
  };

  List<String> detail = [
    "Action",
    "Approve",
    "Reject",
  ];
  TextEditingController _gstAmount = TextEditingController();
  TextEditingController _basicAmount = TextEditingController();
  TextEditingController _totalAmount = TextEditingController();
  // TravelViewModel _travelData = new TravelViewModel();

  TextEditingController _fgstamount = TextEditingController();
  TextEditingController _fgstbasicamount = TextEditingController();
  TextEditingController _fgstclaimamount = TextEditingController();
  TextEditingController _agstamount = TextEditingController();
  TextEditingController _agstbasicamount = TextEditingController();
  TextEditingController _agstclaimamount = TextEditingController();
  TextEditingController _tgstamount = TextEditingController();
  TextEditingController _tgstbasicamount = TextEditingController();
  TextEditingController _tgstclaimamount = TextEditingController();

  TextEditingController _gstAmtTravel = TextEditingController();
  TextEditingController _basicAmtTravel = TextEditingController();
  TextEditingController _claimAmtTravel = TextEditingController();

  TextEditingController _gstAmtLocal = TextEditingController();
  TextEditingController _basicAmtLocal = TextEditingController();
  TextEditingController _claimAmtLocal = TextEditingController();

  TextEditingController _gstAmtIncidental = TextEditingController();
  TextEditingController _basicAmtIncidental = TextEditingController();
  TextEditingController _claimAmtIncidental = TextEditingController();

  TextEditingController _gstAmtAccomodation = TextEditingController();
  TextEditingController _basicAmtAccomodation = TextEditingController();
  TextEditingController _claimAmtAccomodation = TextEditingController();

  TextEditingController _gstAmtFood = TextEditingController();
  TextEditingController _basicAmtFood = TextEditingController();
  TextEditingController _claimAmtFood = TextEditingController();

  double _final_amount = 0.0;
  int page_load = 0;

  @override
  void initState() {
    // TODO: implement initState
    // _gstAmount.text = '50';
    // _basicAmount.text = '500';
    // _totalAmount.text = '550';
    // Map _data_request = {
    //   "doc_no": widget.arguments["doc"],
    //   "all": widget.arguments["all"],
    //   "status": widget.arguments["status"],
    // };
    // _travelData.postTravelDoc(_data_request);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                        'Convenyance Claim View',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 16, color: Colors.grey),
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
                              width: SizeVariables.getWidth(context) * 0.02),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              "122344545",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.amber, fontSize: 16),
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
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.03,
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
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 30,
                                  ),
                        ),
                      ),
                    ],
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
                                    height:
                                        SizeVariables.getHeight(context) * 0.03,
                                    width:
                                        SizeVariables.getWidth(context) * 0.02,
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
                    SizedBox(width: SizeVariables.getWidth(context) * 0.045),
                    Container(
                      width: SizeVariables.getWidth(context) * 0.77,
                      height: SizeVariables.getHeight(context) * 0.1,
                      // color: Colors.pink,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                                  _selection == 0 ? Colors.amber : Colors.black,
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
                              decoration: new BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    // color: Colors.orangeAccent,
                                    blurRadius: 2.0,
                                    offset: const Offset(0.0, .0),
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
                                        top: SizeVariables.getHeight(context) *
                                            0.015,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/travelIcon/flightbus.svg",
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.035,
                                        width: SizeVariables.getWidth(context) *
                                            0.05,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getHeight(context) * 0.025,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                                  _selection == 2 ? Colors.amber : Colors.black,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(3),
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
                              decoration: new BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30),
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
                                        top: SizeVariables.getHeight(context) *
                                            0.015,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/travelIcon/Hotel.svg",
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.035,
                                        width: SizeVariables.getWidth(context) *
                                            0.05,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getHeight(context) * 0.025,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                                  _selection == 3 ? Colors.amber : Colors.black,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(3),
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
                              decoration: new BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30),
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
                                        top: SizeVariables.getHeight(context) *
                                            0.015,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/travelIcon/Food.svg",
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.035,
                                        width: SizeVariables.getWidth(context) *
                                            0.05,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getHeight(context) * 0.025,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                                  _selection == 4 ? Colors.amber : Colors.black,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(3),
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
                              decoration: new BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30),
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
                                        top: SizeVariables.getHeight(context) *
                                            0.016,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/travelIcon/Local Travel.svg",
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.035,
                                        width: SizeVariables.getWidth(context) *
                                            0.05,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getHeight(context) * 0.025,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary:
                                  _selection == 5 ? Colors.amber : Colors.black,
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(3),
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
                              decoration: new BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30),
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
                                        top: SizeVariables.getHeight(context) *
                                            0.016,
                                      ),
                                      child: SvgPicture.asset(
                                        "assets/travelIcon/incidentals.svg",
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.035,
                                        width: SizeVariables.getWidth(context) *
                                            0.05,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeVariables.getHeight(context) * 0.02,
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
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                    _selection == 1 ? _infotabManager() : SizedBox(),
                    _selection == 0 ? _traveltabManager() : SizedBox(),
                    _selection == 2 ? _accomondationtabManager() : SizedBox(),
                    _selection == 3 ? _foodtabManager() : SizedBox(),
                    _selection == 4 ? _localtabManager() : SizedBox(),
                    _selection == 5 ? _incidentaltabManager() : SizedBox(),
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
    );
  }

  _infotabManager() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              // height: SizeVariables.getHeight(context) * 0.23,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                .button!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.02,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.account_circle_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Meet to whom',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            "test",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                right: SizeVariables.getWidth(context) * 0.07),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.book_online_outlined),
                                ),
                                SizedBox(
                                  width: SizeVariables.getWidth(context) * 0.01,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Feedback',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            'Test1',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.1,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.handshake_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Purpose',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'test',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.02),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.05,
                  ),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Approval Status',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            Container(
                height: SizeVariables.getHeight(context) * 1,
                child: Scrollbar(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
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
                                              '1500',
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
                                        width: SizeVariables.getWidth(context) *
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
                                                'Pending For Approval',
                                                style: Theme.of(context)
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
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
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
                                                  "This is claim amount",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.02,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _popupApprove(
                                                    "approval", context);
                                              },
                                              child: Container(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.03,
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.15,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Color.fromARGB(
                                                      255, 232, 237, 241),
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
                                                        'Action',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .blueAccent,
                                                                fontSize: 12),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Shaikh Salim Akhtar',
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
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.6,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height:
                                              SizeVariables.getHeight(context) *
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
                                                  "21 Oct 2022",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: FittedBox(
                                                fit: BoxFit.contain,
                                                child: Text(
                                                  '12:02:23',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black),
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
                ))
          ],
        ),
      ),
    );
  }

  _traveltabManager() {
    return AutofillGroup(
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.01,
          right: SizeVariables.getWidth(context) * 0.01,
        ),
        child: Container(
          // height: SizeVariables.getHeight(context) * 0.6,
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
                        'Travel details',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(
                            right: SizeVariables.getWidth(context) * 0.07),
                        child: const Icon(
                          Icons.remove_red_eye,
                          // size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.02,
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: Icon(Icons.mode_of_travel_outlined),
                      ),
                      SizedBox(
                        width: SizeVariables.getWidth(context) * 0.01,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Travel type',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.black, fontSize: 12),
                                ),
                              ),
                            ),
                            Container(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  "Business class",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: Colors.black, fontSize: 14),
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
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.travel_explore_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Travel way',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "oneway",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
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
                              height: SizeVariables.getHeight(context) * 0.01,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.location_on_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'From',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "kolkata",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
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
                              height: SizeVariables.getHeight(context) * 0.01,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.calendar_month_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Departure',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "21 Sep 2022",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.handshake_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Name of Provider',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "test",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
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
                              height: SizeVariables.getHeight(context) * 0.01,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.location_on_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'To',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "coochbehar",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
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
                              height: SizeVariables.getHeight(context) * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                right: SizeVariables.getWidth(context) * 0.17,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.calendar_month_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Return',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "21 Oct 2022",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.04,
                        top: SizeVariables.getHeight(context) * 0.01,
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
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Container(
                  padding: EdgeInsets.only(
                      right: SizeVariables.getWidth(context) * 0.238),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.07,
                        ),
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.calendar_month_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.01,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Doc. date',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          "24 Nov 2022",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         child: Icon(Icons.account_balance_wallet_outlined),
                      //       ),
                      //       SizedBox(
                      //         width: SizeVariables.getWidth(context) * 0.01,
                      //       ),
                      //       Container(
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(
                      //               child: FittedBox(
                      //                 fit: BoxFit.contain,
                      //                 child: Text(
                      //                   'Exchange rate',
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .bodyText1!
                      //                       .copyWith(
                      //                           color: Colors.black,
                      //                           fontSize: 12),
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //               child: FittedBox(
                      //                 fit: BoxFit.contain,
                      //                 child: Text(
                      //                   '2734767437',
                      //                   style: Theme.of(context)
                      //                       .textTheme
                      //                       .bodyText2!
                      //                       .copyWith(
                      //                           color: Colors.black,
                      //                           fontSize: 14),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.book_online),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'GST No',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              "1456GFDGFF11",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.currency_rupee_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Basic Amount',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.021,
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.18,
                                          child: TextFormField(
                                            controller: _basicAmtTravel,
                                            onChanged: (content) {
                                              if (_gstAmtTravel.text == '') {
                                                setState(() {
                                                  _claimAmtTravel.text =
                                                      _basicAmtTravel.text;
                                                });
                                              } else {
                                                setState(() {
                                                  _claimAmtTravel
                                                      .text = (double.parse(
                                                              _basicAmtTravel
                                                                  .text) +
                                                          double.parse(
                                                              _gstAmtTravel
                                                                  .text))
                                                      .toString();
                                                });
                                              }
                                              setState(() {});
                                              setState(() {
                                                //_final_amount = double.parse(tclaim_amount.text);
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                            cursorColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeVariables.getHeight(context) * 0.01,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.currency_rupee_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'GST Amount',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.021,
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.18,
                                          child: TextField(
                                            controller: _gstAmtTravel,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                            cursorColor: Colors.black,
                                            onChanged: (val) {
                                              if (_gstAmtTravel.text == '') {
                                                setState(() {
                                                  _claimAmtTravel.text =
                                                      _basicAmtTravel.text;
                                                });
                                              } else {
                                                setState(() {
                                                  _claimAmtTravel
                                                      .text = double.parse(
                                                          _gstAmtTravel.text)
                                                      .toString();
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(Icons.currency_rupee_outlined),
                                  ),
                                  SizedBox(
                                    width:
                                        SizeVariables.getWidth(context) * 0.01,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              'Claim Amount',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontSize: 12),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.021,
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.18,
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: _claimAmtTravel,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                            cursorColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Container(
                  padding: EdgeInsets.only(
                      right: SizeVariables.getWidth(context) * 0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.05,
                        ),
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(Icons.payment_outlined),
                              ),
                              SizedBox(
                                width: SizeVariables.getWidth(context) * 0.01,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          'Payment type',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          "paid by self",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                        text: 'Submit',
                        isReverse: true,
                        selectedTextColor: Colors.black,
                        transitionType: TransitionType.LEFT_TO_RIGHT,
                        textStyle: TextStyle(fontSize: 13),
                        backgroundColor: Colors.black,
                        borderColor: Colors.white,
                        borderRadius: 8,
                        borderWidth: 2,
                        onPress: () {},
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

  _accomondationtabManager() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
        // height: SizeVariables.getHeight(context) * 0.6,
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
                      'Accomodation details',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // _viewdocument(context, travel);
                      // _viewdocument(context, accomodation!.document.toString());
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.07),
                      child: Icon(
                        Icons.remove_red_eye,
                        // size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.handshake_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Name of Provider',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "test",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.238),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.calendar_month_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'From date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "21 Oct 2022",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.calendar_month_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.01,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'To date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      "22 Oct 2022",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.04,
                      top: SizeVariables.getHeight(context) * 0.01,
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
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.238),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.calendar_month_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Doc. date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "24 Nov 2022",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         child: Icon(Icons.account_balance_wallet_outlined),
                    //       ),
                    //       SizedBox(
                    //         width: SizeVariables.getWidth(context) * 0.01,
                    //       ),
                    //       Container(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               child: FittedBox(
                    //                 fit: BoxFit.contain,
                    //                 child: Text(
                    //                   'Exchange rate',
                    //                   style: Theme.of(context)
                    //                       .textTheme
                    //                       .bodyText1!
                    //                       .copyWith(
                    //                           color: Colors.black,
                    //                           fontSize: 12),
                    //                 ),
                    //               ),
                    //             ),
                    //             Container(
                    //               child: FittedBox(
                    //                 fit: BoxFit.contain,
                    //                 child: Text(
                    //                   '7347756784',
                    //                   style: Theme.of(context)
                    //                       .textTheme
                    //                       .bodyText2!
                    //                       .copyWith(
                    //                           color: Colors.black,
                    //                           fontSize: 14),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.book_online),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'GST No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "1233GHGHFGG",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.currency_rupee_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.01,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'GST Amount',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.021,
                                  width: SizeVariables.getWidth(context) * 0.18,
                                  child: TextFormField(
                                    controller: _gstAmtAccomodation,
                                    onChanged: (val) {
                                      if (_gstAmtAccomodation.text == '') {
                                        setState(() {
                                          _claimAmtAccomodation.text =
                                              _basicAmtAccomodation.text;
                                        });
                                      } else {
                                        setState(() {
                                          _claimAmtAccomodation.text =
                                              double.parse(
                                                      _gstAmtAccomodation.text)
                                                  .toString();
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.219),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.currency_rupee_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Basic Amount',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: SizeVariables.getHeight(context) *
                                        0.021,
                                    width:
                                        SizeVariables.getWidth(context) * 0.18,
                                    child: TextFormField(
                                      controller: _basicAmtAccomodation,
                                      onChanged: (content) {
                                        if (_gstAmtAccomodation.text == '') {
                                          setState(() {
                                            _claimAmtAccomodation.text =
                                                _basicAmtAccomodation.text;
                                          });
                                        } else {
                                          setState(() {
                                            _claimAmtAccomodation
                                                .text = (double.parse(
                                                        _basicAmtAccomodation
                                                            .text) +
                                                    double.parse(
                                                        _gstAmtAccomodation
                                                            .text))
                                                .toString();
                                          });
                                        }
                                        setState(() {});
                                        //_final_amount = double.parse(tclaim_amount.text);
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 14),
                                      cursorColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.currency_rupee_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.01,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'Claim Amount',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.021,
                                  width: SizeVariables.getWidth(context) * 0.18,
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: _claimAmtAccomodation,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.payment_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Payment type',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "paid by self",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                      text: 'Submit',
                      isReverse: true,
                      selectedTextColor: Colors.black,
                      transitionType: TransitionType.LEFT_TO_RIGHT,
                      textStyle: TextStyle(fontSize: 13),
                      backgroundColor: Colors.black,
                      borderColor: Colors.white,
                      borderRadius: 8,
                      borderWidth: 2,
                      onPress: () {},
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

  _foodtabManager() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
        // height: SizeVariables.getHeight(context) * 0.6,
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
                      'Food details',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // _viewdocument(context, food!.document.toString());
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.07),
                      child: Icon(
                        Icons.remove_red_eye,
                        // size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.handshake_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Name of Provider',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "test",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.04,
                      top: SizeVariables.getHeight(context) * 0.01,
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
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.238),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.calendar_month_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Doc. date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "24 Nov 2022",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         child: Icon(Icons.account_balance_wallet_outlined),
                    //       ),
                    //       SizedBox(
                    //         width: SizeVariables.getWidth(context) * 0.01,
                    //       ),
                    //       Container(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               child: FittedBox(
                    //                 fit: BoxFit.contain,
                    //                 child: Text(
                    //                   'Exchange rate',
                    //                   style: Theme.of(context)
                    //                       .textTheme
                    //                       .bodyText1!
                    //                       .copyWith(
                    //                           color: Colors.black,
                    //                           fontSize: 12),
                    //                 ),
                    //               ),
                    //             ),
                    //             Container(
                    //               child: FittedBox(
                    //                 fit: BoxFit.contain,
                    //                 child: Text(
                    //                   '2999999999',
                    //                   style: Theme.of(context)
                    //                       .textTheme
                    //                       .bodyText2!
                    //                       .copyWith(
                    //                           color: Colors.black,
                    //                           fontSize: 14),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.book_online),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'GST No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "1234HGHGHHH",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.currency_rupee_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.01,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'GST Amount',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.021,
                                  width: SizeVariables.getWidth(context) * 0.18,
                                  child: TextFormField(
                                    controller: _gstAmtFood,
                                    onChanged: (val) {
                                      if (_gstAmtFood.text == '') {
                                        setState(() {
                                          _claimAmtFood.text =
                                              _basicAmtFood.text;
                                        });
                                      } else {
                                        setState(() {
                                          _claimAmtFood.text =
                                              double.parse(_gstAmtFood.text)
                                                  .toString();
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                    cursorColor: Colors.black,
                                    // onChanged: (val) {
                                    //   setState(() {
                                    //     _gstAmtTravel.text = val;
                                    //   });
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.219),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.currency_rupee_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Basic Amount',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: SizeVariables.getHeight(context) *
                                        0.021,
                                    width:
                                        SizeVariables.getWidth(context) * 0.18,
                                    child: TextFormField(
                                      controller: _basicAmtFood,
                                      onChanged: (content) {
                                        if (_gstAmtFood.text == '') {
                                          setState(() {
                                            _claimAmtFood.text =
                                                _basicAmtFood.text;
                                          });
                                        } else {
                                          setState(() {
                                            _claimAmtFood.text = (double.parse(
                                                        _basicAmtFood.text) +
                                                    double.parse(
                                                        _gstAmtFood.text))
                                                .toString();
                                          });
                                        }
                                        setState(() {});
                                        //_final_amount = double.parse(tclaim_amount.text);

                                        setState(() {});
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 14),
                                      cursorColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.currency_rupee_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.01,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'Claim Amount',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.021,
                                  width: SizeVariables.getWidth(context) * 0.18,
                                  child: TextFormField(
                                    readOnly: true,
                                    controller: _claimAmtFood,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.payment_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Payment type',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "paid by Self",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                      text: 'Submit',
                      isReverse: true,
                      selectedTextColor: Colors.black,
                      transitionType: TransitionType.LEFT_TO_RIGHT,
                      textStyle: TextStyle(fontSize: 13),
                      backgroundColor: Colors.black,
                      borderColor: Colors.white,
                      borderRadius: 8,
                      borderWidth: 2,
                      onPress: () {},
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

  _localtabManager() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
        // height: SizeVariables.getHeight(context) * 0.6,
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
                      'Local details',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // _viewdocument(context, food!.document.toString());
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.07),
                      child: Icon(
                        Icons.remove_red_eye,
                        // size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.handshake_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Name of Provider',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "test",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.04,
                      top: SizeVariables.getHeight(context) * 0.01,
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
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.238),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.calendar_month_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Doc. date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "24 Nov 2022",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         child: Icon(Icons.account_balance_wallet_outlined),
                    //       ),
                    //       SizedBox(
                    //         width: SizeVariables.getWidth(context) * 0.01,
                    //       ),
                    //       Container(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               child: FittedBox(
                    //                 fit: BoxFit.contain,
                    //                 child: Text(
                    //                   'Exchange rate',
                    //                   style: Theme.of(context)
                    //                       .textTheme
                    //                       .bodyText1!
                    //                       .copyWith(
                    //                           color: Colors.black,
                    //                           fontSize: 12),
                    //                 ),
                    //               ),
                    //             ),
                    //             Container(
                    //               child: FittedBox(
                    //                 fit: BoxFit.contain,
                    //                 child: Text(
                    //                   '2999999999',
                    //                   style: Theme.of(context)
                    //                       .textTheme
                    //                       .bodyText2!
                    //                       .copyWith(
                    //                           color: Colors.black,
                    //                           fontSize: 14),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.book_online),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'GST No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "1544FGFFF",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.currency_rupee_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.01,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'GST Amount',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.021,
                                  width: SizeVariables.getWidth(context) * 0.18,
                                  child: TextFormField(
                                    controller: _gstAmtLocal,
                                    onChanged: (val) {
                                      if (_gstAmtLocal.text == '') {
                                        setState(() {
                                          _claimAmtLocal.text =
                                              _basicAmtLocal.text;
                                        });
                                      } else {
                                        setState(() {
                                          _claimAmtLocal.text =
                                              double.parse(_gstAmtLocal.text)
                                                  .toString();
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                    cursorColor: Colors.black,
                                    // onChanged: (val) {
                                    //   setState(() {
                                    //     _gstAmtTravel.text = val;
                                    //   });
                                    // },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.219),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.currency_rupee_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Basic Amount',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: SizeVariables.getHeight(context) *
                                        0.021,
                                    width:
                                        SizeVariables.getWidth(context) * 0.18,
                                    child: TextFormField(
                                      controller: _basicAmtLocal,
                                      onChanged: (content) {
                                        if (_gstAmtLocal.text == '') {
                                          setState(() {
                                            _claimAmtLocal.text =
                                                _basicAmtLocal.text;
                                          });
                                        } else {
                                          setState(() {
                                            _claimAmtLocal.text = (double.parse(
                                                        _basicAmtLocal.text) +
                                                    double.parse(
                                                        _gstAmtLocal.text))
                                                .toString();
                                          });
                                        }
                                        setState(() {});

                                        setState(() {
                                          //_final_amount = double.parse(tclaim_amount.text);
                                        });
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 14),
                                      cursorColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.currency_rupee_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.01,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'Claim Amount',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.021,
                                  width: SizeVariables.getWidth(context) * 0.18,
                                  child: TextFormField(
                                    controller: _claimAmtLocal,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.payment_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Payment type',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "paid by company",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                      text: 'Submit',
                      isReverse: true,
                      selectedTextColor: Colors.black,
                      transitionType: TransitionType.LEFT_TO_RIGHT,
                      textStyle: TextStyle(fontSize: 13),
                      backgroundColor: Colors.black,
                      borderColor: Colors.white,
                      borderRadius: 8,
                      borderWidth: 2,
                      onPress: () {},
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

  _incidentaltabManager() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeVariables.getWidth(context) * 0.01,
        right: SizeVariables.getWidth(context) * 0.01,
      ),
      child: Container(
        // height: SizeVariables.getHeight(context) * 0.6,
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
                      'Incidental details',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // _viewdocument(context, incidental!.document.toString());
                    },
                    child: Container(
                      // color: Colors.amber,
                      padding: EdgeInsets.only(
                          right: SizeVariables.getWidth(context) * 0.07),
                      child: Icon(
                        Icons.remove_red_eye,
                        // size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.02,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.handshake_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Name of Provider',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "test",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.handshake_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Purchase details',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "test",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.04,
                      top: SizeVariables.getHeight(context) * 0.01,
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
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.246),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.calendar_month_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Doc. date',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "24 Nov 2022",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.book_online),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'GST No',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "1234FGFFFG",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.currency_rupee_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.01,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'GST Amount',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.021,
                                  width: SizeVariables.getWidth(context) * 0.18,
                                  child: TextFormField(
                                    controller: _gstAmtIncidental,
                                    onChanged: (val) {
                                      if (_gstAmtIncidental.text == '') {
                                        setState(() {
                                          _claimAmtIncidental.text =
                                              _basicAmtIncidental.text;
                                        });
                                      } else {
                                        setState(() {
                                          _claimAmtIncidental.text =
                                              double.parse(
                                                      _gstAmtIncidental.text)
                                                  .toString();
                                        });
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.219),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.currency_rupee_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Basic Amount',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: SizeVariables.getHeight(context) *
                                        0.021,
                                    width:
                                        SizeVariables.getWidth(context) * 0.18,
                                    child: TextFormField(
                                      controller: _basicAmtIncidental,
                                      onChanged: (_) {
                                        if (_gstAmtIncidental.text == '') {
                                          setState(() {
                                            _claimAmtIncidental.text =
                                                _basicAmtIncidental.text;
                                          });
                                        } else {
                                          setState(() {
                                            _claimAmtIncidental
                                                .text = (double.parse(
                                                        _basicAmtIncidental
                                                            .text) +
                                                    double.parse(
                                                        _gstAmtIncidental.text))
                                                .toString();
                                          });
                                        }
                                        setState(() {});
                                        setState(() {});
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 14),
                                      cursorColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Icon(Icons.currency_rupee_outlined),
                          ),
                          SizedBox(
                            width: SizeVariables.getWidth(context) * 0.01,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      'Claim Amount',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.021,
                                  width: SizeVariables.getWidth(context) * 0.18,
                                  child: TextFormField(
                                    controller: _claimAmtIncidental,
                                    // onChanged: (val){
                                    //
                                    // },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            color: Colors.black, fontSize: 14),
                                    cursorColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05,
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(Icons.payment_outlined),
                            ),
                            SizedBox(
                              width: SizeVariables.getWidth(context) * 0.01,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Payment type',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 12),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        "paid by self",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: Colors.black,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                      text: 'Submit',
                      isReverse: true,
                      selectedTextColor: Colors.black,
                      transitionType: TransitionType.LEFT_TO_RIGHT,
                      textStyle: TextStyle(fontSize: 13),
                      backgroundColor: Colors.black,
                      borderColor: Colors.white,
                      borderRadius: 8,
                      borderWidth: 2,
                      onPress: () {},
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

  _popupApprove(String type, BuildContext context) {
    TextEditingController remarks = new TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Give Remarks",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.grey),
              ),
              TextFormField(
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Remarks",
                  hintStyle: TextStyle(color: Colors.grey),
                  // prefixIcon: Icon(
                  //   Icons.info,
                  //   color: Colors.white,
                  // ),
                ),
                style: Theme.of(context).textTheme.bodyText1,
                validator: (val) => val!.isEmpty ? 'Enter Remarks' : null,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(168, 94, 92, 92),
                      ),
                      onPressed: () {},
                      child: Text('Approve',
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: Color(0xffF59F23),
                                  )),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(168, 94, 92, 92),
                      ),
                      //     disabledColor: Colors.red,
                      // disabledTextColor: Colors.black,
                      // padding: const EdgeInsets.all(12),
                      // textColor: Color(0xffF59F23),
                      // : Color.fromARGB(168, 81, 80, 80),
                      onPressed: () {},
                      child: Text('Reject',
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: Color(0xffF59F23),
                                  )),
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

  void _finalSum(String type, String paytype) {
    if (type == "travel") {
      if (paytype == "Paid by self") {
        if (_claimAmtTravel.text == "") {
          _final_amount = 0.0 +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        } else {
          _final_amount = double.parse(_claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        }
      } else if (paytype == "Paid by company") {
        _final_amount = double.parse(_claimAmtAccomodation.text == ""
                ? "0"
                : _claimAmtAccomodation.text) +
            double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
            double.parse(
                _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
            double.parse(_claimAmtIncidental.text == ""
                ? "0"
                : _claimAmtIncidental.text);
      }
    } else if (type == "accomodation") {
      if (paytype == "Paid by self") {
        if (_claimAmtAccomodation.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        } else {
          _final_amount = double.parse(_claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        }
      } else {
        _final_amount = double.parse(
                _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
            double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
            double.parse(
                _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
            double.parse(_claimAmtIncidental.text == ""
                ? "0"
                : _claimAmtIncidental.text);
      }
    } else if (type == "food") {
      if (paytype == "Paid by self") {
        if (_claimAmtFood.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        } else {
          _final_amount = double.parse(_claimAmtFood.text) +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        }
      } else {
        _final_amount = double.parse(
                _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
            double.parse(_claimAmtAccomodation.text == ""
                ? "0"
                : _claimAmtAccomodation.text) +
            double.parse(
                _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
            double.parse(_claimAmtIncidental.text == ""
                ? "0"
                : _claimAmtIncidental.text);
      }
    } else if (type == "local") {
      if (paytype == "Paid by self") {
        if (_claimAmtLocal.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        } else {
          _final_amount = double.parse(_claimAmtLocal.text) +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
              double.parse(_claimAmtIncidental.text == ""
                  ? "0"
                  : _claimAmtIncidental.text);
        }
      } else {
        _final_amount = double.parse(
                _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
            double.parse(_claimAmtAccomodation.text == ""
                ? "0"
                : _claimAmtAccomodation.text) +
            double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text) +
            double.parse(_claimAmtIncidental.text == ""
                ? "0"
                : _claimAmtIncidental.text);
      }
    } else if (type == "incidental") {
      if (paytype == "Paid by self") {
        if (_claimAmtIncidental.text == "") {
          _final_amount = 0.0 +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text);
        } else {
          _final_amount = double.parse(_claimAmtIncidental.text) +
              double.parse(
                  _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
              double.parse(_claimAmtAccomodation.text == ""
                  ? "0"
                  : _claimAmtAccomodation.text) +
              double.parse(
                  _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
              double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text);
        }
      } else {
        _final_amount = double.parse(
                _claimAmtTravel.text == "" ? "0" : _claimAmtTravel.text) +
            double.parse(_claimAmtAccomodation.text == ""
                ? "0"
                : _claimAmtAccomodation.text) +
            double.parse(
                _claimAmtLocal.text == "" ? "0" : _claimAmtLocal.text) +
            double.parse(_claimAmtFood.text == "" ? "0" : _claimAmtFood.text);
      }
    }
  }

  _viewdocument(BuildContext context, link) {
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
                    'View your document',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 18),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  // left: SizeVariables.getWidth(context) * 0.1,
                  top: SizeVariables.getHeight(context) * 0.06,
                  bottom: SizeVariables.getHeight(context) * 0.1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(children: [
                      InkWell(
                        onTap: () {
                          print('link : $link');
                          showDialog(
                            context: context,
                            builder: (_) => Dialog(
                              child: Image.network(
                                link,
                                width: 500,
                                height: 500,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          child: Icon(
                            Icons.download,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Invoice',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ]),
                    Column(children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Icon(
                            Icons.file_download_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            ' Org. invoice',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
