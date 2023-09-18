import 'package:claimz/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../utils/routes/routeNames.dart';
import '../../viewModel/leaveTypeViewModel.dart';
import '../config/mediaQuery.dart';
import '../widgets/requestleaveWidget/requestButtom.dart';
import '../widgets/requestleaveWidget/requestleaveContainer.dart';
import '../widgets/requestleaveWidget/requestleaveHeader.dart';

class RequestLeave extends StatefulWidget {
  int fromRegularisation;
  var date;
  String subject;
  String description;
  int leaveId;
  // const RequestLeave({Key? key}) : super(key: key);

  @override
  State<RequestLeave> createState() => _RequestLeaveState();

  RequestLeave(this.fromRegularisation, this.date, this.subject,
      this.description, this.leaveId);
}

class _RequestLeaveState extends State<RequestLeave> {
  // LeaveTypeViewModel leaveTypeViewModel = LeaveTypeViewModel();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   leaveTypeViewModel.getLeaveTypes(context);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Container(
            // color: Colors.red,
            padding: EdgeInsets.only(
              left: SizeVariables.getWidth(context) * 0.025,
              right: SizeVariables.getWidth(context) * 0.025,
            ),
            child: ListView(
              children: [
                // Padding(
                //   padding: EdgeInsets.only(
                //       top: SizeVariables.getHeight(context) * 0.02),
                //   child: Row(
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           Navigator.of(context).pop();
                //         },
                //         child: SvgPicture.asset(
                //           "assets/icons/back button.svg",
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                RequestleaveHeader(),
                SizedBox(
                  height: SizeVariables.getHeight(context) * 0.02,
                ),
                RequestleaveContainer(widget.fromRegularisation, widget.date,
                    widget.subject, widget.description, widget.leaveId),
                SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                Container(
                  width: double.infinity,
                  height: SizeVariables.getHeight(context) * 0.2,
                  // color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Expanded(
                          child: Center(
                        child: Text(
                          'Please Ensure that you are selecting Duration for the Start And End Dates. This is for the purpose of marking your leave as either Half Day or Full Day.',
                          textAlign: TextAlign.center,
                        ),
                      ))
                    ],
                  ),
                ),
                // RequestButtom(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
