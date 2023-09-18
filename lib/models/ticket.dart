class Ticket {
  final String id;
  final String title;
  final String description;
  final int status;
  final String? priority;
  final String? createDate;
  final String? createdDate;
  final String? doneDate;
  final String? ongoingDate;

  Ticket({
    this.createDate,
    this.createdDate,
    required this.description,
    this.doneDate,
    required this.id,
    this.ongoingDate,
    this.priority,
    required this.status,
    required this.title,
  });
}
