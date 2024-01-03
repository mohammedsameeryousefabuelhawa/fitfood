class orderstatusmodel {
  String Id;
  String Name;
  bool selected = false;

  orderstatusmodel({
    required this.Id,
    required this.Name,
  });

  factory orderstatusmodel.fromJson(var json) {
    return orderstatusmodel(
      Id: json['Id'],
      Name: json['Name'],
    );
  }
}
