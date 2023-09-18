// import 'package:claimz/views/screens/paySlipShimmer.dart';
import 'package:flutter/material.dart';
import '../widgets/paysilpWidget/paysilpHeader.dart';
import '../widgets/paysilpWidget/payslipNewWidget.dart';

class PaySlipScreen extends StatefulWidget {
  @override
  State<PaySlipScreen> createState() => _PaySlipScreenState();
}

class _PaySlipScreenState extends State<PaySlipScreen> {
  bool isLoading = true;
  void initState() {
    isLoading = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            PayslipHeader(),

            // HorizontalWidget(),

            const PaySlip_NewWidget(),
          ],
        ),
      ),
    );
  }
}
