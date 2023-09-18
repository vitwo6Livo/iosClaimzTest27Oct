class Authentication {
  Data? data;

  Authentication({this.data});

  Authentication.fromJson(Map<String, dynamic> json) {
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
  String? accessToken;
  int? role;
  int? id;
  String? approval;
  int? candidateStatus;
  String? email;
  String? name;
  String? verificationCode;

  Data({
    this.accessToken,
    this.role,
    this.id,
    this.approval,
    this.candidateStatus,
    this.email,
    this.name,
    this.verificationCode,
  });

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    role = json['role'];
    id = json['id'];
    approval = json['approval'];
    candidateStatus = json['candidate_status'];
    email = json['email'];
    name = json['name'];
    verificationCode = json['verification_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['role'] = this.role;
    data['id'] = this.id;
    data['approval'] = this.approval;
    data['candidate_status'] = this.candidateStatus;
    data['email'] = this.email;
    data['name'] = this.name;
    data['verification_code'] = this.verificationCode;
    return data;
  }
}
