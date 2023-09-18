import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/data/response/status.dart';
import 'package:claimz/res/components/badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../utils/routes/routeNames.dart';
import '../../../viewModel/claimsStatusViewModel.dart';
import '../../config/mediaQuery.dart';
import '../../../viewModel/userViewModel.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/profileViewModel.dart';
import '../../../res/appUrl.dart';
import '../../screens/profileScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../res/appUrl.dart';

class HeaderWidget extends StatefulWidget {
  final Map<String, dynamic> profileDetails;

  HeaderWidget(this.profileDetails);

  HeaderWidgetState createState() => HeaderWidgetState();
}

class HeaderWidgetState extends State<HeaderWidget> {
  // final profileViewModel = ProfileViewModel();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   profileViewModel.getProfileDetails(context);
  //   super.initState();
  // }
  File? image;
  bool isLoading = true;
  int? count;

  @override
  void initState() {
    // TODO: implement initState
    count = Provider.of<ClaimzStatusViewModel>(context, listen: false).count;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SizeVariables().init(context);
    // TODO: implement build

    final provider = Provider.of<ProfileViewModel>(context).profileDetails;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
        height: SizeVariables.getHeight(context) * 0.12,
        width: double.infinity,
        // color: Colors.red,
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen(widget.profileDetails)));
                    Provider.of<UserViewModel>(context, listen: false)
                        .getUser();
                  },
                  child: Container(
                    // color: Colors.red,
                    width: SizeVariables.getWidth(context) * 0.8,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileScreen(widget.profileDetails)));
                              Provider.of<UserViewModel>(context, listen: false)
                                  .getUser();
                            },
                            child: provider['data']['photo'] == ''
                                ? CircleAvatar(
                                    radius:
                                        SizeVariables.getWidth(context) * 0.08,
                                    backgroundColor: Colors.green,
                                    backgroundImage: const AssetImage(
                                        'assets/img/profilePic.jpg'),
                                    // child: const Icon(Icons.account_box, color: Colors.white),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: provider['data']['photo'],
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.08,
                                      width: SizeVariables.getHeight(context) *
                                          0.08,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.contain)),
                                    ),
                                    placeholder: (context, url) => Container(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.06,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey[400]!,
                                          highlightColor: const Color.fromARGB(
                                              255, 120, 120, 120),
                                          child: const CircleAvatar(
                                            radius: 2,
                                            backgroundColor: Colors.green,
                                            child: Center(
                                              child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.white,
                                                  size: 20),
                                            ),
                                          ),
                                        )),
                                  ),
                          ),
                        ),
                        Flexible(
                          flex: 9,
                          fit: FlexFit.tight,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: height > 750
                                  ? 2.h
                                  : height < 650
                                      ? 1.5.h
                                      : 1.1.h,
                              left: SizeVariables.getWidth(context) * 0.02,
                            ),
                            height: double.infinity,
                            // color: Colors.amber,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    widget.profileDetails['userdata']
                                        ['emp_name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 20),
                                  ),
                                ),
                                Container(
                                  // color: Colors.amber,
                                  width: SizeVariables.getWidth(context) * 0.7,
                                  // height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Icon(
                                          Icons.shield,
                                          color: Colors.grey,
                                          size: 17,
                                        ),
                                      ),
                                      // FittedBox(
                                      //   fit: BoxFit.contain,
                                      //   child: Text(
                                      //     '${widget.profileDetails['userdata']['emp_code']} ',
                                      //     style: Theme.of(context)
                                      //         .textTheme
                                      //         .bodyText1!
                                      //         .copyWith(color: Colors.grey),
                                      //   ),
                                      // ),
                                      Expanded(
                                        // fit: BoxFit.contain,
                                        child: Text(
                                          // '| ${widget.profileDetails['userdata']['designation']}',
                                          "${widget.profileDetails['userdata']['emp_code']} | ${widget.profileDetails['userdata']['designation']}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color: Color.fromARGB(
                                                      255, 218, 255, 219)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     right: SizeVariables.getWidth(context) * 0.004,
                        //   ),
                        //   child: InkWell(
                        //     onTap: () {},
                        //     child: const FittedBox(
                        //       fit: BoxFit.contain,
                        //       child: Icon(
                        //         Icons.chat_outlined,
                        //         color: const Color(0xffF59F23),
                        //         size: 27,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     right: SizeVariables.getWidth(context) * 0.02,
                        //   ),
                        // child: InkWell(
                        //   onTap: () {},
                        //   child: const FittedBox(
                        //     fit: BoxFit.contain,
                        //     child: Icon(
                        //       Icons.notifications_outlined,
                        //       color: const Color(0xffF59F23),
                        //       size: 30,
                        //     ),
                        //   ),
                        // ),
                        // ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: SizeVariables.getHeight(context) * 0.07,
                  width: SizeVariables.getWidth(context) * 0.1,
                  // color: Colors.amber,
                  child: Stack(
                    children: [
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteNames.notificationList);
                            setState(() {
                              count = 0;
                            });
                          },
                          child: const FittedBox(
                            fit: BoxFit.contain,
                            child: Icon(
                              Icons.notifications_outlined,
                              color: const Color(0xffF59F23),
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      count == 0
                          ? Container()
                          : Positioned(
                              top: SizeVariables.getHeight(context) * 0.002,
                              right: SizeVariables.getWidth(context) * 0.0005,
                              child: Badges(label: count.toString()),
                            )
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
