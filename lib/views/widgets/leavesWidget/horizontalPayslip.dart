import 'package:claimz/main.dart';
import 'package:claimz/viewModel/leaveRemainingViewModel.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../viewModel/leaveTypeViewModel.dart';
import '../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import './leaveWidget.dart';

class HorizontalPayslip extends StatefulWidget {
  // const HorizontalPayslip({Key? key}) : super(key: key);

  @override
  State<HorizontalPayslip> createState() => _HorizontalPayslipState();
}

class _HorizontalPayslipState extends State<HorizontalPayslip> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LeaveRemainingViewModel>(context).leaveBalance;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height > 800
          ? 15.h
          : height < 650
              ? 22.h
              : 20.h,
      width: double.infinity,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            // color: Colors.red,
            width: width > 400
                ? 38.w
                : width < 300
                    ? 36.w
                    : 38.w,
            child: Center(
              child: ContainerStyle(
                height: height > 750
                    ? 16.h
                    : height < 650
                        ? 16.h
                        : 22.h,
                child: Container(
                  // margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Container(
                      // padding: EdgeInsets.only(bottom: 10),
                      // color: Colors.amber,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${provider['data'][index]['leave_types'].split(' ')[0]}: ${provider['data'][index]['number']}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                    itemCount: provider['data'].length,
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(
          //   width: SizeVariables.getWidth(context)*0.08,
          // ),
          Container(
            width: width > 400
                ? 38.w
                : width < 300
                    ? 36.w
                    : 38.w,
            child: ContainerStyle(
              height: height > 750
                  ? 16.h
                  : height < 650
                      ? 16.h
                      : 22.h,
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Approved:  0",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Pending:  0",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        "Rejected:  0",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // child: ListView.builder(
      //   scrollDirection: Axis.horizontal,
      //     itemBuilder: (context, index) => LeaveWidget(
      //         provider['data'][index]['leave_types'].split(' '),
      //         provider['data'][index]['number'].toString(),
      //         provider['data'][index]['image']),
      //     itemCount: provider['data'].length),
    );
  }
}
