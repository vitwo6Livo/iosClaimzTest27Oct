import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/routes/routeNames.dart';
import '../../../viewModel/announcementCountViewModel.dart';
import '../../../viewModel/dashboardAnnouncementViewModel.dart';
import '../../config/mediaQuery.dart';
import '../../config/appColors.dart';
import '../../../res/components/containerStyle.dart';
import '../../../res/components/badge.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/announcementViewModel.dart';
import '../../../data/response/status.dart';
import '../../../viewModel/claimsStatusViewModel.dart';

class BirthdayAndAnnouncementShimmer extends StatefulWidget {
  // final DashboardAnnouncementViewModel announcements;
  BirthdayAndAnnouncementShimmerState createState() =>
      BirthdayAndAnnouncementShimmerState();

  // BirthdayAndAnnouncementShimmer(this.announcements);
}

class BirthdayAndAnnouncementShimmerState
    extends State<BirthdayAndAnnouncementShimmer> {
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
    final provider = Provider.of<ClaimzStatusViewModel>(context).claimzStatuss;
    final anouncementProvider =
        Provider.of<AnnouncementViewModel>(context).allAnouncements;

    // TODO: implement build
    return Container(
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
            child: Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: const Color.fromARGB(255, 120, 120, 120),
              child: GlassmorphicContainer(
                width: MediaQuery.of(context).size.width * 1,
                height: double.infinity,
                borderRadius: MediaQuery.of(context).size.width * 0.02,
                border: 0.06,
                blur: 15,
                linearGradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 100, 100, 100),
                      Color.fromARGB(255, 65, 65, 65)
                    ],
                    stops: [
                      0.1,
                      1
                    ]),
                borderGradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 100, 100, 100),
                    Color.fromARGB(255, 65, 65, 65)
                  ],
                ),
                child: Container(
                  height: SizeVariables.getHeight(context) * 0.1,
                  width: SizeVariables.getWidth(context) * 0.20,
                  color: Colors.red,
                  // child: Image.asset('assets/img/bIrthdayIcon-01.png'),
                  // schild: Image.asset('assets/img/bIrthdayIcon-01.png')
                ),
              ),
            ),
          ),
          SizedBox(width: SizeVariables.getWidth(context) * 0.07),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: const Color.fromARGB(255, 120, 120, 120),
              child: ContainerStyle(
                height: double.infinity,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
