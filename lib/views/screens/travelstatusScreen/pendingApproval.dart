import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/managerIncidentalViewModel.dart';
import 'package:claimz/viewModel/travelViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';

class PendingApproval extends StatelessWidget {
  int self;
  PendingApproval(int this.self);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TravelViewModel>(context).pendingapproval;

    // TODO: implement build
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.02,
          top: SizeVariables.getHeight(context) * 0.02,
          right: SizeVariables.getWidth(context) * 0.02),
      // color: Colors.red,
      child: provider.isEmpty
          ? Center(
              child: Text('No Pending Approval Travel Claims',
                  style: Theme.of(context).textTheme.bodyText1),
            )
          : ListView.builder(
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.fieldfrom,
                          arguments: provider[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ContainerStyle(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: Column(
                          children: [
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.001,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.035,
                                    top:
                                        SizeVariables.getHeight(context) * 0.02,
                                  ),
                                  child: Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Travel Id: ' +
                                            provider[index]['id'].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 14,
                                                color: Colors.amber),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.49,
                                    top:
                                        SizeVariables.getHeight(context) * 0.02,
                                  ),
                                  child: Container(
                                    child: Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          '\₹' +
                                              provider[index]['claim_amount']
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.amber,
                                                  fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right:
                                        SizeVariables.getWidth(context) * 0.461,
                                  ),
                                  child: Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        provider[index]['from_place']
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 16,
                                                color: Colors.amber),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      provider[index]['to_place'].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 16,
                                              color: Colors.amber),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right:
                                        SizeVariables.getWidth(context) * 0.235,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            provider[index]['from_date']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left:
                                              SizeVariables.getWidth(context) *
                                                  0.01,
                                        ),
                                        child: Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              provider[index]['from_time']
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 10,
                                                    color: Colors.grey,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          provider[index]['to_date'].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 12,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      child: Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            provider[index]['to_time']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.01,
                            ),
                            self == 0
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.64,
                                    ),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: InkWell(
                                              onTap: () => approveClaimAlert(
                                                  provider[index]['id']
                                                      .toString(),
                                                  provider[index],
                                                  context),
                                              child: Icon(Icons.check_box,
                                                  color: Colors.orangeAccent),
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: InkWell(
                                              onTap: () => rejectClaimAlert(
                                                  provider[index]['id']
                                                      .toString(),
                                                  provider[index],
                                                  context),
                                              child: Icon(Icons.cancel,
                                                  color: Colors.orangeAccent),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
              itemCount: provider.length),
    );
  }

  void approveClaimAlert(
      String tid, Map<String, dynamic> data, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 137, 131, 131),
              content: Text('Are you sure you want to Approve this claim?',
                  style: Theme.of(context).textTheme.bodyText1),
              actions: [
                TextButton(
                    onPressed: () {
                      Map field_data = {
                        "id": tid,
                        "status": "payment_pending",
                        "remarks": "",
                        "paid_amount": "",
                        "partial_amount": "",
                        "partial_gst": "",
                        "partial_total": "",
                      };
                      Provider.of<TravelViewModel>(context, listen: false)
                          .postTravelApproval(
                              data, field_data, "payment_pending", tid);

                      Navigator.of(context).pop();
                    },
                    child: Text('Yes',
                        style: Theme.of(context).textTheme.bodyText1)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No',
                        style: Theme.of(context).textTheme.bodyText1))
              ],
            ));
  }

  void rejectClaimAlert(
      String tid, Map<String, dynamic> data, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 137, 131, 131),
              content: Text('Are you sure you want to Reject this claim?',
                  style: Theme.of(context).textTheme.bodyText1),
              actions: [
                TextButton(
                    onPressed: () {
                      Map field_data = {
                        "id": tid,
                        "status": "rejected",
                        "remarks": "",
                        "paid_amount": "",
                        "partial_amount": "",
                        "partial_gst": "",
                        "partial_total": "",
                      };
                      Provider.of<TravelViewModel>(context, listen: false)
                          .postTravelApproval(
                              data, field_data, "rejected", tid);

                      Navigator.of(context).pop();
                    },
                    child: Text('Yes',
                        style: Theme.of(context).textTheme.bodyText1)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No',
                        style: Theme.of(context).textTheme.bodyText1))
              ],
            ));
  }
}
