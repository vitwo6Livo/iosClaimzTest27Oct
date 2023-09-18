class travelListstatusModel {
  int? status;
  List<Data>? data;

  travelListstatusModel({this.status, this.data});

  travelListstatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic? empName;
  dynamic? empCode;
  dynamic? profilePhoto;
  dynamic? modOfTravel;
  dynamic? modOfAcco;
  int? id;
  int? docNo;
  dynamic? tripWay;
  dynamic? travelType;
  dynamic? fromPlace;
  dynamic? toPlace;
  dynamic? fromDate;
  dynamic? fromTime;
  dynamic? toDate;
  dynamic? toTime;
  dynamic? date;
  dynamic? serviceProvider;
  dynamic? gstNo;
  dynamic? gstAmount;
  dynamic? paidAmount;
  dynamic? claimAmount;
  dynamic? basicAmount;
  dynamic? paymentType;
  dynamic? exchangeRate;
  dynamic? document;
  dynamic? metWhom;
  dynamic? purposeOfVisit;
  dynamic? feedback;
  dynamic? status;
  dynamic? remarks;
  dynamic? partialAmount;
  dynamic? partialGst;
  dynamic? partialTotal;

  Data(
      {this.empName,
      this.empCode,
      this.profilePhoto,
      this.modOfTravel,
      this.modOfAcco,
      this.id,
      this.docNo,
      this.tripWay,
      this.travelType,
      this.fromPlace,
      this.toPlace,
      this.fromDate,
      this.fromTime,
      this.toDate,
      this.toTime,
      this.date,
      this.serviceProvider,
      this.gstNo,
      this.gstAmount,
      this.paidAmount,
      this.claimAmount,
      this.basicAmount,
      this.paymentType,
      this.exchangeRate,
      this.document,
      this.metWhom,
      this.purposeOfVisit,
      this.feedback,
      this.status,
      this.remarks,
      this.partialAmount,
      this.partialGst,
      this.partialTotal});

  Data.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    empCode = json['emp_code'];
    profilePhoto = json['profile_photo'];
    modOfTravel = json['mod_of_travel'];
    modOfAcco = json['mod_of_acco'];
    id = json['id'];
    docNo = json['doc_no'];
    tripWay = json['trip_way'];
    travelType = json['travel_type'];
    fromPlace = json['from_place'];
    toPlace = json['to_place'];
    fromDate = json['from_date'];
    fromTime = json['from_time'];
    toDate = json['to_date'];
    toTime = json['to_time'];
    date = json['date'];
    serviceProvider = json['service_provider'];
    gstNo = json['gst_no'];
    gstAmount = json['gst_amount'];
    paidAmount = json['paid_amount'];
    claimAmount = json['claim_amount'];
    basicAmount = json['basic_amount'];
    paymentType = json['payment_type'];
    exchangeRate = json['exchange_rate'];
    document = json['document'];
    metWhom = json['met_whom'];
    purposeOfVisit = json['purpose_of_visit'];
    feedback = json['feedback'];
    status = json['status'];
    remarks = json['remarks'];
    partialAmount = json['partial_amount'];
    partialGst = json['partial_gst'];
    partialTotal = json['partial_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['emp_code'] = this.empCode;
    data['profile_photo'] = this.profilePhoto;
    data['mod_of_travel'] = this.modOfTravel;
    data['mod_of_acco'] = this.modOfAcco;
    data['id'] = this.id;
    data['doc_no'] = this.docNo;
    data['trip_way'] = this.tripWay;
    data['travel_type'] = this.travelType;
    data['from_place'] = this.fromPlace;
    data['to_place'] = this.toPlace;
    data['from_date'] = this.fromDate;
    data['from_time'] = this.fromTime;
    data['to_date'] = this.toDate;
    data['to_time'] = this.toTime;
    data['date'] = this.date;
    data['service_provider'] = this.serviceProvider;
    data['gst_no'] = this.gstNo;
    data['gst_amount'] = this.gstAmount;
    data['paid_amount'] = this.paidAmount;
    data['claim_amount'] = this.claimAmount;
    data['basic_amount'] = this.basicAmount;
    data['payment_type'] = this.paymentType;
    data['exchange_rate'] = this.exchangeRate;
    data['document'] = this.document;
    data['met_whom'] = this.metWhom;
    data['purpose_of_visit'] = this.purposeOfVisit;
    data['feedback'] = this.feedback;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    data['partial_amount'] = this.partialAmount;
    data['partial_gst'] = this.partialGst;
    data['partial_total'] = this.partialTotal;
    return data;
  }
}
