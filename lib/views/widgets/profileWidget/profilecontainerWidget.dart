import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:claimz/res/components/containerStyle.dart';
import 'package:claimz/views/config/mediaQuery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../data/response/status.dart';
import '../../../utils/cropUtil.dart';
import '../../../viewModel/profileViewModel.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/userViewModel.dart';
import '../../../res/appUrl.dart';

class ProfilecontainerWidget extends StatefulWidget {
  // const ProfilecontainerWidget({Key? key}) : super(key: key);
  final Map<String, dynamic> profile;

  ProfilecontainerWidget(this.profile);

  @override
  State<ProfilecontainerWidget> createState() => _ProfilecontainerWidgetState();
}

class _ProfilecontainerWidgetState extends State<ProfilecontainerWidget> {
  File? image;
  bool isLoading = true;
  bool? isGallery;

  Future takePhoto() async {
    // final imageTemporary;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      // imageTemporary = cropSquareImage(File(image.path));

      File? imageTemporary = File(image.path);

      imageTemporary = await cropImage(imageTemporary);

      setState(() {
        this.image = imageTemporary;
        isLoading = false;
        isGallery = false;
      });

      Provider.of<ProfileViewModel>(context, listen: false)
          .postImage(context, imageTemporary);
    } on PlatformException catch (e) {
      print('Failed To Pick Image: $e');
    }
  }

  Future chooseImage() async {
    // final imageTemporary;

    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // imageTemporary = cropSquareImage(File(image.path));

      File? imageTemporary = File(image.path);

      imageTemporary = await cropImage(imageTemporary);

      setState(() {
        this.image = imageTemporary;
        isLoading = false;
        isGallery = true;
      });

      Provider.of<ProfileViewModel>(context, listen: false)
          .postImage(context, imageTemporary);
    } on PlatformException catch (e) {
      print('Failed To Pick Image: $e');
    }
  }

  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        compressFormat: ImageCompressFormat.jpg);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileViewModel>(context).profileDetails;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ContainerStyle(
        height: height > 750
            ? 39.h
            : height < 650
                ? 50.h
                : 48.h,
        child: Container(
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    // color: Colors.amber,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            elevation: 10,
                            builder: (context) => Container(
                              height: SizeVariables.getHeight(context) * 0.1,
                              padding: EdgeInsets.only(
                                  left: SizeVariables.getWidth(context) * 0.02,
                                  top: SizeVariables.getHeight(context) * 0.01),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      takePhoto();
                                      Navigator.of(context).pop();
                                    },
                                    child: SizedBox(
                                      child: Row(
                                        children: [
                                          const Icon(Icons.camera,
                                              color: Colors.white),
                                          SizedBox(
                                              width: SizeVariables.getWidth(
                                                      context) *
                                                  0.05),
                                          const Text('Take A Photo',
                                              style: TextStyle(fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height: SizeVariables.getHeight(context) *
                                          0.02),
                                  InkWell(
                                    onTap: () {
                                      chooseImage();
                                      Navigator.of(context).pop();
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.image,
                                            color: Colors.white),
                                        SizedBox(
                                            width: SizeVariables.getWidth(
                                                    context) *
                                                0.05),
                                        const Text('Choose From Gallery',
                                            style: TextStyle(fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 72, 71, 71),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10),
                              ),
                            ),
                          ),
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: 20, top: 15),
                              child: widget.profile['photo'] == '' &&
                                      image == null
                                  ? const CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/img/profilePic.jpg'),
                                      // backgroundImage: NetworkImage(
                                      //     '${AppUrl.profileDetails}${value.profileDetails.data!.data!.userdata!.profilePhoto}'),
                                      radius: 45,
                                    )
                                  : image != null
                                      ? CircleAvatar(
                                          backgroundImage: FileImage(image!),
                                          // backgroundImage: NetworkImage(
                                          //     '${AppUrl.profileDetails}${value.profileDetails.data!.data!.userdata!.profilePhoto}'),
                                          radius: 45,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: widget.profile['photo'],
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  CircleAvatar(
                                            backgroundImage: imageProvider,

                                            // backgroundImage: NetworkImage(
                                            //     '${AppUrl.profileDetails}${value.profileDetails.data!.data!.userdata!.profilePhoto}'),
                                            radius: 45,
                                          ),
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: Colors.grey[400]!,
                                            highlightColor:
                                                const Color.fromARGB(
                                                    255, 120, 120, 120),
                                            child: const CircleAvatar(
                                              radius: 45,
                                            ),
                                          ),
                                        ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeVariables.getWidth(context) * 0.06),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  widget.profile['userdata']['emp_name'],
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                              SizedBox(
                                height: SizeVariables.getHeight(context) * 0.01,
                              ),
                              FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  widget.profile['userdata']['department_name'],
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Positioned(
                  //   // right: SizeVariables.getWidth(context) * 0.022,
                  //   left: SizeVariables.getWidth(context) * 0.2,
                  //   top: SizeVariables.getHeight(context) * 0.095,
                  //   child: InkWell(
                  //     onTap: () => showModalBottomSheet(
                  //       context: context,
                  //       elevation: 10,
                  //       builder: (context) => Container(
                  //         height: SizeVariables.getHeight(context) * 0.1,
                  //         padding: EdgeInsets.only(
                  //             left: SizeVariables.getWidth(context) * 0.02,
                  //             top: SizeVariables.getHeight(context) * 0.01),
                  //         child: Column(
                  //           children: [
                  //             InkWell(
                  //               onTap: () {
                  //                 takePhoto();
                  //                 Navigator.of(context).pop();
                  //               },
                  //               child: SizedBox(
                  //                 child: Row(
                  //                   children: [
                  //                     const Icon(Icons.camera,
                  //                         color: Colors.white),
                  //                     SizedBox(
                  //                         width:
                  //                             SizeVariables.getWidth(context) *
                  //                                 0.05),
                  //                     const Text('Take A Photo',
                  //                         style: TextStyle(fontSize: 18)),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //             SizedBox(
                  //                 height:
                  //                     SizeVariables.getHeight(context) * 0.02),
                  //             InkWell(
                  //               onTap: () {
                  //                 chooseImage();
                  //                 Navigator.of(context).pop();
                  //               },
                  //               child: Row(
                  //                 children: [
                  //                   const Icon(Icons.image,
                  //                       color: Colors.white),
                  //                   SizedBox(
                  //                       width: SizeVariables.getWidth(context) *
                  //                           0.05),
                  //                   const Text('Choose From Gallery',
                  //                       style: TextStyle(fontSize: 18)),
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       backgroundColor: const Color.fromARGB(255, 72, 71, 71),
                  //       shape: const RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.vertical(
                  //           top: Radius.circular(10),
                  //         ),
                  //       ),
                  //     ),
                  //     child: const Icon(Icons.camera_alt_outlined,
                  //         color: Colors.amber, size: 30),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Emp Code: ${widget.profile['userdata']['emp_code']}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Email: ${widget.profile['userdata']['email']}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Reporting Manager: ${widget.profile['primary']['emp_name']}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'Secondary Reporting: ${widget.profile['secondary']['emp_name']}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                      widget.profile['userdata']['blood_group'] == null
                          ? 'Blood Group: '
                          : 'Blood Group: ${widget.profile['userdata']['blood_group']}',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                      'Pan Card: ${widget.profile['userdata']['pan_no']}',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                      'Aadhar No: ${widget.profile['userdata']['aadhar_no']}',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              SizedBox(
                height: SizeVariables.getHeight(context) * 0.01,
              ),
            ],
          ),
        ));
  }
}
