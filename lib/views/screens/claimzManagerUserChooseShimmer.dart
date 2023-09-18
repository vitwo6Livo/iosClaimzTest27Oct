import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../config/mediaQuery.dart';

class ManagerConvenyanceShimmer extends StatelessWidget {
  // const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // width: double.infinity,
      // height: SizeVariables.getHeight(context) * 1,
      // color: Theme.of(context).primaryColor,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        itemCount: 8,
        itemBuilder: (context, index) => ContainerStyle(
          height: SizeVariables.getHeight(context) * 0.07,
          child: Padding(
            padding:
                EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.02),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                        height: SizeVariables.getHeight(context) * 0.08,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Color.fromARGB(255, 120, 120, 120),
                          child: CircleAvatar(
                            radius: SizeVariables.getWidth(context) * 0.08,
                            backgroundColor: Colors.green,
                            child: Center(
                              child: Icon(Icons.camera_alt_outlined,
                                  color: Colors.white, size: 20),
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.01,
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.3,
                        height: SizeVariables.getHeight(context) * 0.015,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.005,
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: const Color.fromARGB(255, 120, 120, 120),
                      child: Container(
                        width: SizeVariables.getWidth(context) * 0.07,
                        height: SizeVariables.getHeight(context) * 0.015,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
