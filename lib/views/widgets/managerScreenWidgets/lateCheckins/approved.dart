import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../models/lateCheckinModel.dart';
import '../../../../res/components/containerStyle.dart';
import '../../../../viewModel/lateCheckinViewModel.dart';
import '../../../config/mediaQuery.dart';

class ApprovedCheckins extends StatefulWidget {
  final List<Data> lateCheckinViewModel;

  ApprovedCheckinsState createState() => ApprovedCheckinsState();

  ApprovedCheckins(this.lateCheckinViewModel);
}

class ApprovedCheckinsState extends State<ApprovedCheckins> {
  DateFormat day = DateFormat('dd');
  DateFormat monthFormat = DateFormat('MMM');
  var selectedValue;

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<LateCheckinViewModel>(context).approvedCheckIns;

    // TODO: implement build
    return provider.isEmpty
        ? Center(
            child: Text(
              'No Approved Requests',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        : Container(
            height: double.infinity,
            width: double.infinity,
            // color: Colors.amber,
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
                          // widget.lateCheckinViewModel.lateCheckin.data!.data![index]
                          //                 .status ==
                          //             1 ||
                          //         widget.lateCheckinViewModel.lateCheckin.data!
                          //                 .data![index].status ==
                          //             2
                          // provider[index].status == 1 ||
                          //         provider[index].status == 2
                          widget.lateCheckinViewModel[index].status == 1 ||
                                  widget.lateCheckinViewModel[index].status == 2
                              ? ContainerStyle(
                                  height:
                                      SizeVariables.getHeight(context) * 0.12,
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
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .all(SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.01),
                                                            child: CircleAvatar(
                                                              // backgroundColor: Colors.red,
                                                              radius: SizeVariables
                                                                      .getWidth(
                                                                          context) *
                                                                  0.08,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: double
                                                                  .infinity,
                                                              // color: Colors.orange,
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: SizeVariables
                                                                        .getWidth(
                                                                            context) *
                                                                    0.01,
                                                                // top: SizeVariables
                                                                //         .getHeight(
                                                                //             context) *
                                                                //     0.02
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  FittedBox(
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    child: Text(
                                                                      // widget
                                                                      //     .lateCheckinViewModel
                                                                      //     .lateCheckin
                                                                      //     .data!
                                                                      //     .data![
                                                                      //         index]
                                                                      //     .empName
                                                                      //     .toString(),
                                                                      // provider[
                                                                      //         index]
                                                                      //     .empName,
                                                                      // style: Theme.of(
                                                                      //         context)
                                                                      //     .textTheme
                                                                      //     .bodyText1,
                                                                      widget
                                                                          .lateCheckinViewModel[
                                                                              index]
                                                                          .empName
                                                                          .toString(),
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    // widget
                                                                    //     .lateCheckinViewModel
                                                                    //     .lateCheckin
                                                                    //     .data!
                                                                    //     .data![
                                                                    //         index]
                                                                    //     .lateDate
                                                                    //     .toString(),
                                                                    // provider[
                                                                    //         index]
                                                                    //     .lateDate,
                                                                    widget
                                                                        .lateCheckinViewModel[
                                                                            index]
                                                                        .lateDate
                                                                        .toString(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyText1,
                                                                  ),
                                                                  Text(
                                                                    // 'Check In Time: ${widget.lateCheckinViewModel.lateCheckin.data!.data![index].lateCheckinTime}',
                                                                    'Check In Time: ${widget.lateCheckinViewModel[index].lateCheckinTime}',

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
                                                  //     flex: 1,
                                                  //     fit: FlexFit.tight,
                                                  //     child: Center(
                                                  //       child: PopupMenuButton(
                                                  //         icon: const Icon(
                                                  //             Icons.arrow_drop_down,
                                                  //             color: Colors.white),
                                                  //         color:
                                                  //             const Color.fromARGB(
                                                  //                 255, 77, 76, 76),
                                                  //         itemBuilder: (context) =>
                                                  //             [
                                                  //           PopupMenuItem(
                                                  //             value: 1,
                                                  //             child: Text('Approve',
                                                  //                 style: Theme.of(
                                                  //                         context)
                                                  //                     .textTheme
                                                  //                     .bodyText1),
                                                  //           ),
                                                  //           PopupMenuItem(
                                                  //             value: 2,
                                                  //             child: Text(
                                                  //                 'Half Day',
                                                  //                 style: Theme.of(
                                                  //                         context)
                                                  //                     .textTheme
                                                  //                     .bodyText1),
                                                  //           ),
                                                  //           PopupMenuItem(
                                                  //             value: 3,
                                                  //             child: Text('Reject',
                                                  //                 style: Theme.of(
                                                  //                         context)
                                                  //                     .textTheme
                                                  //                     .bodyText1),
                                                  //           ),
                                                  //         ],
                                                  //         onSelected:
                                                  //             (value) async {
                                                  //           setState(() {
                                                  //             selectedValue = value;
                                                  //           });
                                                  //           if(kDebugMode) {
                                                  //             print('SELECTED OPTION: $selectedValue');
                                                  //           }
                                                  //           Map<String, dynamic> data = {
                                                  //             'status': selectedValue
                                                  //           };
                                                  //           Provider.of<LateCheckinViewModel>(context, listen: false).lateCheckInApproval(context, data, widget.lateCheckinViewModel.lateCheckin.data!.data![index].lateId);
                                                  //           // setState(() {
                                                  //           //   Provider.of<LateCheckinViewModel>(context, listen: false).getLateCheckin(context);
                                                  //           // });
                                                  //         },
                                                  //       ),
                                                  //     ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )))
                              : Container(),
                          SizedBox(
                            height: SizeVariables.getHeight(context) * 0.02,
                          )
                        ],
                      ),
                  itemCount:
                      // widget.lateCheckinViewModel.lateCheckin.data!.data!.length
                      widget.lateCheckinViewModel.length
                  // provider['data'].length
                  ),
            ));
  }
}
