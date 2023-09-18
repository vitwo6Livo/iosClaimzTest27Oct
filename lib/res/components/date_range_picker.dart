import 'package:claimz/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateRangePicker extends StatelessWidget {
  final VoidCallback onPressed;
  final DateTime start;
  final DateTime end;
  // final double width;

  DateRangePicker({
    required this.onPressed,
    required this.end,
    required this.start,
    // required this.width
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      // width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          primary:
              (themeProvider.darkTheme) ? Colors.white : Colors.amberAccent,
          elevation: 0,
          onPrimary: Colors.black,
          // textStyle: TextStyle(color: Colors.black)
        ),
        child: Text(
            '${start.day}/${start.month}/${start.year} - ${end.day}/${end.month}/${end.year}'),
        onPressed: onPressed,
      ),
    );
  }
}
