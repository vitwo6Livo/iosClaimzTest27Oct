import 'package:claimz/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/routes/routeNames.dart';
import '../../config/mediaQuery.dart';
import '../../../viewModel/userViewModel.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/profileViewModel.dart';
import '../../../res/appUrl.dart';
import '../../screens/profileScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../res/appUrl.dart';

class HeaderShimmer extends StatelessWidget {
  // final profileViewModel = ProfileViewModel();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   profileViewModel.getProfileDetails(context);
  //   super.initState();
  // }
  File? image;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    // SizeVariables().init(context);
    // TODO: implement build

    final provider = Provider.of<ProfileViewModel>(context).profileDetails;

    return Container(
        height: SizeVariables.getHeight(context) * 0.12,
        width: double.infinity,
        // color: Colors.red,
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  fit: FlexFit.tight,
                  child: Container(
                    height: SizeVariables.getHeight(context) * 0.06,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Color.fromARGB(255, 120, 120, 120),
                      child: const CircleAvatar(
                        radius: 2,
                        backgroundColor: Colors.green,
                        child: Center(
                          child: Icon(Icons.camera_alt_outlined,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 9,
                  fit: FlexFit.tight,
                  child: Container(
                    width: double.infinity,
                    height: SizeVariables.getHeight(context) * 0.2,
                    padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.02),
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Color.fromARGB(255, 120, 120, 120),
                          child: Container(
                            width: SizeVariables.getWidth(context) * 0.5,
                            height: SizeVariables.getHeight(context) * 0.015,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                            height: SizeVariables.getHeight(context) * 0.01),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Color.fromARGB(255, 120, 120, 120),
                          child: Container(
                            width: SizeVariables.getWidth(context) * 0.4,
                            height: SizeVariables.getHeight(context) * 0.015,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Flexible(
                //   flex: 9,
                //   fit: FlexFit.tight,
                //   child: Container(
                //     padding: EdgeInsets.only(
                //       top: SizeVariables.getHeight(context) * 0.01,
                //       // left: SizeVariables.getWidth(context) * 0.02,
                //     ),
                //     height: double.infinity,
                //     // color: Colors.amber,
                //     child: Column(
                //       // mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         FittedBox(
                //           fit: BoxFit.contain,
                //           // child: Text(
                //           //   widget.profileDetails['userdata']['emp_name'],
                //           //   style: const TextStyle(
                //           //     fontSize: 16,
                //           //     color: Colors.white,
                //           //   ),
                //           // ),
                //           child: Container(
                //               width: SizeVariables.getWidth(context) * 0.8,
                //               height: SizeVariables.getHeight(context) * 0.05,
                //               color: Colors.black,
                //               child: Shimmer.fromColors(
                //                 baseColor: Colors.grey[400]!,
                //                 highlightColor:
                //                     Color.fromARGB(255, 120, 120, 120),
                //                 child: Container(
                //                   width: double.infinity,
                //                   height:
                //                       SizeVariables.getHeight(context) * 0.01,
                //                   color: Colors.black,
                //                 ),
                //               )),
                //         ),
                //         FittedBox(
                //           fit: BoxFit.contain,
                //           // child: Text(
                //           //   'Designation',
                //           //   style: Theme.of(context).textTheme.bodyText1,
                //           // ),
                //           child: Shimmer.fromColors(
                //             baseColor: Colors.grey[400]!,
                //             highlightColor: Color.fromARGB(255, 120, 120, 120),
                //             child: Container(
                //               width: SizeVariables.getWidth(context) * 0.8,
                //               height: SizeVariables.getHeight(context) * 0.05,
                //               color: Colors.black,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(
                //     right: SizeVariables.getWidth(context) * 0.004,
                //   ),
                //   child: InkWell(
                //     onTap: () {},
                //     child: FittedBox(
                //       fit: BoxFit.contain,
                //       child: Icon(
                //         Icons.chat_outlined,
                //         color: const Color(0xffF59F23),
                //         size: 27,
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    right: SizeVariables.getWidth(context) * 0.02,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Icon(
                        Icons.notifications_outlined,
                        color: const Color(0xffF59F23),
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
