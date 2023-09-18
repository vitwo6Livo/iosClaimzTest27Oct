import 'package:claimz/viewModel/travelViewModel.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:claimz/views/screens/travelstatusScreen/paid.dart';
import 'package:claimz/views/screens/travelstatusScreen/partialPayment.dart';
import 'package:claimz/views/screens/travelstatusScreen/pendingApproval.dart';
import 'package:claimz/views/screens/travelstatusScreen/pendingPayment.dart';
import 'package:claimz/views/screens/travelstatusScreen/rejected.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../utils/routes/routeNames.dart';

class TravelStatusList extends StatefulWidget {
  // const TravelStatusList({Key? key}) : super(key: key);
  final Map<dynamic, dynamic> args;
  TravelStatusList(this.args);

  @override
  State<TravelStatusList> createState() => _TravelStatusListState();
}

class _TravelStatusListState extends State<TravelStatusList> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<TravelViewModel>(context, listen: false)
        .getTravelClaimStatus(widget.args["doc"])
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(widget.args.toString());

    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            elevation: 10,
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
                    },
                    child: SvgPicture.asset(
                      "assets/icons/back button.svg",
                    ),
                  ),
                  SizedBox(width: SizeVariables.getWidth(context) * 0.05),
                  Container(
                    padding: EdgeInsets.only(
                      left: SizeVariables.getWidth(context) * 0.01,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Travel Claim Status',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Text(
                            'Doc No. : ' + widget.args["doc"],
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.amber,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            bottom: const TabBar(
                indicatorColor: Colors.amber,
                isScrollable: true,
                tabs: [
                  Tab(text: 'Pending for Approval'),
                  Tab(text: 'Pending for Payment'),
                  Tab(text: 'Partially Paid'),
                  Tab(text: 'Paid'),
                  Tab(text: 'Rejected'),
                ]),
          ),
          backgroundColor: Colors.black,
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : TabBarView(
                  children: [
                    PendingApproval(0),
                    PendingPayment(0),
                    PartialPayment(),
                    Paid(),
                    Rejected(),
                    // PendingManagerIncidents(),
                    // ApprovedManagerIncidents(),
                    // RejectedManagerIncidents()
                  ],
                ),
        ),
      ),
    );
  }
}
