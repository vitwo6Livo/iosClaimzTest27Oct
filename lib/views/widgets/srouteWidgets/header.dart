import 'package:flutter/material.dart';
import '../../../utils/routes/routeNames.dart';
import '../../config/mediaQuery.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SizeVariables().init(context);
    // TODO: implement build
    return Container(
      height: SizeVariables.getHeight(context) * 0.15,
      width: double.infinity,
      // color: Colors.red,
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              flex: 4,
              fit: FlexFit.tight,
              child: Container(
                height: double.infinity,

                // color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Demo User',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.profile);
                },
                child: Container(
                  height: double.infinity,

                  // color: Colors.green,
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.red,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
