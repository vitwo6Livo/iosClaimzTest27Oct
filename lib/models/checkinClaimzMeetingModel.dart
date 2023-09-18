class checkin_claimz_meeting_Model {
  int? status;
  String? data;

  checkin_claimz_meeting_Model({this.status, this.data});

  checkin_claimz_meeting_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}
