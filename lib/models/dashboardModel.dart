class Dashboard {
  Data? data;

  Dashboard({this.data});

  Dashboard.fromJson(Map<String, dynamic> json) {
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
  DashboardData? dashboardData;

  Data({this.dashboardData});

  Data.fromJson(Map<String, dynamic> json) {
    dashboardData = json['dashboard_data'] != null
        ? new DashboardData.fromJson(json['dashboard_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dashboardData != null) {
      data['dashboard_data'] = this.dashboardData!.toJson();
    }
    return data;
  }
}

class DashboardData {
  int? totalRequisition;
  int? approvedRequisition;
  int? travelDesk;
  int? finance;
  int? claimSubPending;
  int? totalClaim;
  int? approvedClaim;
  int? preAudit;
  int? processed;
  int? paid;
  String? statisticsLast7;
  String? statisticsLastMonth;
  String? statisticsLastYear;
  int? statisticsUpcoming7;
  int? statisticsUpcomingMonth;
  int? statisticsUpcomingYear;
  List<Birthdays>? birthdays;
  List<Holidays>? holidays;
  List<Announcements>? announcements;
  List<Attendance>? attendance;
  int? unreadAnnouncments;
  String? lat;
  String? lng;
  int? radius;
  List<Workstation>? workstation;

  DashboardData(
      {this.totalRequisition,
      this.approvedRequisition,
      this.travelDesk,
      this.finance,
      this.claimSubPending,
      this.totalClaim,
      this.approvedClaim,
      this.preAudit,
      this.processed,
      this.paid,
      this.statisticsLast7,
      this.statisticsLastMonth,
      this.statisticsLastYear,
      this.statisticsUpcoming7,
      this.statisticsUpcomingMonth,
      this.statisticsUpcomingYear,
      this.birthdays,
      this.holidays,
      this.announcements,
      this.attendance,
      this.unreadAnnouncments,
      this.lat,
      this.lng,
      this.radius,
      this.workstation});

  DashboardData.fromJson(Map<String, dynamic> json) {
    totalRequisition = json['total_requisition'];
    approvedRequisition = json['approved_requisition'];
    travelDesk = json['travel_desk'];
    finance = json['finance'];
    claimSubPending = json['claim_sub_pending'];
    totalClaim = json['total_claim'];
    approvedClaim = json['approved_claim'];
    preAudit = json['pre_audit'];
    processed = json['processed'];
    paid = json['paid'];
    statisticsLast7 = json['statistics_last_7'];
    statisticsLastMonth = json['statistics_last_month'];
    statisticsLastYear = json['statistics_last_year'];
    statisticsUpcoming7 = json['statistics_Upcoming_7'];
    statisticsUpcomingMonth = json['statistics_Upcoming_month'];
    statisticsUpcomingYear = json['statistics_Upcoming_year'];
    if (json['birthdays'] != null) {
      birthdays = <Birthdays>[];
      json['birthdays'].forEach((v) {
        birthdays!.add(new Birthdays.fromJson(v));
      });
    }
    if (json['holidays'] != null) {
      holidays = <Holidays>[];
      json['holidays'].forEach((v) {
        holidays!.add(new Holidays.fromJson(v));
      });
    }
    if (json['announcements'] != null) {
      announcements = <Announcements>[];
      json['announcements'].forEach((v) {
        announcements!.add(new Announcements.fromJson(v));
      });
    }
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(new Attendance.fromJson(v));
      });
    }
    unreadAnnouncments = json['unread_announcements'];
    lat = json['lat'];
    lng = json['lng'];
    radius = json['radius'];
    if (json['workstation'] != null) {
      workstation = <Workstation>[];
      json['workstation'].forEach((v) {
        workstation!.add(new Workstation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_requisition'] = this.totalRequisition;
    data['approved_requisition'] = this.approvedRequisition;
    data['travel_desk'] = this.travelDesk;
    data['finance'] = this.finance;
    data['claim_sub_pending'] = this.claimSubPending;
    data['total_claim'] = this.totalClaim;
    data['approved_claim'] = this.approvedClaim;
    data['pre_audit'] = this.preAudit;
    data['processed'] = this.processed;
    data['paid'] = this.paid;
    data['statistics_last_7'] = this.statisticsLast7;
    data['statistics_last_month'] = this.statisticsLastMonth;
    data['statistics_last_year'] = this.statisticsLastYear;
    data['statistics_Upcoming_7'] = this.statisticsUpcoming7;
    data['statistics_Upcoming_month'] = this.statisticsUpcomingMonth;
    data['statistics_Upcoming_year'] = this.statisticsUpcomingYear;
    if (this.birthdays != null) {
      data['birthdays'] = this.birthdays!.map((v) => v.toJson()).toList();
    }
    if (this.holidays != null) {
      data['holidays'] = this.holidays!.map((v) => v.toJson()).toList();
    }
    if (this.announcements != null) {
      data['announcements'] =
          this.announcements!.map((v) => v.toJson()).toList();
    }
    if (this.attendance != null) {
      data['attendance'] = this.attendance!.map((v) => v.toJson()).toList();
    }
    data['unread_announcements'] = this.unreadAnnouncments;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['radius'] = this.radius;
    if (this.workstation != null) {
      data['workstation'] = this.workstation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Birthdays {
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
  String? leaveDate;
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
  String? createdAt;
  String? updatedAt;
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
  dynamic? profilePhoto;
  dynamic? pAddressTemp;
  dynamic? presentAddressTemp;
  dynamic? mobileNoTemp;
  dynamic? contactNoTemp;
  dynamic? altEmailTemp;
  dynamic? profilePhotoTemp;
  dynamic? deviceId;
  dynamic? deviceType;

  Birthdays(
      {this.id,
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
      this.createdAt,
      this.updatedAt,
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
      this.deviceType});

  Birthdays.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    return data;
  }
}

class HolidayModel {
  List<Holidays>? holidays;

  HolidayModel({this.holidays});

  HolidayModel.fromJson(Map<String, dynamic> json) {
    if (json['holidays'] != null) {
      holidays = <Holidays>[];
      json['holidays'].forEach((v) {
        holidays!.add(new Holidays.fromJson(v));
      });
    }
  }
}

class Holidays {
  int? holidayId;
  String? holiday;
  String? holidayDate;
  dynamic? createdAt;
  dynamic? updatedAt;

  Holidays(
      {this.holidayId,
      this.holiday,
      this.holidayDate,
      this.createdAt,
      this.updatedAt});

  Holidays.fromJson(Map<String, dynamic> json) {
    holidayId = json['holiday_id'];
    holiday = json['holiday'];
    holidayDate = json['holiday_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holiday_id'] = this.holidayId;
    data['holiday'] = this.holiday;
    data['holiday_date'] = this.holidayDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AnnouncementModel {
  List<Announcements>? announcements;

  AnnouncementModel({this.announcements});

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    if (json['announcements'] != null) {
      announcements = <Announcements>[];
      json['announcements'].forEach((v) {
        announcements!.add(new Announcements.fromJson(v));
      });
    }
  }
}

class Announcements {
  // int? announcementId;
  String? announcement;
  String? empName;
  dynamic profilePhoto;

  Announcements(
      {
      // this.announcementId,
      this.announcement,
      this.empName,
      // this.createdAt,
      this.profilePhoto});

  Announcements.fromJson(Map<String, dynamic> json) {
    // empName = json['emp_name'];
    // announcement = json['announcement'];
    // createdAt = json['created_at'];
    // announcementId = json['announcement_id'];
    announcement = json['announcement'];
    empName = json['emp_name'];
    profilePhoto = json['profile_photo'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['announcement_id'] = this.announcementId;
    data['announcement'] = this.announcement;
    data['emp_name'] = this.empName;
    data['profile_photo'] = this.profilePhoto;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AttendanceModel {
  List<Attendance>? attendance;

  AttendanceModel({this.attendance});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(new Attendance.fromJson(v));
      });
    }
  }
}

class Attendance {
  User? user;
  String? status;

  Attendance({this.user, this.status});

  Attendance.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class User {
  String? empName;
  String? profilePhoto;
  int? id;
  String? departmentName;

  User({this.empName, this.profilePhoto, this.id});

  User.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    profilePhoto = json['profile_photo'];
    id = json['id'];
    departmentName = json['department_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['profile_photo'] = this.profilePhoto;
    data['id'] = this.id;
    data['department_name'] = this.departmentName;
    return data;
  }
}

class WorkstationModel {
  List<Workstation>? workstation;

  WorkstationModel({this.workstation});

  WorkstationModel.fromJson(Map<String, dynamic> json) {
    if (json['workstation'] != null) {
      workstation = <Workstation>[];
      json['workstation'].forEach((v) {
        workstation!.add(new Workstation.fromJson(v));
      });
    }
  }
}

class Workstation {
  int? office;
  int? onsite;
  int? offsite;

  Workstation({this.office, this.onsite, this.offsite});

  Workstation.fromJson(Map<String, dynamic> json) {
    office = json['office'];
    onsite = json['onsite'];
    offsite = json['offsite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['office'] = this.office;
    data['onsite'] = this.onsite;
    data['offsite'] = this.offsite;
    return data;
  }
}

// class AttendanceModel {
//   List<Attendance>? attendance;

//   AttendanceModel({this.attendance});

//   AttendanceModel.fromJson(Map<String, dynamic> json) {
//     if (json['attendance'] != null) {
//       attendance = <Attendance>[];
//       json['attendance'].forEach((v) {
//         attendance!.add(new Attendance.fromJson(v));
//       });
//     }
//   }
// }

// class Attendance {
//   String? empName;
//   int? departmentId;
//   String? profilePhoto;

//   Attendance({this.empName, this.departmentId, this.profilePhoto});

//   Attendance.fromJson(Map<String, dynamic> json) {
//     empName = json['emp_name'];
//     departmentId = json['department_id'];
//     profilePhoto = json['profile_photo'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['emp_name'] = this.empName;
//     data['department_id'] = this.departmentId;
//     data['profile_photo'] = this.profilePhoto;
//     return data;
//   }
// }
