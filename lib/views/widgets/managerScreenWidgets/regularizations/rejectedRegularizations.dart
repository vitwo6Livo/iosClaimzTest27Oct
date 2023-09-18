import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../res/components/alert_dialog.dart';
import '../../../../res/components/containerStyle.dart';
import '../../../../viewModel/regularisationRequestViewModel.dart';
import '../../../config/mediaQuery.dart';

class RejectedRegularizations extends StatefulWidget {
  RejectedRegularizationsState createState() => RejectedRegularizationsState();
}

class RejectedRegularizationsState extends State<RejectedRegularizations> {
  DateFormat day = DateFormat('dd');
  DateFormat monthFormat = DateFormat('MMM');

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegularisationRequestViewModel>(context)
        .rejectedRegularisation;
    final themeProvider = Provider.of<ThemeProvider>(context);

    // TODO: implement build
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.025,
          top: SizeVariables.getHeight(context) * 0.01,
          right: SizeVariables.getWidth(context) * 0.025),
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
                                                        SizeVariables.getWidth(
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
                                                                Colors.green,
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
                                                                  Colors.green,
                                                              backgroundImage:
                                                                  imageProvider,
                                                              // child: const Icon(Icons.account_box, color: Colors.white),
                                                            ),
                                                            placeholder: (context,
                                                                    url) =>
                                                                Shimmer
                                                                    .fromColors(
                                                              baseColor: Colors
                                                                  .grey[400]!,
                                                              highlightColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      120,
                                                                      120,
                                                                      120),
                                                              child: CircleAvatar(
                                                                  radius: SizeVariables
                                                                          .getWidth(
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
                                                                  Colors.green,
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
                                                          fit: BoxFit.contain,
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
                                                          style:
                                                              Theme.of(context)
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
                                        Flexible(
                                            flex: 2,
                                            fit: FlexFit.tight,
                                            child: Center(
                                                child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: SizeVariables.getWidth(
                                                          context) *
                                                      0.02),
                                              child: Text(
                                                'Rejected',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: Colors.red,
                                                        fontSize: 12),
                                              ),
                                            )))
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
                                                  height: 22,
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                        day.format(DateTime
                                                                .parse(provider[
                                                                        index][
                                                                    'attendance_date'])
                                                            .toLocal()),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontSize: 20)),
                                                  ),
                                                ),
                                                Container(
                                                  height: 15,
                                                  child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                        monthFormat.format(DateTime
                                                                .parse(provider[
                                                                        index][
                                                                    'attendance_date'])
                                                            .toLocal()),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1),
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
                                                          fit: FlexFit.tight,
                                                          child: Container(
                                                            height:
                                                                double.infinity,
                                                            // color: Colors.blue,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  'In: ',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1,
                                                                ),
                                                                Text(
                                                                  'Out: ',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          flex: 1,
                                                          fit: FlexFit.tight,
                                                          child: Container(
                                                            height:
                                                                double.infinity,
                                                            // color: Colors.amber,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  provider[
                                                                          index]
                                                                      [
                                                                      'checkin'],
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1,
                                                                ),
                                                                Text(
                                                                  provider[
                                                                          index]
                                                                      [
                                                                      'checkout'],
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText1,
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
                                                        'Forgot To Sign Out',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
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
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  )
                ],
              ),
          itemCount: provider.length
          // provider['data'].length
          ),
    );
  }
}
