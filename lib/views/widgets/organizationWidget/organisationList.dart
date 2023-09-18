import 'package:claimz/views/widgets/organizationWidget/orgWidget.dart';
import 'package:claimz/views/widgets/organizationWidget/organisationShimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../data/response/status.dart';
import '../../../provider/theme_provider.dart';
import '../../../viewModel/organisationViewModel.dart';
import '../../config/mediaQuery.dart';

class OrganisationList extends StatefulWidget {
  Map<String, dynamic> map;
  // const OrganisationList({Key? key}) : super(key: key);

  @override
  State<OrganisationList> createState() => _OrganisationListState();

  OrganisationList(this.map);
}

class _OrganisationListState extends State<OrganisationList> {
  // final organizationViewModel = OrganizationViewModel();
  // bool isLoading = true;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   organizationViewModel.getOrganisationList();
  //   setState(() {
  //     isLoading = false;
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Container(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.01),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/back button.svg",
                        ),
                      ),
                      // ProfilededarWidget(),
                      SizedBox(width: SizeVariables.getWidth(context) * 0.02),
                      Text(
                        widget.map['department'],
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                OrgWidget(widget.map),
              ],
            ),
          ),
        ),
      ),
    );
    // return ChangeNotifierProvider<OrganizationViewModel>(
    //   create: (context) => organizationViewModel,
    //   child: Consumer<OrganizationViewModel>(
    //     builder: (context, value, child) {
    //       switch (value.organisation.status) {
    //         case Status.LOADING:
    //           return OrganisationShimmer();
    //         case Status.ERROR:
    //           return Center(
    //             child: Text(value.organisation.message.toString()),
    //           );
    //         case Status.COMPLETED:
    //           return SafeArea(
    //             child: Scaffold(
    //               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    //               body: Padding(
    //                 padding: const EdgeInsets.only(left: 18, right: 18),
    //                 child: Container(
    //                   child: ListView(
    //                     children: [
    //                       Padding(
    //                         padding: EdgeInsets.only(
    //                             top: SizeVariables.getHeight(context) * 0.01),
    //                         child: Row(
    //                           children: [
    //                             InkWell(
    //                               onTap: () {
    //                                 Navigator.of(context).pop();
    //                               },
    //                               child: SvgPicture.asset(
    //                                 "assets/icons/back button.svg",
    //                               ),
    //                             ),
    //                             // ProfilededarWidget(),
    //                             SizedBox(
    //                                 width:
    //                                     SizeVariables.getWidth(context) * 0.02),
    //                             Text(
    //                               widget.map,
    //                               style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       OrgWidget(),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    //         default:
    //       }
    //       return Container();
    //     },
    //   ),
    // );
  }
}
