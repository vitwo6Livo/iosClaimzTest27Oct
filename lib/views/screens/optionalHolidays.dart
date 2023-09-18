import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../provider/theme_provider.dart';
import '../../viewModel/claimsStatusViewModel.dart';
import '../config/mediaQuery.dart';

class OptionalHolidays extends StatefulWidget {
  OptionalHolidaysState createState() => OptionalHolidaysState();
}

class OptionalHolidaysState extends State<OptionalHolidays> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState

    Provider.of<ClaimzStatusViewModel>(context, listen: false)
        .getOptionalHolidays()
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<ClaimzStatusViewModel>(context).optionalHolidays;
    final themeProvider = Provider.of<ThemeProvider>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Container(
          // height: 400,
          // color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: SvgPicture.asset(
                        "assets/icons/back button.svg",
                      ),
                    ),
                    SizedBox(width: SizeVariables.getWidth(context) * 0.02),
                    Container(
                      width: SizeVariables.getWidth(context) * 0.4,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Optional Holidays',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              // color: Colors.red,
              child: ListView.builder(
                  itemBuilder: (context, index) =>
                      //  Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Expanded(
                      //           child: Container(
                      //             // color: Colors.red,
                      //             child: Row(
                      //               children: [
                      //                 Icon(Icons.circle,
                      //                     color: Colors.white,
                      //                     size: SizeVariables.getWidth(
                      //                             context) *
                      //                         0.03),
                      //                 SizedBox(
                      //                     width: SizeVariables.getWidth(
                      //                             context) *
                      //                         0.01),
                      //                 FittedBox(
                      //                   fit: BoxFit.contain,
                      //                   child: Text(
                      //                     provider['data']['dashboard_data']
                      //                         ['holidays'][index]['holiday'],
                      //                     // style: TextStyle(
                      //                     //     color: Colors.white, fontSize: 18)
                      //                     style: Theme.of(context)
                      //                         .textTheme
                      //                         .bodyText1,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //         Flexible(
                      //           flex: 1,
                      //           child: Container(
                      //             // color: Colors.blue,
                      //             child: FittedBox(
                      //               fit: BoxFit.contain,
                      //               child: Text(
                      // provider['data']['dashboard_data']
                      //     ['holidays'][index]['holiday_date'],

                      //                 // style: TextStyle(
                      //                 //     color: Colors.white, fontSize: 18),
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .bodyText1,
                      //               ),
                      //             ),
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      InkWell(
                        onTap: () => Provider.of<ClaimzStatusViewModel>(context,
                                listen: false)
                            .postOptionalHoliday(context),
                        child: Container(
                          padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.03,
                            // right: SizeVariables.getWidth(context) * 0.01
                          ),
                          margin: EdgeInsets.only(
                              bottom: SizeVariables.getHeight(context) * 0.02),
                          width: double.infinity,
                          height: SizeVariables.getHeight(context) * 0.1,
                          decoration: BoxDecoration(
                              // color: Colors.amber,

                              borderRadius: BorderRadius.circular(
                                  SizeVariables.getHeight(context) * 0.02),
                              border: Border.all(
                                  color: (themeProvider.darkTheme)
                                      ? Colors.grey
                                      : Colors.white,
                                  width: 2)),
                          child: Row(
                            children: [
                              // Center(child: Icon(Icons.circle, color: Colors.white)),
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius:
                                      SizeVariables.getWidth(context) * 0.02,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.05,
                                      right: SizeVariables.getWidth(context) *
                                          0.05),
                                  height: double.infinity,
                                  // color: Colors.red,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          // provider['data']
                                          //             ['dashboard_data']
                                          //         ['holidays'][index]
                                          //     ['holiday'],
                                          provider['data'][index]['holiday'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2),
                                      Text(
                                          '${DateFormat('EEE').format(DateTime.parse(
                                            // provider['data']
                                            //             ['dashboard_data']
                                            //         ['holidays'][index]
                                            //     ['holiday_date'],
                                            provider['data'][index]
                                                ['holiday_date'],
                                          ))}, ${provider['data'][index]['holiday_date']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.grey))
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
                                      SizeVariables.getHeight(context) * 0.057,
                                  width: SizeVariables.getWidth(context) * 0.2,
                                  // padding: EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.01),
                                  // color: Colors.red,
                                  child: CachedNetworkImage(
                                    imageUrl: provider['data'][index]['image'],
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      backgroundImage: imageProvider,
                                      // backgroundImage: NetworkImage(
                                      //     '${AppUrl.profileDetails}${value.profileDetails.data!.data!.userdata!.profilePhoto}'),
                                      radius: 60,
                                    ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey[400]!,
                                      highlightColor: const Color.fromARGB(
                                          255, 120, 120, 120),
                                      child: const CircleAvatar(
                                        radius: 60,
                                      ),
                                    ),
                                  ),
                                  // Lottie.asset('assets/json/gandhiji.json'),
                                ),
                              )
                              // ClipRRect(
                              //   borderRadius: BorderRadius.only(
                              //       topRight: Radius.circular(
                              //           SizeVariables.getHeight(
                              //                   context) *
                              //               0.02),
                              //       bottomRight: Radius
                              //           .circular(SizeVariables
                              //                   .getHeight(
                              //                       context) *
                              //               0.02)),
                              //   child: Container(
                              //     height: double.infinity,
                              //     width: SizeVariables.getWidth(
                              //             context) *
                              //         0.2,
                              //     padding: EdgeInsets.all(
                              //         SizeVariables.getHeight(
                              //                 context) *
                              //             0.02),
                              //     // padding: EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.01),
                              //     // color: Colors.red,
                              //     child: Center(
                              //         child: Image.network(value
                              //             .allHoliday
                              //             .data!
                              //             .data![index]
                              //             .image
                              //             .toString())),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                  itemCount: provider['data'].length)),
    );
  }
}
