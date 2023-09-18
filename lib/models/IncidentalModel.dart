class IncidentalModel {
  int? status;
  List<Data>? data;

  IncidentalModel({this.status, this.data});

  IncidentalModel.fromJson(Map<String, dynamic> json) {
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
  String? claimDay;
  String? claimMonth;
  String? claimYear;
  List<ClaimData>? claimData;

  Data({this.claimDay, this.claimMonth, this.claimYear, this.claimData});

  Data.fromJson(Map<String, dynamic> json) {
    claimDay = json['claim_day'];
    claimMonth = json['claim_month'];
    claimYear = json['claim_year'];
    if (json['claim_data'] != null) {
      claimData = <ClaimData>[];
      json['claim_data'].forEach((v) {
        claimData!.add(new ClaimData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claim_day'] = this.claimDay;
    data['claim_month'] = this.claimMonth;
    data['claim_year'] = this.claimYear;
    if (this.claimData != null) {
      data['claim_data'] = this.claimData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClaimData {
  int? incedentalFormId;
  int? empId;
  int? claimNo;
  int? docNo;
  String? date;
  String? purpose;
  String? serviceProvider;
  int? gSTNo;
  int? basicAmount;
  int? gSTAmount;
  int? totalAmount;
  String? billNo;
  String? attachment;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? id;
  int? companyId;
  int? idFranchise;
  int? gradeId;
  String? empName;
  String? userType;
  String? email;
  String? password;
  String? empCode;
  String? birthDate;
  String? joinDate;
  dynamic? leaveDate;
  String? gender;
  String? fatherName;
  String? pAddress;
  String? presentAddress;
  String? mobileNo;
  String? contactNo;
  String? panNo;
  String? aadharNo;
  String? passportNo;
  String? visaNo;
  String? placeOfPosting;
  String? bloodGroup;
  String? isActive;
  dynamic? rememberToken;
  dynamic? deletedAt;
  int? createdBy;
  int? modifiedBy;
  int? departmentId;
  dynamic? costCenterId;
  String? headOfDepartment;
  int? aprrover1;
  int? aprrover2;
  int? aprrover3;
  dynamic? specialPermission;
  int? theme;
  dynamic? otp;
  dynamic? altEmail;
  String? profilePhoto;
  dynamic? pAddressTemp;
  dynamic? presentAddressTemp;
  dynamic? mobileNoTemp;
  dynamic? contactNoTemp;
  dynamic? altEmailTemp;
  dynamic? profilePhotoTemp;
  dynamic? deviceId;
  dynamic? deviceType;
  String? designation;
  dynamic? weekoff;

  ClaimData(
      {this.incedentalFormId,
      this.empId,
      this.claimNo,
      this.docNo,
      this.date,
      this.purpose,
      this.serviceProvider,
      this.gSTNo,
      this.basicAmount,
      this.gSTAmount,
      this.totalAmount,
      this.billNo,
      this.attachment,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.id,
      this.companyId,
      this.idFranchise,
      this.gradeId,
      this.empName,
      this.userType,
      this.email,
      this.password,
      this.empCode,
      this.birthDate,
      this.joinDate,
      this.leaveDate,
      this.gender,
      this.fatherName,
      this.pAddress,
      this.presentAddress,
      this.mobileNo,
      this.contactNo,
      this.panNo,
      this.aadharNo,
      this.passportNo,
      this.visaNo,
      this.placeOfPosting,
      this.bloodGroup,
      this.isActive,
      this.rememberToken,
      this.deletedAt,
      this.createdBy,
      this.modifiedBy,
      this.departmentId,
      this.costCenterId,
      this.headOfDepartment,
      this.aprrover1,
      this.aprrover2,
      this.aprrover3,
      this.specialPermission,
      this.theme,
      this.otp,
      this.altEmail,
      this.profilePhoto,
      this.pAddressTemp,
      this.presentAddressTemp,
      this.mobileNoTemp,
      this.contactNoTemp,
      this.altEmailTemp,
      this.profilePhotoTemp,
      this.deviceId,
      this.deviceType,
      this.designation,
      this.weekoff});

  ClaimData.fromJson(Map<String, dynamic> json) {
    incedentalFormId = json['incedental_form_id'];
    empId = json['emp_id'];
    claimNo = json['claim_no'];
    docNo = json['doc_no'];
    date = json['date'];
    purpose = json['purpose'];
    serviceProvider = json['service_provider'];
    gSTNo = json['GST_no'];
    basicAmount = json['basic_amount'];
    gSTAmount = json['GST_amount'];
    totalAmount = json['total_amount'];
    billNo = json['bill_no'];
    attachment = json['attachment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
    companyId = json['company_id'];
    idFranchise = json['id_franchise'];
    gradeId = json['grade_id'];
    empName = json['emp_name'];
    userType = json['user_type'];
    email = json['email'];
    password = json['password'];
    empCode = json['emp_code'];
    birthDate = json['birth_date'];
    joinDate = json['join_date'];
    leaveDate = json['leave_date'];
    gender = json['gender'];
    fatherName = json['father_name'];
    pAddress = json['p_address'];
    presentAddress = json['present_address'];
    mobileNo = json['mobile_no'];
    contactNo = json['contact_no'];
    panNo = json['pan_no'];
    aadharNo = json['aadhar_no'];
    passportNo = json['passport_no'];
    visaNo = json['visa_no'];
    placeOfPosting = json['place_of_posting'];
    bloodGroup = json['blood_group'];
    isActive = json['is_active'];
    rememberToken = json['remember_token'];
    deletedAt = json['deleted_at'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    departmentId = json['department_id'];
    costCenterId = json['cost_center_id'];
    headOfDepartment = json['head_of_department'];
    aprrover1 = json['aprrover_1'];
    aprrover2 = json['aprrover_2'];
    aprrover3 = json['aprrover_3'];
    specialPermission = json['special_permission'];
    theme = json['theme'];
    otp = json['otp'];
    altEmail = json['alt_email'];
    profilePhoto = json['profile_photo'];
    pAddressTemp = json['p_address_temp'];
    presentAddressTemp = json['present_address_temp'];
    mobileNoTemp = json['mobile_no_temp'];
    contactNoTemp = json['contact_no_temp'];
    altEmailTemp = json['alt_email_temp'];
    profilePhotoTemp = json['profile_photo_temp'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    designation = json['designation'];
    weekoff = json['weekoff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['incedental_form_id'] = this.incedentalFormId;
    data['emp_id'] = this.empId;
    data['claim_no'] = this.claimNo;
    data['doc_no'] = this.docNo;
    data['date'] = this.date;
    data['purpose'] = this.purpose;
    data['service_provider'] = this.serviceProvider;
    data['GST_no'] = this.gSTNo;
    data['basic_amount'] = this.basicAmount;
    data['GST_amount'] = this.gSTAmount;
    data['total_amount'] = this.totalAmount;
    data['bill_no'] = this.billNo;
    data['attachment'] = this.attachment;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id'] = this.id;
    data['company_id'] = this.companyId;
    data['id_franchise'] = this.idFranchise;
    data['grade_id'] = this.gradeId;
    data['emp_name'] = this.empName;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['password'] = this.password;
    data['emp_code'] = this.empCode;
    data['birth_date'] = this.birthDate;
    data['join_date'] = this.joinDate;
    data['leave_date'] = this.leaveDate;
    data['gender'] = this.gender;
    data['father_name'] = this.fatherName;
    data['p_address'] = this.pAddress;
    data['present_address'] = this.presentAddress;
    data['mobile_no'] = this.mobileNo;
    data['contact_no'] = this.contactNo;
    data['pan_no'] = this.panNo;
    data['aadhar_no'] = this.aadharNo;
    data['passport_no'] = this.passportNo;
    data['visa_no'] = this.visaNo;
    data['place_of_posting'] = this.placeOfPosting;
    data['blood_group'] = this.bloodGroup;
    data['is_active'] = this.isActive;
    data['remember_token'] = this.rememberToken;
    data['deleted_at'] = this.deletedAt;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['department_id'] = this.departmentId;
    data['cost_center_id'] = this.costCenterId;
    data['head_of_department'] = this.headOfDepartment;
    data['aprrover_1'] = this.aprrover1;
    data['aprrover_2'] = this.aprrover2;
    data['aprrover_3'] = this.aprrover3;
    data['special_permission'] = this.specialPermission;
    data['theme'] = this.theme;
    data['otp'] = this.otp;
    data['alt_email'] = this.altEmail;
    data['profile_photo'] = this.profilePhoto;
    data['p_address_temp'] = this.pAddressTemp;
    data['present_address_temp'] = this.presentAddressTemp;
    data['mobile_no_temp'] = this.mobileNoTemp;
    data['contact_no_temp'] = this.contactNoTemp;
    data['alt_email_temp'] = this.altEmailTemp;
    data['profile_photo_temp'] = this.profilePhotoTemp;
    data['device_id'] = this.deviceId;
    data['device_type'] = this.deviceType;
    data['designation'] = this.designation;
    data['weekoff'] = this.weekoff;
    return data;
  }
}
