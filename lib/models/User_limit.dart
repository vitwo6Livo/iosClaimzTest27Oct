class User_limit {
  int? status;
  List<Travel>? travel;
  List<Food>? food;
  List<Incidental>? incidental;
  int? travelStatus;
  int? foodStatus;
  int? incidentalStatus;
  dynamic? travelData;
  dynamic? foodData;
  dynamic? incidentData;

  User_limit(
      {this.status,
      this.travel,
      this.food,
      this.incidental,
      this.travelStatus,
      this.foodStatus,
      this.incidentalStatus,
      this.travelData,
      this.foodData,
      this.incidentData});

  User_limit.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['travel'] != null) {
      travel = <Travel>[];
      json['travel'].forEach((v) {
        travel!.add(new Travel.fromJson(v));
      });
    }
    if (json['food'] != null) {
      food = <Food>[];
      json['food'].forEach((v) {
        food!.add(new Food.fromJson(v));
      });
    }
    if (json['incidental'] != null) {
      incidental = <Incidental>[];
      json['incidental'].forEach((v) {
        incidental!.add(new Incidental.fromJson(v));
      });
    }
    travelStatus = json['travel_status'];
    foodStatus = json['food_status'];
    incidentalStatus = json['incidental_status'];
    travelData = json['travel_data'] != null
        ? new TravelData.fromJson(json['travel_data'])
        : null;
    foodData = json['food_data'] != null
        ? new TravelData.fromJson(json['food_data'])
        : null;
    incidentData = json['incident_data'] != null
        ? new TravelData.fromJson(json['incident_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.travel != null) {
      data['travel'] = this.travel!.map((v) => v.toJson()).toList();
    }
    if (this.food != null) {
      data['food'] = this.food!.map((v) => v.toJson()).toList();
    }
    if (this.incidental != null) {
      data['incidental'] = this.incidental!.map((v) => v.toJson()).toList();
    }
    data['travel_status'] = this.travelStatus;
    data['food_status'] = this.foodStatus;
    data['incidental_status'] = this.incidentalStatus;
    if (this.travelData != null) {
      data['travel_data'] = this.travelData!.toJson();
    }
    if (this.foodData != null) {
      data['food_data'] = this.foodData!.toJson();
    }
    if (this.incidentData != null) {
      data['incident_data'] = this.incidentData!.toJson();
    }
    return data;
  }
}

class Travel {
  int? conveyanceId;
  String? componentName;
  int? limitPerKm;

  Travel({this.conveyanceId, this.componentName, this.limitPerKm});

  Travel.fromJson(Map<String, dynamic> json) {
    conveyanceId = json['conveyance_id'];
    componentName = json['component_name'];
    limitPerKm = json['limit_per_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conveyance_id'] = this.conveyanceId;
    data['component_name'] = this.componentName;
    data['limit_per_km'] = this.limitPerKm;
    return data;
  }
}

class Food {
  int? limit;

  Food({this.limit});

  Food.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    return data;
  }
}

class Incidental {
  int? limit;

  Incidental({this.limit});

  Incidental.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    return data;
  }
}

class TravelData {
  dynamic? claimzId;
  dynamic? claimNo;
  dynamic? docNo;
  dynamic? claimType;
  dynamic? date;
  dynamic? from;
  dynamic? to;
  dynamic? purpose;
  dynamic? serviceProvider;
  dynamic? gSTNo;
  dynamic? basicAmount;
  dynamic? gSTAmount;
  dynamic? totalAmount;
  dynamic? modeOfTravel;
  dynamic? distance;
  dynamic? status;
  dynamic? createdAt;
  dynamic? updatedAt;

  TravelData(
      {this.claimzId,
      this.claimNo,
      this.docNo,
      this.claimType,
      this.date,
      this.from,
      this.to,
      this.purpose,
      this.serviceProvider,
      this.gSTNo,
      this.basicAmount,
      this.gSTAmount,
      this.totalAmount,
      this.modeOfTravel,
      this.distance,
      this.status,
      this.createdAt,
      this.updatedAt});

  TravelData.fromJson(Map<String, dynamic> json) {
    claimzId = json['claimz_id'];
    claimNo = json['claim_no'];
    docNo = json['doc_no'];
    claimType = json['claim_type'];
    date = json['date'];
    from = json['from'];
    to = json['to'];
    purpose = json['purpose'];
    serviceProvider = json['service_provider'];
    gSTNo = json['GST_no'];
    basicAmount = json['basic_amount'];
    gSTAmount = json['GST_amount'];
    totalAmount = json['total_amount'];
    modeOfTravel = json['mode_of_travel'];
    distance = json['distance'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['claimz_id'] = this.claimzId;
    data['claim_no'] = this.claimNo;
    data['doc_no'] = this.docNo;
    data['claim_type'] = this.claimType;
    data['date'] = this.date;
    data['from'] = this.from;
    data['to'] = this.to;
    data['purpose'] = this.purpose;
    data['service_provider'] = this.serviceProvider;
    data['GST_no'] = this.gSTNo;
    data['basic_amount'] = this.basicAmount;
    data['GST_amount'] = this.gSTAmount;
    data['total_amount'] = this.totalAmount;
    data['mode_of_travel'] = this.modeOfTravel;
    data['distance'] = this.distance;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
