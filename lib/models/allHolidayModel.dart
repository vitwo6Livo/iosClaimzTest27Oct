class AllHolidayModel {
  int? status;
  List<Data>? data;

  AllHolidayModel({this.status, this.data});

  AllHolidayModel.fromJson(Map<String, dynamic> json) {
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
  int? holidayId;
  String? holiday;
  String? holidayDate;
  String? image;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.holidayId,
      this.holiday,
      this.holidayDate,
      this.image,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    holidayId = json['holiday_id'];
    holiday = json['holiday'];
    holidayDate = json['holiday_date'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holiday_id'] = this.holidayId;
    data['holiday'] = this.holiday;
    data['holiday_date'] = this.holidayDate;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
