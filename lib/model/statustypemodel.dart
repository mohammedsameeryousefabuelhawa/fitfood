class statusTypemodel {
  String Id;
  String Name;

  statusTypemodel({
    required this.Id,
    required this.Name,
  });

  factory statusTypemodel.fromJson(var json) {
    return statusTypemodel(
      Id: json['Id'],
      Name: json['Name'],
    );
  }
}
