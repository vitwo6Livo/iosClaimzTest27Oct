import 'package:shared_preferences/shared_preferences.dart';

class SalesOrderToken {
  String? salesToken;

  SalesOrderToken() {
    _initializeSalesToken();
  }

  Future<void> _initializeSalesToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    salesToken = 'Bearer ${localStorage.getString('kamToken')}';

    print('SAlesssssssssss Tokennnnnnnnnnnn: $salesToken');
  }

  // SharedPreferences localStorage = await SharedPreferences.getInstance();

  // String salesToken =
  //   // 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ2aXR3by5haSIsImF1ZCI6InZpdHdvLmFpIiwiaWF0IjoxNjkxMTQxNDMwLCJuYmYiOjE2OTExNDE0MzAsImV4cCI6MTY5MzczMzQzMCwiY3VzdG9tZXJfaWQiOiI2IiwiY3VzdG9tZXJfY29kZSI6IjUyMzAwMDA2In0.mo28KjompK3tpWzBLBSsIO4YqLklRLlgDtNt8qi8xr4';
  //   'Bearer ${localStorage.getString('kamToken')}';
}

// String salesToken =
//     'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJ2aXR3by5haSIsImF1ZCI6InZpdHdvLmFpIiwiaWF0IjoxNjkxMTQxNDMwLCJuYmYiOjE2OTExNDE0MzAsImV4cCI6MTY5MzczMzQzMCwiY3VzdG9tZXJfaWQiOiI2IiwiY3VzdG9tZXJfY29kZSI6IjUyMzAwMDA2In0.mo28KjompK3tpWzBLBSsIO4YqLklRLlgDtNt8qi8xr4';
