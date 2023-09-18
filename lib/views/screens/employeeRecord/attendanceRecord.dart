import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../res/components/containerStyle.dart';
import '../../../res/components/newAlertDialog.dart';
import '../../../viewModel/reportingTreeViewModel.dart';
import '../../config/mediaQuery.dart';
import '../mapScreen.dart';

class EmployeeAttendanceReport extends StatefulWidget {
  final Map<String, dynamic> provider;

  EmployeeAttendanceReport(this.provider);

  EmployeeAttendanceReportState createState() =>
      EmployeeAttendanceReportState();
}

class EmployeeAttendanceReportState extends State<EmployeeAttendanceReport> {
  @override
  void initState() {
    // TODO: implement initState
    print('EMPLOYEEEEEE RECORDDDSSSSS: ${widget.provider}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    DateFormat day = DateFormat('dd');
    DateFormat monthFormat = DateFormat('EEE');
    DateFormat logInOutTime = DateFormat('HH:mm:ss');
    DateFormat yyyyMmDd = DateFormat('yyyy-MM-dd');

    DateFormat secondMonthFormat = DateFormat('MMMM');

    // TODO: implement build
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: (themeProvider.darkTheme)
            ? Colors.black
            : Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.025,
          top: SizeVariables.getHeight(context) * 0.02,
          right: SizeVariables.getWidth(context) * 0.025,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: SizeVariables.getWidth(context) * 0.05,
                right: SizeVariables.getWidth(context) * 0.04,
              ),
              child: ContainerStyle(
                height: SizeVariables.getHeight(context) * 0.15,
                child: widget.provider['attendance'].isEmpty ||
                        widget.provider == {}
                    ? Center(
                        child: Text('No Record Found',
                            style: Theme.of(context).textTheme.bodyText1),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.08,
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const CircleAvatar(
                                                  radius: 9,
                                                  backgroundColor: Colors.green,
                                                ),
                                                SizedBox(
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.01,
                                                ),
                                                Container(
                                                  child: Text(
                                                    widget.provider['count'][0]
                                                            ['present']
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontSize: 18.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: Text(
                                                'Present',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 8.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const CircleAvatar(
                                                  radius: 9,
                                                  backgroundColor: Colors.blue,
                                                ),
                                                SizedBox(
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.01,
                                                ),
                                                Container(
                                                  child: Text(
                                                    widget.provider['count'][0]
                                                            ['leavec']
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontSize: 18.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: Text(
                                                'Leave',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 8.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const CircleAvatar(
                                                  radius: 9,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 30, 233, 233),
                                                ),
                                                SizedBox(
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.01,
                                                ),
                                                Container(
                                                  child: Text(
                                                    widget.provider['count'][0]
                                                            ['holiday']
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontSize: 18.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: Text(
                                                'Holiday',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 8.sp),
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
                                child: Row(
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration:
                                                      const BoxDecoration(
                                                          // color: Colors.amber,
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.amber),
                                                ),
                                                SizedBox(
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.01,
                                                ),
                                                Container(
                                                  child: Text(
                                                    widget.provider['count'][0]
                                                            ['halfday']
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontSize: 18.sp),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: Text(
                                                'Half Day',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(fontSize: 8.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const CircleAvatar(
                                                  radius: 9,
                                                  backgroundColor: Colors.red,
                                                ),
                                                SizedBox(
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.01,
                                                ),
                                                Container(
                                                  child: Text(
                                                    widget.provider['count'][0]
                                                            ['absent']
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 18.sp,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: Text(
                                                'Absent',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 8.sp,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const CircleAvatar(
                                                  radius: 9,
                                                  backgroundColor: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: SizeVariables.getWidth(
                                                          context) *
                                                      0.01,
                                                ),
                                                Container(
                                                  child: Text(
                                                    widget.provider['count'][0]
                                                            ['weekend']
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 18.sp,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: Text(
                                                'Weekend',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      fontSize: 8.sp,
                                                    ),
                                              ),
                                            ),
                                          ],
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
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.02,
            ),
            Expanded(
              child: Container(
                // color: Colors.red,
                padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.01,
                    // top: SizeVariables.getHeight(context) * 0.01,
                    right: SizeVariables.getWidth(context) * 0.01),
                child:
                    widget.provider['attendance'].isEmpty ||
                            widget.provider == {}
                        ? Center(
                            child: Text('No Record Found',
                                style: Theme.of(context).textTheme.bodyText1),
                          )
                        : ListView.builder(
                            // reverse: true,
                            itemBuilder: (context, index) => Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          // Future.delayed(
                                          //     const Duration(seconds: 8),
                                          //     () => Navigator.of(context).pop());
                                          return CupertinoAlertDialog(
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: Colors.green,
                                                    ),
                                                    widget.provider['attendance']
                                                                        [index][
                                                                    'address'] ==
                                                                null ||
                                                            widget.provider['attendance']
                                                                        [index][
                                                                    'address'] ==
                                                                ''
                                                        ? Text('----',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black))
                                                        : Expanded(
                                                            // fit: BoxFit.contain,
                                                            child: Text(
                                                              widget.provider[
                                                                          'attendance']
                                                                      [index]
                                                                  ['address'],
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        left: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.2,
                                                        top: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.006,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .timer_outlined,
                                                            color: Color(
                                                                0xffF59F23),
                                                            size: 20,
                                                          ),
                                                          widget.provider['attendance']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'created_at'] ==
                                                                      null ||
                                                                  widget.provider['attendance']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'created_at'] ==
                                                                      ""
                                                              ? Text('--:--:--',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .grey,
                                                                      ))
                                                              : Text(
                                                                  logInOutTime
                                                                      .format(DateTime.parse(widget.provider['attendance'][index]
                                                                              [
                                                                              'created_at'])
                                                                          .toLocal())
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            88,
                                                                            151,
                                                                            91),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                    widget.provider['attendance']
                                                                        [index][
                                                                    'checkin_workstation'] ==
                                                                '' ||
                                                            widget.provider['attendance']
                                                                        [index][
                                                                    'checkin_workstation'] ==
                                                                null
                                                        ? Container()
                                                        : Container(
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                    widget.provider['attendance'][index]['checkin_workstation'] ==
                                                                            'Office'
                                                                        ? Icons
                                                                            .business_center
                                                                        : widget.provider['attendance'][index]['checkin_workstation'] ==
                                                                                'Offsite'
                                                                            ? Icons
                                                                                .home
                                                                            : Icons
                                                                                .person,
                                                                    color: const Color(
                                                                        0xffF59F23),
                                                                    size: 20),
                                                                Text(widget.provider[
                                                                            'attendance']
                                                                        [index][
                                                                    'checkin_workstation'])
                                                              ],
                                                            ),
                                                          )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.02,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: Colors.red),
                                                    widget.provider['attendance']
                                                                        [index][
                                                                    'checkout_address'] ==
                                                                null ||
                                                            widget.provider['attendance']
                                                                        [index][
                                                                    'checkout_address'] ==
                                                                ''
                                                        ? Text('----',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black))
                                                        : Expanded(
                                                            // fit: BoxFit.contain,
                                                            child: Text(
                                                              widget.provider[
                                                                          'attendance']
                                                                      [index][
                                                                  'checkout_address'],
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                        left: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.2,
                                                        top: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.006,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .timer_outlined,
                                                            color: Color(
                                                                0xffF59F23),
                                                            size: 20,
                                                          ),
                                                          widget.provider['attendance']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'checkout_time'] ==
                                                                      null ||
                                                                  widget.provider['attendance']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'checkout_time'] ==
                                                                      ""
                                                              ? Text('--:--:--',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .grey,
                                                                      ))
                                                              : Text(
                                                                  logInOutTime
                                                                      .format(DateTime.parse(widget.provider['attendance'][index]
                                                                              [
                                                                              'checkout_time'])
                                                                          .toLocal())
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            173,
                                                                            78,
                                                                            70),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                    widget.provider['attendance']
                                                                        [index][
                                                                    'checkout_workstation'] ==
                                                                '' ||
                                                            widget.provider['attendance']
                                                                        [index][
                                                                    'checkout_workstation'] ==
                                                                null
                                                        ? Container()
                                                        : Container(
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                    widget.provider['attendance'][index]['checkout_workstation'] ==
                                                                            'Office'
                                                                        ? Icons
                                                                            .business_center
                                                                        : widget.provider['attendance'][index]['checkout_workstation'] ==
                                                                                'Offsite'
                                                                            ? Icons
                                                                                .home
                                                                            : Icons
                                                                                .person,
                                                                    color: const Color(
                                                                        0xffF59F23),
                                                                    size: 20),
                                                                Text(widget.provider[
                                                                            'attendance']
                                                                        [index][
                                                                    'checkout_workstation'])
                                                              ],
                                                            ),
                                                          )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.02,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Working Time: ',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                    Container(
                                                      // color: Colors
                                                      //     .green,
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.av_timer,
                                                            color: Colors.black,
                                                            size: 17,
                                                          ),
                                                          SizedBox(
                                                            width: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.002,
                                                          ),
                                                          widget.provider[
                                                                              'attendance'][index]
                                                                          [
                                                                          'checkout_time'] ==
                                                                      "" ||
                                                                  widget.provider['attendance']
                                                                              [index]
                                                                          [
                                                                          'checkout_time'] ==
                                                                      null ||
                                                                  widget.provider['attendance']
                                                                              [index]
                                                                          [
                                                                          'created_at'] ==
                                                                      "" ||
                                                                  widget.provider['attendance']
                                                                              [index]
                                                                          ['created_at'] ==
                                                                      null
                                                              ? Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.002),
                                                                  child: Text(
                                                                    "--:--:--",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1,
                                                                  ),
                                                                )
                                                              : Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: SizeVariables.getHeight(
                                                                              context) *
                                                                          0.002),
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    child:
                                                                        Container(
                                                                      width: SizeVariables.getWidth(
                                                                              context) *
                                                                          0.14,
                                                                      // color: Colors.black,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          FittedBox(
                                                                            fit:
                                                                                BoxFit.contain,
                                                                            child:
                                                                                Text(
                                                                              '${DateTime.parse(widget.provider['attendance'][index]['checkout_time']).difference(DateTime.parse(widget.provider['attendance'][index]['created_at'])).inHours}',
                                                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 13.sp, color: Colors.black),
                                                                            ),
                                                                          ),
                                                                          FittedBox(
                                                                            fit:
                                                                                BoxFit.contain,
                                                                            child:
                                                                                Text(
                                                                              'H',
                                                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black, fontSize: 12),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                SizeVariables.getWidth(context) * 0.015,
                                                                          ),
                                                                          FittedBox(
                                                                            fit:
                                                                                BoxFit.contain,
                                                                            child:
                                                                                Text(
                                                                              '${DateTime.parse(widget.provider['attendance'][index]['checkout_time']).difference(DateTime.parse(widget.provider['attendance'][index]['created_at'])).inMinutes % 60}',
                                                                              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 13.sp, color: Colors.black),
                                                                            ),
                                                                          ),
                                                                          FittedBox(
                                                                            fit:
                                                                                BoxFit.contain,
                                                                            child:
                                                                                Text(
                                                                              'm',
                                                                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black, fontSize: 12),
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
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context); //close Dialog
                                                },
                                                child: Text(
                                                  'Close',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Map<String, dynamic> data = {
                                                    'user_id': widget.provider[
                                                            'attendance'][index]
                                                        ['user_id'],
                                                    'date': DateFormat(
                                                            'yyyy-MM-dd')
                                                        .format(DateTime.parse(
                                                            widget.provider[
                                                                        'attendance']
                                                                    [index]
                                                                ['created_at']))
                                                  };

                                                  print(
                                                      'DATAAAAAAAAAAAAA: $data');

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MapScreen(data)));
                                                },
                                                child: Text(
                                                  'Location',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: SizeVariables.getWidth(context) *
                                            0.033,
                                        right: SizeVariables.getWidth(context) *
                                            0.03),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: (themeProvider.darkTheme)
                                            ? []
                                            : [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 0,
                                                  blurRadius: 7,
                                                  //offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                      ),
                                      child: ContainerStyle(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.1,
                                          child: Container(
                                            height: double.infinity,
                                            // color: Colors.green,
                                            // padding: EdgeInsets.only(left: SizeVariables.getWidth(context) * 0.02),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: SizeVariables.getWidth(
                                                          context) *
                                                      0.02),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: double.infinity,
                                                    // color: Colors.pink,
                                                    padding: EdgeInsets.only(
                                                        left: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.02,
                                                        right: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.02),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        widget.provider['attendance']
                                                                        [index][
                                                                    'attendance_status'] ==
                                                                0
                                                            ? const CircleAvatar(
                                                                radius: 8,
                                                                backgroundColor:
                                                                    Colors.red,
                                                              )
                                                            : widget.provider['attendance']
                                                                            [index]
                                                                        [
                                                                        'attendance_status'] ==
                                                                    1
                                                                ?
                                                                // const CircleAvatar(
                                                                //     radius: 8,
                                                                //     backgroundColor:
                                                                //         Colors
                                                                //             .amber,
                                                                //   )
                                                                Container(
                                                                    width: 16,
                                                                    height: 16,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                            // color: Colors.amber,
                                                                            shape: BoxShape
                                                                                .circle,
                                                                            gradient:
                                                                                LinearGradient(begin: Alignment.center, end: Alignment(0.05, 0.004), colors: [
                                                                              Colors.amber,
                                                                              Colors.red
                                                                            ])),
                                                                  )
                                                                : widget.provider['attendance'][index]
                                                                            [
                                                                            'attendance_status'] ==
                                                                        2
                                                                    ? const CircleAvatar(
                                                                        radius:
                                                                            8,
                                                                        backgroundColor:
                                                                            Colors.green,
                                                                      )
                                                                    : widget.provider['attendance'][index]['attendance_status'] ==
                                                                            3
                                                                        ? const CircleAvatar(
                                                                            radius:
                                                                                8,
                                                                            backgroundColor: Color.fromARGB(
                                                                                255,
                                                                                30,
                                                                                233,
                                                                                233),
                                                                          )
                                                                        : widget.provider['attendance'][index]['attendance_status'] == 4
                                                                            ? const CircleAvatar(
                                                                                radius: 8,
                                                                                backgroundColor: Colors.blue,
                                                                              )
                                                                            : const CircleAvatar(
                                                                                radius: 8,
                                                                                backgroundColor: Colors.grey,
                                                                              ),

                                                        // CircleAvatar(
                                                        //   radius: 8,
                                                        //   backgroundColor: widget.provider[
                                                        //                       'attendance']
                                                        //                   [index][
                                                        //               'attendance_status'] ==
                                                        //           0
                                                        //       ? Colors.red
                                                        //       : widget.provider['attendance']
                                                        //                       [index][
                                                        //                   'attendance_status'] ==
                                                        //               1
                                                        //           ? Colors.amber
                                                        //           : widget.provider['attendance']
                                                        //                           [index]
                                                        //                       ['attendance_status'] ==
                                                        //                   2
                                                        //               ? Colors.green
                                                        //               : widget.provider['attendance'][index]['attendance_status'] == 3
                                                        //                   ? const Color.fromARGB(255, 30, 233, 233)
                                                        //                   : widget.provider['attendance'][index]['attendance_status'] == 4
                                                        //                       ? Colors.blue
                                                        //                       : Colors.grey,
                                                        // ),
                                                        SizedBox(
                                                            width: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.01),
                                                        Container(
                                                          // color: Colors.black,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                day.format(DateTime.parse(widget.provider['attendance']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'created_at'])
                                                                    .toLocal()),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .caption!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            30),
                                                              ),
                                                              Text(
                                                                monthFormat.format(DateTime.parse(widget.provider['attendance']
                                                                            [
                                                                            index]
                                                                        [
                                                                        'created_at'])
                                                                    .toLocal()),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1,
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                      height: double.infinity,
                                                      // color: Color.fromARGB(
                                                      //     255, 0, 255, 8),
                                                      // color: Colors.red,
                                                      child: widget.provider['attendance']
                                                                      [index][
                                                                  'attendance_status'] ==
                                                              5
                                                          ? Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: const [
                                                                  Text(
                                                                      'Weekend',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18)),
                                                                ],
                                                              ),
                                                            )
                                                          : widget.provider['attendance']
                                                                          [index]
                                                                      ['attendance_status'] ==
                                                                  0
                                                              ? Center(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: const [
                                                                      Text(
                                                                          'Absent',
                                                                          style:
                                                                              TextStyle(fontSize: 18)),
                                                                    ],
                                                                  ),
                                                                )
                                                              : widget.provider['attendance'][index]['attendance_status'] == 3
                                                                  ? Center(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: const [
                                                                          Text(
                                                                              'Holiday',
                                                                              style: TextStyle(fontSize: 18)),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : widget.provider['attendance'][index]['attendance_status'] == 4
                                                                      ? Center(
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.end,
                                                                            children: const [
                                                                              Text('Leave', style: TextStyle(fontSize: 18)),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Flexible(
                                                                              flex: 1,
                                                                              fit: FlexFit.loose,
                                                                              child: Container(
                                                                                height: double.infinity,
                                                                                // color: Colors.blue,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                  children: [
                                                                                    const Icon(
                                                                                      Icons.timer_outlined,
                                                                                      color: Color(0xffF59F23),
                                                                                      size: 20,
                                                                                    ),
                                                                                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                                                                                    const Icon(
                                                                                      Icons.timer_outlined,
                                                                                      color: Color(0xffF59F23),
                                                                                      size: 20,
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
                                                                                // color: Colors.pink,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    widget.provider['attendance'][index]['created_at'] == null || widget.provider['attendance'][index]['created_at'] == ""
                                                                                        ? Text('--:--:--',
                                                                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                                  fontSize: 16,
                                                                                                  color: Colors.grey,
                                                                                                ))
                                                                                        : Text(
                                                                                            logInOutTime.format(DateTime.parse(widget.provider['attendance'][index]['created_at']).toLocal()).toString(),
                                                                                            style: const TextStyle(
                                                                                              fontStyle: FontStyle.italic,
                                                                                              color: Color.fromARGB(255, 41, 77, 43),
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontSize: 15,
                                                                                            ),
                                                                                          ),
                                                                                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                                                                                    widget.provider['attendance'][index]['checkout_time'] == null || widget.provider['attendance'][index]['checkout_time'] == ""
                                                                                        ? Text('--:--:--',
                                                                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                                  fontSize: 16,
                                                                                                  color: Colors.grey,
                                                                                                ))
                                                                                        : Text(
                                                                                            logInOutTime.format(DateTime.parse(widget.provider['attendance'][index]['checkout_time']).toLocal()).toString(),
                                                                                            style: const TextStyle(
                                                                                              fontStyle: FontStyle.italic,
                                                                                              color: Color.fromARGB(255, 96, 38, 33),
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontSize: 15,
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
                                                  Flexible(
                                                    flex: 1,
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                        height: double.infinity,
                                                        // color: Colors.blue,
                                                        padding: EdgeInsets.only(
                                                            right: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.02),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  // color: Colors
                                                                  //     .green,
                                                                  child: widget.provider['attendance'][index]['attendance_status'] == 0 ||
                                                                          widget.provider['attendance'][index]['attendance_status'] ==
                                                                              3 ||
                                                                          widget.provider['attendance'][index]['attendance_status'] ==
                                                                              4 ||
                                                                          widget.provider['attendance'][index]['attendance_status'] ==
                                                                              5
                                                                      ? Container()
                                                                      : Row(
                                                                          children: [
                                                                            const Icon(
                                                                              Icons.av_timer,
                                                                              color: Colors.amber,
                                                                              size: 17,
                                                                            ),
                                                                            SizedBox(
                                                                              width: SizeVariables.getWidth(context) * 0.002,
                                                                            ),
                                                                            widget.provider['attendance'][index]['checkout_time'] == "" || widget.provider['attendance'][index]['checkout_time'] == null || widget.provider['attendance'][index]['created_at'] == "" || widget.provider['attendance'][index]['created_at'] == null
                                                                                ? Padding(
                                                                                    padding: EdgeInsets.only(left: SizeVariables.getHeight(context) * 0.002),
                                                                                    child: Text(
                                                                                      "--:--:--",
                                                                                      style: Theme.of(context).textTheme.bodyText1,
                                                                                    ),
                                                                                  )
                                                                                : Padding(
                                                                                    padding: EdgeInsets.only(left: SizeVariables.getHeight(context) * 0.002),
                                                                                    child: FittedBox(
                                                                                      fit: BoxFit.contain,
                                                                                      child: Container(
                                                                                        width: SizeVariables.getWidth(context) * 0.14,
                                                                                        // color: Colors.black,
                                                                                        child: Row(
                                                                                          children: [
                                                                                            FittedBox(
                                                                                              fit: BoxFit.contain,
                                                                                              child: Text(
                                                                                                '${DateTime.parse(widget.provider['attendance'][index]['checkout_time']).difference(DateTime.parse(widget.provider['attendance'][index]['created_at'])).inHours}',
                                                                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
                                                                                              ),
                                                                                            ),
                                                                                            FittedBox(
                                                                                              fit: BoxFit.contain,
                                                                                              child: Text(
                                                                                                'H',
                                                                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.amber, fontSize: 12),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: SizeVariables.getWidth(context) * 0.015,
                                                                                            ),
                                                                                            FittedBox(
                                                                                              fit: BoxFit.contain,
                                                                                              child: Text(
                                                                                                '${DateTime.parse(widget.provider['attendance'][index]['checkout_time']).difference(DateTime.parse(widget.provider['attendance'][index]['created_at'])).inMinutes % 60}',
                                                                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
                                                                                              ),
                                                                                            ),
                                                                                            FittedBox(
                                                                                              fit: BoxFit.contain,
                                                                                              child: Text(
                                                                                                'm',
                                                                                                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.amber, fontSize: 12),
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
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      SizeVariables.getHeight(context) * 0.02,
                                )
                              ],
                            ),
                            itemCount: widget.provider['attendance'].length,
                          ),
              ),
            ),
          ],
        ));
  }
}
