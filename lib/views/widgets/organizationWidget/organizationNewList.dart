import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/views/widgets/organizationWidget/treeviewWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../config/mediaQuery.dart';
import 'listviewWidget.dart';

class OrganizationNewList extends StatefulWidget {
  final Map<String, dynamic> orgDetails;

  OrganizationNewList(this.orgDetails);

  @override
  State<OrganizationNewList> createState() => _OrganizationNewListState();
}

class _OrganizationNewListState extends State<OrganizationNewList> {
  int _selection = 0;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: Container(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  "assets/icons/back button.svg",
                ),
              ),
              SizedBox(width: SizeVariables.getWidth(context) * 0.02),
              Text(
                widget.orgDetails['department'],
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 20,
                    ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            // height: 151,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xFF47505F),
                              radius: SizeVariables.getHeight(context) * 0.025,
                              child: Text(
                                widget.orgDetails['members'].length.toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.007,
                            ),
                            Container(
                              child: Text(
                                'Total EMP',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.07,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: SizeVariables.getHeight(context) * 0.025,
                              child: Text(
                                widget.orgDetails['present'].toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.007,
                            ),
                            Container(
                              child: Text(
                                'In',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.07,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: SizeVariables.getHeight(context) * 0.025,
                              child: Text(
                                widget.orgDetails['leave'].toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.007,
                            ),
                            Container(
                              child: Text(
                                'Leave',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.07,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: SizeVariables.getHeight(context) * 0.025,
                              child: Text(
                                widget.orgDetails['absent'].toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.007,
                            ),
                            Container(
                              child: Text(
                                'Absent',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.07,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.amber,
                              radius: SizeVariables.getHeight(context) * 0.025,
                              child: Text(
                                widget.orgDetails['checkout'].toString(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.007,
                            ),
                            Container(
                              child: Text(
                                'Out',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.025,
                    right: SizeVariables.getWidth(context) * 0.025,
                  ),
                  child: Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                primary: _selection == 0
                                    ? Color.fromARGB(255, 64, 63, 63)
                                    : Color.fromARGB(255, 32, 31, 31),
                              ),
                              child: Container(
                                width: SizeVariables.getWidth(context) * 0.22,
                                child: Row(
                                  children: [
                                    // Image.asset(
                                    //   'assest/org/listview.png',
                                    //   height: 10,
                                    // ),
                                    SvgPicture.asset(
                                      'assets/img/list-pointers.svg',
                                      height: SizeVariables.getHeight(context) *
                                          0.023,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(
                                      width: SizeVariables.getWidth(context) *
                                          0.01,
                                    ),
                                    Text(
                                      'List View',
                                      style: TextStyle(
                                        color: _selection == 0
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selection = 0;
                                });
                                print('SELECTION: $_selection');
                              },
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: SizeVariables.getHeight(context) * 0.006,
                        // ),
                        // Container(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(4.0),
                        //     child: ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //         shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(10),
                        //         ),
                        //         primary: _selection == 1
                        //             ? Color.fromARGB(255, 64, 63, 63)
                        //             : Color.fromARGB(255, 32, 31, 31),
                        //       ),
                        //       child: Container(
                        //         width: SizeVariables.getWidth(context) * 0.23,
                        //         child: Row(
                        //           children: [
                        //             SvgPicture.asset(
                        //               'assets/img/tree-view-svgrepo-com.svg',
                        //               height: SizeVariables.getHeight(context) *
                        //                   0.023,
                        //               color: Colors.amber,
                        //             ),
                        //             SizedBox(
                        //               width: SizeVariables.getWidth(context) *
                        //                   0.01,
                        //             ),
                        //             Text(
                        //               'Tree View',
                        //               style: TextStyle(
                        //                 color: _selection == 1
                        //                     ? Colors.white
                        //                     : Colors.grey,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       onPressed: () {
                        //         setState(() {
                        //           _selection = 1;
                        //         });
                        //         print('SELECTION: $_selection');
                        //       },
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 32, 31, 31),
              ),
              height: height > 850
                  ? 72.45.h
                  : height > 750
                      ? 71.6.h
                      : height < 650
                          ? 70.h
                          : 67.9.h,
              child: Column(
                children: [
                  _selection == 0
                      ? ListviewWidget(widget.orgDetails['members'],
                          widget.orgDetails['department'])
                      : _selection == 1
                          ? TreeviewWidget(
                              widget.orgDetails['hod']['user_id'] ?? 999999,
                              widget.orgDetails['hod']['emp_name'] ?? 'NA',
                              widget.orgDetails['hod']['department_name'] ??
                                  'NA',
                              widget.orgDetails['hod']['profile_photo'] ==
                                      'https://console.claimz.in/api/profile_photo'
                                  ? 'NA'
                                  : widget.orgDetails['hod']['profile_photo'])
                          : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
