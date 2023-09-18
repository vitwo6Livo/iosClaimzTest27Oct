// ignore_for_file: use_build_context_synchronously

import 'package:another_flushbar/flushbar.dart';
import 'package:claimz/utils/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../res/appUrl.dart';
import '../../views/screens/salesOrder/widget/salesToken.dart';
import '../profileViewModel.dart';

class SalesOrderApis with ChangeNotifier {
  Map<String, dynamic> _soList = {};

  SalesOrderToken salesToken = SalesOrderToken();

  List<Map<String, dynamic>> _openSoList = [];

  List<Map<String, dynamic>> _pendingSoList = [];

  List<Map<String, dynamic>> _exceptionalSoList = [];

  List<Map<String, dynamic>> _closedSoList = [];

  Map<String, dynamic> _customerDetails = {};
  Map<String, dynamic> _customers = {};

  Map<String, dynamic> _kamDetails = {};
  Map<String, dynamic> _salesOrder = {};
  Map<String, dynamic> _addCustomerAddress = {};
  Map<String, dynamic> _customerAddress = {};
  Map<String, dynamic> _customerAddressDetails = {};
  Map<String, dynamic> _itemDetails = {};
  Map<String, dynamic> _items = {};
  Map<String, dynamic> _funcationalArea = {};
  Map<String, dynamic> _invoiceType = {};
  String _inventoryItemId = '';
  String _lineNo = '';
  String _itemName = '';
  String _itemDesc = '';
  String _goodsType = '';
  String _hsnCode = '';
  String _itemTotalDiscount = '';
  String _totalTax = '';
  String _itemTotalTax1 = '';
  String _tolerance = '';
  String _itemCode = '';
  String _unitPrice = '';
  String _maxDiscount = '';
  String _tax = '';
  String _uom = '';
  double _totalPrice = 0.0;
  double _totalBasePrice = 0.0;
  double _totalItemDiscount = 0.0;
  double _igst = 0.0;
  String _billingAddress = '';
  String _shippingAddress = '';
  String _postingDate = '';
  String _postingTime = '';
  String _deliveryDate = '';
  String _customerOrderNumber = '';
  String _salesPersonId = '';
  String _creditPeriodDays = '';
  String _functionalArea = '';
  String _complianceInvoiceType = '';
  bool _isCustomerSelected = false;
  Map<String, dynamic> _kamResponse = {};
  Map<String, dynamic> _otpResponse = {};
  Map<String, dynamic> _location = {};
  int _customerId = 0;

  set customerId(int id) {
    _customerId = id;
    notifyListeners();
  }

  int get customerId {
    return _customerId;
  }

  Map<String, dynamic> get location {
    return {..._location};
  }

  Map<String, dynamic> get kamResponse {
    return {..._kamResponse};
  }

  Map<String, dynamic> get otpResponse {
    return {..._otpResponse};
  }

  set isCustomerSelected(bool value) {
    _isCustomerSelected = value;
    print('Is Customer Selected: $_isCustomerSelected');
    notifyListeners();
  }

  bool get isCustomerSelected {
    return _isCustomerSelected;
  }

  set postingDate(String value) {
    _postingDate = value;
    notifyListeners();
  }

  String get postingDate {
    return _postingDate;
  }

  set postingTime(String value) {
    _postingTime = value;
    notifyListeners();
  }

  String get postingTime {
    return _postingTime;
  }

  set deliveryDate(String value) {
    _deliveryDate = value;
    notifyListeners();
  }

  String get deliveryDate {
    return _deliveryDate;
  }

  set customerOrderNumber(String value) {
    _customerOrderNumber = value;
    notifyListeners();
  }

  String get customerOrderNumber {
    return _customerOrderNumber;
  }

  set salesPersonId(String value) {
    _salesPersonId = value;
    notifyListeners();
  }

  String get salesPersonId {
    return _salesPersonId;
  }

  set creditPeriodDays(String value) {
    _creditPeriodDays = value;
    notifyListeners();
  }

  String get creditPeriodDays {
    return _creditPeriodDays;
  }

  set functionalArea(String value) {
    _functionalArea = value;
    notifyListeners();
  }

  String get functionalArea {
    return _functionalArea;
  }

  set complianceInvoiceType(String value) {
    _complianceInvoiceType = value;
    notifyListeners();
  }

  String get complianceInvoiceType {
    return _complianceInvoiceType;
  }

  List<Map<String, dynamic>> _itemList = [];

  Map<String, dynamic> get soList {
    return {..._soList};
  }

  List<Map<String, dynamic>> get openSoList {
    return [..._openSoList];
  }

  List<Map<String, dynamic>> get pendingSoList {
    return [..._pendingSoList];
  }

  List<Map<String, dynamic>> get exceptionalSoList {
    return [..._exceptionalSoList];
  }

  List<Map<String, dynamic>> get closedSoList {
    return [..._closedSoList];
  }

  // Map<String, dynamic> _serviceItems = {};
  // Map<String, dynamic> _goodsItems = {};

  List<Map<String, dynamic>> get itemList {
    return [..._itemList];
  }

  Map<String, dynamic> get customerDetails {
    return {..._customerDetails};
  }

  Map<String, dynamic> get customers {
    return {..._customers};
  }

  Map<String, dynamic> get kamDetails {
    return {..._kamDetails};
  }

  Map<String, dynamic> get salesOrder {
    return {..._salesOrder};
  }

  Map<String, dynamic> get addCustomerAddress {
    return {..._addCustomerAddress};
  }

  Map<String, dynamic> get customerAddress {
    return {..._customerAddress};
  }

  Map<String, dynamic> get customerAddressDetails {
    return {..._customerAddressDetails};
  }

  Map<String, dynamic> get items {
    return {..._items};
  }

  Map<String, dynamic> get itemDetails {
    return {..._itemDetails};
  }

  String get itemName {
    return _itemName;
  }

  String get itemCode {
    return _itemCode;
  }

  String get unitPrice {
    return _unitPrice;
  }

  String get maxDiscount {
    return _maxDiscount;
  }

  String get tax {
    return _tax;
  }

  String get uom {
    return _uom;
  }

  String get inventoryItemId {
    return _inventoryItemId;
  }

  String get lineNo {
    return _lineNo;
  }

  String get itemDesc {
    return _itemDesc;
  }

  String get goodsType {
    return _goodsType;
  }

  String get hsnCode {
    return _hsnCode;
  }

  String get itemTotalDiscount {
    return _itemTotalDiscount;
  }

  String get totalTax {
    return _totalTax;
  }

  String get itemTotalTax1 {
    return _itemTotalTax1;
  }

  String get tolerance {
    return _tolerance;
  }

  double get totalPrice {
    return _totalPrice;
  }

  double get totalBasePrice {
    return _totalBasePrice;
  }

  double get igst {
    return _igst;
  }

  double get totalItemDiscount {
    return _totalItemDiscount;
  }

  Map<String, dynamic> get funcationalArea {
    return {..._funcationalArea};
  }

  Map<String, dynamic> get invoicetype {
    return {..._invoiceType};
  }

  String get billingAddress {
    return _billingAddress;
  }

  String get shippingAddress {
    return _shippingAddress;
  }

  Future<dynamic> validateKam(String id, BuildContext context) async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('Sent KAM ID: $id');

    var response = await http.post(Uri.parse(AppUrl.kamIdCheck),
        body: json.encode({'kamCode': id}),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      _kamResponse = json.decode(response.body);
      print('Kam Code Validation Response: $_kamResponse');
    } else {
      _kamResponse = json.decode(response.body);

      print('Kam Code Validation Response: $_kamResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }
    return response.statusCode;
  }

  Future<dynamic> validateOtp(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // localStorage.setInt('id', value['data']['id']);

    var response = await http
        .post(Uri.parse(AppUrl.otpValidate), body: json.encode(data), headers: {
      'Authorization': 'Bearer ${localStorage.getString('token')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      _otpResponse = json.decode(response.body);
      print('OTP Validation Response: $_otpResponse');

      localStorage.setString('kamToken', _otpResponse['token']);

      Navigator.of(context).pushNamed(RouteNames.salesorder);
    } else {
      _otpResponse = json.decode(response.body);

      print('OTP Validation Response: $_otpResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),

        message: 'An Error Occured',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();

    return _otpResponse;
  }

  Future<void> fetchSoList(BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    _soList = {};
    _openSoList = [];
    _pendingSoList = [];
    _exceptionalSoList = [];
    _closedSoList = [];

    var response = await http.post(Uri.parse(AppUrl.salesList),
        body: json.encode({
          "pageNo": "0",
          "limit": "10",
          'user_id': localStorage.getInt('id'),
          "formDate": "",
          "toDate": "",
          "keyword": "",
        }),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    print('New Salessss Token: ${localStorage.getString('kamToken')}');

    if (response.statusCode == 200) {
      _soList = json.decode(response.body);

      print('SoList: $_soList');

      for (int i = 0; i < _soList['data'].length; i++) {
        if (_soList['data'][i]['soStatus'] == 'open') {
          _openSoList.add(_soList['data'][i]);
        } else if (_soList['data'][i]['soStatus'] == 'pending') {
          _pendingSoList.add(_soList['data'][i]);
        } else if (_soList['data'][i]['soStatus'] == 'exceptional') {
          _exceptionalSoList.add(_soList['data'][i]);
        } else {
          _closedSoList.add(_soList['data'][i]);
        }
      }
    } else {
      _soList = {};
      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> fetchCustomers(String locationId) async {
    // var uri = Uri.parse(AppUrl.customerSales);

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.customerSales),
        body: json.encode({
          // "pageNo": "0",
          // "limit": "2",
          // "formDate": "2022-08-20",
          // "toDate": "2023-08-20",
          // "keyword": ""
          'location_id': locationId
        }),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _customers = json.decode(response.body);

      print('Customer Response: $customers');
    } else {
      print('Failed');
      _customers = json.decode(response.body);

      print('Failed Response: $customers');
    }
    // var request = http.MultipartRequest('POST', uri);
    // request.headers.addAll({
    //   'Authorization': salesToken,
    // });
    // var response = await request.send();

    // if (response.statusCode == 200) {
    //   var response2 = await http.Response.fromStream(response);
    //   final data = json.decode(response2.body);
    //   print('dataaaaaaaaaaaaa ${data}');
    //   setState(() {
    //     customers = data['data'];
    //   });
    // }
    notifyListeners();
  }

  Future<void> fetchLocation() async {
    // var uri = Uri.parse(AppUrl.customerSales);

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.companyLocationApi),
        body: json.encode({
          // "pageNo": "0",
          // "limit": "2",
          // "formDate": "2022-08-20",
          // "toDate": "2023-08-20",
          // "keyword": ""
        }),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _location = json.decode(response.body);

      print('Response: $customers');
    } else {
      print('Failed');
      _location = json.decode(response.body);

      print('Failed Response: $customers');
    }
    // var request = http.MultipartRequest('POST', uri);
    // request.headers.addAll({
    //   'Authorization': salesToken,
    // });
    // var response = await request.send();

    // if (response.statusCode == 200) {
    //   var response2 = await http.Response.fromStream(response);
    //   final data = json.decode(response2.body);
    //   print('dataaaaaaaaaaaaa ${data}');
    //   setState(() {
    //     customers = data['data'];
    //   });
    // }
    notifyListeners();
  }

  Future<void> removeList() async {
    _itemList.clear();
    _totalItemDiscount = 0.0;
    _totalBasePrice = 0.0;
    _igst = 0.0;
    notifyListeners();
  }

  Future<void> addListItem(dynamic data, BuildContext context) async {
    print('Tax Of Item: ${data['itemTotalTax1']}');

    _itemList.add(data);
    Flushbar(
      duration: const Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.BOTTOM,
      borderRadius: BorderRadius.circular(10),
      icon: const Icon(Icons.error, color: Colors.white),
      // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
      // title: 'Item Added',
      message: 'Item Added',
      barBlur: 20,
    ).show(context);
    print('Item List; $_itemList');
    // for (int i = 0; i < _itemList.length; i++) {
    //   _totalPrice += double.parse(_itemList[i]['totalPrice']);
    //   _totalItemDiscount += double.parse(_itemList[i]['itemTotalDiscount1']);
    // }

    // List<Map<String, dynamic>> itemList =
    //     Provider.of<SalesOrderApis>(context, listen: false).itemList;

    _totalPrice = _itemList.fold<double>(
        0.0, (sum, item) => sum + double.parse(item['totalPrice'] as String));

    _totalItemDiscount = _itemList.fold<double>(
        0.0,
        (sum, item) =>
            sum + double.parse(item['itemTotalDiscount1'] as String));

    _totalBasePrice +=
        double.parse(data['qty']) * double.parse(data['unitPrice']);

    _igst = _itemList.fold<double>(0.0,
        (sum, item) => sum + double.parse(item['itemTotalTax1'] as String));

    print('Total Price: $_totalPrice');
    print('Total Discount: $_totalItemDiscount');
    print('Total Base Price: $_totalBasePrice');
    print('Total IGST: $_igst');

    notifyListeners();
  }

  // Map<String, dynamic> get bothItems {
  //   return {..._bothItems};
  // }

  // Map<String, dynamic> get serviceItems {
  //   return {..._serviceItems};
  // }

  // Map<String, dynamic> get goodsItems {
  //   return {..._goodsItems};
  // }

  Future<void> getCustomerDetails(int customerId, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    // __customerDetails = {};
    var response = await http.post(Uri.parse(AppUrl.fetchCustomerDetails),
        body: json.encode({'customerId': customerId}),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _customerDetails = json.decode(response.body);

      _creditPeriodDays =
          _customerDetails['data']['customerDetails']['customer_credit_period'];

      _billingAddress =
          '${_customerDetails['data']['billingAddress']['customer_address_recipient_name'] ?? ''}, ${_customerDetails['data']['billingAddress']['customer_address_building_no'] ?? ''}, ${_customerDetails['data']['billingAddress']['customer_address_flat_no'] ?? ''}, ${_customerDetails['data']['billingAddress']['customer_address_street_name'] ?? ''}, ${_customerDetails['data']['billingAddress']['customer_address_location'] ?? ''}, ${_customerDetails['data']['billingAddress']['customer_address_city'] ?? ''}, ${_customerDetails['data']['billingAddress']['customer_address_district'] ?? ''}, ${_customerDetails['data']['billingAddress']['customer_address_state'] ?? ''}, ${_customerDetails['data']['billingAddress']['customer_address_country'] ?? ''}, ${_customerDetails['data']['billingAddress']['customer_address_pin_code'] ?? ''}, ${_customerDetails['data']['billingAddress']['customer_address_state_code'] ?? ''}';

      _shippingAddress =
          '${_customerDetails['data']['shippingAddress']['customer_address_recipient_name'] ?? ''}, ${_customerDetails['data']['shippingAddress']['customer_address_building_no'] ?? ''}, ${_customerDetails['data']['shippingAddress']['customer_address_flat_no'] ?? ''}, ${_customerDetails['data']['shippingAddress']['customer_address_street_name'] ?? ''}, ${_customerDetails['data']['shippingAddress']['customer_address_location'] ?? ''}, ${_customerDetails['data']['shippingAddress']['customer_address_city'] ?? ''}, ${_customerDetails['data']['shippingAddress']['customer_address_district'] ?? ''}, ${_customerDetails['data']['shippingAddress']['customer_address_state'] ?? ''}, ${_customerDetails['data']['shippingAddress']['customer_address_country'] ?? ''}, ${_customerDetails['data']['shippingAddress']['customer_address_pin_code'] ?? ''}, ${_customerDetails['data']['shippingAddress']['customer_address_state_code'] ?? ''}';

      print('Customer Details: $_customerDetails');

      print('Customer Credit Period: $_creditPeriodDays');

      print('Shipping Address: $_shippingAddress');
      print('Business Address: $_billingAddress');
    } else {
      _customerDetails = {};
      var jsonResponse = json.decode(response.body);

      print('Customer Details: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> fetchKam(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http
        .post(Uri.parse(AppUrl.fetchKam), body: json.encode(data), headers: {
      'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      _kamDetails = json.decode(response.body);
    } else {
      _kamDetails = {};
      var jsonResponse = json.decode(response.body);

      print('KAM Details: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> addSalesOrder(dynamic data, BuildContext context,
      String otherLocationId, String branchId) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var map = {
      'kamId': salesPersonId,
      'user_id': localStorage.getInt('id'),
      'customer_po_no': customerOrderNumber,
      'goodsType':
          '1', //send material for goods, service for service or both as per selected choice
      'so_date': postingDate,
      'so_posting_time': postingTime,
      'delivery_date': deliveryDate,
      'billing_address': billingAddress,
      'shipping_address': shippingAddress,
      'profit_center': functionalArea,
      'totalAmount': totalPrice.toString(),
      'totalDiscount': totalItemDiscount.toString(),
      'totalItems': itemList.length.toString(),
      'created_by': Provider.of<ProfileViewModel>(context, listen: false)
          .profileDetails['data']['userdata']['emp_name'], //*
      'updated_by': Provider.of<ProfileViewModel>(context, listen: false)
          .profileDetails['data']['userdata']['emp_name'], //*
      'approvalStatus': '14', //*
      'credit_period': creditPeriodDays,
      'customer_id': _customerId,
      'location_id': otherLocationId,
      'branch_id': branchId
    };

    print('SO DETAIIILS: $map');
    print('ITEM DETAILSSS; $data');

    var response = await http.post(Uri.parse(AppUrl.addSalesOrder),
        body: json.encode({'soDetails': map, 'itemDetails': data}),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _salesOrder = json.decode(response.body);

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        // title: 'Successful',
        message: 'Sales Order Created Successfully',
        barBlur: 20,
      ).show(context);

      print('Sales Order: $_salesOrder');

      fetchSoList(context);
    } else {
      _salesOrder = {};
      var jsonResponse = json.decode(response.body);

      print('Add Sales Order: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> newCustomerAddress(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.addCustomerAddress),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _addCustomerAddress = json.decode(response.body);
    } else {
      _addCustomerAddress = {};
      var jsonResponse = json.decode(response.body);

      print('Add Customer Address: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> fetchCustomerAddress(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.fetchCustomerAddress),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _customerAddress = json.decode(response.body);
    } else {
      _customerAddress = {};
      var jsonResponse = json.decode(response.body);

      print('Fetch Customer Address Details: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> fetchCustomerAddressDetails(
      dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(
        Uri.parse(AppUrl.fetchCustomerAddressDetails),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _customerAddressDetails = json.decode(response.body);
    } else {
      _customerAddressDetails = {};
      var jsonResponse = json.decode(response.body);

      print('Fetch Customer Address Details: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> fetchItemDetails(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    print('Sent ITEM DETAILSSSSS: ${data['itemId']}');

    var response = await http.post(Uri.parse(AppUrl.fetchItemDetails),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _itemDetails = json.decode(response.body);
      _itemName = _itemDetails['data']['itemName'];
      _itemCode = _itemDetails['data']['itemCode'];
      _unitPrice = _itemDetails['data']['itemPrice'];
      _maxDiscount = _itemDetails['data']['itemMaxDiscount'];
      _tax = _itemDetails['data']['taxPercentage'];
      _inventoryItemId = _itemDetails['data']['itemId'];
      _lineNo = '1';
      _itemDesc = _itemDetails['data']['itemDesc'];
      _goodsType = _itemDetails['data']['goodsType'];
      _hsnCode = _itemDetails['data']['hsnCode'];
      _itemTotalDiscount = _itemDetails['data']['itemMaxDiscount'];
      _totalTax = _itemDetails['data']['taxPercentage'];
      _itemTotalTax1 = _itemDetails['data']['taxPercentage'];
      _tolerance = '10';
      _uom = _itemDetails['data']['uomName'] ?? 'NA';
      print('Fetch Item Details: $_itemDetails');
    } else {
      _itemDetails = {};
      var jsonResponse = json.decode(response.body);

      print('Fetch Item Details: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> fetchBothItems(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.fetchBothItems),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _items = json.decode(response.body);
      print('Fetch Both Item: $_items');
    } else {
      _items = {};
      var jsonResponse = json.decode(response.body);

      print('Fetch Both Item: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> fetchServiceItems(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.fetchServiceItems),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _items = json.decode(response.body);
      print('Fetch Service Item: $_items');
    } else {
      _items = {};
      var jsonResponse = json.decode(response.body);

      print('Fetch Service Item: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> fetchGoodsItems(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.fetchGoodItems),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _items = json.decode(response.body);
      print('Fetch Goods Item: $_items');
    } else {
      _items = {};
      var jsonResponse = json.decode(response.body);

      print('Fetch Good Item: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> fetchfuncationalArea(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.funcationalAreaApi),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _funcationalArea = json.decode(response.body);
      print('Fetch dataaaaaaa: $_funcationalArea');
    } else {
      _funcationalArea = {};
      var jsonResponse = json.decode(response.body);

      print('Funcational Area: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }

  Future<void> fetchInvoiceType(dynamic data, BuildContext context) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    var response = await http.post(Uri.parse(AppUrl.invoiceTypeApi),
        body: json.encode(data),
        headers: {
          'Authorization': 'Bearer ${localStorage.getString('kamToken')}',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      _invoiceType = json.decode(response.body);
      print('Fetch invoice dataaaaaaa: $_invoiceType');
    } else {
      _invoiceType = {};
      var jsonResponse = json.decode(response.body);

      print('Invoice Type: $jsonResponse');

      Flushbar(
        duration: const Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.error, color: Colors.white),
        // margin: const EdgeInsets.fromLTRB(100, 10, 100, 0),
        title: 'Request Failed',
        message: 'Failed',
        barBlur: 20,
      ).show(context);
    }
    notifyListeners();
  }
}

//////////////////// git push//////////////////