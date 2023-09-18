import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../viewModel/logIn&signUpViewModel.dart';
import '../../../config/mediaQuery.dart';
import '../widget/containerDesign.dart';

class LastCompany extends StatefulWidget {
  final int selection;

  LastCompany(this.selection);

  @override
  State<LastCompany> createState() => _LastCompanyState();
}

class _LastCompanyState extends State<LastCompany> {
  File? offerLetter;
  File? resignationLetter;

  File? apointmentLetter;

  File? releaseLetter;

  File? payslip;

  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        compressFormat: ImageCompressFormat.jpg);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  pickImage(ImageSource imageType, String type) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      File? tempimage = File(photo.path);
      tempimage = await cropImage(tempimage);

      setState(() {
        if (type == 'offerLetter') {
          offerLetter = tempimage;
        } else if (type == 'resignationLetter') {
          resignationLetter = tempimage;
        } else if (type == 'appointmentLetter') {
          apointmentLetter = tempimage;
        } else if (type == 'releaseLetter') {
          releaseLetter = tempimage;
        } else {
          payslip = tempimage;
        }
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        Container(
          height: SizeVariables.getHeight(context) * 0.65,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (1 / 1.5),
              crossAxisCount: 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
            ),
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      pickImage(ImageSource.camera, 'offerLetter');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: offerLetter != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                            File(offerLetter!.path)))),
                                // color: Colors.red,
                                // child: Image.file(
                                //     _ie_file.toString()
                                //         as File,
                                //     fit: BoxFit
                                //         .cover),
                              )
                            : Container(
                                padding: EdgeInsets.only(
                                  top: SizeVariables.getHeight(context) * 0.04,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: Color.fromARGB(
                                                    255, 155, 26, 17),
                                                fontSize: 22,
                                              ),
                                        ),
                                        Container(
                                          // color: Colors.amber,
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.29,
                                          child: Text(
                                            'Maximum Upload file',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'size 940KB',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.005,
                  ),
                  Text(
                    'Offer Letter',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.003,
                  ),
                  Text(
                    '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      pickImage(ImageSource.camera, 'resignationLetter');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: resignationLetter != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                            File(resignationLetter!.path)))),
                                // color: Colors.red,
                                // child: Image.file(
                                //     _ie_file.toString()
                                //         as File,
                                //     fit: BoxFit
                                //         .cover),
                              )
                            : Container(
                                padding: EdgeInsets.only(
                                  top: SizeVariables.getHeight(context) * 0.04,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: Color.fromARGB(
                                                    255, 155, 26, 17),
                                                fontSize: 22,
                                              ),
                                        ),
                                        Container(
                                          // color: Colors.amber,
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.29,
                                          child: Text(
                                            'Maximum Upload file',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'size 940KB',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.005,
                  ),
                  Text(
                    'Resignation Letter',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.003,
                  ),
                  Text(
                    '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      pickImage(ImageSource.camera, 'appointmentLetter');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: apointmentLetter != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                            File(apointmentLetter!.path)))),
                                // color: Colors.red,
                                // child: Image.file(
                                //     _ie_file.toString()
                                //         as File,
                                //     fit: BoxFit
                                //         .cover),
                              )
                            : Container(
                                padding: EdgeInsets.only(
                                  top: SizeVariables.getHeight(context) * 0.04,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: Color.fromARGB(
                                                    255, 155, 26, 17),
                                                fontSize: 22,
                                              ),
                                        ),
                                        Container(
                                          // color: Colors.amber,
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.29,
                                          child: Text(
                                            'Maximum Upload file',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'size 940KB',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.005,
                  ),
                  Text(
                    'Appointment Letter',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.003,
                  ),
                  Text(
                    '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      pickImage(ImageSource.camera, 'releaseLetter');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: releaseLetter != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                            File(releaseLetter!.path)))),
                                // color: Colors.red,
                                // child: Image.file(
                                //     _ie_file.toString()
                                //         as File,
                                //     fit: BoxFit
                                //         .cover),
                              )
                            : Container(
                                padding: EdgeInsets.only(
                                  top: SizeVariables.getHeight(context) * 0.04,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: Color.fromARGB(
                                                    255, 155, 26, 17),
                                                fontSize: 22,
                                              ),
                                        ),
                                        Container(
                                          // color: Colors.amber,
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.29,
                                          child: Text(
                                            'Maximum Upload file',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'size 940KB',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.005,
                  ),
                  Text(
                    'Release Letter',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.003,
                  ),
                  Text(
                    '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      pickImage(ImageSource.camera, 'payslip');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: payslip != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(File(payslip!.path)))),
                                // color: Colors.red,
                                // child: Image.file(
                                //     _ie_file.toString()
                                //         as File,
                                //     fit: BoxFit
                                //         .cover),
                              )
                            : Container(
                                padding: EdgeInsets.only(
                                  top: SizeVariables.getHeight(context) * 0.04,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '*',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                color: Color.fromARGB(
                                                    255, 155, 26, 17),
                                                fontSize: 22,
                                              ),
                                        ),
                                        Container(
                                          // color: Colors.amber,
                                          width:
                                              SizeVariables.getWidth(context) *
                                                  0.29,
                                          child: Text(
                                            'Maximum Upload file',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'size 940KB',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            fontSize: 12,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.005,
                  ),
                  Text(
                    'Payslip',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.003,
                  ),
                  Text(
                    '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 25,
              ),
              child: Container(
                child: AnimatedButton(
                  height: 55,
                  width: SizeVariables.getWidth(context) * 0.83,
                  text: 'Save',
                  isReverse: true,
                  selectedTextColor: Colors.black,
                  transitionType: TransitionType.LEFT_TO_RIGHT,
                  textStyle: TextStyle(
                      fontSize: 18,
                      color: (themeProvider.darkTheme)
                          ? Colors.white
                          : Colors.black),
                  backgroundColor: (themeProvider.darkTheme)
                      ? Colors.black
                      : Colors.amberAccent,
                  borderColor: (themeProvider.darkTheme)
                      ? Colors.white
                      : Colors.amberAccent,
                  borderRadius: 8,
                  borderWidth: 2,
                  onPress: () async {
                    SharedPreferences localStorage =
                        await SharedPreferences.getInstance();

                    Provider.of<LoginSignUpViewModel>(context, listen: false)
                        .previousCompanyDetail(
                            context,
                            offerLetter!,
                            resignationLetter!,
                            apointmentLetter!,
                            releaseLetter!,
                            payslip!,
                            localStorage.getInt('userId')!);
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
