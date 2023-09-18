import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/response/status.dart';
import '../../../res/appUrl.dart';
import '../../../viewModel/organisationViewModel.dart';
import '../../config/mediaQuery.dart';
import 'organisationShimmer.dart';

class OrgWidget extends StatefulWidget {
  // const OrgWidget({Key? key}) : super(key: key);
  Map<String, dynamic> map;

  OrgWidget(this.map);

  @override
  State<OrgWidget> createState() => OrgWidgetState();
}

class OrgWidgetState extends State<OrgWidget> {
  // int index=0;
  // int indexTwo = 0;
  // final organizationViewModel = OrganizationViewModel();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   organizationViewModel.getOrganisationList();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: SizeVariables.getHeight(context) * 0.02,
      ),
      height: SizeVariables.getHeight(context) * 0.9,
      child: ListView(
        children: [
          // for (int index = 0;
          //     index < value.organisation.data!.data!.length;
          //     index++)
          //   for (int indexTwo = 0;
          //       indexTwo <
          //           value.organisation.data!.data![index].members!
          //               .length;
          //       indexTwo++)

          for (int index = 0; index < widget.map['members'].length; index++)
            InkWell(
              onTap: () =>
                  _dialogProfile(context, widget.map['members'][index]),
              child: Container(
                margin: EdgeInsets.only(
                    bottom: SizeVariables.getHeight(context) * 0.02),
                child: ContainerStyle(
                  height: SizeVariables.getHeight(context) * 0.09,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: widget.map['members'][index]
                                      ['profile_photo'] ==
                                  null
                              ? CircleAvatar(
                                  radius:
                                      SizeVariables.getWidth(context) * 0.06,
                                  // backgroundColor:Colors.green,
                                  backgroundImage: const AssetImage(
                                      'assets/img/profilePic.jpg'),
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      '${AppUrl.baseUrl}/profile_photo/${widget.map['members'][index]['profile_photo']}',
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    radius:
                                        SizeVariables.getWidth(context) * 0.08,
                                    backgroundColor: Colors.green,
                                    backgroundImage: imageProvider,
                                    // child: const Icon(Icons.account_box, color: Colors.white),
                                  ),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[400]!,
                                    highlightColor: const Color.fromARGB(
                                        255, 120, 120, 120),
                                    child: CircleAvatar(
                                        radius:
                                            SizeVariables.getWidth(context) *
                                                0.08),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                    radius:
                                        SizeVariables.getWidth(context) * 0.08,
                                    backgroundColor: Colors.green,
                                    backgroundImage: const AssetImage(
                                        'assets/img/profilePic.jpg'),
                                    // child: const Icon(Icons.account_box, color: Colors.white),
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeVariables.getHeight(context) * 0.02,
                            left: SizeVariables.getWidth(context) * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                widget.map['members'][index]['emp_name'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                            SizedBox(
                              height: SizeVariables.getHeight(context) * 0.0035,
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                widget.map['members'][index]['email'],
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

_dialogProfile(BuildContext context, Map<String, dynamic> info) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //backgroundColor: Colors.black,
      content: Container(
        width: double.maxFinite,
        height: SizeVariables.getHeight(context) * 0.45,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                info['profile_photo'] == null
                    ? CircleAvatar(
                        radius: SizeVariables.getWidth(context) * 0.1,
                        // backgroundColor:Colors.green,
                        backgroundImage:
                            const AssetImage('assets/img/profilePic.jpg'),
                      )
                    : CachedNetworkImage(
                        imageUrl:
                            '${AppUrl.baseUrl}/profile_photo/${info['profile_photo']}',
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: SizeVariables.getWidth(context) * 0.1,
                          backgroundColor: Colors.green,
                          backgroundImage: imageProvider,
                          // child: const Icon(Icons.account_box, color: Colors.white),
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor:
                              const Color.fromARGB(255, 120, 120, 120),
                          child: CircleAvatar(
                              radius: SizeVariables.getWidth(context) * 0.18),
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          radius: SizeVariables.getWidth(context) * 0.1,
                          backgroundColor: Colors.green,
                          backgroundImage:
                              const AssetImage('assets/img/profilePic.jpg'),
                          // child: const Icon(Icons.account_box, color: Colors.white),
                        ),
                      )
              ],
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  info['emp_name'],
                  style: Theme.of(context).textTheme.bodyText1!,
                )
              ],
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.005),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  info['designation'],
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 15,
                      ),
                )
              ],
            ),
            SizedBox(height: SizeVariables.getHeight(context) * 0.008),
            Expanded(
              child: Container(
                width: double.infinity,
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          const Icon(Icons.shield, color: Colors.amber),
                          Text(info['emp_code'],
                              style: TextStyle(
                                  color: Theme.of(context).canvasColor))
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: SizeVariables.getHeight(context) * 0.01,
                    // ),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       const Icon(Icons.person, color: Colors.amber),
                    //       Text(
                    //           value.organisation.data!.data![index]
                    //               .members![indexTwo].aprrover1
                    //               .toString(),
                    //           style: TextStyle(color: Colors.white))
                    //     ],
                    //   ),
                    // ),

                    // SizedBox(
                    //   height: SizeVariables.getHeight(context) * 0.01,
                    // ),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       const Icon(Icons.person, color: Colors.amber),
                    //       Text(
                    //           value.organisation.data!.data![index]
                    //               .members![indexTwo].aprrover2
                    //               .toString(),
                    //           style: TextStyle(color: Colors.white))
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        child: Row(
                          children: [
                            const Icon(Icons.email, color: Colors.amber),
                            Text(info['email'],
                                style: TextStyle(
                                    color: Theme.of(context).canvasColor))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        String url = 'tel://${info['contact_no']}';
                        _calluser(url);
                      },
                      child: Container(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.phone, color: Colors.green),
                                  // Text(
                                  //   "9062050556",
                                  //   style: TextStyle(color: Colors.white),
                                  // ),

                                  Text(
                                    info['contact_no'],
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor),
                                  ),
                                ],
                              ),
                            ),
                            // InkWell(
                            //   onTap: () => _calluser(url),
                            //   child: const Icon(Icons.phone, color: Colors.green),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        // _calluser(url);
                      },
                      child: Container(
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.phone, color: Colors.green),
                                  Text(
                                    "9999999999",
                                    style: TextStyle(
                                        color: Theme.of(context).canvasColor),
                                  ),

                                  // Text(
                                  //   value.organisation.data!.data![index]
                                  //       .members![indexTwo].contactNo
                                  //       .toString(),
                                  //   style: TextStyle(color: Colors.white),
                                  // ),
                                ],
                              ),
                            ),
                            // InkWell(
                            //   onTap: () => _calluser(url),
                            //   child: const Icon(Icons.phone, color: Colors.green),
                            // ),
                          ],
                        ),
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
  );
  // return showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //           backgroundColor: Color.fromARGB(255, 50, 48, 48),
  //           content: Container(
  //             width: double.maxFinite,
  //             height: SizeVariables.getHeight(context),
  //             child: Column(
  //               children: [
  //                 Expanded(
  //                   child: Row(
  //                     children: [
  //                       Flexible(
  //                         flex: 1,
  //                         fit: FlexFit.tight,
  //                         child: Container(
  //                           // color: Colors.red,
  //                           height: double.infinity,
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             children: [
  //                               value
  //                                           .organisation
  //                                           .data!
  //                                           .data![index]
  //                                           .members![indexTwo]
  //                                           .profilePhoto ==
  //                                       null
  //                                   ? CircleAvatar(
  //                                       backgroundImage: AssetImage(
  //                                           'assets/img/profilePic.jpg'),
  //                                     )
  //                                   : CircleAvatar(
  //                                       backgroundImage: NetworkImage(
  //                                           'http://claimz.vitwo.in/profile_photo/${value.organisation.data!.data![index].members![indexTwo].profilePhoto}'),
  //                                     )
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                       Flexible(
  //                         flex: 3,
  //                         fit: FlexFit.tight,
  //                         child: Container(
  //                           // color: Colors.green,
  //                           height: double.infinity,
  //                           child: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               FittedBox(
  //                                 fit: BoxFit.contain,
  //                                 child: Text(
  //                                     value.organisation.data!.data![index]
  //                                         .members![indexTwo].empName
  //                                         .toString(),
  //                                     style: Theme.of(context)
  //                                         .textTheme
  //                                         .bodyText1),
  //                               ),
  //                               FittedBox(
  //                                 fit: BoxFit.contain,
  //                                 child: Text(
  //                                     value.organisation.data!.data![index]
  //                                         .members![indexTwo].empCode
  //                                         .toString(),
  //                                     style: Theme.of(context)
  //                                         .textTheme
  //                                         .bodyText1),
  //                               ),
  //                               FittedBox(
  //                                 fit: BoxFit.contain,
  //                                 child: value
  //                                             .organisation
  //                                             .data!
  //                                             .data![index]
  //                                             .members![indexTwo]
  //                                             .designation ==
  //                                         null
  //                                     ? Text('No Designation',
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .bodyText1)
  //                                     : Text(
  //                                         value
  //                                             .organisation
  //                                             .data!
  //                                             .data![index]
  //                                             .members![indexTwo]
  //                                             .designation
  //                                             .toString(),
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .bodyText1),
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   const Icon(Icons.business,
  //                                       color: Colors.amber, size: 14),
  //                                   SizedBox(
  //                                       width:
  //                                           SizeVariables.getWidth(context) *
  //                                               0.005),
  //                                   FittedBox(
  //                                     fit: BoxFit.contain,
  //                                     child: Text(
  //                                         value
  //                                             .organisation
  //                                             .data!
  //                                             .data![index]
  //                                             .members![indexTwo]
  //                                             .departmentId
  //                                             .toString(),
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .bodyText1),
  //                                   ),
  //                                 ],
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   const Icon(Icons.mobile_screen_share,
  //                                       color: Colors.amber, size: 14),
  //                                   SizedBox(
  //                                       width:
  //                                           SizeVariables.getWidth(context) *
  //                                               0.005),
  //                                   FittedBox(
  //                                     fit: BoxFit.contain,
  //                                     child: Text(
  //                                         value
  //                                                     .organisation
  //                                                     .data!
  //                                                     .data![index]
  //                                                     .members![indexTwo]
  //                                                     .contactNo
  //                                                     .toString() ==
  //                                                 ""
  //                                             ? "999999999"
  //                                             : value
  //                                                 .organisation
  //                                                 .data!
  //                                                 .data![index]
  //                                                 .members![indexTwo]
  //                                                 .contactNo
  //                                                 .toString(),
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .bodyText1),
  //                                   ),
  //                                   // FittedBox(
  //                                   //   fit: BoxFit
  //                                   //       .contain,
  //                                   //   child: Text(
  //                                   //       value
  //                                   //           .organisation
  //                                   //           .data!
  //                                   //           .data![index]
  //                                   //           .members![indexTwo]
  //                                   //           .contactNo
  //                                   //           .toString(),
  //                                   //       style: Theme.of(context).textTheme.bodyText1),
  //                                   // ),
  //                                 ],
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   const Icon(Icons.email,
  //                                       color: Colors.amber, size: 14),
  //                                   SizedBox(
  //                                       width:
  //                                           SizeVariables.getWidth(context) *
  //                                               0.005),
  //                                   FittedBox(
  //                                     fit: BoxFit.contain,
  //                                     child: Text(
  //                                         value
  //                                             .organisation
  //                                             .data!
  //                                             .data![index]
  //                                             .members![indexTwo]
  //                                             .email
  //                                             .toString(),
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .bodyText1),
  //                                   ),
  //                                 ],
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   const Icon(Icons.map,
  //                                       color: Colors.amber, size: 14),
  //                                   SizedBox(
  //                                       width:
  //                                           SizeVariables.getWidth(context) *
  //                                               0.005),
  //                                   FittedBox(
  //                                     fit: BoxFit.contain,
  //                                     child: Text(
  //                                         value
  //                                             .organisation
  //                                             .data!
  //                                             .data![index]
  //                                             .members![indexTwo]
  //                                             .placeOfPosting
  //                                             .toString(),
  //                                         style: Theme.of(context)
  //                                             .textTheme
  //                                             .bodyText1),
  //                                   ),
  //                                 ],
  //                               )
  //                             ],
  //                           ),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 ElevatedButton(
  //                     onPressed: () async {
  //                       _calluser(url);
  //                     },
  //                     child: new Text("Call me")),
  //               ],
  //             ),
  //           ),
  //         ));
}

Future<void> _calluser(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not call';
  }
}
