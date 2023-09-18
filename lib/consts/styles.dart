import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../views/config/appColors.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      unselectedWidgetColor: Colors.white,
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
      primaryColor: isDarkTheme ? Colors.black : Colors.grey.shade300,
      canvasColor: isDarkTheme ? Colors.white : Colors.black,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: isDarkTheme ? Colors.black : Colors.amberAccent[100],
        onPrimary: Colors.amberAccent,
        onSecondary: isDarkTheme ? Colors.black : Color(0xfffffefc),
        tertiary: isDarkTheme
            ? const Color.fromARGB(255, 65, 65, 65)
            : Color(0xfffffefc),
        tertiaryContainer:
            isDarkTheme ? AppColors.gradientStartColor : Colors.grey,
        secondaryContainer:
            isDarkTheme ? AppColors.gradientEndColor : Colors.grey,
        background: isDarkTheme
            ? const Color.fromARGB(255, 181, 179, 179).withOpacity(0.1)
            : Color(0xfffffefc),
        outline: isDarkTheme
            ? Color.fromARGB(255, 123, 125, 125)
            : Color(0xfffffefc),
        onSurfaceVariant: isDarkTheme ? Colors.grey[800] : Color(0xfffffefc),
      ),

      appBarTheme: AppBarTheme(
          backgroundColor: isDarkTheme ? Colors.black : Color(0xfffffefc),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: isDarkTheme ? Colors.black : Colors.grey,
          )),

      //primarySwatch: Colors.purple,
      //primaryColor: isDarkTheme ? Colors.black : Color(0xffF59F23),
      textTheme: ThemeData.light().textTheme.copyWith(
            caption: TextStyle(
              fontFamily: 'SourceSansPro',
              fontSize: 25.sp,
              color: isDarkTheme ? Colors.white : Colors.black,
              // fontWeight: FontWeight.bold,
            ),
            bodyText1: TextStyle(
                fontFamily: 'SourceSansPro',
                color: isDarkTheme ? Colors.white : Colors.black,
                fontSize: 10.sp),
            bodyText2: TextStyle(
                fontFamily: 'SourceSansPro',
                color: isDarkTheme ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
    );
  }
}
