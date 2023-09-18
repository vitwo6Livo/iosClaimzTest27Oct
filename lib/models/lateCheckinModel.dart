class LateCheckinModel {
  int? status;
  List<Data>? data;

  LateCheckinModel({this.status, this.data});

  LateCheckinModel.fromJson(Map<String, dynamic> json) {
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
  String? empName;
  int? lateId;
  String? lateDate;
  String? lateCheckinTime;
  dynamic? status;

  Data(
      {this.empName,
      this.lateId,
      this.lateDate,
      this.lateCheckinTime,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    lateId = json['late_id'];
    lateDate = json['late_date'];
    lateCheckinTime = json['late_checkin_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['late_id'] = this.lateId;
    data['late_date'] = this.lateDate;
    data['late_checkin_time'] = this.lateCheckinTime;
    data['status'] = this.status;
    return data;
  }
}
