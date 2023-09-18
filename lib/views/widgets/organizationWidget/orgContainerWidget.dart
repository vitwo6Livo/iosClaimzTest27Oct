// import 'package:accordion/accordion.dart';
// import 'package:accordion/controllers.dart';
// import 'package:another_flushbar/flushbar.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:claimz/data/response/status.dart';
// import 'package:claimz/provider/theme_provider.dart';
// import 'package:claimz/res/components/containerStyle.dart';
// import 'package:claimz/utils/routes/routeNames.dart';
// import 'package:claimz/views/config/mediaQuery.dart';
// import 'package:claimz/views/widgets/organizationWidget/organisationShimmer.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../../res/appUrl.dart';
// import '../../../viewModel/organisationViewModel.dart';
// import 'package:provider/provider.dart';

// class OrgContainerWidget extends StatefulWidget {
//   // const OrgContainerWidget({Key? key}) : super(key: key);

//   @override
//   State<OrgContainerWidget> createState() => _OrgContainerWidgetState();
// }

// class _OrgContainerWidgetState extends State<OrgContainerWidget> {
//   final organizationViewModel = OrganizationViewModel();

//   @override
//   void initState() {
//     // TODO: implement initState
//     organizationViewModel.getOrganisationList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return Container(
//       height: SizeVariables.getHeight(context) * 0.97,
//       // color: Colors.red,
//       width: double.infinity,
//       child: ListView(
//         children: [
//           ChangeNotifierProvider<OrganizationViewModel>(
//             create: (context) => organizationViewModel,
//             child: Consumer<OrganizationViewModel>(
//                 builder: (context, value, child) {
//               switch (value.organisation.status) {
//                 case Status.LOADING:
//                   return OrganisationShimmer();
//                 case Status.ERROR:
//                   return Center(
//                     child: Text(value.organisation.message.toString()),
//                   );
//                 case Status.COMPLETED:
//                   return Container(
//                     // color: Colors.red,
//                     child: Accordion(
//                       headerBackgroundColor: Colors.black38,
//                       headerBackgroundColorOpened: Colors.black54,
//                       scaleWhenAnimating: true,
//                       openAndCloseAnimation: true,
//                       headerPadding: const EdgeInsets.symmetric(
//                           vertical: 7, horizontal: 15),
//                       sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
//                       sectionClosingHapticFeedback: SectionHapticFeedback.light,
//                       contentBackgroundColor:
//                           Theme.of(context).colorScheme.secondary,
//                       // headerBackgroundColor: Colors.black,
//                       contentBorderColor:
//                           Theme.of(context).colorScheme.secondary,
//                       children: [
//                         for (int index = 0;
//                             index < value.organisation.data!.data!.length;
//                             index++)
//                           AccordionSection(
//                             isOpen: false,

//                             // leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
//                             headerBackgroundColor: (themeProvider.darkTheme)
//                                 ? Colors.grey
//                                 : Colors.amberAccent,
//                             header: Text(
//                               '${value.organisation.data!.data![index].department}:',
//                             ),
//                             content: Center(
//                               child: Container(
//                                 // color: Colors.red,
//                                 width: SizeVariables.getWidth(context),
//                                 height: value.organisation.data!.data![index]
//                                             .members!.length >
//                                         3
//                                     ? SizeVariables.getHeight(context) * 0.3
//                                     : null,
//                                 child: ListView(
//                                   shrinkWrap: true,
//                                   children: [
//                                     for (int indexTwo = 0;
//                                         indexTwo <
//                                             value.organisation.data!
//                                                 .data![index].members!.length;
//                                         indexTwo++)
//                                       InkWell(
//                                         onTap: () {
//                                           // Navigator.pushNamed(
//                                           //     context, RouteNames.fristhr);
//                                           String number = value
//                                               .organisation
//                                               .data!
//                                               .data![index]
//                                               .members![indexTwo]
//                                               .contactNo
//                                               .toString();

//                                           if (number == "") {
//                                             number = "99999999";
//                                           }
//                                           String   = "tel://" + number;
//                                           _dialogProfile(context, value, index,
//                                               indexTwo, url);
//                                         },
//                                         child: Container(
//                                           //color: Colors.amber,
//                                           margin: EdgeInsets.only(
//                                               bottom: SizeVariables.getHeight(
//                                                       context) *
//                                                   0.02),
//                                           // color: Colors.red,
//                                           child: ContainerStyle(
//                                             height: SizeVariables.getHeight(
//                                                     context) *
//                                                 0.09,
//                                             child: Row(
//                                               children: [
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(10),
//                                                   child: FittedBox(
//                                                     fit: BoxFit.contain,
//                                                     child: value
//                                                                 .organisation
//                                                                 .data!
//                                                                 .data![index]
//                                                                 .members![
//                                                                     indexTwo]
//                                                                 .profilePhoto ==
//                                                             null
//                                                         ? CircleAvatar(
//                                                             radius: SizeVariables
//                                                                     .getWidth(
//                                                                         context) *
//                                                                 0.06,
//                                                             // backgroundColor:Colors.green,
//                                                             backgroundImage:
//                                                                 const AssetImage(
//                                                                     'assets/img/profilePic.jpg'),
//                                                           )
//                                                         : CachedNetworkImage(
//                                                             imageUrl:
//                                                                 '${AppUrl.baseUrl}/profile_photo/${value.organisation.data!.data![index].members![indexTwo].profilePhoto}',
//                                                             imageBuilder: (context,
//                                                                     imageProvider) =>
//                                                                 CircleAvatar(
//                                                               radius: SizeVariables
//                                                                       .getWidth(
//                                                                           context) *
//                                                                   0.08,
//                                                               backgroundColor:
//                                                                   Colors.green,
//                                                               backgroundImage:
//                                                                   imageProvider,
//                                                               // child: const Icon(Icons.account_box, color: Colors.white),
//                                                             ),
//                                                             placeholder: (context,
//                                                                     url) =>
//                                                                 Shimmer
//                                                                     .fromColors(
//                                                               baseColor: Colors
//                                                                   .grey[400]!,
//                                                               highlightColor:
//                                                                   const Color
//                                                                           .fromARGB(
//                                                                       255,
//                                                                       120,
//                                                                       120,
//                                                                       120),
//                                                               child: CircleAvatar(
//                                                                   radius: SizeVariables
//                                                                           .getWidth(
//                                                                               context) *
//                                                                       0.08),
//                                                             ),
//                                                             errorWidget: (context,
//                                                                     url,
//                                                                     error) =>
//                                                                 CircleAvatar(
//                                                               radius: SizeVariables
//                                                                       .getWidth(
//                                                                           context) *
//                                                                   0.08,
//                                                               backgroundColor:
//                                                                   Colors.green,
//                                                               backgroundImage:
//                                                                   const AssetImage(
//                                                                       'assets/img/profilePic.jpg'),
//                                                               // child: const Icon(Icons.account_box, color: Colors.white),
//                                                             ),
//                                                           ),
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(
//                                                       top: SizeVariables
//                                                               .getHeight(
//                                                                   context) *
//                                                           0.02,
//                                                       left: SizeVariables
//                                                               .getWidth(
//                                                                   context) *
//                                                           0.03),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       FittedBox(
//                                                         fit: BoxFit.contain,
//                                                         child: Text(
//                                                           value
//                                                               .organisation
//                                                               .data!
//                                                               .data![index]
//                                                               .members![
//                                                                   indexTwo]
//                                                               .empName
//                                                               .toString(),
//                                                           style:
//                                                               Theme.of(context)
//                                                                   .textTheme
//                                                                   .bodyText1,
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         height: SizeVariables
//                                                                 .getHeight(
//                                                                     context) *
//                                                             0.0035,
//                                                       ),
//                                                       FittedBox(
//                                                         fit: BoxFit.contain,
//                                                         child: Text(
//                                                           value
//                                                               .organisation
//                                                               .data!
//                                                               .data![index]
//                                                               .members![
//                                                                   indexTwo]
//                                                               .email
//                                                               .toString(),
//                                                           style:
//                                                               Theme.of(context)
//                                                                   .textTheme
//                                                                   .bodyText1,
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   );
//                 default:
//               }
//               return Container();
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   _dialogProfile(BuildContext context, OrganizationViewModel value, int index,
//       int indexTwo, String url) {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         //backgroundColor: Colors.black,
//         content: Container(
//           width: double.maxFinite,
//           height: SizeVariables.getHeight(context) * 0.45,
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   value.organisation.data!.data![index].members![indexTwo]
//                               .profilePhoto ==
//                           null
//                       ? CircleAvatar(
//                           radius: SizeVariables.getWidth(context) * 0.1,
//                           // backgroundColor:Colors.green,
//                           backgroundImage:
//                               const AssetImage('assets/img/profilePic.jpg'),
//                         )
//                       : CachedNetworkImage(
//                           imageUrl:
//                               '${AppUrl.baseUrl}/profile_photo/${value.organisation.data!.data![index].members![indexTwo].profilePhoto}',
//                           imageBuilder: (context, imageProvider) =>
//                               CircleAvatar(
//                             radius: SizeVariables.getWidth(context) * 0.1,
//                             backgroundColor: Colors.green,
//                             backgroundImage: imageProvider,
//                             // child: const Icon(Icons.account_box, color: Colors.white),
//                           ),
//                           placeholder: (context, url) => Shimmer.fromColors(
//                             baseColor: Colors.grey[400]!,
//                             highlightColor:
//                                 const Color.fromARGB(255, 120, 120, 120),
//                             child: CircleAvatar(
//                                 radius: SizeVariables.getWidth(context) * 0.18),
//                           ),
//                           errorWidget: (context, url, error) => CircleAvatar(
//                             radius: SizeVariables.getWidth(context) * 0.1,
//                             backgroundColor: Colors.green,
//                             backgroundImage:
//                                 const AssetImage('assets/img/profilePic.jpg'),
//                             // child: const Icon(Icons.account_box, color: Colors.white),
//                           ),
//                         )
//                 ],
//               ),
//               SizedBox(height: SizeVariables.getHeight(context) * 0.02),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     value.organisation.data!.data![index].members![indexTwo]
//                         .empName
//                         .toString(),
//                     style: Theme.of(context).textTheme.bodyText1!,
//                   )
//                 ],
//               ),
//               SizedBox(height: SizeVariables.getHeight(context) * 0.005),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     value.organisation.data!.data![index].members![indexTwo]
//                         .designation
//                         .toString(),
//                     style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                           fontSize: 15,
//                         ),
//                   )
//                 ],
//               ),
//               SizedBox(height: SizeVariables.getHeight(context) * 0.008),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   // color: Colors.red,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         child: Row(
//                           children: [
//                             const Icon(Icons.shield, color: Colors.amber),
//                             Text(
//                                 value.organisation.data!.data![index]
//                                     .members![indexTwo].empCode
//                                     .toString(),
//                                 style: TextStyle(
//                                     color: Theme.of(context).accentColor))
//                           ],
//                         ),
//                       ),
//                       // SizedBox(
//                       //   height: SizeVariables.getHeight(context) * 0.01,
//                       // ),
//                       // Container(
//                       //   child: Row(
//                       //     children: [
//                       //       const Icon(Icons.person, color: Colors.amber),
//                       //       Text(
//                       //           value.organisation.data!.data![index]
//                       //               .members![indexTwo].aprrover1
//                       //               .toString(),
//                       //           style: TextStyle(color: Colors.white))
//                       //     ],
//                       //   ),
//                       // ),

//                       // SizedBox(
//                       //   height: SizeVariables.getHeight(context) * 0.01,
//                       // ),
//                       // Container(
//                       //   child: Row(
//                       //     children: [
//                       //       const Icon(Icons.person, color: Colors.amber),
//                       //       Text(
//                       //           value.organisation.data!.data![index]
//                       //               .members![indexTwo].aprrover2
//                       //               .toString(),
//                       //           style: TextStyle(color: Colors.white))
//                       //     ],
//                       //   ),
//                       // ),
//                       SizedBox(
//                         height: SizeVariables.getHeight(context) * 0.01,
//                       ),
//                       InkWell(
//                         onTap: () {},
//                         child: Container(
//                           child: Row(
//                             children: [
//                               const Icon(Icons.email, color: Colors.amber),
//                               Text(
//                                   value.organisation.data!.data![index]
//                                       .members![indexTwo].email
//                                       .toString(),
//                                   style: TextStyle(
//                                       color: Theme.of(context).accentColor))
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: SizeVariables.getHeight(context) * 0.01,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           _calluser(url);
//                         },
//                         child: Container(
//                           child: Row(
//                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.phone, color: Colors.green),
//                                     // Text(
//                                     //   "9062050556",
//                                     //   style: TextStyle(color: Colors.white),
//                                     // ),

//                                     Text(
//                                       value.organisation.data!.data![index]
//                                           .members![indexTwo].contactNo
//                                           .toString(),
//                                       style: TextStyle(
//                                           color: Theme.of(context).accentColor),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               // InkWell(
//                               //   onTap: () => _calluser(url),
//                               //   child: const Icon(Icons.phone, color: Colors.green),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: SizeVariables.getHeight(context) * 0.01,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           // _calluser(url);
//                         },
//                         child: Container(
//                           child: Row(
//                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.phone, color: Colors.green),
//                                     Text(
//                                       "9999999999",
//                                       style: TextStyle(
//                                           color: Theme.of(context).accentColor),
//                                     ),

//                                     // Text(
//                                     //   value.organisation.data!.data![index]
//                                     //       .members![indexTwo].contactNo
//                                     //       .toString(),
//                                     //   style: TextStyle(color: Colors.white),
//                                     // ),
//                                   ],
//                                 ),
//                               ),
//                               // InkWell(
//                               //   onTap: () => _calluser(url),
//                               //   child: const Icon(Icons.phone, color: Colors.green),
//                               // ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//     // return showDialog(
//     //     context: context,
//     //     builder: (context) => AlertDialog(
//     //           backgroundColor: Color.fromARGB(255, 50, 48, 48),
//     //           content: Container(
//     //             width: double.maxFinite,
//     //             height: SizeVariables.getHeight(context),
//     //             child: Column(
//     //               children: [
//     //                 Expanded(
//     //                   child: Row(
//     //                     children: [
//     //                       Flexible(
//     //                         flex: 1,
//     //                         fit: FlexFit.tight,
//     //                         child: Container(
//     //                           // color: Colors.red,
//     //                           height: double.infinity,
//     //                           child: Column(
//     //                             mainAxisAlignment: MainAxisAlignment.start,
//     //                             children: [
//     //                               value
//     //                                           .organisation
//     //                                           .data!
//     //                                           .data![index]
//     //                                           .members![indexTwo]
//     //                                           .profilePhoto ==
//     //                                       null
//     //                                   ? CircleAvatar(
//     //                                       backgroundImage: AssetImage(
//     //                                           'assets/img/profilePic.jpg'),
//     //                                     )
//     //                                   : CircleAvatar(
//     //                                       backgroundImage: NetworkImage(
//     //                                           'http://claimz.vitwo.in/profile_photo/${value.organisation.data!.data![index].members![indexTwo].profilePhoto}'),
//     //                                     )
//     //                             ],
//     //                           ),
//     //                         ),
//     //                       ),
//     //                       Flexible(
//     //                         flex: 3,
//     //                         fit: FlexFit.tight,
//     //                         child: Container(
//     //                           // color: Colors.green,
//     //                           height: double.infinity,
//     //                           child: Column(
//     //                             crossAxisAlignment: CrossAxisAlignment.start,
//     //                             children: [
//     //                               FittedBox(
//     //                                 fit: BoxFit.contain,
//     //                                 child: Text(
//     //                                     value.organisation.data!.data![index]
//     //                                         .members![indexTwo].empName
//     //                                         .toString(),
//     //                                     style: Theme.of(context)
//     //                                         .textTheme
//     //                                         .bodyText1),
//     //                               ),
//     //                               FittedBox(
//     //                                 fit: BoxFit.contain,
//     //                                 child: Text(
//     //                                     value.organisation.data!.data![index]
//     //                                         .members![indexTwo].empCode
//     //                                         .toString(),
//     //                                     style: Theme.of(context)
//     //                                         .textTheme
//     //                                         .bodyText1),
//     //                               ),
//     //                               FittedBox(
//     //                                 fit: BoxFit.contain,
//     //                                 child: value
//     //                                             .organisation
//     //                                             .data!
//     //                                             .data![index]
//     //                                             .members![indexTwo]
//     //                                             .designation ==
//     //                                         null
//     //                                     ? Text('No Designation',
//     //                                         style: Theme.of(context)
//     //                                             .textTheme
//     //                                             .bodyText1)
//     //                                     : Text(
//     //                                         value
//     //                                             .organisation
//     //                                             .data!
//     //                                             .data![index]
//     //                                             .members![indexTwo]
//     //                                             .designation
//     //                                             .toString(),
//     //                                         style: Theme.of(context)
//     //                                             .textTheme
//     //                                             .bodyText1),
//     //                               ),
//     //                               Row(
//     //                                 children: [
//     //                                   const Icon(Icons.business,
//     //                                       color: Colors.amber, size: 14),
//     //                                   SizedBox(
//     //                                       width:
//     //                                           SizeVariables.getWidth(context) *
//     //                                               0.005),
//     //                                   FittedBox(
//     //                                     fit: BoxFit.contain,
//     //                                     child: Text(
//     //                                         value
//     //                                             .organisation
//     //                                             .data!
//     //                                             .data![index]
//     //                                             .members![indexTwo]
//     //                                             .departmentId
//     //                                             .toString(),
//     //                                         style: Theme.of(context)
//     //                                             .textTheme
//     //                                             .bodyText1),
//     //                                   ),
//     //                                 ],
//     //                               ),
//     //                               Row(
//     //                                 children: [
//     //                                   const Icon(Icons.mobile_screen_share,
//     //                                       color: Colors.amber, size: 14),
//     //                                   SizedBox(
//     //                                       width:
//     //                                           SizeVariables.getWidth(context) *
//     //                                               0.005),
//     //                                   FittedBox(
//     //                                     fit: BoxFit.contain,
//     //                                     child: Text(
//     //                                         value
//     //                                                     .organisation
//     //                                                     .data!
//     //                                                     .data![index]
//     //                                                     .members![indexTwo]
//     //                                                     .contactNo
//     //                                                     .toString() ==
//     //                                                 ""
//     //                                             ? "999999999"
//     //                                             : value
//     //                                                 .organisation
//     //                                                 .data!
//     //                                                 .data![index]
//     //                                                 .members![indexTwo]
//     //                                                 .contactNo
//     //                                                 .toString(),
//     //                                         style: Theme.of(context)
//     //                                             .textTheme
//     //                                             .bodyText1),
//     //                                   ),
//     //                                   // FittedBox(
//     //                                   //   fit: BoxFit
//     //                                   //       .contain,
//     //                                   //   child: Text(
//     //                                   //       value
//     //                                   //           .organisation
//     //                                   //           .data!
//     //                                   //           .data![index]
//     //                                   //           .members![indexTwo]
//     //                                   //           .contactNo
//     //                                   //           .toString(),
//     //                                   //       style: Theme.of(context).textTheme.bodyText1),
//     //                                   // ),
//     //                                 ],
//     //                               ),
//     //                               Row(
//     //                                 children: [
//     //                                   const Icon(Icons.email,
//     //                                       color: Colors.amber, size: 14),
//     //                                   SizedBox(
//     //                                       width:
//     //                                           SizeVariables.getWidth(context) *
//     //                                               0.005),
//     //                                   FittedBox(
//     //                                     fit: BoxFit.contain,
//     //                                     child: Text(
//     //                                         value
//     //                                             .organisation
//     //                                             .data!
//     //                                             .data![index]
//     //                                             .members![indexTwo]
//     //                                             .email
//     //                                             .toString(),
//     //                                         style: Theme.of(context)
//     //                                             .textTheme
//     //                                             .bodyText1),
//     //                                   ),
//     //                                 ],
//     //                               ),
//     //                               Row(
//     //                                 children: [
//     //                                   const Icon(Icons.map,
//     //                                       color: Colors.amber, size: 14),
//     //                                   SizedBox(
//     //                                       width:
//     //                                           SizeVariables.getWidth(context) *
//     //                                               0.005),
//     //                                   FittedBox(
//     //                                     fit: BoxFit.contain,
//     //                                     child: Text(
//     //                                         value
//     //                                             .organisation
//     //                                             .data!
//     //                                             .data![index]
//     //                                             .members![indexTwo]
//     //                                             .placeOfPosting
//     //                                             .toString(),
//     //                                         style: Theme.of(context)
//     //                                             .textTheme
//     //                                             .bodyText1),
//     //                                   ),
//     //                                 ],
//     //                               )
//     //                             ],
//     //                           ),
//     //                         ),
//     //                       )
//     //                     ],
//     //                   ),
//     //                 ),
//     //                 ElevatedButton(
//     //                     onPressed: () async {
//     //                       _calluser(url);
//     //                     },
//     //                     child: new Text("Call me")),
//     //               ],
//     //             ),
//     //           ),
//     //         ));
//   }

//   Future<void> _calluser(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not call';
//     }
//   }

//   Future<void> _launch(Uri url) async {
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url);
//     } else {
//       throw 'Could not email';
//     }
//   }
// }
