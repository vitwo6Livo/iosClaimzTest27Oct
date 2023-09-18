import 'package:claimz/views/screens/requestLeaveScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../data/response/status.dart';
import '../../provider/theme_provider.dart';
import '../../res/components/containerStyle.dart';
import '../../viewModel/leaveListViewModel.dart';
import '../config/mediaQuery.dart';
import 'custom_page_route.dart';
import 'leaveScreen.dart';
import 'leaveScreenShimmer.dart';

class RequestLeaveNew extends StatefulWidget {
  @override
  State<RequestLeaveNew> createState() => _RequestLeaveNewState();
}

class _RequestLeaveNewState extends State<RequestLeaveNew> {
  LeaveListViewModel leaveListViewModel = LeaveListViewModel();
  String? text;

  @override
  void initState() {
    leaveListViewModel.getLeaveList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent,
        onPressed: () {
          Navigator.of(context).push(
            CustomPageRoute(
              child: RequestLeave(0, '', '', '', 0),
              direction: AxisDirection.up,
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 35,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
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
              ],
            ),
            SizedBox(width: SizeVariables.getWidth(context) * 0.02),
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'Leave History',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                    ),
              ),
            )
          ],
        ),
      ),
      body: ChangeNotifierProvider<LeaveListViewModel>(
        create: (context) => leaveListViewModel,
        child: Consumer<LeaveListViewModel>(builder: (context, value, child) {
          switch (value.leaveList.status) {
            case Status.LOADING:
              return LeaveScreenShimmer();
            case Status.ERROR:
              return Center(
                child: Lottie.asset('assets/json/ToDo.json',
                    height: 250, width: 250),
              );
            case Status.COMPLETED:
              return ListView.builder(
                itemBuilder: (context, index) {
                  if (value.leaveList.data!.data![index].dates!.isEmpty) {
                    print('');
                  } else if (value.leaveList.data!.data![index].dates!.length ==
                      1) {
                    text = method(
                        value.leaveList.data!.data![index].dates!.last,
                        value.leaveList.data!.data![index].dates!.last);
                  } else {
                    text = method(value.leaveList.data!.data![index].dates![0],
                        value.leaveList.data!.data![index].dates!.last);
                  }
                  return value.leaveList.data!.data!.isEmpty
                      ? Center(
                          child: Lottie.asset('assets/json/ToDo.json'),
                        )
                      : Column(
                          children: [
                            value.leaveList.data!.data![index].dates!.isEmpty
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      color: (themeProvider.darkTheme)
                                          ? Colors.black
                                          : Colors.white,
                                      child: InkWell(
                                        onTap: () => _leaveDetails(context),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: ContainerStyle(
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.12,
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.loose,
                                                    child: Container(
                                                      height: double.infinity,
                                                      // color: Colors.red,
                                                      padding: EdgeInsets.only(
                                                        left: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.05,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: width > 400
                                                                ? 7.w
                                                                : width < 300
                                                                    ? 8.w
                                                                    : 8.w,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(
                                                              10,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              border:
                                                                  Border.all(
                                                                width: 2,
                                                                color: const Color
                                                                    .fromARGB(
                                                                  255,
                                                                  165,
                                                                  157,
                                                                  157,
                                                                ),
                                                              ),
                                                            ),
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .contain,
                                                              child: value
                                                                      .leaveList
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .dates!
                                                                      .isEmpty
                                                                  ? Text(
                                                                      '0',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText2!
                                                                          .copyWith(
                                                                            fontSize:
                                                                                18.sp,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    )
                                                                  : Text(
                                                                      value
                                                                          .leaveList
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .dates!
                                                                          .length
                                                                          .toString(),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText2!
                                                                          .copyWith(
                                                                            fontSize:
                                                                                18.sp,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.02,
                                                  ),
                                                  Container(
                                                    child: Flexible(
                                                      flex: 1,
                                                      fit: FlexFit.loose,
                                                      child: Container(
                                                        height: double.infinity,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              width: 80,
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .contain,
                                                                child: Text(
                                                                  value
                                                                      .leaveList
                                                                      .data!
                                                                      .data![
                                                                          index]
                                                                      .leaveType
                                                                      .toString(),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: SizeVariables
                                                                      .getHeight(
                                                                          context) *
                                                                  0.006,
                                                            ),
                                                            Text(
                                                              'Day(s)',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText2!
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.036,
                                                  ),
                                                  Container(
                                                    width: 184,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          flex: 1,
                                                          fit: FlexFit.loose,
                                                          child: Container(
                                                            height:
                                                                double.infinity,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      value
                                                                          .leaveList
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .dates![
                                                                              0]
                                                                          .toString(),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                            color:
                                                                                const Color.fromARGB(
                                                                              255,
                                                                              127,
                                                                              182,
                                                                              129,
                                                                            ),
                                                                          ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.01,
                                                                    ),
                                                                    Text(
                                                                      value.leaveList.data!.data![index].dates!.length == 1
                                                                          ? value
                                                                              .leaveList
                                                                              .data!
                                                                              .data![
                                                                                  index]
                                                                              .dates![
                                                                                  0]
                                                                              .toString()
                                                                          : value
                                                                              .leaveList
                                                                              .data!
                                                                              .data![index]
                                                                              .dates!
                                                                              .last,
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .copyWith(
                                                                            color:
                                                                                const Color.fromARGB(
                                                                              255,
                                                                              248,
                                                                              112,
                                                                              78,
                                                                            ),
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 10),
                                                          child: SizedBox(
                                                            height: 22,
                                                            child: Center(
                                                              child: value
                                                                          .leaveList
                                                                          .data!
                                                                          .data![
                                                                              index]
                                                                          .status ==
                                                                      1
                                                                  ? Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          5.0,
                                                                        ),
                                                                        color: const Color
                                                                            .fromARGB(
                                                                          255,
                                                                          103,
                                                                          122,
                                                                          114,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(
                                                                          left:
                                                                              5.0,
                                                                          right:
                                                                              5.0,
                                                                          top:
                                                                              2.5,
                                                                          bottom:
                                                                              2.5,
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              FittedBox(
                                                                            fit:
                                                                                BoxFit.contain,
                                                                            child:
                                                                                Text(
                                                                              'Approved',
                                                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                    color: const Color.fromARGB(255, 109, 247, 143),
                                                                                    fontSize: 18.sp,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : value.leaveList.data!.data![index]
                                                                              .status ==
                                                                          2
                                                                      ? Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0),
                                                                            color:
                                                                                const Color(0xffffeded),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 5.0,
                                                                              right: 5.0,
                                                                              top: 2.5,
                                                                              bottom: 2.5,
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: FittedBox(
                                                                                fit: BoxFit.contain,
                                                                                child: Text(
                                                                                  'Rejected',
                                                                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                        color: const Color(0xffff1414),
                                                                                        fontSize: 18.sp,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : InkWell(
                                                                          onTap: () =>
                                                                              Navigator.of(context).push(
                                                                            MaterialPageRoute(
                                                                              builder: (context) => RequestLeave(
                                                                                1,
                                                                                value.leaveList.data!.data![index].dates,
                                                                                value.leaveList.data!.data![index].subject!,
                                                                                value.leaveList.data!.data![index].description!,
                                                                                value.leaveList.data!.data![index].leaveId!,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(5.0),
                                                                              color: const Color.fromARGB(
                                                                                112,
                                                                                241,
                                                                                210,
                                                                                100,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                left: 5.0,
                                                                                right: 5.0,
                                                                                top: 2.5,
                                                                                bottom: 2.5,
                                                                              ),
                                                                              child: Center(
                                                                                child: FittedBox(
                                                                                  fit: BoxFit.contain,
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        "Pending",
                                                                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                              color: Colors.amber,
                                                                                              fontSize: 18.sp,
                                                                                            ),
                                                                                      ),
                                                                                      const Icon(Icons.edit, color: Colors.white),
                                                                                    ],
                                                                                  ),
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
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        );
                },
                itemCount: value.leaveList.data!.data!.length,
              );
            default:
          }
          return Container();
        }),
      ),
    );
  }

  Future<dynamic> _leaveDetails(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: SizedBox(
          height: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: 'Leave type: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Sick leave 1',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Leave duration: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Full day',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'From date',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        '2023-08-23',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'To date',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        '2023-08-23',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reason:',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    'Depending upon your condition, you can say that you have an appointment with your lawyer or a bank manager or a chartered accountant or other similar types of official who generally works on weekdays only. To make an excuse true, you can take an appointment deliberately and take a day off.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Remarks: ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    'Okey',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
