import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../res/components/containerStyle.dart';
import '../../../res/components/date_range_picker.dart';
import '../../../viewModel/workRoleViewModel.dart';
import '../../config/mediaQuery.dart';
// import '../../screens/paySlipShimmer.dart';
import 'managerWorkShimmer.dart';

class WorkRole extends StatefulWidget {
  WorkRoleState createState() => WorkRoleState();
}

class WorkRoleState extends State<WorkRole> {
  // final departmentModelView = WorkRoleViewModel();
  var selectedValue;
  bool isLoading = true;
  bool office = true;
  bool offsite = false;
  bool onsite = false;
  final _controller = TextEditingController();
  var query;
  List<dynamic> data = [];

  int? empId;

  @override
  void initState() {
    // TODO: implement initState

    initialiseStorage();

    Provider.of<WorkRoleViewModel>(context, listen: false)
        .getManagerDepartmentList()
        .then((_) {
      setState(() {
        isLoading = false;
        data = Provider.of<WorkRoleViewModel>(context, listen: false)
            .departmentList['data'];
        query = data;
      });
    });
    super.initState();
  }

  searchByQuery(String search) {
    setState(() {
      query = data
          .where((element) =>
              element['emp_name'].toLowerCase().contains(search.toLowerCase()))
          .toList();
      // provider = data
      //     .where((element) => element['announcement_title']
      //         .toLowerCase()
      //         .contains(search.toLowerCase()))
      //     .toList();
    });
  }

  void initialiseStorage() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    empId = localStorage.getInt('userId');

    print('EMP ID: $empId');
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<WorkRoleViewModel>(context).departmentList;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final provider = Provider.of<WorkRoleViewModel>(context).departmentList;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        toolbarHeight: 130,
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: InkWell(
        //     onTap: () {
        //       Navigator.of(context).pop();
        //     },
        //     child: SvgPicture.asset(
        //       "assets/icons/back button.svg",
        //     ),
        //   ),
        // ),
        title: Column(
          children: [
            Container(
              // height: 400,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                        Container(
                          width: SizeVariables.getWidth(context) * 0.4,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Permissions',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   // color: Colors.amber,
                  //   width: SizeVariables.getWidth(context) * 0.3,
                  //   height: SizeVariables.getHeight(context) * 0.05,
                  //   child: FittedBox(
                  //     fit: BoxFit.contain,
                  //     child: DateRangePicker(
                  //       onPressed: pickDateRange,
                  //       end: end,
                  //       start: start,
                  //       // width: double.infinity,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              height: 80,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 17),
              // color: Colors.red,
              child: Row(
                children: [
                  // Padding(
                  //   padding:
                  //       EdgeInsets.only(left: SizeVariables.getWidth(context) * 0.03, top: SizeVariables.getHeight(context) * 0.014),
                  //   child: InkWell(
                  //       onTap: () => Navigator.of(context).pop(),
                  //       child: const Icon(Icons.arrow_back_ios,
                  //           color: Colors.green, size: 30)),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.02,
                        right: SizeVariables.getWidth(context) * 0.04,
                        bottom: SizeVariables.getHeight(context) * 0.04),
                    child: Container(
                      // color: Colors.amber,
                      width: SizeVariables.getWidth(context) * 0.8,
                      height: SizeVariables.getHeight(context) * 0.065,
                      // margin: EdgeInsets.only(
                      //     // top: SizeVariables.getHeight(context) * 0.02,
                      //     ),
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            // spreadRadius: 5,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Icon(
                              Icons.search_outlined,
                              color: Colors.grey,
                              size: 22,
                            ),
                          ),
                          Flexible(
                            flex: 9,
                            fit: FlexFit.tight,
                            child: TextField(
                              controller: _controller,
                              onChanged: (value) => searchByQuery(value),
                              autofocus: false,
                              cursorColor: Colors.grey,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search By Name or Title',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        // title: Column(
        //   children: [
        //     Text(
        //       'Work Roles',
        //       style: Theme.of(context).textTheme.caption,
        //     ),
        //     Container(
        //             height: 80,
        //             width: double.infinity,
        //             margin: const EdgeInsets.only(
        //               top: 17
        //             ),
        //             // color: Colors.red,
        //             child: Row(
        //               children: [
        //                 // Padding(
        //                 //   padding:
        //                 //       EdgeInsets.only(left: SizeVariables.getWidth(context) * 0.03, top: SizeVariables.getHeight(context) * 0.014),
        //                 //   child: InkWell(
        //                 //       onTap: () => Navigator.of(context).pop(),
        //                 //       child: const Icon(Icons.arrow_back_ios,
        //                 //           color: Colors.green, size: 30)),
        //                 // ),
        //                 Padding(
        //                   padding: EdgeInsets.only(
        //                       left: SizeVariables.getWidth(context) * 0.02,
        //                       right: SizeVariables.getWidth(context) * 0.04,
        //                       bottom: SizeVariables.getHeight(context) * 0.04),
        //                   child: Container(
        //                     // color: Colors.amber,
        //                     width: SizeVariables.getWidth(context) * 0.8,
        //                     height: SizeVariables.getHeight(context) * 0.065,
        //                     // margin: EdgeInsets.only(
        //                     //     // top: SizeVariables.getHeight(context) * 0.02,
        //                     //     ),
        //                     padding: EdgeInsets.only(
        //                         left: SizeVariables.getWidth(context) * 0.02),
        //                     decoration: BoxDecoration(
        //                       color: Colors.white,
        //                       borderRadius: BorderRadius.circular(20),
        //                       boxShadow: const [
        //                         BoxShadow(
        //                           color: Colors.grey,
        //                           // spreadRadius: 5,
        //                           blurRadius: 5,
        //                           offset: Offset(0, 2),
        //                         ),
        //                       ],
        //                     ),
        //                     child: Row(
        //                       children: [
        //                         const Flexible(
        //                           flex: 1,
        //                           fit: FlexFit.tight,
        //                           child: Icon(
        //                             Icons.search_outlined,
        //                             color: Colors.grey,
        //                             size: 22,
        //                           ),
        //                         ),
        //                         Flexible(
        //                           flex: 9,
        //                           fit: FlexFit.tight,
        //                           child: TextField(
        //                             controller: _controller,
        //                             // onChanged: (value) => searchByQuery(value),
        //                             autofocus: false,
        //                             cursorColor: Colors.grey,
        //                             style: const TextStyle(
        //                                 color: Colors.black, fontSize: 14),
        //                             decoration: const InputDecoration(
        //                               border: InputBorder.none,
        //                               hintText: 'Search By Name or Title',
        //                               hintStyle: TextStyle(color: Colors.grey),
        //                             ),
        //                           ),
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           )
        //   ],
        // ),
      ),
      body: isLoading
          ? WorkRoleShimmer()
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
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Container(
                        // color: Colors.red,
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
                          height: height > 750
                              ? 15.h
                              : height < 650
                                  ? 23.h
                                  : 20.h,
                          child: Container(
                            height: height > 750
                                ? 14.h
                                : height < 650
                                    ? 22.h
                                    : 19.h,
                            // height: double.infinity,
                            // color: Color.fromARGB(255, 31, 11, 142),
                            // padding: EdgeInsets.only(
                            //     bottom: SizeVariables.getHeight(
                            //             context) *
                            //         0.02),
                            child: Column(
                              children: [
                                Flexible(
                                  flex: 3,
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
                                                    child: provider['data']
                                                                    [index][
                                                                'profile_photo'] ==
                                                            null
                                                        ? CircleAvatar(
                                                            // backgroundColor: Colors.red,
                                                            radius: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.08,
                                                            backgroundImage:
                                                                const AssetImage(
                                                                    'assets/img/profilePic.jpg'),
                                                          )
                                                        : CircleAvatar(
                                                            radius: SizeVariables
                                                                    .getWidth(
                                                                        context) *
                                                                0.08,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    'http://claimz.vitwo.in/profile_photo/${provider['data'][index]['profile_photo']}'),
                                                          )),
                                                Expanded(
                                                  child: Container(
                                                    height: double.infinity,
                                                    // color: Colors.orange,
                                                    padding: EdgeInsets.only(
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
                                                          fit: BoxFit.contain,
                                                          child: Text(
                                                            provider['data']
                                                                    [index]
                                                                ['emp_name'],
                                                            // widget
                                                            //     .lateCheckinViewModel
                                                            //     .lateCheckin
                                                            //     .data!
                                                            //     .data![
                                                            //         index]
                                                            //     .empName
                                                            //     .toString(),
                                                            // provider[index].empName,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1,
                                                          ),
                                                        ),
                                                        Text(
                                                          provider['data']
                                                                      [index]
                                                                  ['emp_code']
                                                              .toString(),
                                                          // provider[index].lateDate,
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
                                        empId == provider['data'][index]['id']
                                            ? Container()
                                            : Flexible(
                                                flex: 1,
                                                fit: FlexFit.tight,
                                                child: Center(
                                                  child: PopupMenuButton(
                                                    icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color: Theme.of(context)
                                                            .canvasColor),
                                                    // color: const Color
                                                    //         .fromARGB(
                                                    //     255,
                                                    //     77,
                                                    //     76,
                                                    //     76),
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                        value: 1,
                                                        child: provider['data']
                                                                        [index][
                                                                    'offsite'] ==
                                                                1
                                                            ? Text(
                                                                'Disable Offsite',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!)
                                                            : Text(
                                                                'Enable Offsite',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!),
                                                      ),
                                                      PopupMenuItem(
                                                        value: 2,
                                                        child: provider['data']
                                                                        [index][
                                                                    'onsite'] ==
                                                                1
                                                            ? Text(
                                                                'Disable Onsite',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!)
                                                            : Text(
                                                                'Enable Onsite',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!),
                                                      )
                                                    ],
                                                    onSelected: (item) async {
                                                      setState(() {
                                                        selectedValue = item;
                                                      });
                                                      if (kDebugMode) {
                                                        print(
                                                            'SELECTED OPTION: $selectedValue');
                                                      }
                                                      Map<String, dynamic>
                                                          dataOffsite = {
                                                        'emp_id':
                                                            provider['data']
                                                                [index]['id'],
                                                        'status': provider['data']
                                                                        [index][
                                                                    'offsite'] ==
                                                                1
                                                            ? 0
                                                            : 1
                                                      };

                                                      Map<String, dynamic>
                                                          dataOnsite = {
                                                        'emp_id':
                                                            provider['data']
                                                                [index]['id'],
                                                        'status': provider['data']
                                                                        [index][
                                                                    'onsite'] ==
                                                                1
                                                            ? 0
                                                            : 1
                                                      };

                                                      selectedValue == 1
                                                          ?
                                                          // print(
                                                          //     'SELECTED CHOICE OFFSITE: $data')
                                                          Provider.of<WorkRoleViewModel>(
                                                                  context,
                                                                  listen: false)
                                                              .offSiteEnable(
                                                                  context,
                                                                  dataOffsite)
                                                          :
                                                          // print(
                                                          //     'SELECTED CHOICE ONSITE: $data');
                                                          Provider.of<WorkRoleViewModel>(
                                                                  context,
                                                                  listen: false)
                                                              .onSiteEnable(
                                                                  context,
                                                                  dataOnsite);
                                                    },
                                                  ),
                                                )),
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Container(
                                    width: double.infinity,
                                    // color: Colors.amber,
                                    padding: EdgeInsets.only(
                                        left: SizeVariables.getWidth(context) *
                                            0.05),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            height: double.infinity,
                                            // color: Colors.red,
                                            // padding: EdgeInsets.only(bottom: SizeVariables.getHeight(context) * 0.01),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text('Office',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            fontSize: 12)),
                                                SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.04),
                                                Container(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.042,
                                                    height:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.042,
                                                    // color: Colors.white,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            // color: Colors
                                                            //     .white,
                                                            color: Theme.of(
                                                                    context)
                                                                .canvasColor,
                                                            width: 1)),
                                                    child: const Icon(
                                                        Icons.check,
                                                        color: Colors.amber,
                                                        size: 15))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          // flex: 1,
                                          fit: FlexFit.loose,
                                          child: Container(
                                            height: double.infinity,
                                            // color: Colors.green,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text('Offsite',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            fontSize: 12)),
                                                // Checkbox(
                                                //     activeColor: Colors
                                                //         .transparent,
                                                //     checkColor:
                                                //         Colors
                                                //             .amber,
                                                //     side: MaterialStateBorderSide
                                                //         .resolveWith(
                                                //       (states) => const BorderSide(
                                                //           width:
                                                //               1.0,
                                                //           color: Colors
                                                //               .white),
                                                //     ),
                                                //     value: offsite,
                                                //     onChanged:
                                                //         (_) {
                                                //           if(provider['data'][index]['offsite'] == 1) {
                                                //             setState(() {
                                                //               offsite = true;
                                                //             });
                                                //           }
                                                //         })
                                                SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.04),

                                                provider['data'][index]
                                                            ['offsite'] ==
                                                        1
                                                    ? Container(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.042,
                                                        height: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.042,
                                                        // color: Colors.white,
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                        // color: Colors
                                                                        //     .white,
                                                                        color: Theme.of(context)
                                                                            .canvasColor,
                                                                        width:
                                                                            1)),
                                                        child: const Icon(
                                                            Icons.check,
                                                            color: Colors.amber,
                                                            size: 15))
                                                    : Container(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.042,
                                                        height: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.042,
                                                        // color: Colors.white,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                // color: Colors.white,
                                                                color: Theme.of(context).canvasColor,
                                                                width: 1)),
                                                        // child: const Icon(Icons.check, color: Colors.amber, size: 15)
                                                      )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: Container(
                                            height: double.infinity,
                                            // color: Colors.blue,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text('Onsite',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2!
                                                        .copyWith(
                                                            fontSize: 12)),
                                                SizedBox(
                                                    width:
                                                        SizeVariables.getWidth(
                                                                context) *
                                                            0.04),
                                                provider['data'][index]
                                                            ['onsite'] ==
                                                        1
                                                    ? Container(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.042,
                                                        height: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.042,
                                                        // color: Colors.white,
                                                        decoration:
                                                            BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                        // color: Colors
                                                                        //     .white,
                                                                        color: Theme.of(context)
                                                                            .canvasColor,
                                                                        width:
                                                                            1)),
                                                        child: const Icon(
                                                            Icons.check,
                                                            color: Colors.amber,
                                                            size: 15))
                                                    : Container(
                                                        width: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.042,
                                                        height: SizeVariables
                                                                .getWidth(
                                                                    context) *
                                                            0.042,
                                                        // color: Colors.white,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                // color: Colors.white,
                                                                color: Theme.of(context).canvasColor,
                                                                width: 1)),
                                                        // child: const Icon(Icons.check, color: Colors.amber, size: 15)
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
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeVariables.getHeight(context) * 0.02,
                      )
                    ],
                  ),
                  // itemCount: provider['data'].length
                  itemCount: provider['data'].length,
                  // itemCount: provider.length,
                  // provider['data'].length
                ),
              ),
            ),
    );
  }
}
