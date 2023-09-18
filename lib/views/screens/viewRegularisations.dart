import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/screens/user_regularisation_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/leaveListViewModel.dart';
import '../../../data/response/status.dart';
import 'package:lottie/lottie.dart';

import '../../res/components/date_range_picker.dart';
import '../../viewModel/allRegularisationViewModel.dart';
import 'leaveScreenShimmer.dart';

class ViewRegularisations extends StatefulWidget {
  const ViewRegularisations({Key? key}) : super(key: key);

  @override
  State<ViewRegularisations> createState() => _ViewRegularisationsState();
}

class _ViewRegularisationsState extends State<ViewRegularisations> {
  LeaveListViewModel leaveListViewModel = LeaveListViewModel();
  bool isLoading = true;

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  var myMonth = DateFormat('MMMM').format(DateTime.now());

  var myYears = DateFormat('yyyy').format(DateTime.now());

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, 4, 1),
    end: DateTime(DateTime.now().year + 1, 3, 31),
  );

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AllRegularisationViewModel>(context, listen: false)
        .getAllRegularisations(dateFormat.format(dateRange.start),
            dateFormat.format(DateTime.now()))
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;

    final provider =
        Provider.of<AllRegularisationViewModel>(context).allRegularisation;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            elevation: 20,
            title: Container(
              padding: EdgeInsets.only(
                top: SizeVariables.getHeight(context) * 0.008,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Regularisations',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 18,
                            ),
                      ),
                    ],
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
            )),
        body: Container(
            width: double.infinity,
            height: SizeVariables.getHeight(context) * 0.99,
            // color: Colors.amber,
            padding: EdgeInsets.only(
                left: SizeVariables.getWidth(context) * 0.02,
                top: SizeVariables.getHeight(context) * 0.02,
                right: SizeVariables.getWidth(context) * 0.02),
            child: isLoading
                ? Center(
                    // child: CircularProgressIndicator(),
                    child: UserRegularisationShimmer(),
                  )
                : provider['data'] == 'No regularization request found' ||
                        provider == {}
                    ? Center(
                        child: Lottie.asset('assets/json/ToDo.json'),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => Column(
                          children: [
                            InkWell(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                        content: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Approver Remarks',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black)),
                                            Container(
                                              child: Text(
                                                  provider['data'][index]
                                                          ['approve_remarks'] ??
                                                      'NA',
                                                  textAlign: TextAlign.start),
                                            )
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text('Close',
                                                  style: TextStyle(
                                                      color: Colors.black)))
                                        ],
                                      )),
                              child: ContainerStyle(
                                height: SizeVariables.getHeight(context) * 0.12,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  // color: Colors.red,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Container(
                                          height: double.infinity,
                                          // color: Colors.red,
                                          padding: EdgeInsets.only(
                                              left: SizeVariables.getWidth(
                                                      context) *
                                                  0.05),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                provider['data'][index]['name'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey,
                                                        fontSize: 16),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    provider['data'][index]
                                                        ['attendance_date'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: const Color
                                                                .fromARGB(255,
                                                                127, 182, 129)),
                                                  ),
                                                  // Text(
                                                  //   '-',
                                                  //   style: Theme.of(context).textTheme.bodyText1,
                                                  // ),
                                                  // Text(
                                                  //   value.leaveList.data!
                                                  //       .data![index].dates!.last,
                                                  //   style: Theme.of(context)
                                                  //       .textTheme
                                                  //       .bodyText1!
                                                  //       .copyWith(
                                                  //           color: const Color
                                                  //                   .fromARGB(
                                                  //               255, 248, 112, 78)),
                                                  // ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.loose,
                                        child: Container(
                                          height: double.infinity,
                                          // color: Colors.green,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // Text('|',
                                                    //     style: Theme.of(context)
                                                    //         .textTheme
                                                    //         .bodyText2),
                                                    // SizedBox(
                                                    //     width:
                                                    //         SizeVariables.getWidth(context) *
                                                    //             0.005),
                                                    // Text(
                                                    //     // value
                                                    //     //     .leaveList
                                                    //     //     .data!
                                                    //     //     .data![index]
                                                    //     //     .dates!
                                                    //     //     .length
                                                    //     //     .toString(),
                                                    //     '${DateFormat('yyyy-MM-dd').parse(value.leaveList.data!.data![index].dates![1]).difference(DateFormat('yyyy-MM-dd').parse(value.leaveList.data!.data![index].dates![0])).inDays + 1}',
                                                    //     style: Theme.of(context)
                                                    //         .textTheme
                                                    //         .bodyText2!
                                                    //         .copyWith(
                                                    //             fontSize: 30,
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .normal)),
                                                    Text(
                                                        provider['data'][index]
                                                            ['checkin'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    248,
                                                                    112,
                                                                    78))),

                                                    // Column(
                                                    //   children: [
                                                    //     Text(
                                                    //       'Day(s)',
                                                    //       style: Theme.of(context)
                                                    //           .textTheme
                                                    //           .bodyText2!
                                                    //           .copyWith(
                                                    //               fontSize: 12),
                                                    //     ),
                                                    //   ],
                                                    // )
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // Text('|',
                                                    //     style: Theme.of(context)
                                                    //         .textTheme
                                                    //         .bodyText2),
                                                    // SizedBox(
                                                    //     width:
                                                    //         SizeVariables.getWidth(context) *
                                                    //             0.005),
                                                    // Text(
                                                    //     // value
                                                    //     //     .leaveList
                                                    //     //     .data!
                                                    //     //     .data![index]
                                                    //     //     .dates!
                                                    //     //     .length
                                                    //     //     .toString(),
                                                    //     '${DateFormat('yyyy-MM-dd').parse(value.leaveList.data!.data![index].dates![1]).difference(DateFormat('yyyy-MM-dd').parse(value.leaveList.data!.data![index].dates![0])).inDays + 1}',
                                                    //     style: Theme.of(context)
                                                    //         .textTheme
                                                    //         .bodyText2!
                                                    //         .copyWith(
                                                    //             fontSize: 30,
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .normal)),
                                                    Text(
                                                        provider['data'][index]
                                                            ['checkout'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    248,
                                                                    112,
                                                                    78))),

                                                    // Column(
                                                    //   children: [
                                                    //     Text(
                                                    //       'Day(s)',
                                                    //       style: Theme.of(context)
                                                    //           .textTheme
                                                    //           .bodyText2!
                                                    //           .copyWith(
                                                    //               fontSize: 12),
                                                    //     ),
                                                    //   ],
                                                    // )
                                                  ])
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Container(
                                          height: double.infinity,
                                          // color: Colors.blue,
                                          child: Center(
                                              child: provider['data'][index]
                                                          ['status'] ==
                                                      1
                                                  ? const Icon(Icons.check,
                                                      color: Colors.green)
                                                  : provider['data'][index]
                                                              ['status'] ==
                                                          2
                                                      ? const Icon(Icons.close,
                                                          color: Colors.red)
                                                      : const Icon(Icons.timer,
                                                          color: Colors.amber)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                height: SizeVariables.getHeight(context) * 0.02)
                          ],
                        ),
                        itemCount: provider['data'].length,
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
    Provider.of<AllRegularisationViewModel>(context, listen: false)
        .getAllRegularisations(dateFormat.format(dateRange.start),
            dateFormat.format(DateTime.now()))
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });

    print('dateRange re-selected: $dateRange');
    return dateRange;
  }
}
