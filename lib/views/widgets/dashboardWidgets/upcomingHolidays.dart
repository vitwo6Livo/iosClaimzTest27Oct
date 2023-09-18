import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/models/dashboardModel.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../data/response/status.dart';
import '../../../res/components/containerStyle.dart';
import '../../../viewModel/claimsStatusViewModel.dart';
import '../../config/mediaQuery.dart';
import 'package:intl/intl.dart';
import '../../../viewModel/holidayViewModel.dart';
import 'package:provider/provider.dart';

class UpcomingHolidays extends StatefulWidget {
  UpcomingHolidaysState createState() => UpcomingHolidaysState();
}

class UpcomingHolidaysState extends State<UpcomingHolidays> {
  DateFormat dateFormat = DateFormat('EEE');

  // HolidayViewModel holidayViewModel = HolidayViewModel();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   holidayViewModel.getHolidayList(context);

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClaimzStatusViewModel>(context).claimzStatuss;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);

    // TODO: implement build
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RouteNames.upcomingHoldayList),
      child: Container(
        //color: Colors.red,
        child: ContainerStyle(
          height: height > 750
              ? 55.h
              : height < 650
                  ? 56.h
                  : 56.h,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: SizeVariables.getHeight(context) * 0.015,
                    left: SizeVariables.getWidth(context) * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Upcoming Holiday List',
                        // style: TextStyle(
                        //   fontSize: 30,
                        //   color: Colors.white,
                        // ),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeVariables.getHeight(context) * 0.005),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.04,
                      top: SizeVariables.getHeight(context) * 0.005,
                      right: SizeVariables.getWidth(context) * 0.04),
                  height: SizeVariables.getHeight(context) * 0.47,
                  // color: Colors.red,
                  child: provider['data']['dashboard_data']['holidays'].isEmpty
                      ? const Center(
                          child: Text('No Holidays Added'),
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          // itemBuilder: (context, index) => Column(
                          //       children: [
                          //         Row(
                          //           children: [
                          //             Flexible(
                          //               flex: 2,
                          //               child: Container(
                          //                 height:
                          //                     SizeVariables.getHeight(context) * 0.05,
                          //                 // color: Colors.red,
                          //                 child: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.start,
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.center,
                          //                   children: [
                          //                     Icon(Icons.circle,
                          //                         color: Colors.white,
                          //                         size: SizeVariables.getWidth(
                          //                                 context) *
                          //                             0.03),
                          //                     SizedBox(
                          //                       width:
                          //                           SizeVariables.getWidth(context) *
                          //                               0.01,
                          //                     ),
                          //                     FittedBox(
                          //                       fit: BoxFit.contain,
                          //                       child: Text(
                          //                           // provider['data']['dashboard_data']
                          //                           //         ['holidays'][index]
                          //                           //     ['holiday'],
                          //                           widget.holidays[index].holiday
                          //                               .toString(),
                          //                           style: Theme.of(context)
                          //                               .textTheme
                          //                               .bodyText1!
                          //                               .copyWith(
                          //                                   fontSize: 18,
                          //                                   color: Colors.amber)),
                          //                     )
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //             Flexible(
                          //               flex: 1,
                          //               fit: FlexFit.tight,
                          //               child: Container(
                          //                 height:
                          //                     SizeVariables.getHeight(context) * 0.05,
                          //                 // color: Colors.green,
                          //                 child: Column(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.center,
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.end,
                          //                   children: [
                          //                     Text(
                          //                         // provider['data']['dashboard_data']
                          //                         //         ['holidays'][index]
                          //                         //     ['holiday_date'],
                          //                         widget.holidays[index].holidayDate
                          //                             .toString(),
                          //                         style: Theme.of(context)
                          //                             .textTheme
                          //                             .bodyText1!
                          //                             .copyWith(fontSize: 10)),
                          //                     Text(
                          //                         // '(${DateFormat('EEE').format(DateTime.parse(provider['data']['dashboard_data']['holidays'][index]['holiday_date']))})',
                          //                         '(${DateFormat('EEE').format(DateTime.parse(widget.holidays[index].holidayDate!))})',
                          //                         style: Theme.of(context)
                          //                             .textTheme
                          //                             .bodyText1!
                          //                             .copyWith(
                          //                                 fontSize: 10,
                          //                                 color: Color.fromARGB(
                          //                                     255, 223, 215, 215)))
                          //                   ],
                          //                 ),
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //         SizedBox(
                          //             height: SizeVariables.getHeight(context) * 0.02)
                          //       ],
                          //     ),
                          itemBuilder: (context, index) => Container(
                                //
                                padding: EdgeInsets.all(
                                    SizeVariables.getHeight(context) * 0.01),
                                margin: EdgeInsets.only(
                                    bottom: SizeVariables.getHeight(context) *
                                        0.02),
                                width: double.infinity,
                                height: SizeVariables.getHeight(context) * 0.1,
                                decoration: BoxDecoration(
                                    boxShadow: (themeProvider.darkTheme)
                                        ? []
                                        : [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 0,
                                              blurRadius: 7,
                                              //offset: Offset(0, 3), // changes position of shadow
                                            ),
                                          ],
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    borderRadius: BorderRadius.circular(
                                        SizeVariables.getHeight(context) *
                                            0.02),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        width: 1)),
                                child: Row(
                                  children: [
                                    // Center(child: Icon(Icons.circle, color: Colors.white)),
                                    // Center(
                                    //   child: CircleAvatar(
                                    //     backgroundColor: Colors.white,
                                    //     radius:
                                    //         SizeVariables.getWidth(context) * 0.02,
                                    //   ),
                                    // ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: SizeVariables.getWidth(
                                                    context) *
                                                0.05,
                                            right: SizeVariables.getWidth(
                                                    context) *
                                                0.05),
                                        height: double.infinity,
                                        // color: Colors.red,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                provider['data']
                                                            ['dashboard_data']
                                                        ['holidays'][index]
                                                    ['holiday'],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2! // Tanay --- I have made this change of bang operator
                                                    .copyWith()),
                                            Text(
                                                '${DateFormat('EEE').format(DateTime.parse(provider['data']['dashboard_data']['holidays'][index]['holiday_date']))}, ${provider['data']['dashboard_data']['holidays'][index]['holiday_date']}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: Colors.grey))
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              SizeVariables.getHeight(context) *
                                                  0.02),
                                          bottomRight: Radius.circular(
                                              SizeVariables.getHeight(context) *
                                                  0.02)),
                                      child: Container(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.057,
                                        width: SizeVariables.getWidth(context) *
                                            0.2,
                                        // padding: EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.01),
                                        // color: Colors.red,
                                        child: CachedNetworkImage(
                                          imageUrl: provider['data']
                                                  ['dashboard_data']['holidays']
                                              [index]['image'],
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  CircleAvatar(
                                            backgroundImage: imageProvider,
                                            // backgroundImage: NetworkImage(
                                            //     '${AppUrl.profileDetails}${value.profileDetails.data!.data!.userdata!.profilePhoto}'),
                                            radius: 60,
                                          ),
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: Colors.grey[400]!,
                                            highlightColor:
                                                const Color.fromARGB(
                                                    255, 120, 120, 120),
                                            child: const CircleAvatar(
                                              radius: 60,
                                            ),
                                          ),
                                        ),
                                        // Lottie.asset('assets/json/gandhiji.json'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          itemCount: provider['data']['dashboard_data']
                                              ['holidays']
                                          .length ==
                                      4 ||
                                  provider['data']['dashboard_data']['holidays']
                                          .length >
                                      4
                              ? 4
                              : provider['data']['dashboard_data']['holidays']
                                  .length
                          // widget.holidays.length == 4 ||
                          //         widget.holidays.length > 4
                          //     ? 4
                          //     : widget.holidays.length
                          ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
