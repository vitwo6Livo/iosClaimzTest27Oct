import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/managerIncidentalViewModel.dart';
import 'package:claimz/viewModel/travelViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';

class Paid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TravelViewModel>(context).paid;

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
              child: Text('No Paid Travel Claims',
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
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.06,
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
                                        SizeVariables.getWidth(context) * 0.38,
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
                                        SizeVariables.getWidth(context) * 0.3,
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
                                Padding(
                                  padding: EdgeInsets.only(
                                    right:
                                        SizeVariables.getWidth(context) * 0.02,
                                  ),
                                  child: Container(
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
                                        SizeVariables.getWidth(context) * 0.1,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      right: SizeVariables.getWidth(context) *
                                          0.04,
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
                                        SizedBox(
                                          width:
                                              SizeVariables.getHeight(context) *
                                                  0.004,
                                        ),
                                        Container(
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
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            provider[index]['to_date']
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
                                      SizedBox(
                                        width:
                                            SizeVariables.getHeight(context) *
                                                0.004,
                                      ),
                                      Container(
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              itemCount: provider.length),
    );
  }
}
