import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseApiService {
  Future<dynamic> getApiResponse(String url);

  Future<dynamic> postApiResponse(String url, dynamic data);

  Future<dynamic> getAuthRequests(String url, String token);

  Future<dynamic> postAuthRequests(String url, dynamic data, String token);

  Future<dynamic> postAuthImageRequests(String url, dynamic data, String token);

  Future<dynamic> postAuth_uploadImage(Map<String, String> field_data,
      dynamic file, dynamic file_data, String url, String token);

  Future<dynamic> postAuth_uploadImage_two_files(Map<String, String> field_data,
      dynamic file, dynamic file2, dynamic file_data, String url, String token);
}
