import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../viewModel/organisationViewModel.dart';
import '../config/mediaQuery.dart';
import '../widgets/organizationWidget/orgContainerWidget.dart';
import '../widgets/organizationWidget/orgHeaderWidget.dart';
import '../widgets/organizationWidget/organizationNew.dart';
import '../widgets/organizationWidget/organizationTree.dart';

class OrganizationScreen extends StatefulWidget {
  // const OrganizationScreen({Key? key}) : super(key: key);

  @override
  State<OrganizationScreen> createState() => _OrganizationScreenState();
}

class _OrganizationScreenState extends State<OrganizationScreen> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<OrganizationViewModel>(context, listen: false)
        .getOrganisation()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  // void apiCall() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();

  //   if (Provider.of<OrganizationViewModel>(context, listen: false)
  //               .organisation ==
  //           {} ||
  //       Provider.of<OrganizationViewModel>(context, listen: false)
  //               .organisation ==
  //           null ||
  //       Provider.of<OrganizationViewModel>(context, listen: false)
  //               .organisation ==
  //           '') {
  //     Provider.of<OrganizationViewModel>(context, listen: false)
  //         .getOrganisation()
  //         .then((value) {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     });
  //   } else {
  //     Future.delayed(const Duration(seconds: 20)).then((value) {
  //       localStorage.remove('organisation').then((value) {
  //         Provider.of<OrganizationViewModel>(context, listen: false)
  //             .getOrganisation()
  //             .then((value) {
  //           setState(() {
  //             isLoading = false;
  //           });
  //         });
  //       });
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var organisation = Provider.of<OrganizationViewModel>(context).organisation;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 18, right: 18),
                child: Container(
                  // height: 900,
                  // height: double.infinity,
                  // color: Colors.amber,
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
                            SizedBox(
                                width: SizeVariables.getWidth(context) * 0.02),
                            Text(
                              'Organization',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                      // SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                      // OrgContainerWidget(),
                      // OrganizationTree(),
                      OrganizationNew(organisation),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
