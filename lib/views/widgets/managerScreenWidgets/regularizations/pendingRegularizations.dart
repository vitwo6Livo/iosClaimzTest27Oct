import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../../res/components/alert_dialog.dart';
import '../../../../res/components/containerStyle.dart';
import '../../../../viewModel/regularisationRequestViewModel.dart';
import '../../../config/mediaQuery.dart';

class PendingRegulazations extends StatefulWidget {
  PendingRegulazationsState createState() => PendingRegulazationsState();
}

class PendingRegulazationsState extends State<PendingRegulazations> {
  DateFormat day = DateFormat('dd');
  DateFormat monthFormat = DateFormat('MMM');
  DateFormat yearFormat = DateFormat('yyyy');
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  TextEditingController _reason = TextEditingController();
  String? add;
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  var selectedValue;

  Future<void> refresh() async {
    await Provider.of<RegularisationRequestViewModel>(context, listen: false)
        .getRegularisationRequest(dateFormat.format(DateTime.now()),
            dateFormat.format(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegularisationRequestViewModel>(context)
        .pendingRegularisation;
    final themeProvider = Provider.of<ThemeProvider>(context);
    // TODO: implement build
    return RefreshIndicator(
      onRefresh: refresh,
      color: Colors.amber,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(
            left: SizeVariables.getWidth(context) * 0.025,
            top: SizeVariables.getHeight(context) * 0.01,
            right: SizeVariables.getWidth(context) * 0.025),
        child: ListView.builder(
            itemBuilder: (context, index) => Column(
                  children: [
                    InkWell(
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
                                          mainAxisAlignment: provider[index]
                                                      ['checkin'] ==
                                                  ''
                                              ? MainAxisAlignment.start
                                              : MainAxisAlignment.spaceBetween,
                                          children: [
                                            provider[index]['checkin'] == ''
                                                ? Container()
                                                : Container(
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
                                                          provider[index]
                                                              ['checkin'],
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
                                            provider[index]['checkout'] == ''
                                                ? Container()
                                                : Container(
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
                                                          provider[index]
                                                              ['checkout'],
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
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.02,
                                      ),
                                      Row(
                                        children: [
                                          const Text('Applied On: '),
                                          Text(provider[index]['updated_at'])
                                        ],
                                      ),
                                      SizedBox(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.02,
                                      ),
                                      Container(
                                        child: Text(
                                          "Description",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            provider[index]['description'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeVariables.getHeight(context) *
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
                                                      color: Colors.black),
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
                                            decoration: (themeProvider
                                                    .darkTheme)
                                                ? BoxDecoration()
                                                : BoxDecoration(
                                                    // border: Border.all(
                                                    //     color: Colors.amber, width: 2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: (themeProvider
                                                            .darkTheme)
                                                        ? []
                                                        : [
                                                            BoxShadow(
                                                              color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      62,
                                                                      60,
                                                                      60)
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 0,
                                                              blurRadius: 7,
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
                                                  left: SizeVariables.getWidth(
                                                          context) *
                                                      0.02,
                                                ),
                                                child: TextFormField(
                                                  controller: _reason,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                    // border: OutlineInputBorder(
                                                    //   borderSide: BorderSide(color: Colors.grey),
                                                    // ),
                                                    // fillColor: Colors.grey,
                                                  ),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: Colors.black),
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
                                        var response = Provider.of<
                                                    RegularisationRequestViewModel>(
                                                context,
                                                listen: false)
                                            .postRejectRegularizationReqest(
                                                provider[index]
                                                    ['regularize_id'],
                                                selectedValue,
                                                provider[index],
                                                context,
                                                _reason.text)
                                            .then((value) => _reason.text = '');
                                      },
                                      child: Text(
                                        'Reject',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.black),
                                      )),
                                  TextButton(
                                    onPressed: () {
                                      var response = Provider.of<
                                                  RegularisationRequestViewModel>(
                                              context,
                                              listen: false)
                                          .postRegularizationReqest(
                                              provider[index]['regularize_id'],
                                              selectedValue,
                                              provider[index],
                                              context,
                                              _reason.text)
                                          .then((_) => _reason.text = '');
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
                      child: Container(
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
                        child: ContainerStyle(
                            height: SizeVariables.getHeight(context) * 0.16,
                            child: Container(
                                height: double.infinity,
                                // color: Colors.green,
                                child: Column(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Container(
                                        width: double.infinity,
                                        // color: Colors.red,
                                        // padding: const EdgeInsets.all(5),
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
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets.all(
                                                            SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.01),
                                                        child: provider[index][
                                                                    'profile_photo'] ==
                                                                null
                                                            ? CircleAvatar(
                                                                radius: SizeVariables
                                                                        .getWidth(
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
                                                                    '${provider[index]['profile_photo']}',
                                                                imageBuilder: (context,
                                                                        imageProvider) =>
                                                                    CircleAvatar(
                                                                  radius: SizeVariables
                                                                          .getWidth(
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
                                                                      Colors.grey[
                                                                          400]!,
                                                                  highlightColor:
                                                                      const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          120,
                                                                          120,
                                                                          120),
                                                                  child: CircleAvatar(
                                                                      radius: SizeVariables.getWidth(
                                                                              context) *
                                                                          0.08),
                                                                ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    CircleAvatar(
                                                                  radius: SizeVariables
                                                                          .getWidth(
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
                                                    Expanded(
                                                      child: Container(
                                                        height: double.infinity,
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
                                                                provider[index]
                                                                    ['name'],
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1,
                                                              ),
                                                            ),
                                                            Text(
                                                              provider[index]
                                                                  ['emp_code'],
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
                                            //       icon: Icon(Icons.arrow_drop_down,
                                            //           color: Theme.of(context)
                                            //               .accentColor),
                                            //       // color: const Color.fromARGB(
                                            //       //     255, 77, 76, 76),
                                            //       color: Theme.of(context)
                                            //           .colorScheme
                                            //           .secondary,
                                            //       itemBuilder: (context) => [
                                            //         PopupMenuItem(
                                            //           value: 1,
                                            //           child: Text('Approve',
                                            //               style: Theme.of(context)
                                            //                   .textTheme
                                            //                   .bodyText1!
                                            //                   .copyWith(
                                            //                       color: Colors
                                            //                           .white)),
                                            //         ),
                                            //         PopupMenuItem(
                                            //           value: 2,
                                            //           child: Text('Reject',
                                            //               style: Theme.of(context)
                                            //                   .textTheme
                                            //                   .bodyText1!
                                            //                   .copyWith(
                                            //                       color: Colors
                                            //                           .white)),
                                            //         ),
                                            //       ],
                                            //       onSelected: (value) async {
                                            //         setState(() {
                                            //           selectedValue = value;
                                            //         });
                                            //         print('Selected Value: $value');

                                            //         if (selectedValue == 1) {
                                            //           var response = Provider.of<
                                            //                       RegularisationRequestViewModel>(
                                            //                   context,
                                            //                   listen: false)
                                            //               .postRegularizationReqest(
                                            //                   provider[index]
                                            //                       ['regularize_id'],
                                            //                   selectedValue,
                                            //                   provider[index],
                                            //                   context);
                                            //         } else {
                                            //           var response = Provider.of<
                                            //                       RegularisationRequestViewModel>(
                                            //                   context,
                                            //                   listen: false)
                                            //               .postRejectRegularizationReqest(
                                            //                   provider[index]
                                            //                       ['regularize_id'],
                                            //                   selectedValue,
                                            //                   provider[index],
                                            //                   context);
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
                                              flex: 1,
                                              fit: FlexFit.tight,
                                              child: Container(
                                                height: double.infinity,
                                                // color: Colors.amber,
                                                padding: EdgeInsets.all(
                                                    SizeVariables.getWidth(
                                                            context) *
                                                        0.02),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 23,
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Text(
                                                            day.format(DateTime
                                                                    .parse(provider[
                                                                            index]
                                                                        [
                                                                        'attendance_date'])
                                                                .toLocal()),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        20)),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 15,
                                                      child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                '${monthFormat.format(DateTime.parse(provider[index]['attendance_date']).toLocal())}, ',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1),
                                                            Text(
                                                                yearFormat.format(DateTime.parse(
                                                                        provider[index]
                                                                            [
                                                                            'attendance_date'])
                                                                    .toLocal()),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 4,
                                              fit: FlexFit.tight,
                                              child: Container(
                                                height: double.infinity,
                                                // color: Colors.red,
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      flex: 3,
                                                      fit: FlexFit.tight,
                                                      child: Container(
                                                        height: double.infinity,
                                                        // color: Colors.green,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          // crossAxisAlignment:
                                                          //     CrossAxisAlignment
                                                          //         .center,
                                                          children: [
                                                            Flexible(
                                                              flex: 1,
                                                              fit:
                                                                  FlexFit.tight,
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                // color: Colors.blue,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    provider[index]['checkin'] ==
                                                                            ''
                                                                        ? Container()
                                                                        : Text(
                                                                            'In: ',
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyText1,
                                                                          ),
                                                                    provider[index]['checkout'] ==
                                                                            ''
                                                                        ? Container()
                                                                        : Text(
                                                                            'Out: ',
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyText1,
                                                                          )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              flex: 1,
                                                              fit:
                                                                  FlexFit.tight,
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                // color: Colors.amber,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    provider[index]['checkin'] ==
                                                                            ''
                                                                        ? Container()
                                                                        : Text(
                                                                            provider[index]['checkin'],
                                                                            style: provider[index]['reason'] == 'Check In' || provider[index]['reason'] == 'Check In & Check Out'
                                                                                ? Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.amber)
                                                                                : Theme.of(context).textTheme.bodyText1,
                                                                          ),
                                                                    provider[index]['checkout'] ==
                                                                            ''
                                                                        ? Container()
                                                                        : Text(
                                                                            provider[index]['checkout'],
                                                                            style: provider[index]['reason'] == 'Forgot To Check Out' || provider[index]['reason'] == 'Check In & Check Out'
                                                                                ? Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.amber)
                                                                                : Theme.of(context).textTheme.bodyText1,
                                                                          )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      flex: 2,
                                                      fit: FlexFit.tight,
                                                      child: Container(
                                                        height: double.infinity,
                                                        // color: Colors.blue,
                                                        child: Center(
                                                          child: Text(
                                                            provider[index]
                                                                ['reason'],
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
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
            itemCount: provider.length
            // provider['data'].length
            ),
      ),
    );
  }
}
