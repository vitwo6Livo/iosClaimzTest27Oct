class ViewRegularizationManagers {
  int? status;
  List<Data>? data;

  ViewRegularizationManagers({this.status, this.data});

  ViewRegularizationManagers.fromJson(Map<String, dynamic> json) {
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
  int? regularizeId;
  String? name;
  String? empId;
  String? attendanceDate;
  String? reason;
  String? description;
  String? checkin;
  String? checkout;
  int? status;
  int? primaryReporting;
  int? secondaryReporting;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.regularizeId,
      this.name,
      this.empId,
      this.attendanceDate,
      this.reason,
      this.description,
      this.checkin,
      this.checkout,
      this.status,
      this.primaryReporting,
      this.secondaryReporting,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    regularizeId = json['regularize_id'];
    name = json['name'];
    empId = json['emp_id'];
    attendanceDate = json['attendance_date'];
    reason = json['reason'];
    description = json['description'];
    checkin = json['checkin'];
    checkout = json['checkout'];
    status = json['status'];
    primaryReporting = json['primary_reporting'];
    secondaryReporting = json['secondary_reporting'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['regularize_id'] = this.regularizeId;
    data['name'] = this.name;
    data['emp_id'] = this.empId;
    data['attendance_date'] = this.attendanceDate;
    data['reason'] = this.reason;
    data['description'] = this.description;
    data['checkin'] = this.checkin;
    data['checkout'] = this.checkout;
    data['status'] = this.status;
    data['primary_reporting'] = this.primaryReporting;
    data['secondary_reporting'] = this.secondaryReporting;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
