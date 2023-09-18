class ProfileDetails {
  Data? data;

  ProfileDetails({this.data});

  ProfileDetails.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Userdata? userdata;

  Data({this.userdata});

  Data.fromJson(Map<String, dynamic> json) {
    userdata = json['userdata'] != null
        ? new Userdata.fromJson(json['userdata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userdata != null) {
      data['userdata'] = this.userdata!.toJson();
    }
    return data;
  }
}

class Userdata {
  String? empName;
  String? empCode;
  String? email;
  String? profilePhoto;
  String? departmentName;

  Userdata(
      {this.empName,
      this.empCode,
      this.email,
      this.profilePhoto,
      this.departmentName});

  Userdata.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    empCode = json['emp_code'];
    email = json['email'];
    profilePhoto = json['profile_photo'];
    departmentName = json['department_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['emp_code'] = this.empCode;
    data['email'] = this.email;
    data['profile_photo'] = this.profilePhoto;
    data['department_name'] = this.departmentName;
    return data;
  }
}
