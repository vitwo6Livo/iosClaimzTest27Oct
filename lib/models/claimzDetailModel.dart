class claimzdetailModel {
  String? status;
  List<Data>? data;

  claimzdetailModel({this.status, this.data});

  claimzdetailModel.fromJson(Map<String, dynamic> json) {
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
  int? claimzReportId;
  int? empId;
  String? claimTime;
  String? claimDate;
  String? claimType;
  String? docNo;
  String? status;

  Data(
      {this.claimzReportId,
      this.empId,
      this.claimTime,
      this.claimDate,
      this.claimType,
      this.docNo,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    claimzReportId = json['claimz_report_id'];
    empId = json['emp_id'];
    claimTime = json['claim_time'];
    claimDate = json['claim_date'];
    claimType = json['claim_type'];
    docNo = json['doc_no'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claimz_report_id'] = this.claimzReportId;
    data['emp_id'] = this.empId;
    data['claim_time'] = this.claimTime;
    data['claim_date'] = this.claimDate;
    data['claim_type'] = this.claimType;
    data['doc_no'] = this.docNo;
    data['status'] = this.status;
    return data;
  }
}
