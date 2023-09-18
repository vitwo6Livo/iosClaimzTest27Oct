import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

// import '../../config/mediaQuery.dart';
import '../config/mediaQuery.dart';

class TravellistShimmer extends StatelessWidget {
  // const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: SizeVariables.getHeight(context) * 1,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Column(
          children: [
            ContainerStyle(
              height: height > 750
                  ? 16.h
                  : height < 650
                      ? 17.h
                      : 15.h,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    height: double.infinity,
                    // color: Colors.red,
                    padding: EdgeInsets.only(
                        left: SizeVariables.getWidth(context) * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor:
                              const Color.fromARGB(255, 120, 120, 120),
                          child: Container(
                            width: SizeVariables.getWidth(context) * 0.25,
                            height: SizeVariables.getHeight(context) * 0.015,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                            height: SizeVariables.getHeight(context) * 0.01),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              child: Container(
                                width: SizeVariables.getWidth(context) * 0.3,
                                height:
                                    SizeVariables.getHeight(context) * 0.015,
                                color: Colors.grey,
                              ),
                            ),
                            // Text(
                            //   '-',
                            //   style: Theme.of(context).textTheme.bodyText1,
                            // ),
                            SizedBox(
                                height:
                                    SizeVariables.getHeight(context) * 0.01),

                            Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor:
                                  const Color.fromARGB(255, 120, 120, 120),
                              child: Container(
                                width: SizeVariables.getWidth(context) * 0.4,
                                height:
                                    SizeVariables.getHeight(context) * 0.015,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.02)
          ],
        ),
      ),
    );
  }
}
