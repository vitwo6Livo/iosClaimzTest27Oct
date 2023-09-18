import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../res/components/containerStyle.dart';
import '../../viewModel/notificationAndEvent.dart';
import '../config/mediaQuery.dart';
import '../widgets/managerScreenWidgets/claimManager/claimManagerScreen.dart';
import '../widgets/managerScreenWidgets/leaveRequest/leaveRequestManager.dart';
import '../widgets/managerScreenWidgets/regularizations/regularizationManager.dart';
import 'managerCompOffList.dart';
import 'managerIncidentalScreen/managerIncidental.dart';
import 'managertravelClaimList.dart';

class NotificationList extends StatefulWidget {
  NotificationListState createState() => NotificationListState();
}

class NotificationListState extends State<NotificationList> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NotificationAndEvent>(context, listen: false)
        .getNotification()
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notification =
        Provider.of<NotificationAndEvent>(context).notification;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Container(
            padding: EdgeInsets.only(
              top: SizeVariables.getHeight(context) * 0.008,
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.of(context).pushNamed(RouteNames.navbar);
                    Navigator.of(context).pop();

                    // Navigator.pushReplacementNamed(
                    //     context, RouteNames.incidentalClaimsScreen);
                  },
                  child: SvgPicture.asset(
                    "assets/icons/back button.svg",
                  ),
                ),
                SizedBox(width: SizeVariables.getWidth(context) * 0.02),
                Container(
                  child: Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          )),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : notification['data'].isEmpty
                ? const Center(
                    child: Text('No Notifications'),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => notification['data'][index]['notification_type'] ==
                              'leave'
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LeaveRequestManager()))
                          : notification['data'][index]['notification_type'] ==
                                  'regularisation'
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ManagerRegularizations()))
                              : notification['data'][index]['notification_type'] ==
                                      'compoff'
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ManagerCompOffList()))
                                  : notification['data'][index]
                                              ['notification_type'] ==
                                          'incidental'
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ManagerIncidentalExpenseScreen()))
                                      : notification['data'][index]['notification_type'] == 'conveyance'
                                          ? Navigator.push(context, MaterialPageRoute(builder: (context) => ClaimManagerScreen()))
                                          : notification['data'][index]['notification_type'] == 'conveyance'
                                              ? Navigator.push(context, MaterialPageRoute(builder: (context) => ManagerTravelClaimList()))
                                              : null,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.05,
                          right: SizeVariables.getWidth(context) * 0.05,
                          bottom: SizeVariables.getHeight(context) * 0.02,
                        ),
                        child: ContainerStyle(
                          height: SizeVariables.getHeight(context) * 0.12,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.loose,
                                child: notification['data'][index]
                                                ['profile_photo'] ==
                                            null ||
                                        notification['data'][index]
                                                ['profile_photo'] ==
                                            ''
                                    ? CircleAvatar(
                                        radius:
                                            SizeVariables.getHeight(context) *
                                                0.05,
                                        backgroundColor: Colors.red,
                                        backgroundImage: const AssetImage(
                                            'assets/img/profilePic.jpg'))
                                    : CachedNetworkImage(
                                        imageUrl:
                                            '${notification['data'][index]['profile_photo']}',
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                CircleAvatar(
                                          radius:
                                              SizeVariables.getWidth(context) *
                                                  0.08,
                                          backgroundColor: Colors.green,
                                          backgroundImage: imageProvider,
                                          // child: const Icon(Icons.account_box, color: Colors.white),
                                        ),
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey[400]!,
                                          highlightColor: const Color.fromARGB(
                                              255, 120, 120, 120),
                                          child: CircleAvatar(
                                              radius: SizeVariables.getWidth(
                                                      context) *
                                                  0.08),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            CircleAvatar(
                                          radius:
                                              SizeVariables.getWidth(context) *
                                                  0.08,
                                          backgroundColor: Colors.green,
                                          backgroundImage: const AssetImage(
                                              'assets/img/profilePic.jpg'),
                                          // child: const Icon(Icons.account_box, color: Colors.white),
                                        ),
                                      ),
                              ),
                              SizedBox(
                                  width:
                                      SizeVariables.getWidth(context) * 0.01),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.01,
                                    top: SizeVariables.getHeight(context) *
                                        0.008,
                                  ),
                                  // color: Colors.white,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Container(
                                          // color: Colors.red,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(notification['data'][index]
                                                  ['notification_title']),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Container(
                                          // color: Colors.green,
                                          child: Text(
                                              notification['data'][index]
                                                  ['notification_message'],
                                              style: const TextStyle(
                                                  color: Colors.grey)),
                                        ),
                                      )
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                      //   children: [
                                      // Text(notification['data'][index]
                                      //     ['notification_title']),
                                      //   ],
                                      // ),
                                      // Text(notification['data'][index]
                                      //     ['notification_message'])
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: notification['data'].length,
                    // itemCount: 10,
                  ),
      ),
    );
  }
}
