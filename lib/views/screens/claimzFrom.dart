// import 'package:claimz/views/widgets/claimzWidget/claimzContainer.dart';
import 'package:claimz/views/widgets/claimzfromWidget/claimzContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/routes/routeNames.dart';
import '../config/mediaQuery.dart';
// import '../widgets/claimzWidget/claimzContainer.dart';
// import '../widgets/claimzWidget/claimzHeader.dart';
import '../widgets/claimzfromWidget/claimzHeader.dart';
import '../widgets/incidentalExpenseWidget/approvedIncidental.dart';
import '../widgets/incidentalExpenseWidget/pendingIncidental.dart';
import '../widgets/incidentalExpenseWidget/rejectedIncidental.dart';

class ClaimzFrom extends StatefulWidget {
  final String claimzId;
  final String docId;

  ClaimzFrom({required this.claimzId, required this.docId});
  // const ClaimzFrom({Key? key}) : super(key: key);

  @override
  State<ClaimzFrom> createState() => _ClaimzFromState();
}

class _ClaimzFromState extends State<ClaimzFrom> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    // return Stack(
    //   children: [
    //     Scaffold(
    //       backgroundColor: Color.fromARGB(94, 129, 128, 128),
    //       // appBar: AppBar(
    //       //   elevation: 12,
    //       //   backgroundColor: Colors.black,
    //       //   shadowColor: Colors.grey,
    //       //   shape: RoundedRectangleBorder(
    //       //       borderRadius: BorderRadius.only(
    //       //           bottomLeft: Radius.circular(300),
    //       //           bottomRight: Radius.circular(5))),
    //       //   bottom: PreferredSize(
    //       //       child: SizedBox(), preferredSize: Size.fromHeight(100)),
    //       // ),

    //       body: ListView(
    //         children: [
    //           ClaimzHeader(),
    //           ClipPath(
    //             clipper: CurvedAppBar(),
    //             child: Container(
    //               // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    //               height: SizeVariables.getHeight(context) * 0.15,
    //               decoration: BoxDecoration(
    //                 color: Colors.black,
    //               ),
    //               child: Container(),
    //             ),
    //           ),
    //           Container(
    //             height: 700,
    //             color: Colors.amber,
    //             child: DefaultTabController(
    //               length: 3,
    //               child: Scaffold(
    //                 appBar: AppBar(
    //                   backgroundColor: Color.fromARGB(94, 217, 214, 214),
    //                   automaticallyImplyLeading: false,
    //                   elevation: 10,
    //                   title: Container(
    //                     padding: EdgeInsets.only(
    //                       top: SizeVariables.getHeight(context) * 0.008,
    //                     ),
    //                     // child: Row(
    //                     //   children: [
    //                     //     InkWell(
    //                     //       onTap: () {
    //                     //         // Navigator.of(context).pushNamed(RouteNames.navbar);
    //                     //         Navigator.of(context).pop();
    //                     //       },
    //                     //       child: SvgPicture.asset(
    //                     //         "assets/icons/back button.svg",
    //                     //       ),
    //                     //     ),
    //                     //     SizedBox(
    //                     //         width: SizeVariables.getWidth(context) * 0.05),
    //                     //     Container(
    //                     //       padding: EdgeInsets.only(
    //                     //         left: SizeVariables.getWidth(context) * 0.01,
    //                     //       ),
    //                     //       child: Text(
    //                     //         'Incidental Expenses',
    //                     //         style: Theme.of(context).textTheme.caption,
    //                     //       ),
    //                     //     ),
    //                     //   ],
    //                     // ),
    //                   ),
    //                   bottom: const TabBar(indicatorColor: Colors.amber, tabs: [
    //                     Tab(text: 'All',),
    //                     Tab(text: 'Domestic'),
    //                     Tab(text: 'International'),
    //                   ]),
    //                 ),
    //                 // backgroundColor: Colors.wite,
    //                 body: isLoading
    //                     ? const Center(
    //                         child: CircularProgressIndicator(),
    //                       )
    //                     : TabBarView(
    //                         children: [
    //                           PendingIncidental(),
    //                           ApprovedIncidental(),
    //                           RejectedIncidental()
    //                         ],
    //                       ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );

    return Stack(
      children: [
        //   Image.asset(
        //   "assets/img/bg.png",
        //   height: MediaQuery.of(context).size.height,
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.cover,
        // ),
        Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.05,
              right: SizeVariables.getWidth(context) * 0.07,
            ),
            child: ListView(
              children: [
                ClaimzHeader(),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                ClaimzContainer(),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.002,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CurvedAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip

    double height = size.height;

    double width = size.width;

    var path = new Path();

    path.lineTo(0, height - 120);

    path.quadraticBezierTo(width / 2, height + 60, width, height + 80);

    path.lineTo(width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip

    return true;
  }
}
