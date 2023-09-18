import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../config/mediaQuery.dart';

class PersonalForm extends StatefulWidget {
  @override
  State<PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  TextEditingController name = new TextEditingController();
  TextEditingController f_name = new TextEditingController();
  TextEditingController e_mail = new TextEditingController();
  TextEditingController sex = new TextEditingController();
  TextEditingController blood = new TextEditingController();
  TextEditingController birthday = new TextEditingController();
  TextEditingController parmanentLocation = new TextEditingController();
  TextEditingController presentLocation = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    name.text = 'Anisha Pal';
    f_name.text = 'Rintu Pal';
    sex.text = 'Female';
    birthday.text = '13-Jan-1999';
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: TextFormField(
              controller: name,
              cursorColor: Colors.white,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                // hintText: 'Full name',
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Color(0xfff7B7B7B),
                    ),
                prefixIcon: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 188, 188, 188),
                ),
                suffixIcon: const Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.01,
          ),
          Container(
            child: TextFormField(
              controller: f_name,
              cursorColor: Colors.white,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                // hintText: 'Full name',
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Color(0xfff7B7B7B),
                    ),
                prefixIcon: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 188, 188, 188),
                ),
                suffixIcon: const Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.01,
          ),
          Container(
            child: TextFormField(
              controller: e_mail,
              cursorColor: Colors.white,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                hintText: 'ex@gmail.com',
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Color(0xfff7B7B7B),
                    ),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Color.fromARGB(255, 188, 188, 188),
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.01,
          ),
          Container(
            child: TextFormField(
              controller: sex,
              showCursor: false,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                // hintText: 'Full name',
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Color(0xfff7B7B7B),
                    ),
                prefixIcon: const Icon(
                  Icons.person,
                  color: Color.fromARGB(255, 188, 188, 188),
                ),
                suffixIcon: const Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.01,
          ),
          Container(
            child: TextFormField(
              controller: blood,
              cursorColor: Colors.white,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                hintText: 'Blood group',
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Color(0xfff7B7B7B),
                    ),
                prefixIcon: const Icon(
                  Icons.bloodtype,
                  color: Color.fromARGB(255, 188, 188, 188),
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.01,
          ),
          Container(
            child: TextFormField(
              onTap: () {},
              controller: birthday,
              readOnly: true,
              showCursor: false,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                // hintText: 'Full name',
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Color(0xfff7B7B7B),
                    ),
                prefixIcon: const Icon(
                  Icons.calendar_month,
                  color: Color.fromARGB(255, 188, 188, 188),
                ),
                suffixIcon: const Icon(
                  Icons.done,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.01,
          ),
          Container(
            child: TextFormField(
              controller: presentLocation,
              cursorColor: Colors.white,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                hintText: 'Present address',
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Color(0xfff7B7B7B),
                    ),
                prefixIcon: const Icon(
                  Icons.location_city,
                  color: Color.fromARGB(255, 188, 188, 188),
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.01,
          ),
          Container(
            child: TextFormField(
              cursorColor: Colors.white,
              controller: parmanentLocation,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xfffD9D9D9),
                  ),
                ),
                hintText: 'Parameter address',
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Color(0xfff7B7B7B),
                    ),
                prefixIcon: const Icon(
                  Icons.location_city,
                  color: Color.fromARGB(255, 188, 188, 188),
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeVariables.getHeight(context) * 0.03,
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
                    onPress: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
