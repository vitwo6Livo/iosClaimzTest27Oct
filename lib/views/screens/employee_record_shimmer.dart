import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../config/mediaQuery.dart';

class EmployeeRecordShimmer extends StatelessWidget {
  //const EmployeeRecordShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: SizeVariables.getHeight(context) * 0.03,
              left: SizeVariables.getWidth(context) * 0.1,
            ),
            width: double.infinity,
            height: mediaQuery.height * 0.08,
            //color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor:
                              const Color.fromARGB(255, 120, 120, 120),
                          child: Container(
                            width: SizeVariables.getWidth(context) * 0.5,
                            height: SizeVariables.getHeight(context) * 0.02,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.01,
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
                            width: SizeVariables.getWidth(context) * 0.5,
                            height: SizeVariables.getHeight(context) * 0.02,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mediaQuery.height * 0.1,
          ),
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.green,
                    width: double.infinity,
                    height: mediaQuery.height * 0.1,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
