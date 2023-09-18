class AllAnouncementsModel {
  int? status;
  List<Data>? data;

  AllAnouncementsModel({this.status, this.data});

  AllAnouncementsModel.fromJson(Map<String, dynamic> json) {
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
  String? announcementTitle;
  String? announcement;
  String? empName;
  String? profilePhoto;
  String? createdAt;

  Data({this.announcement, this.empName, this.profilePhoto});

  Data.fromJson(Map<String, dynamic> json) {
    announcementTitle = json['announcement_title'];
    announcement = json['announcement'];
    empName = json['emp_name'];
    profilePhoto = json['profile_photo'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['announcement_title'] = this.announcementTitle;
    data['announcement'] = this.announcement;
    data['emp_name'] = this.empName;
    data['profile_photo'] = this.profilePhoto;
    data['created_at'] = this.createdAt;
    return data;
  }
}
