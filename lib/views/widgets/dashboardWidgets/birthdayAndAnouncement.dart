import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../../res/appUrl.dart';
import '../../../utils/routes/routeNames.dart';
import '../../../viewModel/announcementCountViewModel.dart';
import '../../../viewModel/dashboardAnnouncementViewModel.dart';
import '../../../viewModel/profileViewModel.dart';
import '../../config/mediaQuery.dart';
import '../../config/appColors.dart';
import '../../../res/components/containerStyle.dart';
import '../../../res/components/badge.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/announcementViewModel.dart';
import '../../../data/response/status.dart';
import '../../../viewModel/claimsStatusViewModel.dart';
import '../../screens/birthdayWish.dart';
import './birthdayWidget.dart';
import '../../../models/dashboardModel.dart';

class BirthdayAndAnnouncement extends StatefulWidget {
  final Map<String, dynamic> profileDetails;

  BirthdayAndAnnouncement(this.profileDetails);

  // final DashboardAnnouncementViewModel announcements;
  BirthdayAndAnnouncementState createState() => BirthdayAndAnnouncementState();

  // BirthdayAndAnnouncement(this.announcements);
}

class BirthdayAndAnnouncementState extends State<BirthdayAndAnnouncement> {
  int? count;

  @override
  void initState() {
    // TODO: implement initState
    count = Provider.of<ClaimzStatusViewModel>(context, listen: false).count;
    print('COUNT: $count');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final provider = Provider.of<ClaimzStatusViewModel>(context).claimzStatuss;
    final anouncementProvider =
        Provider.of<AnnouncementViewModel>(context).allAnouncements;

    // final count = Provider.of<ClaimzStatusViewModel>(context).count;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: SizeVariables.getHeight(context) * 0.25,
      // color: Colors.red,
      padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.005,
          right: SizeVariables.getWidth(context) * 0.005),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: BirthdayWidget(
              height: double.infinity,
              child: provider['data']['dashboard_data']['birthdays'].isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: SizeVariables.getHeight(context) * 0.18,
                            width: SizeVariables.getWidth(context) * 0.60,
                            // color: Colors.red,
                            child: Lottie.asset(
                              'assets/birthday/Birthday.json',
                            ),
                            // Image.asset('assets/birthday/Birthday.json'),
                            // schild: Image.asset('assets/img/bIrthdayIcon-01.png')
                          ),
                          Text('No cakes for today',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1! //Tanay--- I have made this change of bang operator
                              ),
                        ],
                      ),
                    )
                  : PageView.builder(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => BirthdayWish_Screen(
                                    provider['data']['dashboard_data']
                                        ['birthdays'][index],
                                    index,
                                    provider['data']['dashboard_data']
                                        ['user_id'],
                                    widget.profileDetails))),
                        child: Stack(
                          children: [
                            Container(
                              // color: Colors.red,
                              margin: EdgeInsets.only(
                                  top: SizeVariables.getHeight(context) * 0.04),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // CircleAvatar(
                                  //   backgroundColor: Colors.red,
                                  //   backgroundImage: const AssetImage(
                                  //       'assets/img/profilePic.jpg'),
                                  //   radius: SizeVariables.getHeight(context) *
                                  //       0.065,
                                  // ),
                                  provider['data']['dashboard_data']
                                                      ['birthdays'][index]
                                                  ['profile_photo'] ==
                                              null ||
                                          provider['data']['dashboard_data']
                                                      ['birthdays'][index]
                                                  ['profile_photo'] ==
                                              ''
                                      ? CircleAvatar(
                                          radius:
                                              SizeVariables.getWidth(context) *
                                                  0.065,
                                          backgroundColor: Colors.green,
                                          backgroundImage: const AssetImage(
                                              'assets/img/profilePic.jpg'),
                                          // child: const Icon(Icons.account_box, color: Colors.white),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: provider['data']
                                                      ['dashboard_data']
                                                  ['birthdays'][index]
                                              ['profile_photo'],
                                          imageBuilder: (context,
                                                  imageProvider) =>
                                              CircleAvatar(
                                                  radius:
                                                      SizeVariables.getHeight(
                                                              context) *
                                                          0.065,
                                                  backgroundColor: Colors.green,
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
                                                            255, 120, 120, 120),
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
                                                            color: Colors.white,
                                                            size: 20),
                                                      ),
                                                    ),
                                                  )),
                                        ),
                                  SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.01),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeVariables.getWidth(context) *
                                                  0.02,
                                          right:
                                              SizeVariables.getWidth(context) *
                                                  0.02),
                                      child: Text(
                                          'Today Is ${provider['data']['dashboard_data']['birthdays'][index]['emp_name']}\'s Birthday',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    SizeVariables.getHeight(context) * 0.01),
                                child: CircleAvatar(
                                  radius:
                                      SizeVariables.getWidth(context) * 0.03,
                                  backgroundColor: Colors.red,
                                  child: Center(
                                    child: Text(
                                      provider['data']['dashboard_data']
                                              ['birthdays']
                                          .length
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      itemCount: provider['data']['dashboard_data']['birthdays']
                          .length,
                    ),
            ),
          ),
          SizedBox(width: SizeVariables.getWidth(context) * 0.07),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.announcementscreen);
                setState(() {
                  count = 0;
                });
                // setState(() {

                // });
                // provider['data']['dashboard_data']['unread_announcements'] = 0;
              },
              child: Container(
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
                  height: double.infinity,
                  child: anouncementProvider['data'].isEmpty ||
                          anouncementProvider == {}
                      ? Container(
                          child: Lottie.asset(
                            'assets/birthday/No Announcement.json',
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            count == 0
                                ? Container(
                                    width: double.infinity,
                                    height:
                                        SizeVariables.getHeight(context) * 0.04,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Announcements',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                  color:
                                                      (themeProvider.darkTheme)
                                                          ? Colors.white
                                                          : Theme.of(context)
                                                              .colorScheme
                                                              .onPrimary),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    width: double.infinity,
                                    height:
                                        SizeVariables.getHeight(context) * 0.04,
                                    // color: Colors.white,
                                    margin: EdgeInsets.only(
                                        top: SizeVariables.getHeight(context) *
                                            0.005),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Announcements',
                                            style: TextStyle(
                                                color: (themeProvider.darkTheme)
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                        SizedBox(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.008),
                                        Padding(
                                            padding: EdgeInsets.all(
                                                SizeVariables.getHeight(
                                                        context) *
                                                    0.005),
                                            child: Badges(
                                              label: count.toString(),
                                            )),
                                      ],
                                    ),
                                  ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                // color: Colors.red,
                                padding: EdgeInsets.only(
                                    top:
                                        SizeVariables.getHeight(context) * 0.01,
                                    bottom: SizeVariables.getHeight(context) *
                                        0.01),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.04,
                                    ),
                                    Expanded(
                                      child: Text(
                                        anouncementProvider['data'][0]
                                            ['announcement_title'],
                                        //     anouncementProvider['data'][
                                        // 0]['announcement_title'],
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                    Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.05,
                                      width: double.infinity,
                                      // color: Colors.amber,
                                      padding: EdgeInsets.only(
                                          left:
                                              SizeVariables.getWidth(context) *
                                                  0.02),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          anouncementProvider['data'][
                                                      anouncementProvider[
                                                                  'data']
                                                              .length -
                                                          1]['profile_photo'] ==
                                                  null
                                              ? CircleAvatar(
                                                  radius:
                                                      SizeVariables.getWidth(
                                                              context) *
                                                          0.08,
                                                  backgroundColor: Colors.green,
                                                  backgroundImage: const AssetImage(
                                                      'assets/img/profilePic.jpg'),
                                                  // child: const Icon(Icons.account_box, color: Colors.white),
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl:
                                                      '${AppUrl.baseUrl}/profile_photo/${anouncementProvider['data'][anouncementProvider['data'].length - 1]['profile_photo']}',
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      CircleAvatar(
                                                    backgroundImage:
                                                        imageProvider,
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[400]!,
                                                    highlightColor:
                                                        Color.fromARGB(
                                                            255, 120, 120, 120),
                                                    child: const CircleAvatar(),
                                                  ),
                                                ),
                                          SizedBox(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.04),
                                          Text(
                                            '${anouncementProvider['data'][anouncementProvider['data'].length - 1]['emp_name'].split(' ')[0]}',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .canvasColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
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
