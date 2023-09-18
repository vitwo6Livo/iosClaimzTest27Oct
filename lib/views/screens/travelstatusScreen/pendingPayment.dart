import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/viewModel/managerIncidentalViewModel.dart';
import 'package:claimz/viewModel/travelViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/components/containerStyle.dart';
import '../../../utils/routes/routeNames.dart';
import '../../config/mediaQuery.dart';

class PendingPayment extends StatelessWidget {
  int self;
  PendingPayment(int this.self);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TravelViewModel>(context).pendingpayment;

    // TODO: implement build
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(
          left: SizeVariables.getWidth(context) * 0.02,
          top: SizeVariables.getHeight(context) * 0.02,
          right: SizeVariables.getWidth(context) * 0.02),
      // color: Colors.red,
      child: provider.isEmpty
          ? Center(
              child: Text('No Pending Payment Travel Claims',
                  style: Theme.of(context).textTheme.bodyText1),
            )
          : ListView.builder(
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.fieldfrom,
                          arguments: provider[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ContainerStyle(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: Column(
                          children: [
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.001,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.045,
                                    top:
                                        SizeVariables.getHeight(context) * 0.02,
                                  ),
                                  child: Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        'Travel Id: ' +
                                            provider[index]['id'].toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 14,
                                                color: Colors.amber),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        SizeVariables.getWidth(context) * 0.48,
                                    top:
                                        SizeVariables.getHeight(context) * 0.02,
                                  ),
                                  child: Container(
                                    child: Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          '\₹' +
                                              provider[index]['claim_amount']
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.amber,
                                                  fontSize: 18),
                                        ),
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
                                Padding(
                                  padding: EdgeInsets.only(
                                    right:
                                        SizeVariables.getWidth(context) * 0.43,
                                  ),
                                  child: Container(
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        provider[index]['from_place']
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontSize: 16,
                                                color: Colors.amber),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(
                                      provider[index]['to_place'].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 16,
                                              color: Colors.amber),
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
                                Padding(
                                  padding: EdgeInsets.only(
                                    right:
                                        SizeVariables.getWidth(context) * 0.2,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            provider[index]['from_date']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left:
                                              SizeVariables.getWidth(context) *
                                                  0.01,
                                        ),
                                        child: Container(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              provider[index]['from_time']
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    fontSize: 10,
                                                    color: Colors.grey,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          provider[index]['to_date'].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                fontSize: 12,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: SizeVariables.getWidth(context) *
                                            0.01,
                                      ),
                                      child: Container(
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(
                                            provider[index]['to_time']
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 10,
                                                  color: Colors.grey,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.01,
                            ),
                            self == 0
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                      left: SizeVariables.getWidth(context) *
                                          0.64,
                                    ),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: InkWell(
                                              onTap: () => approveClaimAlert(
                                                  provider[index]['id']
                                                      .toString(),
                                                  provider[index],
                                                  context),
                                              child: Icon(Icons.check_box,
                                                  color: Colors.orangeAccent),
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: InkWell(
                                              onTap: () => PartialClaimAlert(
                                                  provider[index]['id']
                                                      .toString(),
                                                  provider[index],
                                                  context,
                                                  provider[index]
                                                          ['claim_amount']
                                                      .toString()),
                                              child: Icon(
                                                  Icons.do_disturb_on_rounded,
                                                  color: Colors.orangeAccent),
                                            ),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.contain,
                                            child: InkWell(
                                              onTap: () => rejectClaimAlert(
                                                  provider[index]['id']
                                                      .toString(),
                                                  provider[index],
                                                  context),
                                              child: Icon(Icons.cancel,
                                                  color: Colors.orangeAccent),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
              itemCount: provider.length),
    );
  }

  void approveClaimAlert(
      String tid, Map<String, dynamic> data, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 137, 131, 131),
              content: Text('Are you sure you want to Approve this claim?',
                  style: Theme.of(context).textTheme.bodyText1),
              actions: [
                TextButton(
                    onPressed: () {
                      Map field_data = {
                        "id": tid,
                        "status": "paid",
                        "remarks": "",
                        "paid_amount": "",
                        "partial_amount": "",
                        "partial_gst": "",
                        "partial_total": "",
                      };
                      Provider.of<TravelViewModel>(context, listen: false)
                          .postTravelApproval(data, field_data, "paid", tid);

                      Navigator.of(context).pop();
                    },
                    child: Text('Yes',
                        style: Theme.of(context).textTheme.bodyText1)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No',
                        style: Theme.of(context).textTheme.bodyText1))
              ],
            ));
  }

  void PartialClaimAlert(String tid, Map<String, dynamic> data,
      BuildContext context, String amount) {
    TextEditingController basic_amount = TextEditingController();
    TextEditingController gst_amount = TextEditingController();
    TextEditingController total_amount = TextEditingController();
    TextEditingController remarks = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 137, 131, 131),
              content: Container(
                height: 300,
                child: Column(
                  children: [
                    Text('Please provide the details to do partial payment!',
                        style: Theme.of(context).textTheme.bodyText1),
                    TextFormField(
                      controller: basic_amount,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        // border: InputBorder.none,
                        labelText: 'Basic Amount',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 12),
                      ),
                      style: Theme.of(context).textTheme.bodyText1,
                      showCursor: false,
                      cursorColor: Colors.white,
                    ),
                    TextFormField(
                      controller: gst_amount,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        // border: InputBorder.none,
                        labelText: 'GST Amount',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 12),
                      ),
                      style: Theme.of(context).textTheme.bodyText1,
                      showCursor: false,
                      cursorColor: Colors.white,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: total_amount,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        // border: InputBorder.none,
                        labelText: 'Total Amount',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 12),
                      ),
                      style: Theme.of(context).textTheme.bodyText1,
                      showCursor: false,
                      cursorColor: Colors.white,
                    ),
                    TextFormField(
                      controller: remarks,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.white),
                        ),
                        // border: InputBorder.none,
                        labelText: 'Remarks',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 12),
                      ),
                      style: Theme.of(context).textTheme.bodyText1,
                      showCursor: false,
                      cursorColor: Colors.white,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      print(amount);
                      print(total_amount);
                      if (double.parse(amount) <
                          double.parse(total_amount.text)) {
                        Flushbar(
                          duration: const Duration(seconds: 4),
                          flushbarPosition: FlushbarPosition.BOTTOM,
                          borderRadius: BorderRadius.circular(10),
                          icon: const Icon(Icons.error, color: Colors.white),
                          // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                          title: 'Warning',
                          message: "Total amount is more than claim amount",
                          barBlur: 20,
                        ).show(context);
                      } else {
                        Map field_data = {
                          "id": tid,
                          "status": "partial_paid",
                          "remarks":
                              remarks.text == "" ? "no data" : remarks.text,
                          "paid_amount": "",
                          "partial_amount":
                              basic_amount.text == "" ? "0" : basic_amount.text,
                          "partial_gst":
                              gst_amount.text == "" ? "0" : gst_amount.text,
                          "partial_total":
                              total_amount.text == "" ? "0" : total_amount.text,
                        };
                        data.addAll({
                          "partial_amount":
                              basic_amount.text == "" ? "0" : basic_amount.text,
                          "partial_gst":
                              gst_amount.text == "" ? "0" : gst_amount.text,
                          "partial_total":
                              total_amount.text == "" ? "0" : total_amount.text,
                          "remarks":
                              remarks.text == "" ? "no data" : remarks.text,
                        });
                        Provider.of<TravelViewModel>(context, listen: false)
                            .postTravelApproval(
                                data, field_data, "partial_paid", tid);

                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Yes',
                        style: Theme.of(context).textTheme.bodyText1)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No',
                        style: Theme.of(context).textTheme.bodyText1))
              ],
            ));
  }

  void rejectClaimAlert(
      String tid, Map<String, dynamic> data, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 137, 131, 131),
              content: Text('Are you sure you want to Reject this claim?',
                  style: Theme.of(context).textTheme.bodyText1),
              actions: [
                TextButton(
                    onPressed: () {
                      Map field_data = {
                        "id": tid,
                        "status": "rejected",
                        "remarks": "",
                        "paid_amount": "",
                        "partial_amount": "",
                        "partial_gst": "",
                        "partial_total": "",
                      };
                      Provider.of<TravelViewModel>(context, listen: false)
                          .postTravelApproval(
                              data, field_data, "rejected", tid);

                      Navigator.of(context).pop();
                    },
                    child: Text('Yes',
                        style: Theme.of(context).textTheme.bodyText1)),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No',
                        style: Theme.of(context).textTheme.bodyText1))
              ],
            ));
  }
}
