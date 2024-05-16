import 'package:json_annotation/json_annotation.dart';
part 'work_time_model.g.dart';

@JsonSerializable()
class WorkTimeModel {
  String? id;
  String? rounds;
  String? longRestTime;
   String? shortRestTime;
  String? workTime;

  WorkTimeModel({this.rounds, this.longRestTime,
   this.workTime, this.id, this.shortRestTime});

  factory WorkTimeModel.fromJson(Map<String, dynamic> json) =>
      _$WorkTimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$WorkTimeModelToJson(this);
}
