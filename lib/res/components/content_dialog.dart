import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final Container container;
  final VoidCallback onOk;
  final VoidCallback onCancel;

  const ContainerDialog({
    required this.title,
    required this.subtitle,
    required this.onOk,
    required this.onCancel,
    required this.container,
  });

  dialogContent(BuildContext context) {
    return Container(
      height: SizeVariables.getHeight(context) * 0.45,
      decoration: new BoxDecoration(
        color: Color.fromARGB(255, 103, 103, 101),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            // color: Colors.orangeAccent,
            blurRadius: 2.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            SizedBox(height: 16.0),
            // Image.asset('assets/images/splashscreen.png', height: 100),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.white),
            ),
            SizedBox(height: 16.0),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.05),
            container,
            SizedBox(height: SizeVariables.getHeight(context) * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
                // RaisedButton(
                //   //     disabledColor: Colors.red,
                //   // disabledTextColor: Colors.black,
                //   padding: const EdgeInsets.all(20),
                //   textColor: Colors.white,
                //   color: const Color(0xffF59F23),
                //   onPressed: onCancel,
                //   child: Text('Cancel',
                //       style: Theme.of(context)
                //           .textTheme
                //           .bodyText2
                //           ?.copyWith(color: Colors.white)),
                // ),

                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(168, 94, 92, 92),
                    ),
                    //     disabledColor: Colors.red,
                    // disabledTextColor: Colors.black,
                    // padding: const EdgeInsets.all(12),
                    // textColor: Color(0xffF59F23),
                    // : Color.fromARGB(168, 81, 80, 80),
                    onPressed: onOk,
                    child: Text('Submit',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: Color(0xffF59F23),
                            )),
                  ),
                  decoration: new BoxDecoration(
                    color: Color.fromARGB(168, 94, 92, 92),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 74, 74, 70),
                        blurRadius: 2,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
