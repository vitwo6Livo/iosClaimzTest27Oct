import 'package:claimz/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModel/lateCheckinViewModel.dart';
import '../widgets/managerScreenWidgets/lateCheckins/approved.dart';
import '../widgets/managerScreenWidgets/lateCheckins/pending.dart';
import '../widgets/managerScreenWidgets/lateCheckins/rejected.dart';

class LateCheckinRequests extends StatefulWidget {
  LateCheckinRequestsState createState() => LateCheckinRequestsState();
}

class LateCheckinRequestsState extends State<LateCheckinRequests> {
  final lateCheckinViewModel = LateCheckinViewModel();

  @override
  void initState() {
    // TODO: implement initState
    lateCheckinViewModel.getLateCheckin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            elevation: 10,
            title: Text(
              'Late Check In\'s',
              style: Theme.of(context).textTheme.caption,
            ),
            bottom: const TabBar(tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Approved'),
              Tab(text: 'Rejected'),
            ]),
          ),
          body: ChangeNotifierProvider<LateCheckinViewModel>(
            create: (context) => lateCheckinViewModel,
            child: Consumer<LateCheckinViewModel>(
              builder: (context, value, child) {
                switch (value.lateCheckin.status) {
                  case Status.LOADING:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.ERROR:
                    return Center(
                      child: Text(value.lateCheckin.message.toString()),
                    );
                  case Status.COMPLETED:
                    return TabBarView(children: [
                      PendingCheckins(value.lateCheckin.data!.data!),
                      ApprovedCheckins(value.lateCheckin.data!.data!),
                      RejectedCheckins(value.lateCheckin.data!.data!),
                    ]);
                  default:
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
