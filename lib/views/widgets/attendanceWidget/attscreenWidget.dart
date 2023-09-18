// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../res/components/buttonStyle.dart';
// import '../../../res/components/containerStyle.dart';
// import '../../../viewModel/claimsStatusViewModel.dart';
// import '../../../viewModel/onOffViewModel.dart';
// import '../../config/mediaQuery.dart';
// import '../dashboardWidgets/attendance.dart';

// class AttscreenWidget extends StatefulWidget {
//   // const AttscreenWidget({Key? key}) : super(key: key);

//   @override
//   State<AttscreenWidget> createState() => _AttscreenWidgetState();
// }

// class _AttscreenWidgetState extends State<AttscreenWidget> {
//   OnOffViewModel onOffViewModel = OnOffViewModel();

//   @override
//   void initState() {
//     // TODO: implement initState
//     onOffViewModel.getWorkstation(context);

//     super.initState();
//   }

//   int selection = 0;
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ClaimzStatusViewModel>(context).claimzStatuss;

//     return ContainerStyle(
//         height: SizeVariables.getHeight(context) * 0.4,
//         child: AttendanceWidget(provider['data']['dashboard_data']),
//         );
//   }
// }
