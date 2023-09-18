import 'package:claimz/utils/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../viewModel/announcementViewModel.dart';
import '../../config/mediaQuery.dart';

class AnnouncementHeader extends StatefulWidget {
  // const AnnouncementHeader({Key? key}) : super(key: key);

  @override
  State<AnnouncementHeader> createState() => _AnnouncementHeaderState();
}

class _AnnouncementHeaderState extends State<AnnouncementHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: SizeVariables.getHeight(context) * 0.1,
      // color: Colors.green,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.navbar);
              // Navigator.of(context).pop();
              // Provider.of<AnnouncementViewModel>(context, listen: false)
              //     .getAllAnouncements();
            },
            child: SvgPicture.asset(
              "assets/icons/back button.svg",
            ),
          ),
          SizedBox(width: SizeVariables.getWidth(context) * 0.05),
          Text(
            'Announcements',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
