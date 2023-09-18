class AppUrl {
  static var baseUrl = 'https://console.claimz.in/api'; //LIVE LINK
  // static var baseUrl = 'http://consoledev.claimz.in/api'; //TEST LINK

  static var iosDashboard = '$baseUrl/api/ios-dashboard';
  static var iosBirthday = '$baseUrl/api/ios-birthday';
  static var iosHoliday = '$baseUrl/api/ios-holidays';
  static var iosAttendance = '$baseUrl/api/ios-attendance';
  static var iosAnnouncement = '$baseUrl/api/ios-announcement';
  static var iosCompoff = '$baseUrl/api/ios-compoff';
  static var iosClaimApproval = '$baseUrl/api/ios-claim-approval';

  static var finalSubmit = '$baseUrl/api/declaration-final-submit';
  static var getCTC = '$baseUrl/api/user-ctc';
  static var userDeclaration = '$baseUrl/api/user-declaration';
  static var save = '$baseUrl/api/declaration-submit';
  static var allgroupTDS = '$baseUrl/api/all-group';
  static var tdsGroupDetails = '$baseUrl/api/all-type';
  static var allDeclarationRule = '$baseUrl/api/all-declaration-rule';
  static var verificationDetails = '$baseUrl/api/verification-details';
  static var createAccount = '$baseUrl/api/create-account';
  static var documentsUpload = '$baseUrl/api/post-details';
  static var loginUrl = '$baseUrl/api/login';
  static var logOut = '$baseUrl/api/logout';
  static var dashBoard = '$baseUrl/api/dashboard';
  static var profileDetails = '$baseUrl/api/userdetails/';
  static var changePassword = '$baseUrl/api/change-password';
  static var toDoList = '$baseUrl/api/task';
  static var toDoListStatus = '$baseUrl/api/task-status';
  static var addToDoList = '$baseUrl/api/task-post';
  static var editToDoList = '$baseUrl/api/task-edit';
  static var deleteToDoList = '$baseUrl/api/task-delete/';
  static var attendanceReport = '$baseUrl/api/attendance';
  static var leaveRequest = '$baseUrl/api/apply-leave';
  static var remainingLeaves = '$baseUrl/api/leave-balance';
  static var leaveList = '$baseUrl/api/leave-list';
  static var checkInOut = '$baseUrl/api/attendance/save';
  static var checkOut = '$baseUrl/api/attendance/checkout';
  static var regularizationAdd = '$baseUrl/api/add_regularization';
  static var claimz_form = '$baseUrl/api/claimz-form'; //with id
  static var claimz_submit = '$baseUrl/api/claimz-submit'; //with id
  static var checkin_claimz_meeting = '$baseUrl/api/meeting-checkin';
  static var checkout_claimz = '$baseUrl/api/claimz-checkout';
  static var checkin_claimz = '$baseUrl/api/claimz-checkin';
  static var claimz_list = '$baseUrl/api/claim-list';
  static var compOffAdd = '$baseUrl/api/add-compoff';
  static var payslipDetails = '$baseUrl/api/view-payslip';
  static var downloadPayslip = '$baseUrl/api/download-pdf/';
  static var claimz_page_data = '$baseUrl/api/claim-view';
  static var claimz_checkout = '$baseUrl/api/claimz-checkout';
  static var allAnouncements = '$baseUrl/api/all_announcements';
  static var viewRegularizationManager =
      '$baseUrl/api/view_regularization_request';
  static var postRegularizationManager = '$baseUrl/api/approve-regularization/';
  static var postRejectRegularizationManager =
      '$baseUrl/api/reject-regularization/';
  static var viewLeaveManager = '$baseUrl/api/approve-leave-list';
  static var leaveManager = '$baseUrl/api/approve-leave';
  static var claimz_execute = '$baseUrl/api/claimz-execute';
  static var viewCompOffManager =
      '$baseUrl/api/compoff-approve-list'; //Used This For CompOff
  static var viewUserCompOff = '$baseUrl/api/user-compoff-list';

  static var compOffManager = '$baseUrl/api/compoff-list-accept/';
  static var lateCheckinList = '$baseUrl/api/attendance/late-requests';
  static var lateCheckinApproval = '$baseUrl/api/attendance/late-approval/';
  static var estimatedistance =
      'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial';
  static var APIKEY = 'AIzaSyDJJ7rw4YTPHxvD1KuReHoQ-ja2VT3Sp18';
  static var managerDepartment = '$baseUrl/api/my-department';
  static var onSite = '$baseUrl/api/onsite-enable';
  static var offSite = '$baseUrl/api/offsite-enable';
  static var claimz_form_submit = '$baseUrl/api/claimz-form-submit';
  static var claimzFormLimit = '$baseUrl/api/claimz-form-view';
  static var allHoliday = '$baseUrl/api/holidays';
  static var organisation = '$baseUrl/api/organization';
  static var uploadPhoto = '$baseUrl/api/profile-photo';
  static var userSearch = '$baseUrl/api/search-user';
  static var claimzapproval = '$baseUrl/api/claimz-approve';
  static var forgotPassword = '$baseUrl/api/password/reset';
  static var verifyOtp = '$baseUrl/api/verify-otp';
  static var resetPassword = '$baseUrl/api/reset-password';
  static var getUserIncidental = '$baseUrl/api/incidental-list';
  static var claimz_incidental_submit = '$baseUrl/api/incidental-form';
  static var incidentalFinalSubmit = '$baseUrl/api/incidental-final-submit';
  static var claimzIncidentalApprove = '$baseUrl/api/incidental-approve';
  static var editIncidentalClaim = '$baseUrl/api/incidental-partial';
  static var claimz_post_location = '$baseUrl/api/location-record';
  static var claimz_check_in_range = '$baseUrl/api/check-claim-range';
  static var travel_itinerary = '$baseUrl/api/travel-itinerary';
  static var allDeptartment = '$baseUrl/api/all_department';
  static var postAnnouncement = '$baseUrl/api/announcement';
  static var travel_form_submit = '$baseUrl/api/travel-form-submit';
  static var travel_list_date = '$baseUrl/api/travel-list-date';
  static var travel_list_doc = '$baseUrl/api/travel-list-doc';
  static var reportingTree = '$baseUrl/api/reporting-tree/';
  static var incidentalUpdate = '$baseUrl/api/incidental-partial';
  static var applyCompOff = '$baseUrl/api/apply-compoff';
  static var viewAllRegularisations = '$baseUrl/api/regularization-list';
  static var compOffApprove = '$baseUrl/api/comoff-list-accept';
  static var compOffReject = '$baseUrl/api/comoff-list-reject/';
  static var travel_purpose = '$baseUrl/api/travel-meeting-details';
  static var travel_getdocdetails = '$baseUrl/api/travel-list-doc';
  static var travel_final_submit = '$baseUrl/api/travel-final-submit';
  static var travel_approval = '$baseUrl/api/travel-approve';
  static var travel_approval_partial = '$baseUrl/api/partial-payment';
  static var employeeRecord = '$baseUrl/api/employee-report';
  static var conveyanceAsDraft = '$baseUrl/api/claimz-form-submit';
  static var conveyanceManagerEdit = '$baseUrl/api/conveyence-partial';
  static var conveyanceAction = '$baseUrl/api/conveyence-approve';
  static var claimzFormView = '$baseUrl/api/claimz-form-view';
  static var claimzFinalSubmit = '$baseUrl/api/claimz-final-submit';
  static var travel_claim_approvalLog = '$baseUrl/api/travel-approval-log';
  static var travel_claim_listlog = '$baseUrl/api/approved-travel';
  static var conveynance_claim_listlog = '$baseUrl/api/approved-conveyence';
  static var incidental_claim_listlog = '$baseUrl/api/approved-incidental';
  static var compOffManagerView = '$baseUrl/api/apply-compoff-list';
  static var compOffManagerApprove =
      '$baseUrl/api/apply-compoff-approve'; //For Managers To Approve Compoff Leaves
  static var compOffManagerReject = '$baseUrl/api/comoff-list-reject/';
  static var all_claim = '$baseUrl/api/all-claimz';
  static var employeeLocation = '$baseUrl/api/all-location';
  static var assignTask = '$baseUrl/api/task-post';
  static var notificationList = '$baseUrl/api/notification-list';
  static var eventList = '$baseUrl/api/event-list';
  static var allAttendanceReport = '$baseUrl/api/all-employee-attendance';
  static var allLeaveReport = '$baseUrl/api/leave-report';
  static var manualConveyance = '$baseUrl/api/manual-conveyence';
  static var breakIn = '$baseUrl/api/break-in';
  static var breakOut = '$baseUrl/api/break-out';
  static var holidays = '$baseUrl/api/holidays';
  static var userHolidays = '$baseUrl/api/user-holidays';
  static var userHolidaysPost = '$baseUrl/api/user-holidays-post';
  static var birthdayWish = '$baseUrl/api/birthday-comment';
  static var birthdayComment = '$baseUrl/api/birthday-comment-read';
  static var leaveReason = '$baseUrl/api/leave-reason';
  static var editReason = '$baseUrl/api/edit-pending-leave';

  /////////////////////////////// Sales Oder ///////////////////
  // static var salesBaseUrl = 'http://devalpha.vitwo.ai/api/v2/salesperson';  //Test Link

  static var salesBaseUrl =
      'https://one.vitwo.ai/api/v2/salesperson'; //Live Link

  static var customerSales = '$salesBaseUrl/customers_fetch.php';
  static var fetchGoodItems = '$salesBaseUrl/item_goods_fetch.php';
  static var fetchServiceItems = '$salesBaseUrl/item_service_fetch.php';
  static var fetchBothItems = '$salesBaseUrl/item_both_fetch.php';
  static var fetchItemDetails = '$salesBaseUrl/item_details_fetch.php';
  static var fetchCustomers = '$salesBaseUrl/fetch_customers.php';
  static var fetchCustomerAddressDetails =
      '$salesBaseUrl/customer_address_details_fetch.php';
  static var fetchCustomerAddress = '$salesBaseUrl/customer_address_fetch.php';
  static var addCustomerAddress = '$salesBaseUrl/customer_address_add.php';
  static var addSalesOrder = '$salesBaseUrl/salesorder_add.php';
  static var fetchKam = '$salesBaseUrl/sales_person_fetch.php';
  static var fetchCustomerDetails = '$salesBaseUrl/customer_details_fetch.php';
  static var funcationalAreaApi = '$salesBaseUrl/functional_area_fetch.php';
  static var invoiceTypeApi = '$salesBaseUrl/compliance_invoice_type.php';
  static var salesList = '$salesBaseUrl/salesorder_list.php';
  static var kamIdCheck = '$salesBaseUrl/otpsend.php';
  static var otpValidate = '$salesBaseUrl/login.php';
  static var companyLocationApi =
      '$salesBaseUrl/company_all_location_fetch.php';
}
