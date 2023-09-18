import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

// import '../../config/mediaQuery.dart';
import '../../config/mediaQuery.dart';
// import '../config/mediaQuery.dart';

class WorkRoleShimmer extends StatelessWidget {
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
                  ? 15.h
                  : height < 650
                      ? 23.h
                      : 20.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    fit: FlexFit.tight,
                    child: Container(
                      width: double.infinity,
                      // color: Colors.red,
                      // padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 5,
                            fit: FlexFit.loose,
                            child: Container(
                              height: double.infinity,
                              // color: Colors.amber,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                        SizeVariables.getWidth(context) * 0.01),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Container(
                                          height:
                                              SizeVariables.getHeight(context) *
                                                  0.09,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey[400]!,
                                            highlightColor: Color.fromARGB(
                                                255, 120, 120, 120),
                                            child: CircleAvatar(
                                              radius: SizeVariables.getWidth(
                                                      context) *
                                                  0.09,
                                              backgroundColor: Colors.green,
                                              child: Center(
                                                child: Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: Colors.white,
                                                    size: 20),
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: double.infinity,
                                      // color: Colors.orange,
                                      padding: EdgeInsets.only(
                                        left: SizeVariables.getWidth(context) *
                                            0.01,
                                        // top: SizeVariables
                                        //         .getHeight(
                                        //             context) *
                                        //     0.02
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey[400]!,
                                              highlightColor:
                                                  const Color.fromARGB(
                                                      255, 120, 120, 120),
                                              child: Container(
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.3,
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.02,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey[400]!,
                                              highlightColor:
                                                  const Color.fromARGB(
                                                      255, 120, 120, 120),
                                              child: Container(
                                                width: SizeVariables.getWidth(
                                                        context) *
                                                    0.1,
                                                height: SizeVariables.getHeight(
                                                        context) *
                                                    0.02,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      width: SizeVariables.getWidth(context) * 0.4,
                      // color: Colors.amber,
                      padding: EdgeInsets.only(
                          left: SizeVariables.getWidth(context) * 0.05),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor:
                            const Color.fromARGB(255, 120, 120, 120),
                        child: Container(
                          width: SizeVariables.getWidth(context) * 0.4,
                          height: SizeVariables.getHeight(context) * 0.02,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.02)
          ],
        ),
      ),
    );
  }
}
