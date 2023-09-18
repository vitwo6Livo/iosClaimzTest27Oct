import 'package:flutter/material.dart';
import '../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';

class LeaveWidget extends StatelessWidget {
  final List<String> leaveTypes;
  final String balance;
  final String path;

  LeaveWidget(this.leaveTypes, this.balance, this.path);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(right: SizeVariables.getWidth(context) * 0.05),
      child: Container(
        width: SizeVariables.getWidth(context) * 0.33,
        child: ContainerStyle(
            height: SizeVariables.getHeight(context) * 0.16,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        // color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.04),
                          child: Text(leaveTypes[0],
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 18)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.016,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: SizeVariables.getWidth(context) * 0.04),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            '$balance Day(s)',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
