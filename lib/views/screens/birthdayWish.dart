import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../provider/theme_provider.dart';
import '../../viewModel/birthdayViewModel.dart';
import '../../viewModel/profileViewModel.dart';
import '../config/mediaQuery.dart';

class BirthdayWish_Screen extends StatefulWidget {
  final Map<String, dynamic> birthdayDetails;
  final int index;
  final int userId;
  final Map<String, dynamic> profileDetails;

  BirthdayWish_Screen(
      this.birthdayDetails, this.index, this.userId, this.profileDetails);

  @override
  State<BirthdayWish_Screen> createState() => _BirthdayWish_ScreenState();
}

class _BirthdayWish_ScreenState extends State<BirthdayWish_Screen> {
  TextEditingController wish = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<BirthdayViewModel>(context, listen: false)
        .birthdayWish(widget.index, context)
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  // provider['data']['photo']
  // widget.profileDetails['userdata']['emp_name']

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final profileProvider =
        Provider.of<ProfileViewModel>(context).profileDetails;
    final birthdayWish = Provider.of<BirthdayViewModel>(context).birthdayWishes;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.025,
          right: SizeVariables.getWidth(context) * 0.025,
        ),
        child: ListView(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeVariables.getHeight(context) * 0.02,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      "assets/icons/back button.svg",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.02,
                      left: SizeVariables.getWidth(context) * 0.01),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      'Birthday',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 24,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeVariables.getHeight(context) * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ContainerStyle(
                height: height > 750
                    ? 40.h
                    : height < 650
                        ? 52.h
                        : 44.h,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: Colors.pink,
                        height: SizeVariables.getHeight(context) * 0.22,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      SizeVariables.getHeight(context) * 0.11,
                                ),
                                child: Container(
                                  child: Lottie.asset(
                                    'assets/birthday/Birthday blast.json',
                                    // fit: BoxFit.cover,
                                    height:
                                        SizeVariables.getHeight(context) * 0.5,
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child:
                                    // CircleAvatar(
                                    //   radius: SizeVariables.getWidth(context) * 0.13,
                                    //   backgroundColor: Colors.green,
                                    //   backgroundImage: NetworkImage(
                                    //       'https://console.claimz.in/api/api/${widget.birthdayDetails['profile_photo']}'),
                                    //   // child: const Icon(Icons.account_box, color: Colors.white),
                                    // ),
                                    widget.birthdayDetails['profile_photo'] ==
                                                null ||
                                            widget.birthdayDetails[
                                                    'profile_photo'] ==
                                                ''
                                        ? CircleAvatar(
                                            radius: SizeVariables.getWidth(
                                                    context) *
                                                0.05,
                                            backgroundColor: Colors.green,
                                            backgroundImage: const AssetImage(
                                                'assets/img/profilePic.jpg'),
                                            // child: const Icon(Icons.account_box, color: Colors.white),
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: widget.birthdayDetails[
                                                'profile_photo'],
                                            imageBuilder: (context,
                                                    imageProvider) =>
                                                CircleAvatar(
                                                    radius:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.065,
                                                    backgroundColor:
                                                        Colors.green,
                                                    backgroundImage:
                                                        imageProvider),
                                            //         Container(
                                            //   height: SizeVariables.getHeight(
                                            //           context) *
                                            //       0.065,
                                            //   width: SizeVariables.getHeight(
                                            //           context) *
                                            //       0.065,
                                            //   decoration: BoxDecoration(
                                            //       shape: BoxShape.circle,
                                            //       image: DecorationImage(
                                            //           image: imageProvider,
                                            //           fit: BoxFit.contain)),
                                            // ),
                                            placeholder: (context, url) =>
                                                Container(
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.065,
                                                    child: Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[400]!,
                                                      highlightColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              120,
                                                              120,
                                                              120),
                                                      child: CircleAvatar(
                                                        radius: SizeVariables
                                                                .getHeight(
                                                                    context) *
                                                            0.065,
                                                        backgroundColor:
                                                            Colors.green,
                                                        child: const Center(
                                                          child: Icon(
                                                              Icons
                                                                  .camera_alt_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: 20),
                                                        ),
                                                      ),
                                                    )),
                                          )),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: SizeVariables.getHeight(context) * 0.13,
                                ),
                                child: Container(
                                  child: Lottie.asset(
                                    'assets/birthday/Birthday blast.json',
                                    // fit: BoxFit.cover,
                                    height:
                                        SizeVariables.getHeight(context) * 0.1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          'Happy Birthday!',
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 28,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: SizeVariables.getHeight(context) * 0.01,
                      ),
                      Container(
                        child: Text(
                          'Hey ${widget.birthdayDetails['emp_name'].split(' ')[0]}, hope you have a wonderful year ahead',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: SizeVariables.getHeight(context) * 0.01,
                      ),
                      InkWell(
                        onTap: () => birthdayPopup(context, profileProvider),
                        child: Container(
                          child: SvgPicture.asset(
                            "assets/birthday/comment.svg",
                            height: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    height: height > 750
                        ? 50.h
                        : height < 650
                            ? 50.h
                            : 46.h,
                    child: birthdayWish.isEmpty
                        ? const Center(
                            child:
                                Text('Your Birthday Wishes Will Appear Here'),
                          )
                        : ListView.builder(
                            itemCount: birthdayWish.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: ContainerStyle(
                                height: height > 750
                                    ? 17.4.h
                                    : height < 650
                                        ? 25.h
                                        : 23.h,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.loose,
                                          child: SvgPicture.asset(
                                            "assets/birthday/cake.svg",
                                            color: Colors.white,
                                            height: SizeVariables.getHeight(
                                                    context) *
                                                0.1,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 4,
                                          fit: FlexFit.loose,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  birthdayWish[index]['wish'],
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              birthdayWish[
                                                                      index]
                                                                  ['emp_name'],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              birthdayWish[
                                                                      index][
                                                                  'updated_at'],
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontSize: 8,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Container(
                                                      child: birthdayWish[index]
                                                                      [
                                                                      'profile_photo'] ==
                                                                  null ||
                                                              birthdayWish[
                                                                          index]
                                                                      [
                                                                      'profile_photo'] ==
                                                                  ''
                                                          ? CircleAvatar(
                                                              radius: SizeVariables
                                                                      .getWidth(
                                                                          context) *
                                                                  0.02,
                                                              backgroundColor:
                                                                  Colors.green,
                                                              backgroundImage:
                                                                  const AssetImage(
                                                                'assets/img/profilePic.jpg',
                                                              ),
                                                            )
                                                          : CachedNetworkImage(
                                                              imageUrl:
                                                                  birthdayWish[
                                                                          index]
                                                                      [
                                                                      'profile_photo'],
                                                              imageBuilder: (context,
                                                                      imageProvider) =>
                                                                  CircleAvatar(
                                                                radius: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.02,
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                backgroundImage:
                                                                    imageProvider,
                                                              ),
                                                              placeholder:
                                                                  (context,
                                                                          url) =>
                                                                      Container(
                                                                height: SizeVariables
                                                                        .getHeight(
                                                                            context) *
                                                                    0.02,
                                                                child: Shimmer
                                                                    .fromColors(
                                                                  baseColor:
                                                                      Colors.grey[
                                                                          400]!,
                                                                  highlightColor:
                                                                      const Color
                                                                          .fromARGB(
                                                                    255,
                                                                    120,
                                                                    120,
                                                                    120,
                                                                  ),
                                                                  child:
                                                                      CircleAvatar(
                                                                    radius: SizeVariables.getHeight(
                                                                            context) *
                                                                        0.02,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                    child:
                                                                        const Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .camera_alt_outlined,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
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
      ),
    );
  }

  Future<dynamic> birthdayPopup(
      BuildContext context, Map<String, dynamic> profileProvider) {
    return showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Birthday',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
              TextFormField(
                controller: wish,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 167, 164, 164),
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromARGB(255, 81, 80, 80),
                    ),
                  ),
                  labelText: 'Birthday Wish',
                  labelStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                ),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Map<String, dynamic> data = {
                  'candidate_id': widget.birthdayDetails['id'],
                  'wish': wish.text,
                  'birth_date': widget.birthdayDetails['birth_date'],
                  'name': widget.profileDetails['userdata']['emp_name'],
                  'profilePicture': profileProvider['data']['photo'],
                  'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(
                    DateTime.now(),
                  ),
                };

                wish.text == '' || wish.text == null
                    ? Flushbar(
                        duration: const Duration(seconds: 4),
                        flushbarPosition: FlushbarPosition.BOTTOM,
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.error, color: Colors.red),
                        message: 'Your Birthday Wish Cannot Be Blank',
                        barBlur: 20,
                      ).show(context)
                    : Provider.of<BirthdayViewModel>(context, listen: false)
                        .birthdayWishPost(data, widget.index, context)
                        .then(
                          (value) => wish.clear(),
                        );
              },
              child: Text(
                'Wish',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
