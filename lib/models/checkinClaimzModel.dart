class checkin_claimz_Model {
  int? status;
  String? data;
  List<Id>? id;
  int? docNumber;

  checkin_claimz_Model({this.status, this.data, this.id, this.docNumber});

  checkin_claimz_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
    if (json['id'] != null) {
      id = <Id>[];
      json['id'].forEach((v) {
        id!.add(new Id.fromJson(v));
      });
    }
    docNumber = json['doc_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['data'] = this.data;
    if (this.id != null) {
      data['id'] = this.id!.map((v) => v.toJson()).toList();
    }
    data['doc_number'] = this.docNumber;
    return data;
  }
}

class Id {
  int? claimzReportId;

  Id({this.claimzReportId});

  Id.fromJson(Map<String, dynamic> json) {
    claimzReportId = json['claimz_report_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claimz_report_id'] = this.claimzReportId;
    return data;
  }
}
