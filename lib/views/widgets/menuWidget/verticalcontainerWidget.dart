import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../viewModel/leaveTypeViewModel.dart';

class VerticalcontainerWidget extends StatefulWidget {
  // const VerticalcontainerWidget({Key? key}) : super(key: key);
  List<Map<String, dynamic>> images = [
    {
      "image": "assets/icons/attendance.svg",
      "name": "Attendance",
      "routes": RouteNames.attendance,
    },
    {
      "image": "assets/icons/leave request.svg",
      "name": "Leave Request",
      "routes": RouteNames.requestleave,
    },
    {
      "image": "assets/icons/regularisation.svg",
      "name": "Regularisation",
      "routes": RouteNames.regularisation,
    },
    {
      "image": "assets/icons/comp off.svg",
      "name": "Comp-off",
      "routes": RouteNames.compoff,
    },
    {
      "image": "assets/icons/payslip.svg",
      "name": "Paysilp",
      "routes": RouteNames.payslip,
    },
    {
      'image': 'assets/icons/admin.svg',
      'name': 'Managers',
      'routes': RouteNames.managerScreen
    },
    {
      "image": "assets/icons/organisation.svg",
      "name": "Organization",
      "routes": RouteNames.organization,
    },
  ];

  List<String> name = [
    "Attendance",
    "Leave Request",
    "Regularisation",
    "Comp-off",
    "Paysilp",
    'Managers',
    "Organization",
  ];

  @override
  State<VerticalcontainerWidget> createState() =>
      _VerticalcontainerWidgetState();
}

class _VerticalcontainerWidgetState extends State<VerticalcontainerWidget> {
  int? role;

  @override
  void initState() {
    // TODO: implement initState
    initialise();
    super.initState();
  }

  void initialise() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    setState(() {
      role = localStorage.getInt('role');
    });

    print('Role: $role');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeVariables.getHeight(context) * 0.95,
      color: Colors.red,
      // color: Colors.amber,
      // child: GridView.builder(
      //   physics: NeverScrollableScrollPhysics(),
      //   itemCount: widget.images.length,
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2,
      //     crossAxisSpacing: 20,
      //     mainAxisSpacing: 20,
      //   ),
      //   itemBuilder: (BuildContext context, int index) {
      //     return InkWell(
      //       onTap: () =>
      //           Navigator.pushNamed(context, widget.images[index]["routes"]),
      //       child: ContainerStyle(
      //         height: SizeVariables.getHeight(context) * 0.5,
      //         child: Center(
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               SvgPicture.asset(widget.images[index]["image"]),
      //               SizedBox(height: SizeVariables.getHeight(context) * 0.02),
      //               Text(
      //                 widget.name[index],
      //                 style: Theme.of(context).textTheme.bodyText1,
      //               )
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, widget.images[0]["routes"]),
            child: ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(widget.images[0]["image"]),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    Text(
                      widget.name[0],
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, widget.images[1]["routes"]),
            child: ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(widget.images[1]["image"]),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    Text(
                      widget.name[1],
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, widget.images[2]["routes"]),
            child: ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(widget.images[2]["image"]),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    Text(
                      widget.name[2],
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, widget.images[3]["routes"]),
            child: ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(widget.images[3]["image"]),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    Text(
                      widget.name[3],
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, widget.images[4]["routes"]),
            child: ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(widget.images[4]["image"]),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    Text(
                      widget.name[4],
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, widget.images[6]["routes"]),
            child: ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(widget.images[6]["image"]),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    Text(
                      widget.name[6],
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            ),
          ),
          role == 1
              ? InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, widget.images[5]["routes"]),
                  child: ContainerStyle(
                    height: SizeVariables.getHeight(context) * 0.5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(widget.images[5]["image"]),
                          SizedBox(
                              height: SizeVariables.getHeight(context) * 0.02),
                          Text(
                            widget.name[5],
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
