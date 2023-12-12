class DataModel {
  int? id;
  late String Name;
  late String Date;
  late String Description;

  DataModel(
      {required this.Name,
      required this.Date,
      required this.Description,
      required this.id});

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
      Name: json['Name'],
      Date: json['Date'],
      Description: json['Description'],
      id: json['id']);
  Map<String, dynamic> toMap() =>
      {"Name": Name, 'Date': Date, "Description": Description, "id": id};
}
