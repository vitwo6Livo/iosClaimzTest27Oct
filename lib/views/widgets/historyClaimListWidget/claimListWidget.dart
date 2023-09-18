import 'package:flutter/material.dart';

import '../../config/mediaQuery.dart';

class ClaimListWidget extends StatefulWidget {
  Map arguments;
  ClaimListWidget(Map this.arguments, {Key? key}) : super(key: key);

  @override
  State<ClaimListWidget> createState() => _ClaimListWidgetState();
}

class _ClaimListWidgetState extends State<ClaimListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      height: SizeVariables.getHeight(context) * 0.15,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            // color: Colors.blue,
            height: SizeVariables.getHeight(context) * 0.13,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: SizeVariables.getHeight(context) * 0.045,
                      width: SizeVariables.getWidth(context) * 0.4,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 17, 17, 17),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments["date"],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.all(8),
                      height: SizeVariables.getHeight(context) * 0.045,
                      width: SizeVariables.getWidth(context) * 0.4,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 17, 17, 17),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "Doc No : " + widget.arguments["doc_no"],
                            style: Theme.of(context).textTheme.bodyText1,
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
                    Container(
                      height: SizeVariables.getHeight(context) * 0.045,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 17, 17, 17),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            widget.arguments["from"] +
                                " to " +
                                widget.arguments["to"],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
