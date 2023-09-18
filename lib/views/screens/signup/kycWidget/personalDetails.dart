import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/mediaQuery.dart';
import 'personalForm.dart';

class PersonalDetails extends StatefulWidget {
  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  int _selection = 12;
  File? pickedImage;
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempimage = File(photo.path);
      setState(() {
        pickedImage = tempimage;
        _selection = 1;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _selection == 12
          ? Container(
              padding: EdgeInsets.only(
                top: SizeVariables.getHeight(context) * 0.2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.upload,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                  Text(
                    'Upload your Aadhar',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                  SizedBox(
                    height: SizeVariables.getHeight(context) * 0.02,
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          primary: Color(0xfffFEC107),
                        ),
                        child: Container(
                          width: SizeVariables.getWidth(context) * 0.23,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'Choose File',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          pickImage(ImageSource.camera);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : PersonalForm(),
    );
  }
}
