import 'package:claimz/res/components/date_range_picker.dart';
import 'package:claimz/viewModel/leaveRequestViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../res/components/alert_dialog.dart';
import '../../../../res/components/containerStyle.dart';
import '../../../../viewModel/reportingTreeViewModel.dart';
import '../../../config/mediaQuery.dart';
import 'package:provider/provider.dart';
import 'leaveRequestManagerShimmer.dart';
import 'pendingLeaves.dart';
import 'approvedLeaves.dart';
import 'rejectedLeaves.dart';

class LeaveRequestManager extends StatefulWidget {
  LeaveRequestManagerState createState() => LeaveRequestManagerState();
}

class LeaveRequestManagerState extends State<LeaveRequestManager> {
  bool isLoading = true;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  final _controller = TextEditingController();
  List<Map<String, dynamic>> data = [];
  // List<dynamic> query = [];
  var query;
  // bool isLoading = true;
  int? role;
  int? id;

  var myMonth = DateFormat('MMMM').format(DateTime.now());

  var myYears = DateFormat('yyyy').format(DateTime.now());

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, 4, 1),
    end: DateTime(DateTime.now().year + 1, 3, 31),
  );

  Future<void> checkRole() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    role = localStorage.getInt('role');
    id = localStorage.getInt('userId');
    print('Role: $role');
    print('UserIdddddddddddd: $id');
  }

  @override
  void initState() {
    // TODO: implement initState
    checkRole()
        .then((value) =>
            Provider.of<ReportingTreeViewModel>(context, listen: false)
                .getReportingTree(context, id!)
                .then((value) {
              setState(() {
                // isLoading = false;
              });
            }))
        .then((value) {
      Provider.of<LeaveRequestViewModel>(context, listen: false)
          .getLeaveRequest(dateFormat.format(dateRange.start),
              dateFormat.format(DateTime.now()))
          .then((value) {
        setState(() {
          isLoading = false;
          query = Provider.of<LeaveRequestViewModel>(context, listen: false)
              .pendingLeaves;
          // query = data;
          // print('LEAVE DATAAAAA: $query');
        });
      });
    });

    super.initState();
  }

  searchByQuery(String search) {
    setState(() {
      query = data
          .where((element) =>
              element['name'].toLowerCase().contains(search.toLowerCase()))
          .toList();

      print('QUERY: $query');
      // query = data
      //     .where((element) => element['announcement_title']
      //         .toLowerCase()
      //         .contains(search.toLowerCase()))
      //     .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    // final provider = Provider.of<LeaveRequestViewModel>(context).leaveList;

    final provider = Provider.of<LeaveRequestViewModel>(context).pendingLeaves;

    final providerTwo = Provider.of<ReportingTreeViewModel>(context).all;

    print('Query Data: $query');
    print('Provider Two Data: $providerTwo');

    // TODO: implement build
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              elevation: 0,
              toolbarHeight: 130,
              title: Column(
                children: [
                  Container(
                    // height: 400,
                    //color: Colors.red,
                    // margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
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
                                  width:
                                      SizeVariables.getWidth(context) * 0.02),
                              Container(
                                width: SizeVariables.getWidth(context) * 0.4,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    'Leave Request',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // color: Colors.amber,
                          width: SizeVariables.getWidth(context) * 0.3,
                          height: SizeVariables.getHeight(context) * 0.05,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: DateRangePicker(
                              onPressed: pickDateRange,
                              end: end,
                              start: start,
                              // width: double.infinity,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 50),
                  Container(
                    height: 80,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 17),
                    // color: Colors.red,
                    child: Row(
                      children: [
                        // Padding(
                        //   padding:
                        //       EdgeInsets.only(left: SizeVariables.getWidth(context) * 0.03, top: SizeVariables.getHeight(context) * 0.014),
                        //   child: InkWell(
                        //       onTap: () => Navigator.of(context).pop(),
                        //       child: const Icon(Icons.arrow_back_ios,
                        //           color: Colors.green, size: 30)),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.02,
                              right: SizeVariables.getWidth(context) * 0.04,
                              bottom: SizeVariables.getHeight(context) * 0.04),
                          child: Container(
                            // color: Colors.amber,
                            width: SizeVariables.getWidth(context) * 0.8,
                            height: SizeVariables.getHeight(context) * 0.065,
                            // margin: EdgeInsets.only(
                            //     // top: SizeVariables.getHeight(context) * 0.02,
                            //     ),
                            padding: EdgeInsets.only(
                                left: SizeVariables.getWidth(context) * 0.02),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  // spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Icon(
                                    Icons.search_outlined,
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                ),
                                Flexible(
                                  flex: 9,
                                  fit: FlexFit.tight,
                                  child: TextField(
                                    controller: _controller,
                                    onChanged: (value) => searchByQuery(value),
                                    autofocus: false,
                                    cursorColor: Colors.grey,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 14),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Search By Name or Title',
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // title: Container(
              //   padding: EdgeInsets.only(
              //     top: SizeVariables.getHeight(context) * 0.008,
              //   ),
              //   child: Row(
              //     children: [
              //       InkWell(
              //         onTap: () {
              //           // Navigator.of(context).pushNamed(RouteNames.navbar);
              //           Navigator.of(context).pop();
              //         },
              //         child: SvgPicture.asset(
              //           "assets/icons/back button.svg",
              //         ),
              //       ),
              //       Container(
              //         padding: EdgeInsets.only(
              //           left: SizeVariables.getWidth(context) * 0.01,
              //         ),
              //         child: Text(
              //           'Leaves Request',
              //           style: Theme.of(context).textTheme.caption,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              bottom: TabBar(
                  indicatorColor: Theme.of(context).colorScheme.onPrimary,
                  tabs: const [
                    Tab(text: 'Pending'),
                    Tab(text: 'Approved'),
                    Tab(text: 'Rejected'),
                  ]),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: isLoading
                ? LeaveRequestManagerShimmer()
                // CircularProgressIndicator()
                : TabBarView(
                    children: [
                      PendingLeaves(provider, providerTwo, myMonth, myYears),
                      ApprovedLeaves(),
                      RejectedLeaves()
                    ],
                  )),
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        saveText: "SET",
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xffF59F23),
                  surface: Colors.black,
                  onSurface: Colors.grey,
                ),
                dialogBackgroundColor: const Color.fromARGB(255, 91, 91, 91),
              ),
              child: child!,
            ),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
        initialDateRange: dateRange);

    if (newDateRange == null) return;

    setState(() {
      dateRange = newDateRange;
    });

    var fromDate = dateFormat.format(dateRange.start);
    var toDate = dateFormat.format(dateRange.end);

    // Map<String, dynamic> _data = {'month': myMonth, 'year': myYears.toString()};
    Provider.of<LeaveRequestViewModel>(context, listen: false)
        .getLeaveRequest(fromDate, toDate)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });

    print('dateRange re-selected: $dateRange');
    return dateRange;
  }
}
