import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/mediaQuery.dart';

class OrganisationShimmer extends StatelessWidget {
  // const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: SizeVariables.getHeight(context) * 1,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index) => Container(
          margin:
              EdgeInsets.only(bottom: SizeVariables.getHeight(context) * 0.02),
          child: ContainerStyle(
            height: SizeVariables.getHeight(context) * 0.09,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: CircleAvatar(
                          radius: SizeVariables.getWidth(context) * 0.08),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeVariables.getHeight(context) * 0.02,
                      left: SizeVariables.getWidth(context) * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor:
                              const Color.fromARGB(255, 120, 120, 120),
                          child: Container(
                            width: SizeVariables.getWidth(context) * 0.2,
                            height: SizeVariables.getHeight(context) * 0.01,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeVariables.getHeight(context) * 0.01,
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor:
                              const Color.fromARGB(255, 120, 120, 120),
                          child: Container(
                            width: SizeVariables.getWidth(context) * 0.4,
                            height: SizeVariables.getHeight(context) * 0.01,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
