import 'dart:io';
import 'package:claimz/viewModel/logIn&signUpViewModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../provider/theme_provider.dart';
import '../../../config/mediaQuery.dart';
import '../widget/containerDesign.dart';

class DocumentsWidget extends StatefulWidget {
  @override
  State<DocumentsWidget> createState() => _DocumentsWidgetState();
}

class _DocumentsWidgetState extends State<DocumentsWidget> {
  File? aadharFront;
  File? aadharBack;
  File? voterFront;
  File? voterBack;
  File? panFront;
  File? panBack;
  File? passportFront;
  File? passportBack;
  File? ten;
  File? twelve;
  File? graduation;
  File? postGraduation;
  File? passbook;

  Future<File?> cropImage(File imageFile) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        compressFormat: ImageCompressFormat.jpg);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  chooseFile() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png']);
    if (result == null) return;

    final file = result.files.first;

    print('Path Of File: ${file.path}');
  }

  pickImage(ImageSource imageType, String type) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      File? tempimage = File(photo.path);

      print('PICK IMAGE PATH: $tempimage');

      tempimage = await cropImage(tempimage);
      setState(() {
        if (type == 'aadharFront') {
          aadharFront = tempimage;
        } else if (type == 'aadharBack') {
          aadharBack = tempimage;
        } else if (type == 'voterFront') {
          voterFront = tempimage;
        } else if (type == 'voterBack') {
          voterBack = tempimage;
        } else if (type == 'panFront') {
          panFront = tempimage;
        } else if (type == 'panBack') {
          panBack = tempimage;
        } else if (type == 'passportFront') {
          passportFront = tempimage;
        } else if (type == 'passportBack') {
          passportBack = tempimage;
        } else if (type == 'ten') {
          ten = tempimage;
        } else if (type == 'twelve') {
          twelve = tempimage;
        } else if (type == 'grad') {
          graduation = tempimage;
        } else if (type == 'postGrad') {
          postGraduation = tempimage;
        } else {
          passbook = tempimage;
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
          // color: Colors.red,
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
                      // pickImage(ImageSource.camera, 'aadharFront');
                      chooseFile();
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: aadharFront != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                            File(aadharFront!.path)))),
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
                    'Aadhar Card Front',
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
                      pickImage(ImageSource.camera, 'aadharBack');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: aadharBack != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            FileImage(File(aadharBack!.path)))),
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
                    'Aadhar Card Back',
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
                      pickImage(ImageSource.camera, 'voterFront');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: voterFront != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            FileImage(File(voterFront!.path)))),
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
                    'Voter ID Card Front',
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
                      pickImage(ImageSource.camera, 'voterBack');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: voterBack != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            FileImage(File(voterBack!.path)))),
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
                    'Voter ID Card Back',
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
                      pickImage(ImageSource.camera, 'panFront');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: panFront != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            FileImage(File(panFront!.path)))),
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
                    'Pan Card Front',
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
                      pickImage(ImageSource.camera, 'panBack');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: panBack != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(File(panBack!.path)))),
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
                    'Pan Card Back',
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
                      pickImage(ImageSource.camera, 'passportFront');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: passportFront != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                            File(passportFront!.path)))),
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
                                          ' ',
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
                    'Passport Front',
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
                      pickImage(ImageSource.camera, 'passportBack');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: passportBack != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                            File(passportBack!.path)))),
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
                                          ' ',
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
                    'Passport Back',
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
                      pickImage(ImageSource.camera, 'ten');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: ten != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(File(ten!.path)))),
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
                    'Class X Marksheet',
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
                      pickImage(ImageSource.camera, 'twelve');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: twelve != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(File(twelve!.path)))),
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
                    'Class XII Marksheet',
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
                      pickImage(ImageSource.camera, 'grad');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: graduation != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            FileImage(File(graduation!.path)))),
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
                    'Graduation (Last Semester Marksheet)',
                    textAlign: TextAlign.center,
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
                      pickImage(ImageSource.camera, 'postGrad');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: postGraduation != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                            File(postGraduation!.path)))),
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
                    'Post Graduation (if any)',
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
                      pickImage(ImageSource.camera, 'passbookFront');
                    },
                    child: ContainerDesign(
                      height: double.infinity,
                      child: Container(
                        height: SizeVariables.getHeight(context) * 0.15,
                        child: passbook != null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            FileImage(File(passbook!.path)))),
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
                    'Passbook Front Page',
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
                        .documentUpload(
                            context,
                            aadharBack!,
                            aadharFront!,
                            voterFront!,
                            voterBack!,
                            panFront!,
                            panBack!,
                            passportFront!,
                            passportBack!,
                            ten!,
                            twelve!,
                            graduation!,
                            postGraduation!,
                            passbook!,
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
