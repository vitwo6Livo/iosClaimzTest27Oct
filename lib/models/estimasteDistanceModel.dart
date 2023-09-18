class estimateDistanceModel {
  String? destination;
  String? time;
  String? distance;

  estimateDistanceModel({this.destination, this.time, this.distance});

  estimateDistanceModel.fromJson(Map<String, dynamic> json) {
    destination = json['destination'];
    time = json['time'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destination'] = this.destination;
    data['time'] = this.time;
    data['distance'] = this.distance;
    return data;
  }
}
