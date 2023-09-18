import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../res/components/containerStyle.dart';
import '../../viewModel/notificationAndEvent.dart';
import '../config/mediaQuery.dart';

class EventScreen extends StatefulWidget {
  EventScreenState createState() => EventScreenState();
}

class EventScreenState extends State<EventScreen> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<NotificationAndEvent>(context, listen: false)
        .getEvent()
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<NotificationAndEvent>(context).event;

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
            : ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(
                    left: SizeVariables.getWidth(context) * 0.05,
                    right: SizeVariables.getWidth(context) * 0.05,
                    bottom: SizeVariables.getHeight(context) * 0.02,
                  ),
                  child: ContainerStyle(
                    height: SizeVariables.getHeight(context) * 0.1,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: event['data'][index]['profile_photo'] ==
                                      null ||
                                  event['data'][index]['profile_photo'] == ''
                              ? CircleAvatar(
                                  radius:
                                      SizeVariables.getHeight(context) * 0.05,
                                  backgroundColor: Colors.red,
                                  backgroundImage: const AssetImage(
                                      'assets/img/profilePic.jpg'))
                              : CachedNetworkImage(
                                  imageUrl:
                                      '${event['data'][index]['profile_photo']}',
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius:
                                        SizeVariables.getWidth(context) * 0.08,
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
                                        radius:
                                            SizeVariables.getWidth(context) *
                                                0.08),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    radius:
                                        SizeVariables.getWidth(context) * 0.08,
                                    backgroundColor: Colors.green,
                                    backgroundImage: const AssetImage(
                                        'assets/img/profilePic.jpg'),
                                    // child: const Icon(Icons.account_box, color: Colors.white),
                                  ),
                                ),
                        ),
                        SizedBox(width: SizeVariables.getWidth(context) * 0.01),
                        Expanded(
                          flex: 5,
                          child: Container(
                            // color: Colors.white,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
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
                                        Text(event['data'][index]
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
                                    child: Expanded(
                                      child: Text(
                                          event['data'][index]
                                              ['notification_message'],
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ),
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
                itemCount: event['data'].length,
                // itemCount: 10,
              ),
      ),
    );
  }
}
