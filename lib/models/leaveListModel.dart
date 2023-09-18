// class LeaveListModel {
//   int? status;
//   List<Data>? data;

//   LeaveListModel({this.status, this.data});

//   LeaveListModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   int? leaveId;
//   String? empId;
//   String? name;
//   String? date;
//   String? leaveType;
//   String? description;
//   int? status;
//   int? approvedBy;

//   Data(
//       {this.leaveId,
//       this.empId,
//       this.name,
//       this.date,
//       this.leaveType,
//       this.description,
//       this.status,
//       this.approvedBy});

//   Data.fromJson(Map<String, dynamic> json) {
//     leaveId = json['leave_id'];
//     empId = json['emp_id'];
//     name = json['name'];
//     date = json['date'];
//     leaveType = json['leave_type'];
//     description = json['description'];
//     status = json['status'];
//     approvedBy = json['approved_by'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['leave_id'] = this.leaveId;
//     data['emp_id'] = this.empId;
//     data['name'] = this.name;
//     data['date'] = this.date;
//     data['leave_type'] = this.leaveType;
//     data['description'] = this.description;
//     data['status'] = this.status;
//     data['approved_by'] = this.approvedBy;
//     return data;
//   }
// }
class LeaveListModel {
  int? status;
  List<Data>? data;

  LeaveListModel({this.status, this.data});

  LeaveListModel.fromJson(Map<String, dynamic> json) {
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
  int? leaveId;
  String? empId;
  String? name;
  List<String>? dates;
  String? leaveType;
  String? subject;
  String? description;
  int? status;
  int? approvedBy;

  Data(
      {this.leaveId,
      this.empId,
      this.name,
      this.dates,
      this.leaveType,
      this.subject,
      this.description,
      this.status,
      this.approvedBy});

  Data.fromJson(Map<String, dynamic> json) {
    leaveId = json['leave_id'];
    empId = json['emp_id'];
    name = json['name'];
    dates = json['dates'].cast<String>();
    leaveType = json['leave_type'];
    subject = json['subject'];
    description = json['description'];
    status = json['status'];
    approvedBy = json['approved_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_id'] = this.leaveId;
    data['emp_id'] = this.empId;
    data['name'] = this.name;
    data['dates'] = this.dates;
    data['leave_type'] = this.leaveType;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['status'] = this.status;
    data['approved_by'] = this.approvedBy;
    return data;
  }
}
