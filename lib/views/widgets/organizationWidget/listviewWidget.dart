import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../config/mediaQuery.dart';

class ListviewWidget extends StatefulWidget {
  final List<dynamic> listView;
  final String department;

  ListviewWidget(this.listView, this.department);

  @override
  State<ListviewWidget> createState() => _ListviewWidgetState();
}

class _ListviewWidgetState extends State<ListviewWidget> {
  final _textFieldController = TextEditingController();
  var data;
  List<dynamic> query = [];

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      data = widget.listView;
      query = data;
    });
    super.initState();
  }

  searchByQuery(String search) {
    setState(() {
      query = widget.listView
          .where((element) => element['members']
              .where((elementTwo) => elementTwo['emp_name'])
              .toLowerCase()
              .contains(search.toLowerCase()))
          .toList();
      // query = data
      //     .where((element) => element['announcement_title']
      //         .toLowerCase()
      //         .contains(search.toLowerCase()))
      //     .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height > 850
          ? 72.2.h
          : height > 750
              ? 70.4.h
              : height < 650
                  ? 70.h
                  : 67.9.h,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Container(
                      // width: 100,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: _textFieldController,
                        onChanged: (value) => searchByQuery,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          icon: Icon(Icons.search_outlined),
                          iconColor: Colors.grey,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: 'Search',
                          hintStyle:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  // Flexible(
                  //   flex: 1,
                  //   fit: FlexFit.tight,
                  //   child: Container(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //         Container(
                  //           child: Text(
                  //             'Show',
                  //             style: Theme.of(context).textTheme.bodyText1,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: SizeVariables.getWidth(context) * 0.02,
                  //         ),
                  //         Container(
                  //           width: 30,
                  //           child: ContainerStyle(
                  //             height: SizeVariables.getHeight(context) * 0.025,
                  //             child: Center(
                  //               child: Text(
                  //                 '10',
                  //                 style: Theme.of(context).textTheme.bodyText1,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Container(
            height: height > 850
                ? 65.h
                : height > 750
                    ? 64.5.h
                    : height < 650
                        ? 60.h
                        : 58.h,
            child: ListView.builder(
              itemCount: widget.listView.length,
              // shrinkWrap: true,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.organizationdetails,
                        arguments: {
                          'details': widget.listView[index],
                          'departmentName': widget.department,
                          'employees': widget.listView
                        });
                  },
                  child: ContainerStyle(
                    height: SizeVariables.getHeight(context) * 0.1,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.025,
                                    ),
                                    child: Container(
                                      child: widget.listView[index]
                                                  ['profile_photo'] ==
                                              'https://console.claimz.in/api/profile_photo'
                                          ? CircleAvatar(
                                              radius: SizeVariables.getWidth(
                                                      context) *
                                                  0.08,
                                              backgroundColor: Colors.green,
                                              backgroundImage: const AssetImage(
                                                  'assets/img/profilePic.jpg'),
                                              // child: const Icon(Icons.account_box, color: Colors.white),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: widget.listView[index]
                                                  ['profile_photo'],
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.08,
                                                width: SizeVariables.getHeight(
                                                        context) *
                                                    0.08,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.contain)),
                                              ),
                                              placeholder: (context, url) =>
                                                  Container(
                                                      height: SizeVariables
                                                              .getHeight(
                                                                  context) *
                                                          0.06,
                                                      child: Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.grey[400]!,
                                                        highlightColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                120,
                                                                120,
                                                                120),
                                                        child:
                                                            const CircleAvatar(
                                                          radius: 2,
                                                          backgroundColor:
                                                              Colors.green,
                                                          child: Center(
                                                            child: Icon(
                                                                Icons
                                                                    .camera_alt_outlined,
                                                                color: Colors
                                                                    .white,
                                                                size: 20),
                                                          ),
                                                        ),
                                                      )),
                                            ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: SizeVariables.getHeight(context) *
                                          0.008,
                                    ),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Container(
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    widget.listView[index]
                                                        ['emp_name'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.006,
                                                ),
                                                Container(
                                                  child: Text(
                                                    widget.listView[index][
                                                            'designation_name'] ??
                                                        'NA',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Colors.grey,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // CHECK IN CHECK OUT STATUS

                          Padding(
                            padding: EdgeInsets.only(
                              right: SizeVariables.getWidth(context) * 0.02,
                            ),
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor: widget.listView[index]
                                            ['attendance_status'] ==
                                        'Present'
                                    ? Colors.green
                                    : widget.listView[index]
                                                ['attendance_status'] ==
                                            'Absent'
                                        ? Colors.red
                                        : widget.listView[index]
                                                    ['attendance_status'] ==
                                                'Leave'
                                            ? Colors.blue
                                            : widget.listView[index]
                                                        ['attendance_status'] ==
                                                    'Holiday'
                                                ? const Color.fromARGB(
                                                    255, 30, 233, 233)
                                                : widget.listView[index][
                                                            'attendance_status'] ==
                                                        'Half Day'
                                                    ? Colors.grey
                                                    : Colors.amber,
                                radius:
                                    SizeVariables.getHeight(context) * 0.009,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
