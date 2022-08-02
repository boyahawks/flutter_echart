
import 'dart:convert';

class MobilItemModel {
  String? name;
  bool? status;

  MobilItemModel({this.name, this.status});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'status': status
    };
  }
  factory MobilItemModel.fromMap(Map<String, dynamic> map) {
    return MobilItemModel(
      name: map['name'],
      status: map['status'],
    );
  }
  String toJson() => json.encode(toMap());

}
