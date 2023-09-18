import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../res/components/containerStyle.dart';
import '../../utils/routes/routeNames.dart';
import '../../viewModel/profileViewModel.dart';
import '../config/mediaQuery.dart';
import 'profileScreen.dart';

class TicketManu extends StatefulWidget {
  // const TicketManu({Key? key}) : super(key: key);
  List<Map<String, dynamic>> images = [
    {
      'image': "assets/icons/ticket-form.svg",
      'route': RouteNames.ticketscreen,
      'name': "Form"
    },
    {
      'image': "assets/icons/feedback.svg",
      'route': RouteNames.tickethistoryscroll,
      'name': "History"
    },
  ];

  @override
  State<TicketManu> createState() => _TicketManuState();
}

class _TicketManuState extends State<TicketManu> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final profileProvider =
        Provider.of<ProfileViewModel>(context).profileDetails;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Container(
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.025,
              right: SizeVariables.getWidth(context) * 0.025,
            ),
            child: ListView(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: SizeVariables.getHeight(context) * 0.02,
                              ),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.of(context).pop();
                                  // Navigator.pushNamed(context, routeName);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                          profileProvider['data'])));
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/back button.svg",
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeVariables.getHeight(context) * 0.024,
                                  left: SizeVariables.getWidth(context) * 0.01),
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Ticket Menu',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(30),
                      //       ),
                      //       primary: (themeProvider.darkTheme)
                      //           ? Color.fromARGB(168, 94, 92, 92)
                      //           : Colors.amberAccent,
                      //     ),
                      //     onPressed: () {
                      //       Navigator.pushNamed(
                      //           context, RouteNames.tickethistory);
                      //     },
                      //     child: Text('View ',
                      //         style: (themeProvider.darkTheme)
                      //             ? Theme.of(context)
                      //                 .textTheme
                      //                 .bodyText2
                      //                 ?.copyWith(
                      //                   color: Color(0xffF59F23),
                      //                 )
                      //             : TextStyle(
                      //                 color: Colors.black,
                      //               )),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.025,
                    right: SizeVariables.getWidth(context) * 0.025,
                  ),
                  height: height > 750
                      ? 48.h
                      : height < 650
                          ? 103.h
                          : 58.h,
                  // color: Colors.amber,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, widget.images[index]['route']);
                        },
                        child: ContainerStyle(
                          height: SizeVariables.getHeight(context) * 0.5,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(widget.images[index]['image']),
                                SizedBox(
                                    height: SizeVariables.getHeight(context) *
                                        0.02),
                                Text(
                                  widget.images[index]['name'],
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
