class LeaveRemainingModel {
  int? status;
  List<Data>? data;

  LeaveRemainingModel({this.status, this.data});

  LeaveRemainingModel.fromJson(Map<String, dynamic> json) {
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
  String? empId;
  String? name;
  int? totalSickLeave;
  int? sickLeaveTaken;
  int? sickLeaveBalance;
  int? totalPriviledgedLeave;
  int? priviledgedLeaveTaken;
  int? priviledgedLeaveBalance;
  int? totalCasualLeave;
  int? casualLeaveTaken;
  int? casualLeaveBalance;
  int? leaveWithoutPay;
  String? leavesValidity;

  Data(
      {this.empId,
      this.name,
      this.totalSickLeave,
      this.sickLeaveTaken,
      this.sickLeaveBalance,
      this.totalPriviledgedLeave,
      this.priviledgedLeaveTaken,
      this.priviledgedLeaveBalance,
      this.totalCasualLeave,
      this.casualLeaveTaken,
      this.casualLeaveBalance,
      this.leaveWithoutPay,
      this.leavesValidity});

  Data.fromJson(Map<String, dynamic> json) {
    empId = json['emp_id'];
    name = json['name'];
    totalSickLeave = json['total sick leave'];
    sickLeaveTaken = json['sick leave taken'];
    sickLeaveBalance = json['sick leave balance'];
    totalPriviledgedLeave = json['total priviledged leave'];
    priviledgedLeaveTaken = json['priviledged leave taken'];
    priviledgedLeaveBalance = json['priviledged leave balance'];
    totalCasualLeave = json['total casual leave'];
    casualLeaveTaken = json['casual leave taken'];
    casualLeaveBalance = json['casual leave balance'];
    leaveWithoutPay = json['leave without pay'];
    leavesValidity = json['leaves validity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_id'] = this.empId;
    data['name'] = this.name;
    data['total sick leave'] = this.totalSickLeave;
    data['sick leave taken'] = this.sickLeaveTaken;
    data['sick leave balance'] = this.sickLeaveBalance;
    data['total priviledged leave'] = this.totalPriviledgedLeave;
    data['priviledged leave taken'] = this.priviledgedLeaveTaken;
    data['priviledged leave balance'] = this.priviledgedLeaveBalance;
    data['total casual leave'] = this.totalCasualLeave;
    data['casual leave taken'] = this.casualLeaveTaken;
    data['casual leave balance'] = this.casualLeaveBalance;
    data['leave without pay'] = this.leaveWithoutPay;
    data['leaves validity'] = this.leavesValidity;
    return data;
  }
}
