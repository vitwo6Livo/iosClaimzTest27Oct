class iternaryModel {
  int? status;
  Data? data;

  iternaryModel({this.status, this.data});

  iternaryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Travel? travel;
  Accomodation? accomodation;
  Accomodation? food;
  Accomodation? local;
  Accomodation? incidental;
  List<MeetingDetails>? meetingDetails;
  List<ApprovalLog>? approvalLog;
  List<ReasonLog>? reasonLog;
  List<ModeOfTravels>? modeOfTravels;
  WayOfTrip? wayOfTrip;
  List<Accommodations>? accommodations;
  WayOfTrip? paymentType;
  List<Limit>? limit;

  Data(
      {this.travel,
      this.accomodation,
      this.food,
      this.local,
      this.incidental,
      this.meetingDetails,
      this.approvalLog,
      this.modeOfTravels,
      this.wayOfTrip,
      this.accommodations,
      this.paymentType,
      this.limit});

  Data.fromJson(Map<String, dynamic> json) {
    travel =
        json['travel'] != null ? new Travel.fromJson(json['travel']) : null;
    accomodation = json['accomodation'] != null
        ? new Accomodation.fromJson(json['accomodation'])
        : null;
    food =
        json['food'] != null ? new Accomodation.fromJson(json['food']) : null;
    local =
        json['local'] != null ? new Accomodation.fromJson(json['local']) : null;
    incidental = json['incidental'] != null
        ? new Accomodation.fromJson(json['incidental'])
        : null;
    if (json['meeting_details'] != null) {
      meetingDetails = <MeetingDetails>[];
      json['meeting_details'].forEach((v) {
        meetingDetails!.add(new MeetingDetails.fromJson(v));
      });
    }
    if (json['approval_log'] != null) {
      approvalLog = <ApprovalLog>[];
      json['approval_log'].forEach((v) {
        approvalLog!.add(new ApprovalLog.fromJson(v));
      });
    }
    if (json['reason_log'] != null) {
      reasonLog = <ReasonLog>[];
      json['reason_log'].forEach((v) {
        reasonLog!.add(new ReasonLog.fromJson(v));
      });
    }
    if (json['mode_of_travels'] != null) {
      modeOfTravels = <ModeOfTravels>[];
      json['mode_of_travels'].forEach((v) {
        modeOfTravels!.add(new ModeOfTravels.fromJson(v));
      });
    }
    wayOfTrip = json['way_of_trip'] != null
        ? new WayOfTrip.fromJson(json['way_of_trip'])
        : null;
    if (json['accommodations'] != null) {
      accommodations = <Accommodations>[];
      json['accommodations'].forEach((v) {
        accommodations!.add(new Accommodations.fromJson(v));
      });
    }

    if (json['limit'] != null) {
      limit = <Limit>[];
      json['limit'].forEach((v) {
        limit!.add(new Limit.fromJson(v));
      });
    }

    paymentType = json['payment_type'] != null
        ? new WayOfTrip.fromJson(json['payment_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.travel != null) {
      data['travel'] = this.travel!.toJson();
    }
    if (this.accomodation != null) {
      data['accomodation'] = this.accomodation!.toJson();
    }
    if (this.food != null) {
      data['food'] = this.food!.toJson();
    }
    if (this.local != null) {
      data['local'] = this.local!.toJson();
    }
    if (this.incidental != null) {
      data['incidental'] = this.incidental!.toJson();
    }
    if (this.meetingDetails != null) {
      data['meeting_details'] =
          this.meetingDetails!.map((v) => v.toJson()).toList();
    }
    if (this.approvalLog != null) {
      data['approval_log'] = this.approvalLog!.map((v) => v.toJson()).toList();
    }
    if (this.modeOfTravels != null) {
      data['mode_of_travels'] =
          this.modeOfTravels!.map((v) => v.toJson()).toList();
    }
    if (this.wayOfTrip != null) {
      data['way_of_trip'] = this.wayOfTrip!.toJson();
    }
    if (this.accommodations != null) {
      data['accommodations'] =
          this.accommodations!.map((v) => v.toJson()).toList();
    }
    if (this.paymentType != null) {
      data['payment_type'] = this.paymentType!.toJson();
    }
    return data;
  }
}

class ReasonLog {
  dynamic? trlId;
  dynamic? compId;
  dynamic? docNo;
  dynamic? remarks;
  dynamic? status;
  dynamic? sum;
  dynamic? approvedBy;
  dynamic? approvedAt;
  dynamic? createdAt;
  dynamic? updatedAt;
  dynamic? id;
  dynamic? companyId;
  dynamic? idFranchise;
  dynamic? gradeId;
  dynamic? empName;
  dynamic? userType;
  dynamic? email;
  dynamic? password;
  dynamic? empCode;
  dynamic? birthDate;
  dynamic? joinDate;
  dynamic? leaveDate;
  dynamic? gender;
  dynamic? fatherName;
  dynamic? pAddress;
  dynamic? presentAddress;
  dynamic? mobileNo;
  dynamic? contactNo;
  dynamic? panNo;
  dynamic? aadharNo;
  dynamic? passportNo;
  dynamic? visaNo;
  dynamic? placeOfPosting;
  dynamic? bloodGroup;
  dynamic? isActive;
  dynamic? rememberToken;
  dynamic? deletedAt;
  dynamic? createdBy;
  dynamic? modifiedBy;
  dynamic? departmentId;
  dynamic? costCenterId;
  dynamic? headOfDepartment;
  dynamic? approver;
  dynamic? aprrover1;
  dynamic? aprrover2;
  dynamic? aprrover3;
  dynamic? specialPermission;
  dynamic? theme;
  dynamic? otp;
  dynamic? altEmail;
  dynamic? profilePhoto;
  dynamic? pAddressTemp;
  dynamic? presentAddressTemp;
  dynamic? mobileNoTemp;
  dynamic? contactNoTemp;
  dynamic? altEmailTemp;
  dynamic? profilePhotoTemp;
  dynamic? deviceId;
  dynamic? fcmCode;
  dynamic? deviceType;
  dynamic? designation;
  dynamic? weekoff;

  ReasonLog(
      {this.trlId,
      this.compId,
      this.docNo,
      this.remarks,
      this.status,
      this.sum,
      this.approvedBy,
      this.approvedAt,
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
      this.approver,
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
      this.fcmCode,
      this.deviceType,
      this.designation,
      this.weekoff});

  ReasonLog.fromJson(Map<String, dynamic> json) {
    trlId = json['trl_id'];
    compId = json['comp_id'];
    docNo = json['doc_no'];
    remarks = json['remarks'];
    status = json['status'];
    sum = json['sum'];
    approvedBy = json['approved_by'];
    approvedAt = json['approved_at'];
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
    approver = json['approver'];
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
    fcmCode = json['fcm_code'];
    deviceType = json['device_type'];
    designation = json['designation'];
    weekoff = json['weekoff'];
  }
}

class Travel {
  String? original_document;
  dynamic? original_document_status;
  String? empName;
  String? empCode;
  String? profilePhoto;
  String? modOfTravel;
  String? modOfAcco;
  int? id;
  int? docNo;
  String? tripWay;
  String? travelType;
  String? fromPlace;
  String? toPlace;
  String? fromDate;
  String? fromTime;
  String? toDate;
  String? toTime;
  String? claimDate;
  String? serviceProvider;
  String? gstNo;
  String? gstAmount;
  String? claimAmount;
  String? basicAmount;
  String? paymentType;
  String? exchangeRate;
  String? document;
  String? status;
  dynamic? remarks;
  String? type;
  dynamic? paymentDetails;

  Travel(
      {this.empName,
      this.original_document,
      this.original_document_status,
      this.empCode,
      this.profilePhoto,
      this.modOfTravel,
      this.modOfAcco,
      this.id,
      this.docNo,
      this.tripWay,
      this.travelType,
      this.fromPlace,
      this.toPlace,
      this.fromDate,
      this.fromTime,
      this.toDate,
      this.toTime,
      this.claimDate,
      this.serviceProvider,
      this.gstNo,
      this.gstAmount,
      this.claimAmount,
      this.basicAmount,
      this.paymentType,
      this.exchangeRate,
      this.document,
      this.status,
      this.remarks,
      this.type,
      this.paymentDetails});

  Travel.fromJson(Map<String, dynamic> json) {
    original_document = json['original_document'];
    original_document_status = json['original_document_status'];
    empName = json['emp_name'];
    empCode = json['emp_code'];
    profilePhoto = json['profile_photo'];
    modOfTravel = json['mod_of_travel'];
    modOfAcco = json['mod_of_acco'];
    id = json['id'];
    docNo = json['doc_no'];
    tripWay = json['trip_way'];
    travelType = json['travel_type'];
    fromPlace = json['from_place'];
    toPlace = json['to_place'];
    fromDate = json['from_date'];
    fromTime = json['from_time'];
    toDate = json['to_date'];
    toTime = json['to_time'];
    claimDate = json['claim_date'];
    serviceProvider = json['service_provider'];
    gstNo = json['gst_no'];
    gstAmount = json['gst_amount'];
    claimAmount = json['claim_amount'];
    basicAmount = json['basic_amount'];
    paymentType = json['payment_type'];
    exchangeRate = json['exchange_rate'];
    document = json['document'];
    status = json['status'];
    remarks = json['remarks'];
    type = json['type'];
    paymentDetails = json['payment_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['emp_code'] = this.empCode;
    data['profile_photo'] = this.profilePhoto;
    data['mod_of_travel'] = this.modOfTravel;
    data['mod_of_acco'] = this.modOfAcco;
    data['id'] = this.id;
    data['doc_no'] = this.docNo;
    data['trip_way'] = this.tripWay;
    data['travel_type'] = this.travelType;
    data['from_place'] = this.fromPlace;
    data['to_place'] = this.toPlace;
    data['from_date'] = this.fromDate;
    data['from_time'] = this.fromTime;
    data['to_date'] = this.toDate;
    data['to_time'] = this.toTime;
    data['claim_date'] = this.claimDate;
    data['service_provider'] = this.serviceProvider;
    data['gst_no'] = this.gstNo;
    data['gst_amount'] = this.gstAmount;
    data['claim_amount'] = this.claimAmount;
    data['basic_amount'] = this.basicAmount;
    data['payment_type'] = this.paymentType;
    data['exchange_rate'] = this.exchangeRate;
    data['document'] = this.document;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    data['type'] = this.type;
    data['payment_details'] = this.paymentDetails;
    return data;
  }
}

class Accomodation {
  String? empName;
  String? empCode;
  String? profilePhoto;
  dynamic? modOfTravel;
  String? modOfAcco;
  int? id;
  int? docNo;
  dynamic? tripWay;
  String? travelType;
  dynamic? fromPlace;
  dynamic? toPlace;
  String? fromDate;
  String? fromTime;
  String? toDate;
  String? toTime;
  String? claimDate;
  String? serviceProvider;
  String? gstNo;
  String? gstAmount;
  String? claimAmount;
  String? basicAmount;
  String? paymentType;
  String? exchangeRate;
  String? document;
  String? status;
  dynamic? remarks;
  String? type;
  dynamic? paymentDetails;
  String? original_document;
  dynamic? original_document_status;

  Accomodation(
      {this.empName,
      this.original_document,
      this.original_document_status,
      this.empCode,
      this.profilePhoto,
      this.modOfTravel,
      this.modOfAcco,
      this.id,
      this.docNo,
      this.tripWay,
      this.travelType,
      this.fromPlace,
      this.toPlace,
      this.fromDate,
      this.fromTime,
      this.toDate,
      this.toTime,
      this.claimDate,
      this.serviceProvider,
      this.gstNo,
      this.gstAmount,
      this.claimAmount,
      this.basicAmount,
      this.paymentType,
      this.exchangeRate,
      this.document,
      this.status,
      this.remarks,
      this.type,
      this.paymentDetails});

  Accomodation.fromJson(Map<String, dynamic> json) {
    original_document = json['original_document'];
    original_document_status = json['original_document_status'];
    empName = json['emp_name'];
    empCode = json['emp_code'];
    profilePhoto = json['profile_photo'];
    modOfTravel = json['mod_of_travel'];
    modOfAcco = json['mod_of_acco'];
    id = json['id'];
    docNo = json['doc_no'];
    tripWay = json['trip_way'];
    travelType = json['travel_type'];
    fromPlace = json['from_place'];
    toPlace = json['to_place'];
    fromDate = json['from_date'];
    fromTime = json['from_time'];
    toDate = json['to_date'];
    toTime = json['to_time'];
    claimDate = json['claim_date'];
    serviceProvider = json['service_provider'];
    gstNo = json['gst_no'];
    gstAmount = json['gst_amount'];
    claimAmount = json['claim_amount'];
    basicAmount = json['basic_amount'];
    paymentType = json['payment_type'];
    exchangeRate = json['exchange_rate'];
    document = json['document'];
    status = json['status'];
    remarks = json['remarks'];
    type = json['type'];
    paymentDetails = json['payment_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['emp_code'] = this.empCode;
    data['profile_photo'] = this.profilePhoto;
    data['mod_of_travel'] = this.modOfTravel;
    data['mod_of_acco'] = this.modOfAcco;
    data['id'] = this.id;
    data['doc_no'] = this.docNo;
    data['trip_way'] = this.tripWay;
    data['travel_type'] = this.travelType;
    data['from_place'] = this.fromPlace;
    data['to_place'] = this.toPlace;
    data['from_date'] = this.fromDate;
    data['from_time'] = this.fromTime;
    data['to_date'] = this.toDate;
    data['to_time'] = this.toTime;
    data['claim_date'] = this.claimDate;
    data['service_provider'] = this.serviceProvider;
    data['gst_no'] = this.gstNo;
    data['gst_amount'] = this.gstAmount;
    data['claim_amount'] = this.claimAmount;
    data['basic_amount'] = this.basicAmount;
    data['payment_type'] = this.paymentType;
    data['exchange_rate'] = this.exchangeRate;
    data['document'] = this.document;
    data['status'] = this.status;
    data['remarks'] = this.remarks;
    data['type'] = this.type;
    data['payment_details'] = this.paymentDetails;
    return data;
  }
}

class MeetingDetails {
  int? tmdId;
  int? compId;
  String? docNo;
  String? metWhom;
  String? purposeOfVisit;
  String? feedback;
  dynamic? createdAt;
  dynamic? updatedAt;

  MeetingDetails(
      {this.tmdId,
      this.compId,
      this.docNo,
      this.metWhom,
      this.purposeOfVisit,
      this.feedback,
      this.createdAt,
      this.updatedAt});

  MeetingDetails.fromJson(Map<String, dynamic> json) {
    tmdId = json['tmd_id'];
    compId = json['comp_id'];
    docNo = json['doc_no'];
    metWhom = json['met_whom'];
    purposeOfVisit = json['purpose_of_visit'];
    feedback = json['feedback'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tmd_id'] = this.tmdId;
    data['comp_id'] = this.compId;
    data['doc_no'] = this.docNo;
    data['met_whom'] = this.metWhom;
    data['purpose_of_visit'] = this.purposeOfVisit;
    data['feedback'] = this.feedback;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ApprovalLog {
  dynamic? sum;
  dynamic? aplId;
  dynamic? compId;
  dynamic? docNo;
  dynamic? travelId;
  dynamic? gstAmount;
  dynamic? basicAmount;
  dynamic? claimAmount;
  dynamic? remarks;
  String? approvedBy;
  dynamic? status;
  String? createdAt;
  String? updatedAt;
  dynamic? id;
  dynamic? companyId;
  dynamic? idFranchise;
  dynamic? gradeId;
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
  dynamic? createdBy;
  dynamic? modifiedBy;
  dynamic? departmentId;
  dynamic? costCenterId;
  String? headOfDepartment;
  String? approver;
  dynamic? aprrover1;
  dynamic? aprrover2;
  dynamic? aprrover3;
  dynamic? specialPermission;
  dynamic? theme;
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
  String? fcmCode;
  dynamic? deviceType;
  String? designation;
  dynamic? weekoff;

  ApprovalLog(
      {this.sum,
      this.aplId,
      this.compId,
      this.docNo,
      this.travelId,
      this.gstAmount,
      this.basicAmount,
      this.claimAmount,
      this.remarks,
      this.approvedBy,
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
      this.approver,
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
      this.fcmCode,
      this.deviceType,
      this.designation,
      this.weekoff});

  ApprovalLog.fromJson(Map<String, dynamic> json) {
    sum = json['sum'];
    aplId = json['apl_id'];
    compId = json['comp_id'];
    docNo = json['doc_no'];
    travelId = json['travel_id'];
    gstAmount = json['gst_amount'];
    basicAmount = json['basic_amount'];
    claimAmount = json['claim_amount'];
    remarks = json['remarks'];
    approvedBy = json['approved_by'];
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
    approver = json['approver'];
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
    fcmCode = json['fcm_code'];
    deviceType = json['device_type'];
    designation = json['designation'];
    weekoff = json['weekoff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sum'] = this.sum;
    data['apl_id'] = this.aplId;
    data['comp_id'] = this.compId;
    data['doc_no'] = this.docNo;
    data['travel_id'] = this.travelId;
    data['gst_amount'] = this.gstAmount;
    data['basic_amount'] = this.basicAmount;
    data['claim_amount'] = this.claimAmount;
    data['remarks'] = this.remarks;
    data['approved_by'] = this.approvedBy;
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
    data['approver'] = this.approver;
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
    data['fcm_code'] = this.fcmCode;
    data['device_type'] = this.deviceType;
    data['designation'] = this.designation;
    data['weekoff'] = this.weekoff;
    return data;
  }
}

class ModeOfTravels {
  int? id;
  String? name;
  String? type;

  ModeOfTravels({this.id, this.name, this.type});

  ModeOfTravels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class WayOfTrip {
  String? s1;
  String? s2;

  WayOfTrip({this.s1, this.s2});

  WayOfTrip.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    return data;
  }
}

class Limit {
  String? travelName;
  String? limit;

  Limit({this.travelName, this.limit});

  Limit.fromJson(Map<String, dynamic> json) {
    travelName = json['travel_name'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['travel_name'] = this.travelName;
    data['limit'] = this.limit;
    return data;
  }
}

class Accommodations {
  int? id;
  String? name;

  Accommodations({this.id, this.name});

  Accommodations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
