import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../config/mediaQuery.dart';

class UserRegularisationShimmer extends StatelessWidget {
  //const UserRegularisationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 25,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          width: double.infinity,
          height: mediaQuery.height * 0.08,
          //color: Colors.red,
          child: Row(
            children: [
              Flexible(
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
                          height: SizeVariables.getHeight(context) * 0.002),
                      Column(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor:
                                const Color.fromARGB(255, 120, 120, 120),
                            child: Container(
                              width: SizeVariables.getWidth(context) * 0.3,
                              height: SizeVariables.getHeight(context) * 0.015,
                              color: Colors.grey,
                            ),
                          ),
                          // Text(
                          //   '-',
                          //   style: Theme.of(context).textTheme.bodyText1,
                          // ),
                          SizedBox(
                              height: SizeVariables.getHeight(context) * 0.002),

                          Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor:
                                const Color.fromARGB(255, 120, 120, 120),
                            child: Container(
                              width: SizeVariables.getWidth(context) * 0.3,
                              height: SizeVariables.getHeight(context) * 0.015,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
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
                          height: SizeVariables.getHeight(context) * 0.002),
                      Column(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor:
                                const Color.fromARGB(255, 120, 120, 120),
                            child: Container(
                              width: SizeVariables.getWidth(context) * 0.3,
                              height: SizeVariables.getHeight(context) * 0.015,
                              color: Colors.grey,
                            ),
                          ),
                          // Text(
                          //   '-',
                          //   style: Theme.of(context).textTheme.bodyText1,
                          // ),
                          SizedBox(
                              height: SizeVariables.getHeight(context) * 0.002),

                          Shimmer.fromColors(
                            baseColor: Colors.grey[400]!,
                            highlightColor:
                                const Color.fromARGB(255, 120, 120, 120),
                            child: Container(
                              width: SizeVariables.getWidth(context) * 0.3,
                              height: SizeVariables.getHeight(context) * 0.015,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
