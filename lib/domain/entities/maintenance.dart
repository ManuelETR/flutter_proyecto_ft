class Maintenance{
  final int id;
  final int installationId;
  DateTime? scheduleDate;
  DateTime? completionDate;
  String? notes;

  Maintenance({
    required this.id, 
    required this.installationId, 
    this.scheduleDate,
    this.completionDate,
    this.notes
    });
  
}