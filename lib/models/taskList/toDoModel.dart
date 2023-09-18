class ToDoModel {
  int? status;
  List<Today>? today;
  List<Previous>? previous;
  List<Upcoming>? upcoming;
  List<Completed>? completed;

  ToDoModel(
      {this.status, this.today, this.previous, this.upcoming, this.completed});

  ToDoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['today'] != null) {
      today = <Today>[];
      json['today'].forEach((v) {
        today!.add(new Today.fromJson(v));
      });
    }
    if (json['previous'] != null) {
      previous = <Previous>[];
      json['previous'].forEach((v) {
        previous!.add(new Previous.fromJson(v));
      });
    }
    if (json['upcoming'] != null) {
      upcoming = <Upcoming>[];
      json['upcoming'].forEach((v) {
        upcoming!.add(new Upcoming.fromJson(v));
      });
    }
    if (json['completed'] != null) {
      completed = <Completed>[];
      json['completed'].forEach((v) {
        completed!.add(new Completed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.today != null) {
      data['today'] = this.today!.map((v) => v.toJson()).toList();
    }
    if (this.previous != null) {
      data['previous'] = this.previous!.map((v) => v.toJson()).toList();
    }
    if (this.upcoming != null) {
      data['upcoming'] = this.upcoming!.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
      data['completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TodayModel {
  List<Today>? today;

  TodayModel({this.today});

  TodayModel.fromJson(Map<String, dynamic> json) {
    if (json['today'] != null) {
      today = <Today>[];
      json['today'].forEach((v) {
        today!.add(new Today.fromJson(v));
      });
    }
  }
}

class Today {
  int? taskId;
  String? taskName;
  String? taskDate;
  int? taskStatus;
  int? taskOwner;
  String? createdAt;
  String? updatedAt;

  Today(
      {this.taskId,
      this.taskName,
      this.taskDate,
      this.taskStatus,
      this.taskOwner,
      this.createdAt,
      this.updatedAt});

  Today.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskName = json['task_name'];
    taskDate = json['task_date'];
    taskStatus = json['task_status'];
    taskOwner = json['task_owner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['task_name'] = this.taskName;
    data['task_date'] = this.taskDate;
    data['task_status'] = this.taskStatus;
    data['task_owner'] = this.taskOwner;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PreviousModel {
  List<Previous>? today;

  PreviousModel({this.today});

  PreviousModel.fromJson(Map<String, dynamic> json) {
    if (json['previous'] != null) {
      today = <Previous>[];
      json['previous'].forEach((v) {
        today!.add(new Previous.fromJson(v));
      });
    }
  }
}

class Previous {
  int? taskId;
  String? taskName;
  String? taskDate;
  int? taskStatus;
  int? taskOwner;
  String? createdAt;
  String? updatedAt;

  Previous(
      {this.taskId,
      this.taskName,
      this.taskDate,
      this.taskStatus,
      this.taskOwner,
      this.createdAt,
      this.updatedAt});

  Previous.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskName = json['task_name'];
    taskDate = json['task_date'];
    taskStatus = json['task_status'];
    taskOwner = json['task_owner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['task_name'] = this.taskName;
    data['task_date'] = this.taskDate;
    data['task_status'] = this.taskStatus;
    data['task_owner'] = this.taskOwner;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UpcomingModel {
  List<Upcoming>? today;

  UpcomingModel({this.today});

  UpcomingModel.fromJson(Map<String, dynamic> json) {
    if (json['upcoming'] != null) {
      today = <Upcoming>[];
      json['upcoming'].forEach((v) {
        today!.add(new Upcoming.fromJson(v));
      });
    }
  }
}

class Upcoming {
  int? taskId;
  String? taskName;
  String? taskDate;
  int? taskStatus;
  int? taskOwner;
  String? createdAt;
  String? updatedAt;

  Upcoming(
      {this.taskId,
      this.taskName,
      this.taskDate,
      this.taskStatus,
      this.taskOwner,
      this.createdAt,
      this.updatedAt});

  Upcoming.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskName = json['task_name'];
    taskDate = json['task_date'];
    taskStatus = json['task_status'];
    taskOwner = json['task_owner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['task_name'] = this.taskName;
    data['task_date'] = this.taskDate;
    data['task_status'] = this.taskStatus;
    data['task_owner'] = this.taskOwner;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CompletedModel {
  List<Completed>? today;

  CompletedModel({this.today});

  CompletedModel.fromJson(Map<String, dynamic> json) {
    if (json['completed'] != null) {
      today = <Completed>[];
      json['completed'].forEach((v) {
        today!.add(new Completed.fromJson(v));
      });
    }
  }
}

class Completed {
  int? taskId;
  String? taskName;
  String? taskDate;
  int? taskStatus;
  int? taskOwner;
  String? createdAt;
  String? updatedAt;

  Completed(
      {this.taskId,
      this.taskName,
      this.taskDate,
      this.taskStatus,
      this.taskOwner,
      this.createdAt,
      this.updatedAt});

  Completed.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    taskName = json['task_name'];
    taskDate = json['task_date'];
    taskStatus = json['task_status'];
    taskOwner = json['task_owner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['task_name'] = this.taskName;
    data['task_date'] = this.taskDate;
    data['task_status'] = this.taskStatus;
    data['task_owner'] = this.taskOwner;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
