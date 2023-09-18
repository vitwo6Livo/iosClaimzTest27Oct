import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/consts/styles.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/views/widgets/organizationWidget/pie_Card.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../../viewModel/organisationViewModel.dart';
import '../../config/mediaQuery.dart';
import 'barChartModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrganizationNew extends StatefulWidget {
  final Map<String, dynamic> organisation;

  @override
  State<OrganizationNew> createState() => _OrganizationNewState();

  OrganizationNew(this.organisation);
}

class _OrganizationNewState extends State<OrganizationNew> {
  // final List<BarChartModel> data = [
  //   BarChartModel(
  //     emp: "",
  //     total: "Total",
  //     active: 30,
  //     color: charts.ColorUtil.fromDartColor(Color(0xFF47505F)),
  //   ),
  //   BarChartModel(
  //     emp: "12",
  //     total: "In",
  //     active: 20,
  //     color: charts.ColorUtil.fromDartColor(Colors.green),
  //   ),
  //   BarChartModel(
  //     emp: "12",
  //     total: "Leave",
  //     active: 5,
  //     color: charts.ColorUtil.fromDartColor(Colors.blue),
  //   ),
  //   BarChartModel(
  //     emp: "12",
  //     total: "Absent",
  //     active: 10,
  //     color: charts.ColorUtil.fromDartColor(Colors.red),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // List<charts.Series<BarChartModel, String>> series = [
    //   charts.Series(
    //       id: "",
    //       data: data,
    //       domainFn: (BarChartModel series, _) => series.total,
    //       measureFn: (BarChartModel series, _) => series.active,
    //       colorFn: (BarChartModel series, _) => series.color,
    //       labelAccessorFn: (BarChartModel series, _) =>
    //           '${series.total}: ${series.active}'
    //       // measureFormatterFn:
    //       ),
    // ];

    return Container(
      // color: Colors.amber,
      // height: 700,
      padding: EdgeInsets.only(
        top: SizeVariables.getHeight(context) * 0.02,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1 / 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.organisation['data'].length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.pushNamed(context, RouteNames.organizationnewlist,
                arguments: widget.organisation['data'][index]);
          },
          child: ContainerStyle(
            height: 0,
            // color: Colors.amber,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: SizeVariables.getHeight(context) * 0.02,
                      ),
                      child: Container(
                        child: widget.organisation['data'][index]['hod']
                                        ['profile_photo'] ==
                                    'http://consoledev.claimz.in/api/profile_photo' ||
                                widget.organisation['data'][index]['hod']
                                        ['profile_photo'] ==
                                    'https://console.claimz.in/api/profile_photo'
                            ? CircleAvatar(
                                radius: SizeVariables.getWidth(context) * 0.08,
                                backgroundColor: Colors.green,
                                backgroundImage: const AssetImage(
                                    'assets/img/profilePic.jpg'),
                                // child: const Icon(Icons.account_box, color: Colors.white),
                              )
                            : CachedNetworkImage(
                                imageUrl: widget.organisation['data'][index]
                                    ['hod']['profile_photo'],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height:
                                      SizeVariables.getHeight(context) * 0.08,
                                  width:
                                      SizeVariables.getHeight(context) * 0.08,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.contain)),
                                ),
                                placeholder: (context, url) => Container(
                                    height:
                                        SizeVariables.getHeight(context) * 0.06,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[400]!,
                                      highlightColor: const Color.fromARGB(
                                          255, 120, 120, 120),
                                      child: const CircleAvatar(
                                        radius: 2,
                                        backgroundColor: Colors.green,
                                        child: Center(
                                          child: Icon(Icons.camera_alt_outlined,
                                              color: Colors.white, size: 20),
                                        ),
                                      ),
                                    )),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        child: Text(
                          // widget.organisation['data'][index]['members'].isEmpty
                          //     ? 'NA'
                          //     : widget.organisation['data'][index]['members'][0]
                          //         ['emp_name'],
                          widget.organisation['data'][index]['hod']
                                  ['emp_name'] ??
                              'NA',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Container(
                        child: Text(
                          widget.organisation['data'][index]['department'] ??
                              'NA',
                          style:
                              // ignore: deprecated_member_use
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Pie_Card(widget.organisation['data'][index]),
                    ),

                    // InkWell(
                    //   onTap: () {
                    //     Navigator.pushNamed(
                    //         context, RouteNames.organizationnewlist);
                    //   },
                    //   child: Container(
                    //     // color: Colors.white,
                    //     height: height > 850
                    //         ? 15.h
                    //         : height > 750
                    //             ? 22.h
                    //             : height < 650
                    //                 ? 25.h
                    //                 : 22.h,
                    //     width: SizeVariables.getWidth(context) * 0.55,
                    //     child: charts.BarChart(
                    //       series,
                    //       domainAxis: const charts.OrdinalAxisSpec(
                    //         // scaleSpec: ,
                    //         renderSpec: charts.SmallTickRendererSpec(
                    //           labelStyle: charts.TextStyleSpec(
                    //             color: charts.Color.white,
                    //             fontSize: 8,
                    //           ),
                    //           lineStyle: charts.LineStyleSpec(
                    //             color: charts.Color.black,
                    //           ),
                    //         ),
                    //       ),
                    //       primaryMeasureAxis: const charts.NumericAxisSpec(
                    //         renderSpec: charts.GridlineRendererSpec(
                    //           labelStyle: charts.TextStyleSpec(
                    //             color: charts.Color.white,
                    //           ),
                    //           lineStyle: charts.LineStyleSpec(
                    //             color: charts.Color.black,
                    //           ),
                    //         ),
                    //       ),

                    //       // animate: true,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // return Container(
    //   height: 800,
    //   child: ListView.builder(
    //     itemCount: 14,
    //     itemBuilder: (context, index) => InkWell(
    //       onTap: () {
    //         Navigator.pushNamed(context, RouteNames.organizationnewlist);
    //       },
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: ContainerStyle(
    //           height: SizeVariables.getHeight(context) * 0.02.h,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Container(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: Container(
    //                           child: Text(
    //                             'System',
    //                             style: Theme.of(context).textTheme.bodyText2,
    //                           ),
    //                         ),
    //                       ),
    //                       Container(
    //                         child: CircleAvatar(
    //                           radius: SizeVariables.getWidth(context) * 0.08,
    //                           // backgroundColor:Colors.green,
    //                           backgroundImage:
    //                               const AssetImage('assets/img/profilePic.jpg'),
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: SizeVariables.getHeight(context) * 0.01,
    //                       ),
    //                       Padding(
    //                         padding: const EdgeInsets.all(4.0),
    //                         child: Container(
    //                           child: Text(
    //                             'S. S. A.',
    //                             style: Theme.of(context).textTheme.bodyText2,
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //               Container(
    //                 color: Colors.white,
    //                 height: SizeVariables.getHeight(context) * 0.15,
    //                 width: SizeVariables.getWidth(context) * 0.55,
    //                 child: charts.BarChart(

    //                   series,
    //                   animate: true,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
