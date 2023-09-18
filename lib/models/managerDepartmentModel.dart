class ManagerDepartmentModel {
  int? status;
  List<Data>? data;

  ManagerDepartmentModel({this.status, this.data});

  ManagerDepartmentModel.fromJson(Map<String, dynamic> json) {
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
  Null? profilePhoto;
  int? id;

  Data({this.empName, this.profilePhoto, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    profilePhoto = json['profile_photo'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['profile_photo'] = this.profilePhoto;
    data['id'] = this.id;
    return data;
  }
}
