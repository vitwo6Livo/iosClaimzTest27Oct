import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/res/components/date_range_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../../res/components/containerStyle.dart';
import '../../../../viewModel/compOffRequestViewModel.dart';
import '../../../config/mediaQuery.dart';

class PendingCompOffs extends StatefulWidget {
  final List<dynamic> pendingCompOffs;

  PendingCompOffs(this.pendingCompOffs);

  PendingCompOffsState createState() => PendingCompOffsState();
}

class PendingCompOffsState extends State<PendingCompOffs> {
  TextEditingController _compoffReason = TextEditingController();
  String? add;
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  var selectedValue;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  DateTimeRange dateRange = DateTimeRange(
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
  );

  @override
  Widget build(BuildContext context) {
    final start = dateRange.start;
    final end = dateRange.end;
    // final provider =
    //     Provider.of<CompOffManagerViewModel>(context).pendingCompOffData;
    final themeProvider = Provider.of<ThemeProvider>(context);

    // TODO: implement build
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.025,
          top: SizeVariables.getHeight(context) * 0.01,
          right: SizeVariables.getWidth(context) * 0.025),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: (themeProvider.darkTheme)
                                ? []
                                : [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 7,
                                      //offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                          ),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  barrierColor: Colors.black87.withOpacity(0.9),
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      content: Container(
                                        // color: Colors.amber,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'In: ',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Text(
                                                          widget.pendingCompOffs[
                                                                  index]
                                                              ['from_time'],
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'Out: ',
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Text(
                                                          widget.pendingCompOffs[
                                                              index]['to_time'],
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02,
                                            ),
                                            Row(
                                              children: [
                                                const Text('Applied On: '),
                                                Text(widget
                                                        .pendingCompOffs[index]
                                                    ['created_at'])
                                              ],
                                            ),
                                            SizedBox(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.02),
                                            Container(
                                              child: Text(
                                                "Description",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                // "Show reason for which Comp Off has been applied on Managers End (Designal)",
                                                widget.pendingCompOffs[index]
                                                        ['description'] ??
                                                    'REASON NOT GIVEN OR CHECKED IN DURING THE WEEKEND',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        fontSize: 16,
                                                        color: Colors.black),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            SizedBox(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.02,
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.edit_rounded,
                                                    color: Colors.black,
                                                  ),
                                                  Text(
                                                    "Reason",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Form(
                                              key: _key,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    // right: SizeVariables.getWidth(context) * 0.06,
                                                    // left: SizeVariables.getWidth(context) * 0.025,
                                                    top: 1.h),
                                                child: Container(
                                                  decoration:
                                                      (themeProvider.darkTheme)
                                                          ? BoxDecoration()
                                                          : BoxDecoration(
                                                              // border: Border.all(
                                                              //     color: Colors.amber, width: 2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              boxShadow:
                                                                  (themeProvider
                                                                          .darkTheme)
                                                                      ? []
                                                                      : [
                                                                          BoxShadow(
                                                                            color:
                                                                                Color.fromARGB(255, 62, 60, 60).withOpacity(0.5),
                                                                            spreadRadius:
                                                                                0,
                                                                            blurRadius:
                                                                                7,
                                                                            //offset: Offset(0, 3), // changes position of shadow
                                                                          ),
                                                                        ],
                                                            ),
                                                  child: ContainerStyle(
                                                    // margin: const EdgeInsets.only(right: 25),
                                                    // height: SizeVariables.getHeight(context) * 0.1,
                                                    height: 9.h,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        left: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.02,
                                                      ),
                                                      child: TextFormField(
                                                        controller:
                                                            _compoffReason,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          // border: OutlineInputBorder(
                                                          //   borderSide: BorderSide(color: Colors.grey),
                                                          // ),
                                                          // fillColor: Colors.grey,
                                                        ),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                        maxLines: 5,
                                                        validator: (value) {
                                                          if (value!.isEmpty ||
                                                              value == '') {
                                                            return 'Please enter Reason';
                                                          } else {
                                                            add = value;
                                                            return null;
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Provider.of<CompOffManagerViewModel>(
                                                      context,
                                                      listen: false)
                                                  .rejectCompoff(
                                                      context,
                                                      widget.pendingCompOffs[
                                                          index]['compoff_id'],
                                                      widget.pendingCompOffs[
                                                          index]);
                                            },
                                            child: Text(
                                              'Reject',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.black),
                                            )),
                                        TextButton(
                                          onPressed: () {
                                            final Map<String, dynamic>
                                                payLoadData = {
                                              'compoff_id':
                                                  widget.pendingCompOffs[index]
                                                      ['compoff_id'],
                                              'user_id': widget
                                                  .pendingCompOffs[index]['id']
                                            };
                                            Provider.of<CompOffManagerViewModel>(
                                                    context,
                                                    listen: false)
                                                .approveCompOff(
                                                    context,
                                                    widget
                                                        .pendingCompOffs[index],
                                                    payLoadData,
                                                    widget.pendingCompOffs[
                                                        index]['compoff_id']);
                                            // Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Approve',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(color: Colors.black),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: ContainerStyle(
                                height: SizeVariables.getHeight(context) * 0.15,
                                child: Container(
                                    height: double.infinity,
                                    // color: Colors.green,
                                    padding: EdgeInsets.only(
                                        top: SizeVariables.getHeight(context) *
                                            0.008),
                                    child: Column(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            width: double.infinity,
                                            // color: Colors.red,
                                            // padding: EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.02),
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  flex: 5,
                                                  fit: FlexFit.tight,
                                                  child: Container(
                                                    height: double.infinity,
                                                    // color: Colors.amber,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .all(SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.01),
                                                            child: widget.pendingCompOffs[
                                                                            index]
                                                                        [
                                                                        'profile_photo'] ==
                                                                    null
                                                                ? CircleAvatar(
                                                                    radius: SizeVariables.getWidth(
                                                                            context) *
                                                                        0.08,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                    backgroundImage:
                                                                        const AssetImage(
                                                                            'assets/img/profilePic.jpg'),
                                                                    // child: const Icon(Icons.account_box, color: Colors.white),
                                                                  )
                                                                : CachedNetworkImage(
                                                                    imageUrl:
                                                                        '${widget.pendingCompOffs[index]['profile_photo']}',
                                                                    imageBuilder:
                                                                        (context,
                                                                                imageProvider) =>
                                                                            CircleAvatar(
                                                                      radius: SizeVariables.getWidth(
                                                                              context) *
                                                                          0.08,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                      backgroundImage:
                                                                          imageProvider,
                                                                      // child: const Icon(Icons.account_box, color: Colors.white),
                                                                    ),
                                                                    placeholder: (context,
                                                                            url) =>
                                                                        Shimmer
                                                                            .fromColors(
                                                                      baseColor:
                                                                          Colors
                                                                              .grey[400]!,
                                                                      highlightColor: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          120,
                                                                          120,
                                                                          120),
                                                                      child: CircleAvatar(
                                                                          radius:
                                                                              SizeVariables.getWidth(context) * 0.08),
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        CircleAvatar(
                                                                      radius: SizeVariables.getWidth(
                                                                              context) *
                                                                          0.08,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green,
                                                                      backgroundImage:
                                                                          const AssetImage(
                                                                              'assets/img/profilePic.jpg'),
                                                                      // child: const Icon(Icons.account_box, color: Colors.white),
                                                                    ),
                                                                  )),
                                                        // Padding(
                                                        //   padding: EdgeInsets.all(
                                                        //       SizeVariables.getWidth(
                                                        //               context) *
                                                        //           0.01),
                                                        //   child: CircleAvatar(
                                                        //     // backgroundColor: Colors.red,
                                                        //     radius:
                                                        //         SizeVariables.getWidth(
                                                        //                 context) *
                                                        //             0.08,
                                                        //   ),
                                                        // ),
                                                        Expanded(
                                                          child: Container(
                                                            height:
                                                                double.infinity,
                                                            // color: Colors.orange,
                                                            padding: EdgeInsets.only(
                                                                left: SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.005,
                                                                top: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.008),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                FittedBox(
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  child: Text(
                                                                    widget.pendingCompOffs[
                                                                            index]
                                                                        [
                                                                        'emp_name'],
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  widget.pendingCompOffs[
                                                                          index]
                                                                      [
                                                                      'emp_code'],
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Flexible(
                                                //   flex: 1,
                                                //   fit: FlexFit.tight,
                                                //   child: Center(
                                                //     child: PopupMenuButton(
                                                //       icon: Icon(
                                                //           Icons.arrow_drop_down,
                                                //           color:
                                                //               Theme.of(context)
                                                //                   .accentColor),
                                                //       // color: const Color.fromARGB(
                                                //       //     255, 77, 76, 76),
                                                //       color: Theme.of(context)
                                                //           .colorScheme
                                                //           .secondary,
                                                //       itemBuilder: (context) =>
                                                //           [
                                                //         PopupMenuItem(
                                                //           value: 1,
                                                //           child: Text('Approve',
                                                //               style: Theme.of(
                                                //                       context)
                                                //                   .textTheme
                                                //                   .bodyText1!
                                                //                   .copyWith(
                                                //                       color: Colors
                                                //                           .white)),
                                                //         ),
                                                //         PopupMenuItem(
                                                //           value: 0,
                                                //           child: Text('Reject',
                                                //               style: Theme.of(
                                                //                       context)
                                                //                   .textTheme
                                                //                   .bodyText1!
                                                //                   .copyWith(
                                                //                       color: Colors
                                                //                           .white)),
                                                //         ),
                                                //       ],
                                                //       onSelected:
                                                //           (value) async {
                                                //         setState(() {
                                                //           selectedValue = value;
                                                //         });
                                                //         // Provider.of<CompOffManagerViewModel>(
                                                //         //         context,
                                                //         //         listen: false)
                                                //         //     .manageCompOff(
                                                //         //         provider[index]
                                                //         //             ['compoff_id'],
                                                //         //         selectedValue,
                                                //         //         provider[index],
                                                //         //         context);
                                                //         if (selectedValue ==
                                                //             1) {
                                                //           final Map<String,
                                                //                   dynamic>
                                                //               payLoadData = {
                                                //             'compoff_id':
                                                //                 provider[index][
                                                //                     'compoff_id'],
                                                //             'user_id':
                                                //                 provider[index]
                                                //                     ['emp_id']
                                                //           };
                                                //           Provider.of<CompOffManagerViewModel>(
                                                //                   context,
                                                //                   listen: false)
                                                //               .approveCompOff(
                                                //                   context,
                                                //                   provider[
                                                //                       index],
                                                //                   payLoadData,
                                                //                   provider[
                                                //                           index]
                                                //                       [
                                                //                       'compoff_id']);
                                                //         } else {
                                                //           Provider.of<CompOffManagerViewModel>(
                                                //                   context,
                                                //                   listen: false)
                                                //               .rejectCompoff(
                                                //                   context,
                                                //                   provider[
                                                //                           index]
                                                //                       [
                                                //                       'compoff_id'],
                                                //                   provider[
                                                //                       index]);
                                                //         }
                                                //       },
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            width: double.infinity,
                                            // color: Colors.blue,
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  fit: FlexFit.tight,
                                                  child: Container(
                                                    height: double.infinity,
                                                    // color: Colors.amber,
                                                    padding: EdgeInsets.all(
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.02),
                                                    child: Text(
                                                        'Comp Off Date:',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 4,
                                                  fit: FlexFit.tight,
                                                  child: Container(
                                                    height: double.infinity,
                                                    // color: Colors.red,
                                                    child: Container(
                                                      height: double.infinity,
                                                      // color: Colors.amber,
                                                      padding: EdgeInsets.all(
                                                          SizeVariables
                                                                  .getWidth(
                                                                      context) *
                                                              0.02),
                                                      child: Text(
                                                          widget.pendingCompOffs[
                                                                  index]
                                                              ['compoff_date'],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: SizeVariables.getHeight(context) * 0.02,
                        )
                      ],
                    ),
                itemCount: widget.pendingCompOffs.length
                // provider['data'].length
                ),
          ),
        ],
      ),
    );
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
        context: context,
        builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.blue,
                canvasColor: Colors.blue,
                colorScheme: const ColorScheme.light(primary: Colors.blue),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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

    // Map<String, dynamic> _data = {'month': myMonth, 'year': myYears.toString()};

    print('dateRange: $dateRange');
    return dateRange;
  }
}
