import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import '../appException.dart';
import './baseApiService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';

import 'package:provider/provider.dart';
import '../../viewModel/userViewModel.dart';

class NetworkServiceApi extends BaseApiService {
  @override
  Future getApiResponse(String url) async {
    // TODO: implement getApiResponse
    var jsonResponse;

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json'
      }).timeout(const Duration(seconds: 20));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return jsonResponse;
  }

  @override
  Future postApiResponse(String url, dynamic data) async {
    // TODO: implement postApiResponse
    var jsonResponse;

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(data),
          headers: {
            'Content-Type': 'application/json'
          }).timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);
    }
    // on SocketException {
    //   throw FetchDataException(jsonResponse);
    // }
    catch (e) {
      FetchDataException('ERROR: ${e.toString()}');
    }
    return jsonResponse;
  }

  @override
  Future getAuthRequests(String url, String authToken) async {
    // TODO: implement getAuthRequests
    var jsonResponse;

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken'
      }).timeout(const Duration(seconds: 20));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return jsonResponse;
  }

  @override
  Future postAuthRequests(String url, dynamic data, String authToken) async {
    // TODO: implement postAuthRequests
    var jsonResponse;

    // EasyLoading.show(status: "loading.....");
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode(data),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          }).timeout(const Duration(seconds: 20));
      jsonResponse = returnResponse(response);
      print('JSON RESPONSE::::::: $jsonResponse');
    } on SocketException {
      EasyLoading.showError('No Internet Connection');
      EasyLoading.dismiss();
      throw FetchDataException('No Internet Connection');
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = json.decode(response.body);
        // EasyLoading.showSuccess('successful!');
        EasyLoading.dismiss();
        return jsonResponse;

      case 300:
        dynamic jsonResponse = json.decode(response.body);
        // EasyLoading.showSuccess('successful!');
        EasyLoading.dismiss();
        return jsonResponse;

      case 400:
        EasyLoading.showError('Error!');
        EasyLoading.dismiss();
        throw BadRequestException(response.body.toString());

      case 404:
        EasyLoading.showError('Error!');
        EasyLoading.dismiss();
        throw UnauthorizedException(response.body.toString());

      default:
        throw FetchDataException(
            'Error Occured While Communication with Server. Status Code ${response.statusCode}');
    }
  }

  @override
  Future postAuthImageRequests(String url, images, String token) async {
    var uri = Uri.parse(url);
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);
    request.headers['Content-Type'] = 'application/json';
    request.headers['Authorization'] = 'Bearer $token';
    // request.fields['user_id'] = 'token';
    List<MultipartFile> newList = <MultipartFile>[];
    for (int i = 0; i < images.length; i++) {
      File imageFile = File(images[i].toString());
      var stream =
          new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();
      var multipartFile = new http.MultipartFile("imagefile", stream, length,
          filename: basename(imageFile.path));
      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  Future<dynamic> postAuth_uploadImage(
      field_data, file, file_data, url, token) async {
    // Map<String, String> headers = {'Content-Type': 'application/json'};
    // headers.addAll({'Authorization': 'Bearer $token'});
    var jsonResponse;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': 'Bearer $token'});
    // for (int i = 0; i < file_data.length; i++) {
    //   request.files.add(await http.MultipartFile.fromPath( file_data[i]['file_name'], new File(file_data[i]['file']).path));
    // }
    request.fields.addAll(field_data);
    request.files.add(await http.MultipartFile.fromPath(
        file_data['file_name'], new File(file.path).path));
    // request.files.add(await http.MultipartFile.fromPath( file_data['file_name'], new File(file.path).path));
    http.Response response =
        await http.Response.fromStream(await request.send());
    jsonResponse = returnResponse(response);
    return jsonResponse;
  }

  @override
  Future<dynamic> postAuth_uploadImage_two_files(
      field_data, file, file2, file_data, url, token) async {
    // Map<String, String> headers = {'Content-Type': 'application/json'};
    // headers.addAll({'Authorization': 'Bearer $token'});
    var jsonResponse;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({'Authorization': 'Bearer $token'});
    // for (int i = 0; i < file_data.length; i++) {
    //   request.files.add(await http.MultipartFile.fromPath( file_data[i]['file_name'], new File(file_data[i]['file']).path));
    // }
    request.fields.addAll(field_data);
    request.files.add(
      await http.MultipartFile.fromPath(
          file_data['file_name'], new File(file.path).path),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
          file_data['original_file_name'], new File(file2.path).path),
    );
    // request.files.add(await http.MultipartFile.fromPath( file_data['file_name'], new File(file.path).path));
    http.Response response =
        await http.Response.fromStream(await request.send());
    jsonResponse = returnResponse(response);
    return jsonResponse;
  }
}
