class AttendanceReportModel {
  int? status;
  List<Data>? data;
  List<Count>? count;

  AttendanceReportModel({this.status, this.data, this.count});

  AttendanceReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    if (json['count'] != null) {
      count = <Count>[];
      json['count'].forEach((v) {
        count!.add(new Count.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.count != null) {
      data['count'] = this.count!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? lat;
  String? lng;
  String? checkoutLat;
  String? checkoutLng;
  String? checkoutTime;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic? deletedAt;
  String? address;
  String? checkoutAddress;
  int? approvalStatus;
  dynamic? timezone;
  dynamic? createdDate;

  Data(
      {this.id,
      this.userId,
      this.lat,
      this.lng,
      this.checkoutLat,
      this.checkoutLng,
      this.checkoutTime,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.address,
      this.checkoutAddress,
      this.approvalStatus,
      this.timezone,
      this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lat = json['lat'];
    lng = json['lng'];
    checkoutLat = json['checkout_lat'];
    checkoutLng = json['checkout_lng'];
    checkoutTime = json['checkout_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    address = json['address'];
    checkoutAddress = json['checkout_address'];
    approvalStatus = json['approval_status'];
    timezone = json['timezone'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['checkout_lat'] = this.checkoutLat;
    data['checkout_lng'] = this.checkoutLng;
    data['checkout_time'] = this.checkoutTime;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['address'] = this.address;
    data['checkout_address'] = this.checkoutAddress;
    data['approval_status'] = this.approvalStatus;
    data['timezone'] = this.timezone;
    data['created_date'] = this.createdDate;
    return data;
  }
}

class Count {
  int? present;
  int? halfday;
  int? leave;

  Count({this.present, this.halfday, this.leave});

  Count.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    halfday = json['halfday'];
    leave = json['leave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['present'] = this.present;
    data['halfday'] = this.halfday;
    data['leave'] = this.leave;
    return data;
  }
}
