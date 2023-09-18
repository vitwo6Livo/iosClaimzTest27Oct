import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/mediaQuery.dart';

class OrganizationDetails extends StatefulWidget {
  final Map<String, dynamic> orgDetail;

  List<Map<String, dynamic>> images = [
    {
      "image": "assets/organization/phone-call.png",
      "name": "Call",
    },
    {
      "image": "assets/organization/gmail.png",
      "name": "Email",
    },
    {
      "image": "assets/organization/whatsapp.png",
      "name": "Chat",
    },
    {
      "image": "assets/organization/meeting.png",
      "name": "Meeting",
    },
  ];

  @override
  State<OrganizationDetails> createState() => _OrganizationDetailsState();

  OrganizationDetails(this.orgDetail);
}

class _OrganizationDetailsState extends State<OrganizationDetails> {
  int _selection = 0;
  String? name;
  String? designation;
  String? department;
  String? dateOfJoining;
  String? empCode;
  String? bloodGroup;
  String? profilePicture;
  String? phone;
  String? email;
  String? primaryReporting;
  String? secondaryReporting;

  @override
  void initState() {
    // TODO: implement initState
    Map data = {
      "month": "",
      "type": "",
      "year": "",
      "user_id": "",
      "all": "1" //self
    };

    name = widget.orgDetail['details']['emp_name'];
    designation = widget.orgDetail['details']['designation_name'];
    department = widget.orgDetail['departmentName'];
    dateOfJoining = widget.orgDetail['details']['join_date'];
    empCode = widget.orgDetail['details']['emp_code'];
    bloodGroup = widget.orgDetail['details']['blood_group'];
    profilePicture = widget.orgDetail['details']['profile_photo'];
    phone = widget.orgDetail['details']['mobile_no'];
    email = widget.orgDetail['details']['email'];
    primaryReporting = widget.orgDetail['details']['primary'];
    secondaryReporting = widget.orgDetail['details']['secondary'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Container(
          // color: Colors.amber,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: SizeVariables.getHeight(context) * 0.01),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        "assets/icons/back button.svg",
                      ),
                    ),
                    // ProfilededarWidget(),
                    SizedBox(width: SizeVariables.getWidth(context) * 0.02),
                    Text(
                      'Employee Details',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.04,
              ),
              ContainerStyle(
                height: SizeVariables.getHeight(context) * 0.27,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: SizeVariables.getHeight(context) * 0.03,
                          ),
                          child: Container(
                            child: profilePicture ==
                                    'https://console.claimz.in/api/profile_photo'
                                ? CircleAvatar(
                                    radius:
                                        SizeVariables.getWidth(context) * 0.08,
                                    backgroundColor: Colors.green,
                                    backgroundImage: const AssetImage(
                                        'assets/img/profilePic.jpg'),
                                    // child: const Icon(Icons.account_box, color: Colors.white),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: profilePicture!,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: SizeVariables.getHeight(context) *
                                          0.08,
                                      width: SizeVariables.getHeight(context) *
                                          0.08,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.contain)),
                                    ),
                                    placeholder: (context, url) => Container(
                                        height:
                                            SizeVariables.getHeight(context) *
                                                0.06,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey[400]!,
                                          highlightColor: const Color.fromARGB(
                                              255, 120, 120, 120),
                                          child: const CircleAvatar(
                                            radius: 2,
                                            backgroundColor: Colors.green,
                                            child: Center(
                                              child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  color: Colors.white,
                                                  size: 20),
                                            ),
                                          ),
                                        )),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.005,
                    ),
                    Container(
                      child: Text(
                        name!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.005,
                    ),
                    Container(
                      child: Text(
                        designation!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: SizeVariables.getHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: InkWell(
                            onTap: () => launchUrl(
                                Uri(scheme: 'tel', path: '+91$phone')),
                            child: Container(
                              child: Column(
                                children: [
                                  Image.asset(
                                    widget.images[0]["image"],
                                    height:
                                        SizeVariables.getHeight(context) * 0.04,
                                  ),
                                  Text(
                                    widget.images[0]['name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              child: Column(
                                children: [
                                  Image.asset(
                                    widget.images[3]["image"],
                                    height:
                                        SizeVariables.getHeight(context) * 0.04,
                                  ),
                                  Text(
                                    widget.images[3]['name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: InkWell(
                            onTap: () =>
                                launchUrl(Uri(scheme: 'mailto', path: email)),
                            child: Container(
                              child: Column(
                                children: [
                                  Image.asset(
                                    widget.images[1]["image"],
                                    height:
                                        SizeVariables.getHeight(context) * 0.04,
                                  ),
                                  Text(
                                    widget.images[1]['name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeVariables.getWidth(context) * 0.03,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: InkWell(
                            onTap: () =>
                                launch('whatsapp://send?phone=+91$phone'),
                            child: Container(
                              child: Column(
                                children: [
                                  Image.asset(
                                    widget.images[2]["image"],
                                    height:
                                        SizeVariables.getHeight(context) * 0.04,
                                  ),
                                  Text(
                                    widget.images[2]['name'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.04,
              ),
              ContainerStyle(
                height: SizeVariables.getHeight(context) * 0.3,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            child: Row(
                              children: [
                                // Container(
                                //   child: Text(
                                //     'Name:',
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .bodyText1!
                                //         .copyWith(
                                //           fontSize: 16,
                                //         ),
                                //   ),
                                // ),
                                // SizedBox(
                                //   width:
                                //       SizeVariables.getHeight(context) * 0.01,
                                // ),
                                // Container(
                                //   child: Text(
                                //     'Joy SHil',
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .bodyText1!
                                //         .copyWith(
                                //           color: Colors.grey,
                                //           fontSize: 14,
                                //         ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'Department:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      SizeVariables.getHeight(context) * 0.01,
                                ),
                                Container(
                                  child: Text(
                                    department!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'DOJ:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      SizeVariables.getHeight(context) * 0.01,
                                ),
                                Container(
                                  child: Text(
                                    dateOfJoining!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'EMP Code:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      SizeVariables.getHeight(context) * 0.01,
                                ),
                                Container(
                                  child: Text(
                                    empCode!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'Blood Group:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      SizeVariables.getHeight(context) * 0.01,
                                ),
                                Container(
                                  child: Text(
                                    bloodGroup!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'Reporting Manager:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      SizeVariables.getHeight(context) * 0.01,
                                ),
                                Container(
                                  child: Text(
                                    // widget.orgDetail['details']['blood_group'],
                                    primaryReporting!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    'Secondary Manager:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      SizeVariables.getHeight(context) * 0.01,
                                ),
                                Container(
                                  child: Text(
                                    secondaryReporting!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: Colors.grey,
                                          fontSize: 14,
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
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.04,
              ),
              Container(
                  height: SizeVariables.getHeight(context) * 0.22,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          _selection = index;

                          name =
                              widget.orgDetail['employees'][index]['emp_name'];

                          designation = widget.orgDetail['employees'][index]
                                  ['designation_name'] ??
                              'NA';

                          dateOfJoining =
                              widget.orgDetail['employees'][index]['join_date'];

                          empCode =
                              widget.orgDetail['employees'][index]['emp_code'];

                          bloodGroup = widget.orgDetail['employees'][index]
                              ['blood_group'];

                          profilePicture = widget.orgDetail['employees'][index]
                              ['profile_photo'];

                          phone =
                              widget.orgDetail['employees'][index]['mobile_no'];

                          email = widget.orgDetail['employees'][index]['email'];

                          primaryReporting =
                              widget.orgDetail['employees'][index]['primary'];

                          secondaryReporting =
                              widget.orgDetail['employees'][index]['secondary'];
                        });
                      },
                      child: Container(
                        width: 130,
                        decoration: _selection == index
                            ? BoxDecoration(
                                border: Border.all(
                                  color: Colors.amber,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              )
                            : BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                        child: ContainerStyle(
                          height: SizeVariables.getHeight(context) * 0.22,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: widget.orgDetail['employees'][index]
                                                ['profile_photo'] ==
                                            'https://console.claimz.in/api/profile_photo'
                                        ? CircleAvatar(
                                            radius: SizeVariables.getWidth(
                                                    context) *
                                                0.08,
                                            backgroundColor: Colors.green,
                                            backgroundImage: const AssetImage(
                                                'assets/img/profilePic.jpg'),
                                            // child: const Icon(Icons.account_box, color: Colors.white),
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                widget.orgDetail['employees']
                                                    [index]['profile_photo'],
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              height: SizeVariables.getHeight(
                                                      context) *
                                                  0.08,
                                              width: SizeVariables.getHeight(
                                                      context) *
                                                  0.08,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.contain)),
                                            ),
                                            placeholder: (context, url) =>
                                                Container(
                                                    height:
                                                        SizeVariables.getHeight(
                                                                context) *
                                                            0.06,
                                                    child: Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[400]!,
                                                      highlightColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              120,
                                                              120,
                                                              120),
                                                      child: const CircleAvatar(
                                                        radius: 2,
                                                        backgroundColor:
                                                            Colors.green,
                                                        child: Center(
                                                          child: Icon(
                                                              Icons
                                                                  .camera_alt_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: 20),
                                                        ),
                                                      ),
                                                    )),
                                          ),
                                  ),
                                  SizedBox(
                                    height: SizeVariables.getHeight(context) *
                                        0.015,
                                  ),
                                  Container(
                                    // color: Colors.amber,
                                    width:
                                        SizeVariables.getWidth(context) * 0.3,
                                    height:
                                        SizeVariables.getHeight(context) * 0.02,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text(
                                        widget.orgDetail['employees'][index]
                                            ['emp_name'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              fontSize: 16,
                                            ),
                                        // overflow: TextOverflow.ellipsis,
                                        // softWrap: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeVariables.getHeight(context) *
                                        0.008,
                                  ),
                                  Container(
                                    // color: Colors.red,
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        widget.orgDetail['employees'][index]
                                                ['designation_name'] ??
                                            'NA',
                                        // softWrap: true,
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
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    itemCount: widget.orgDetail['employees'].length,
                  )

                  // ListView(
                  //   scrollDirection: Axis.horizontal,
                  //   children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         _selection = 0;
                  //       });
                  //     },
                  //     child: Container(
                  //       width: 130,
                  //       decoration: _selection == 0
                  //           ? BoxDecoration(
                  //               border: Border.all(
                  //                 color: Colors.amber,
                  //               ),
                  //               borderRadius: BorderRadius.circular(8),
                  //             )
                  //           : BoxDecoration(
                  //               border: Border.all(
                  //                 color: Colors.black,
                  //               ),
                  //             ),
                  //       child: ContainerStyle(
                  //         height: SizeVariables.getHeight(context) * 0.22,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             Column(
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Container(
                  //                   child: CircleAvatar(
                  //                     radius:
                  //                         SizeVariables.getWidth(context) *
                  //                             0.09,
                  //                     backgroundColor: Colors.green,
                  //                     backgroundImage: const AssetImage(
                  //                         'assets/img/profilePic.jpg'),
                  //                     // child: const Icon(Icons.account_box, color: Colors.white),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: SizeVariables.getHeight(context) *
                  //                       0.015,
                  //                 ),
                  //                 Container(
                  //                   // color: Colors.amber,
                  //                   width:
                  //                       SizeVariables.getWidth(context) * 0.3,
                  //                   height: SizeVariables.getHeight(context) *
                  //                       0.02,
                  //                   child: FittedBox(
                  //                     fit: BoxFit.contain,
                  //                     child: Text(
                  //                       'Joy Shil',
                  //                       style: Theme.of(context)
                  //                           .textTheme
                  //                           .bodyText1!
                  //                           .copyWith(
                  //                             fontSize: 16,
                  //                           ),
                  //                       // overflow: TextOverflow.ellipsis,
                  //                       // softWrap: true,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 SizedBox(
                  //                   height: SizeVariables.getHeight(context) *
                  //                       0.008,
                  //                 ),
                  //                 Container(
                  //                   child: Text(
                  //                     'System',
                  //                     style: Theme.of(context)
                  //                         .textTheme
                  //                         .bodyText1!
                  //                         .copyWith(
                  //                           fontSize: 14,
                  //                           color: Colors.grey,
                  //                         ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: InkWell(
                  //         onTap: () {
                  //           setState(() {
                  //             _selection = 1;
                  //           });
                  //         },
                  //         child: Container(
                  //           width: 130,
                  //           decoration: _selection == 1
                  //               ? BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.amber,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(8),
                  //                 )
                  //               : BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),
                  //           child: ContainerStyle(
                  //             height: SizeVariables.getHeight(context) * 0.22,
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Container(
                  //                       child: CircleAvatar(
                  //                         radius:
                  //                             SizeVariables.getWidth(context) *
                  //                                 0.09,
                  //                         backgroundColor: Colors.green,
                  //                         backgroundImage: const AssetImage(
                  //                             'assets/img/profilePic.jpg'),
                  //                         // child: const Icon(Icons.account_box, color: Colors.white),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.015,
                  //                     ),
                  //                     Container(
                  //                       // color: Colors.amber,
                  //                       width:
                  //                           SizeVariables.getWidth(context) * 0.3,
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.02,
                  //                       child: FittedBox(
                  //                         fit: BoxFit.contain,
                  //                         child: Text(
                  //                           'Joy Shil',
                  //                           style: Theme.of(context)
                  //                               .textTheme
                  //                               .bodyText1!
                  //                               .copyWith(
                  //                                 fontSize: 16,
                  //                               ),
                  //                           // overflow: TextOverflow.ellipsis,
                  //                           // softWrap: true,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.008,
                  //                     ),
                  //                     Container(
                  //                       child: Text(
                  //                         'System',
                  //                         style: Theme.of(context)
                  //                             .textTheme
                  //                             .bodyText1!
                  //                             .copyWith(
                  //                               fontSize: 14,
                  //                               color: Colors.grey,
                  //                             ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: InkWell(
                  //         onTap: () {
                  //           setState(() {
                  //             _selection = 2;
                  //           });
                  //         },
                  //         child: Container(
                  //           width: 130,
                  //           decoration: _selection == 2
                  //               ? BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.amber,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(8),
                  //                 )
                  //               : BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),
                  //           child: ContainerStyle(
                  //             height: SizeVariables.getHeight(context) * 0.22,
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Container(
                  //                       child: CircleAvatar(
                  //                         radius:
                  //                             SizeVariables.getWidth(context) *
                  //                                 0.09,
                  //                         backgroundColor: Colors.green,
                  //                         backgroundImage: const AssetImage(
                  //                             'assets/img/profilePic.jpg'),
                  //                         // child: const Icon(Icons.account_box, color: Colors.white),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.015,
                  //                     ),
                  //                     Container(
                  //                       // color: Colors.amber,
                  //                       width:
                  //                           SizeVariables.getWidth(context) * 0.3,
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.02,
                  //                       child: FittedBox(
                  //                         fit: BoxFit.contain,
                  //                         child: Text(
                  //                           'Joy Shil',
                  //                           style: Theme.of(context)
                  //                               .textTheme
                  //                               .bodyText1!
                  //                               .copyWith(
                  //                                 fontSize: 16,
                  //                               ),
                  //                           // overflow: TextOverflow.ellipsis,
                  //                           // softWrap: true,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.008,
                  //                     ),
                  //                     Container(
                  //                       child: Text(
                  //                         'System',
                  //                         style: Theme.of(context)
                  //                             .textTheme
                  //                             .bodyText1!
                  //                             .copyWith(
                  //                               fontSize: 14,
                  //                               color: Colors.grey,
                  //                             ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: InkWell(
                  //         onTap: () {
                  //           setState(() {
                  //             _selection = 3;
                  //           });
                  //         },
                  //         child: Container(
                  //           width: 130,
                  //           decoration: _selection == 3
                  //               ? BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.amber,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(8),
                  //                 )
                  //               : BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),
                  //           child: ContainerStyle(
                  //             height: SizeVariables.getHeight(context) * 0.22,
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Container(
                  //                       child: CircleAvatar(
                  //                         radius:
                  //                             SizeVariables.getWidth(context) *
                  //                                 0.09,
                  //                         backgroundColor: Colors.green,
                  //                         backgroundImage: const AssetImage(
                  //                             'assets/img/profilePic.jpg'),
                  //                         // child: const Icon(Icons.account_box, color: Colors.white),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.015,
                  //                     ),
                  //                     Container(
                  //                       // color: Colors.amber,
                  //                       width:
                  //                           SizeVariables.getWidth(context) * 0.3,
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.02,
                  //                       child: FittedBox(
                  //                         fit: BoxFit.contain,
                  //                         child: Text(
                  //                           'Joy Shil',
                  //                           style: Theme.of(context)
                  //                               .textTheme
                  //                               .bodyText1!
                  //                               .copyWith(
                  //                                 fontSize: 16,
                  //                               ),
                  //                           // overflow: TextOverflow.ellipsis,
                  //                           // softWrap: true,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.008,
                  //                     ),
                  //                     Container(
                  //                       child: Text(
                  //                         'System',
                  //                         style: Theme.of(context)
                  //                             .textTheme
                  //                             .bodyText1!
                  //                             .copyWith(
                  //                               fontSize: 14,
                  //                               color: Colors.grey,
                  //                             ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: InkWell(
                  //         onTap: () {
                  //           setState(() {
                  //             _selection = 4;
                  //           });
                  //         },
                  //         child: Container(
                  //           width: 130,
                  //           decoration: _selection == 4
                  //               ? BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.amber,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(8),
                  //                 )
                  //               : BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),
                  //           child: ContainerStyle(
                  //             height: SizeVariables.getHeight(context) * 0.22,
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Container(
                  //                       child: CircleAvatar(
                  //                         radius:
                  //                             SizeVariables.getWidth(context) *
                  //                                 0.09,
                  //                         backgroundColor: Colors.green,
                  //                         backgroundImage: const AssetImage(
                  //                             'assets/img/profilePic.jpg'),
                  //                         // child: const Icon(Icons.account_box, color: Colors.white),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.015,
                  //                     ),
                  //                     Container(
                  //                       // color: Colors.amber,
                  //                       width:
                  //                           SizeVariables.getWidth(context) * 0.3,
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.02,
                  //                       child: FittedBox(
                  //                         fit: BoxFit.contain,
                  //                         child: Text(
                  //                           'Joy Shil',
                  //                           style: Theme.of(context)
                  //                               .textTheme
                  //                               .bodyText1!
                  //                               .copyWith(
                  //                                 fontSize: 16,
                  //                               ),
                  //                           // overflow: TextOverflow.ellipsis,
                  //                           // softWrap: true,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.008,
                  //                     ),
                  //                     Container(
                  //                       child: Text(
                  //                         'System',
                  //                         style: Theme.of(context)
                  //                             .textTheme
                  //                             .bodyText1!
                  //                             .copyWith(
                  //                               fontSize: 14,
                  //                               color: Colors.grey,
                  //                             ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: InkWell(
                  //         onTap: () {
                  //           setState(() {
                  //             _selection = 5;
                  //           });
                  //         },
                  //         child: Container(
                  //           width: 130,
                  //           decoration: _selection == 5
                  //               ? BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.amber,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(8),
                  //                 )
                  //               : BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),
                  //           child: ContainerStyle(
                  //             height: SizeVariables.getHeight(context) * 0.22,
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Container(
                  //                       child: CircleAvatar(
                  //                         radius:
                  //                             SizeVariables.getWidth(context) *
                  //                                 0.09,
                  //                         backgroundColor: Colors.green,
                  //                         backgroundImage: const AssetImage(
                  //                             'assets/img/profilePic.jpg'),
                  //                         // child: const Icon(Icons.account_box, color: Colors.white),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.015,
                  //                     ),
                  //                     Container(
                  //                       // color: Colors.amber,
                  //                       width:
                  //                           SizeVariables.getWidth(context) * 0.3,
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.02,
                  //                       child: FittedBox(
                  //                         fit: BoxFit.contain,
                  //                         child: Text(
                  //                           'Joy Shil',
                  //                           style: Theme.of(context)
                  //                               .textTheme
                  //                               .bodyText1!
                  //                               .copyWith(
                  //                                 fontSize: 16,
                  //                               ),
                  //                           // overflow: TextOverflow.ellipsis,
                  //                           // softWrap: true,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.008,
                  //                     ),
                  //                     Container(
                  //                       child: Text(
                  //                         'System',
                  //                         style: Theme.of(context)
                  //                             .textTheme
                  //                             .bodyText1!
                  //                             .copyWith(
                  //                               fontSize: 14,
                  //                               color: Colors.grey,
                  //                             ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: InkWell(
                  //         onTap: () {
                  //           setState(() {
                  //             _selection = 6;
                  //           });
                  //         },
                  //         child: Container(
                  //           width: 130,
                  //           decoration: _selection == 6
                  //               ? BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.amber,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(8),
                  //                 )
                  //               : BoxDecoration(
                  //                   border: Border.all(
                  //                     color: Colors.black,
                  //                   ),
                  //                 ),
                  //           child: ContainerStyle(
                  //             height: SizeVariables.getHeight(context) * 0.22,
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     Container(
                  //                       child: CircleAvatar(
                  //                         radius:
                  //                             SizeVariables.getWidth(context) *
                  //                                 0.09,
                  //                         backgroundColor: Colors.green,
                  //                         backgroundImage: const AssetImage(
                  //                             'assets/img/profilePic.jpg'),
                  //                         // child: const Icon(Icons.account_box, color: Colors.white),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.015,
                  //                     ),
                  //                     Container(
                  //                       // color: Colors.amber,
                  //                       width:
                  //                           SizeVariables.getWidth(context) * 0.3,
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.02,
                  //                       child: FittedBox(
                  //                         fit: BoxFit.contain,
                  //                         child: Text(
                  //                           'Joy Shil',
                  //                           style: Theme.of(context)
                  //                               .textTheme
                  //                               .bodyText1!
                  //                               .copyWith(
                  //                                 fontSize: 16,
                  //                               ),
                  //                           // overflow: TextOverflow.ellipsis,
                  //                           // softWrap: true,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: SizeVariables.getHeight(context) *
                  //                           0.008,
                  //                     ),
                  //                     Container(
                  //                       child: Text(
                  //                         'System',
                  //                         style: Theme.of(context)
                  //                             .textTheme
                  //                             .bodyText1!
                  //                             .copyWith(
                  //                               fontSize: 14,
                  //                               color: Colors.grey,
                  //                             ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
