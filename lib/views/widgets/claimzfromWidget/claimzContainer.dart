import 'package:claimz/utils/routes/routeNames.dart';
import 'package:claimz/viewModel/claimFormViewModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import '../../../res/components/buttonStyle.dart';
import '../../../res/components/containerStyle.dart';
import '../../config/mediaQuery.dart';

class ClaimzContainer extends StatefulWidget {
  List<Map<String, dynamic>> imagesFrom = [
    {
      "image": "assets/clamizFrom/domestic flight.svg",
      "name": "Domestic",
      "routes": RouteNames.travelClaimsList,
    },
    {
      "image": "assets/clamizFrom/international flight.svg",
      "name": "International",
      "routes": RouteNames.travelClaimsList,
    },
    // {
    //   "image": "assets/clamizFrom/flight.svg",
    //   "name": "Flight",
    //   "routes": RouteNames.flightscreen,
    // },
    // {
    //   "image": "assets/clamizFrom/train.svg",
    //   "name": "Train",
    //   "routes": RouteNames.trainscreen,
    // },
    // {
    //   "image": "assets/clamizFrom/bus.svg",
    //   "name": "Bus",
    //   "routes": RouteNames.busscreen,
    // },
    // {
    //   "image": "assets/clamizFrom/cab.svg",
    //   "name": "Cab",
    //   "routes": RouteNames.cabscreen,
    // },
    // {
    //   "image": "assets/clamizFrom/accomodation.svg",
    //   "name": "accommodation",
    //   "routes": RouteNames.accommodationscreen,
    // },
    // {
    //   "image": "assets/clamizFrom/food.svg",
    //   "name": "Food",
    //   "routes": RouteNames.foodscreen,
    // },
    // {
    //   "image": "assets/clamizFrom/incidental expense.svg",
    //   "name": "Incidental Expense",
    //   "routes": RouteNames.incidentalscreen,
    // },
  ];

  List<String> nameFrom = [
    "Domestic",
    "International",
    // "Flight",
    // "Train",
    // "Bus",
    // "Cab",
    // "Accommodation",
    // "Food",
    // "Incidental Expense"
  ];

  // File? image;
  bool isLoading = true;

  @override
  State<ClaimzContainer> createState() => _ClaimzContainerState();
}

class _ClaimzContainerState extends State<ClaimzContainer> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Color.fromARGB(94, 129, 128, 128),
    //   appBar: AppBar(
    //     elevation: 12,
    //     backgroundColor: Colors.black,
    //     shadowColor: Colors.grey,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.only(
    //             bottomLeft: Radius.circular(600),
    //             bottomRight: Radius.circular(50))),
    //     bottom: PreferredSize(
    //         child: SizedBox(), preferredSize: Size.fromHeight(150)),
    //   ),

    //   // body: ListView(
    //   //   children: [
    //   //     ClipPath(
    //   //       clipper: CurvedAppBar(),
    //   //       child: Container(
    //   //         // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    //   //         height: SizeVariables.getHeight(context)*0.25,
    //   //         decoration: BoxDecoration(
    //   //         color: Colors.amber,
    //   //         ),
    //   //       ),
    //   //     ),
    //   //   ],
    //   // ),
    // );

    return Container(
      height: SizeVariables.getHeight(context) * 0.9,
      // color: Colors.amber,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.imagesFrom.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 40,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () =>
                // Navigator.pushNamed(context, widget.imagesFrom[index]["routes"],arguments:widget.imagesFrom[index]["name"] ),

                Navigator.pushNamed(context, RouteNames.travelClaimsList,
                    arguments: {"type": widget.imagesFrom[index]["name"]}),
            child: ContainerStyle(
              height: SizeVariables.getHeight(context) * 0.5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      widget.imagesFrom[index]["image"],
                      color: Color(0xffF59F23),
                    ),
                    SizedBox(height: SizeVariables.getHeight(context) * 0.02),
                    Text(
                      widget.nameFrom[index],
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Future<dynamic> openDialog(int index) => showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         backgroundColor: Color.fromARGB(255, 87, 83, 83),
  //         title: Center(
  //           child: Text(
  //             'Upload Your File:',
  //             style: Theme.of(context).textTheme.bodyText2,
  //           ),
  //         ),

  //         content: Padding(
  //           padding:
  //               EdgeInsets.only(top: SizeVariables.getHeight(context) * 0.02),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             children: [
  //               InkWell(
  //                 onTap: () => pickImage(),
  //                 child: FittedBox(
  //                   fit: BoxFit.contain,
  //                   child: Icon(
  //                     Icons.camera_alt_outlined,
  //                     color: const Color(0xffF59F23),
  //                     size: 40,
  //                   ),
  //                 ),
  //               ),
  //               InkWell(
  //                 onTap: () async {
  //                   final result = await FilePicker.platform.pickFiles();
  //                   if (result == null) return;
  //                   final file = result.files.first;
  //                   OpenFile(
  //                       file, widget.imagesFrom[index]["routes"].toString());
  //                 },
  //                 child: FittedBox(
  //                   fit: BoxFit.contain,
  //                   child: Icon(
  //                     Icons.file_upload_outlined,
  //                     color: const Color(0xffF59F23),
  //                     size: 40,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),

  //         // title: Text("data"),
  //         // content: TextField(
  //         //   maxLines: 5,
  //         //   style: Theme.of(context).textTheme.bodyText1,
  //         //   decoration: InputDecoration(
  //         //     border: InputBorder.none,
  //         //   ),
  //         // ),
  //         actions: [
  //           // Padding(
  //           //   padding:
  //           //       EdgeInsets.only(right: SizeVariables.getWidth(context) * 0.2),
  //           //   child: TextButton(
  //           //     child: Text(
  //           //       "Cancel",
  //           //       style: Theme.of(context).textTheme.bodyText1,
  //           //     ),
  //           //     onPressed: cancel,
  //           //   ),
  //           // ),
  //           // TextButton(
  //           //   child: Text(
  //           //     "Add",
  //           //     style: Theme.of(context).textTheme.bodyText1,
  //           //   ),
  //           //   onPressed: () => Navigator.pushNamed(
  //           //       context, widget.imagesFrom[index]['routes']),
  //           // ),
  //         ],
  //       ),
  //     );
  // // void add () {
  // //   Navigator.pushNamed(context, RouteNames.flightscreen);
  // // }
  // // void cancel() {
  // //   Navigator.of(context).pop();
  // // }

  // void OpenFile(PlatformFile file, String routename) {
  //   Map data = {'file': 'hi'};
  //   Navigator.of(context).pushNamed(routename, arguments: data);
  // }

  // pickImage() async {
  //   final image = await ImagePicker().pickImage(source: ImageSource.camera);
  // }
}

class CurvedAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    print('Heighhhht $size');
    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.height / 2, 0, size.height / 2 + 20, size.width / 5);
    // path.quadraticBezierTo(x, y);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 20);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}
