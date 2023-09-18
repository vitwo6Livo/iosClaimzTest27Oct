// class LeaveTypes {
//   int? status;
//   List<Data>? data;

//   LeaveTypes({this.status, this.data});

//   LeaveTypes.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   String? leaveTypes;
//   int? number;

//   Data({this.leaveTypes, this.number});

//   Data.fromJson(Map<String, dynamic> json) {
//     leaveTypes = json['leave_types'];
//     number = json['number'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['leave_types'] = this.leaveTypes;
//     data['number'] = this.number;
//     return data;
//   }
// }
