import 'dart:ui';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/main.dart';
import 'package:claimz/viewModel/toDoViewModel/todaysTask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../res/colors/AppColors.dart';
import '../../../../res/components/containerStyle.dart';
import '../../../../res/components/flexContainerStyle.dart';
import '../../../config/mediaQuery.dart';
import './toDoListPie.dart';

class ToDoList extends StatefulWidget {
  ToDoListState createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    final toDoList =
        Provider.of<TodaysTaskList>(context, listen: true).getToDoList;
    // final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final themeProvider = Provider.of<ThemeProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(width * 0.02),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 5,
          color: (themeProvider.darkTheme) ? Colors.black : Colors.white,
          child: Container(
            width: double.infinity,
            // color: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              //color: const Color.fromARGB(255, 181, 179, 179).withOpacity(0.1),
              color: Theme.of(context).colorScheme.background,

              border: const Border(
                  bottom: BorderSide(width: 0.06),
                  top: BorderSide(width: 0.06),
                  right: BorderSide(width: 0.06),
                  left: BorderSide(width: 0.06)),
              // boxShadow: [
              //   BoxShadow(
              //       color: Color.fromARGB(255, 57, 57, 57),
              //       blurRadius: 15,
              //       spreadRadius: 1,
              //       offset: Offset(1, 2))
              // ]
            ),
            child: Container(
              // height: height > 750
              //     ? 8.h
              //     : height < 650
              //         ? 10.h
              //         : 54.6.h,
              // color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.red,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: InkWell(
                        onTap: () {
                          // initializeService();
                          // FlutterBackgroundService().startService();
                        },
                        child: Text(
                          'My Task list',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height > 750
                        ? 0.h
                        : height < 650
                            ? 4.h
                            : 2.5.h,
                  ),
                  Container(
                    // color: Colors.green,
                    child: toDoList['previous'].isEmpty &&
                            toDoList['today'].isEmpty &&
                            toDoList['upcoming'].isEmpty
                        ? Center(
                            child: Lottie.asset('assets/json/ToDo.json',
                                height: 24.h),
                          )
                        : Container(
                            // color: Colors.green,

                            height: height > 750
                                ? 26.h
                                : height < 650
                                    ? 38.h
                                    : 36.h,
                            width: double.infinity,
                            // color: Colors.red,
                            child: ToDoListPie(),
                          ),
                  ),
                  Container(
                    width: double.infinity,
                    // color: Colors.pink,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.circle,
                                color: const Color(0xffF59F23),
                                size: SizeVariables.getWidth(context) * 0.03),
                            SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02),
                            const Text('Current'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.circle,
                                color: const Color.fromARGB(255, 224, 202, 4),
                                size: SizeVariables.getWidth(context) * 0.03),
                            SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02),
                            const Text('Pending'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.circle,
                                color: const Color.fromARGB(255, 103, 103, 101),
                                size: SizeVariables.getWidth(context) * 0.03),
                            SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02),
                            const Text('Future')
                          ],
                        )
                      ],
                    ),
                  ),
                  // SizedBox(height: SizeVariables.getHeight(context) * 0.05),
                  // Container(
                  //   width: double.infinity,
                  //   // color: Colors.red,
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemBuilder: (context, index) => Container(
                  //       width: double.infinity,
                  //       margin: EdgeInsets.only(
                  //           bottom: SizeVariables.getHeight(context) * 0.01),
                  //       // color: Colors.red,
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Icon(Icons.circle,
                  //               color: Colors.white,
                  //               size: SizeVariables.getWidth(context) * 0.03),
                  //           SizedBox(
                  //               width: SizeVariables.getWidth(context) * 0.02),
                  //           Expanded(
                  //             // fit: BoxFit.contain,
                  //             child: Text(toDoList['today'][index]['task_name'],
                  //                 textAlign: TextAlign.justify,
                  //                 // overflow: TextOverflow.ellipsis,
                  //                 style: Theme.of(context).textTheme.bodyText1),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //     itemCount: toDoList['today'].length > 4
                  //         ? 4
                  //         : toDoList['today'].length,
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    // child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.only(
    //             top: SizeVariables.getHeight(context) * 0.015,
    //             left: SizeVariables.getWidth(context) * 0.04),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Container(
    //               // color: Colors.red,
    //               child: FittedBox(
    //                 fit: BoxFit.contain,
    //                 child: Text(
    //                   'My Task list',
    //                   style: Theme.of(context).textTheme.caption,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: SizeVariables.getHeight(context) * 0.01),
    //     Expanded(
    //       child: Container(
    //         // color: Colors.white,
    //         width: double.infinity,
    //         child: Column(
    //           children: [
    //             // ToDoListPie()
    //             Container(
    //               height: SizeVariables.getHeight(context) * 0.38,
    //               width: double.infinity,
    //               // color: Colors.red,
    //               child: ToDoListPie(),
    //             ),
    //             Expanded(
    //                 child: Container(
    //               width: double.infinity,
    //               // color: Colors.green,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       Icon(Icons.circle,
    //                           color: const Color(0xffF59F23),
    //                           size: SizeVariables.getWidth(context) * 0.03),
    //                       SizedBox(
    //                           width: SizeVariables.getWidth(context) * 0.02),
    //                       const Text('Current')
    //                     ],
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       Icon(Icons.circle,
    //                           color: const Color.fromARGB(255, 224, 202, 4),
    //                           size: SizeVariables.getWidth(context) * 0.03),
    //                       SizedBox(
    //                           width: SizeVariables.getWidth(context) * 0.02),
    //                       const Text('Pending')
    //                     ],
    //                   ),
    //                   Row(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     children: [
    //                       Icon(Icons.circle,
    //                           color: const Color.fromARGB(255, 103, 103, 101),
    //                           size: SizeVariables.getWidth(context) * 0.03),
    //                       SizedBox(
    //                           width: SizeVariables.getWidth(context) * 0.02),
    //                       const Text('Future')
    //                     ],
    //                   )
    //                 ],
    //               ),
    //             ))
    //           ],
    //         ),
    //       ),
    //     ),
    //     SizedBox(height: SizeVariables.getHeight(context) * 0.01),
    //     Padding(
    //       padding: EdgeInsets.only(
    //           left: SizeVariables.getWidth(context) * 0.04,
    //           top: SizeVariables.getHeight(context) * 0.005,
    //           right: SizeVariables.getWidth(context) * 0.04),
    //       child: SizedBox(
    //         height: SizeVariables.getHeight(context) * 0.28,
    //         child: Container(
    //           // color: Colors.red,
    //           child: toDoList['today'].isEmpty
    //               ? Center(
    //                   child: Lottie.asset('assets/json/ToDo.json'),
    //                 )
    //               : ListView.separated(
    //                   physics: const NeverScrollableScrollPhysics(),
    //                   itemBuilder: (context, index) => Row(
    //                         children: [
    // Icon(Icons.circle,
    //     color: Colors.white,
    //     size:
    //         SizeVariables.getWidth(context) * 0.03),
    //                           SizedBox(
    //                               width:
    //                                   SizeVariables.getWidth(context) * 0.02),
    //                           FittedBox(
    //                             fit: BoxFit.contain,
    //                             child: Text(
    //                                 toDoList['today'][index]['task_name'],
    //                                 overflow: TextOverflow.ellipsis,
    //                                 style: Theme.of(context)
    //                                     .textTheme
    //                                     .bodyText1),
    //                           )
    //                         ],
    //                       ),
    //                   separatorBuilder: (context, index) => Divider(
    //                         height: SizeVariables.getHeight(context) * 0.045,
    //                         color: Colors.white,
    //                         thickness: 0.5,
    //                       ),
    //                   itemCount: toDoList['today'].length > 4
    //                       ? 4
    //                       : toDoList['today'].length),
    //         ),
    //       ),
    //     )
    //   ],
    // ),
  }
}
