class ConyenanceLogsListModel {
  int? status;
  List<Data>? data;

  ConyenanceLogsListModel({this.status, this.data});

  ConyenanceLogsListModel.fromJson(Map<String, dynamic> json) {
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
  int? crlId;
  int? compId;
  dynamic? docNo;
  dynamic? remarks;
  dynamic? status;
  dynamic? sum;
  dynamic? approvedBy;
  dynamic? approvedAt;
  dynamic? createdAt;
  dynamic? updatedAt;
  int? claimzReportId;
  int? empId;
  dynamic? travelStartTime;
  dynamic? travelStartDate;
  dynamic? travelEndTime;
  dynamic? travelEndDate;
  dynamic? meetingStartTime;
  dynamic? meetingStartDate;
  dynamic? meetingEndTime;
  dynamic? meetingEndDate;
  dynamic? travelStartLocation;
  dynamic? travelEndLocation;
  dynamic? meetingStartLocation;
  dynamic? meetingEndLocation;
  dynamic? tStartOriginAddress;
  dynamic? tEndOriginAddress;
  dynamic? amount;
  int? approvalStatus;
  dynamic? suggestedDistance;
  dynamic? suggestedDuration;
  dynamic? suggestedDestinationLocation;
  dynamic? suggestedDestinationAddress;
  dynamic? purpose;
  int? id;
  int? companyId;
  int? idFranchise;
  int? gradeId;
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
  int? createdBy;
  int? modifiedBy;
  int? departmentId;
  dynamic? costCenterId;
  dynamic? headOfDepartment;
  dynamic? approver;
  int? aprrover1;
  int? aprrover2;
  int? aprrover3;
  dynamic? specialPermission;
  int? theme;
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
  dynamic? waitingTime;
  dynamic? actualDistance;
  dynamic? actualDuration;
  dynamic? meetingTime;
  dynamic? intelligenceDistance;
  dynamic? intelligenceDuration;
  dynamic? claimDay;
  dynamic? claimMonth;
  dynamic? claimYear;

  Data(
      {this.crlId,
      this.compId,
      this.docNo,
      this.remarks,
      this.status,
      this.sum,
      this.approvedBy,
      this.approvedAt,
      this.createdAt,
      this.updatedAt,
      this.claimzReportId,
      this.empId,
      this.travelStartTime,
      this.travelStartDate,
      this.travelEndTime,
      this.travelEndDate,
      this.meetingStartTime,
      this.meetingStartDate,
      this.meetingEndTime,
      this.meetingEndDate,
      this.travelStartLocation,
      this.travelEndLocation,
      this.meetingStartLocation,
      this.meetingEndLocation,
      this.tStartOriginAddress,
      this.tEndOriginAddress,
      this.amount,
      this.approvalStatus,
      this.suggestedDistance,
      this.suggestedDuration,
      this.suggestedDestinationLocation,
      this.suggestedDestinationAddress,
      this.purpose,
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
      this.weekoff,
      this.waitingTime,
      this.actualDistance,
      this.actualDuration,
      this.meetingTime,
      this.intelligenceDistance,
      this.intelligenceDuration,
      this.claimDay,
      this.claimMonth,
      this.claimYear});

  Data.fromJson(Map<String, dynamic> json) {
    crlId = json['crl_id'];
    compId = json['comp_id'];
    docNo = json['doc_no'];
    remarks = json['remarks'];
    status = json['status'];
    sum = json['sum'];
    approvedBy = json['approved_by'];
    approvedAt = json['approved_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    claimzReportId = json['claimz_report_id'];
    empId = json['emp_id'];
    travelStartTime = json['travel_start_time'];
    travelStartDate = json['travel_start_date'];
    travelEndTime = json['travel_end_time'];
    travelEndDate = json['travel_end_date'];
    meetingStartTime = json['meeting_start_time'];
    meetingStartDate = json['meeting_start_date'];
    meetingEndTime = json['meeting_end_time'];
    meetingEndDate = json['meeting_end_date'];
    travelStartLocation = json['travel_start_location'];
    travelEndLocation = json['travel_end_location'];
    meetingStartLocation = json['meeting_start_location'];
    meetingEndLocation = json['meeting_end_location'];
    tStartOriginAddress = json['t_start_origin_address'];
    tEndOriginAddress = json['t_end_origin_address'];
    amount = json['amount'];
    approvalStatus = json['approval_status'];
    suggestedDistance = json['suggested_distance'];
    suggestedDuration = json['suggested_duration'];
    suggestedDestinationLocation = json['suggested_destination_location'];
    suggestedDestinationAddress = json['suggested_destination_address'];
    purpose = json['purpose'];
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
    waitingTime = json['waiting_time'];
    actualDistance = json['actual_distance'];
    actualDuration = json['actual_duration'];
    meetingTime = json['meeting_time'];
    intelligenceDistance = json['intelligence_distance'];
    intelligenceDuration = json['intelligence_duration'];
    claimDay = json['claim_day'];
    claimMonth = json['claim_month'];
    claimYear = json['claim_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crl_id'] = this.crlId;
    data['comp_id'] = this.compId;
    data['doc_no'] = this.docNo;
    data['remarks'] = this.remarks;
    data['status'] = this.status;
    data['sum'] = this.sum;
    data['approved_by'] = this.approvedBy;
    data['approved_at'] = this.approvedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['claimz_report_id'] = this.claimzReportId;
    data['emp_id'] = this.empId;
    data['travel_start_time'] = this.travelStartTime;
    data['travel_start_date'] = this.travelStartDate;
    data['travel_end_time'] = this.travelEndTime;
    data['travel_end_date'] = this.travelEndDate;
    data['meeting_start_time'] = this.meetingStartTime;
    data['meeting_start_date'] = this.meetingStartDate;
    data['meeting_end_time'] = this.meetingEndTime;
    data['meeting_end_date'] = this.meetingEndDate;
    data['travel_start_location'] = this.travelStartLocation;
    data['travel_end_location'] = this.travelEndLocation;
    data['meeting_start_location'] = this.meetingStartLocation;
    data['meeting_end_location'] = this.meetingEndLocation;
    data['t_start_origin_address'] = this.tStartOriginAddress;
    data['t_end_origin_address'] = this.tEndOriginAddress;
    data['amount'] = this.amount;
    data['approval_status'] = this.approvalStatus;
    data['suggested_distance'] = this.suggestedDistance;
    data['suggested_duration'] = this.suggestedDuration;
    data['suggested_destination_location'] = this.suggestedDestinationLocation;
    data['suggested_destination_address'] = this.suggestedDestinationAddress;
    data['purpose'] = this.purpose;
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
    data['waiting_time'] = this.waitingTime;
    data['actual_distance'] = this.actualDistance;
    data['actual_duration'] = this.actualDuration;
    data['meeting_time'] = this.meetingTime;
    data['intelligence_distance'] = this.intelligenceDistance;
    data['intelligence_duration'] = this.intelligenceDuration;
    data['claim_day'] = this.claimDay;
    data['claim_month'] = this.claimMonth;
    data['claim_year'] = this.claimYear;
    return data;
  }
}
