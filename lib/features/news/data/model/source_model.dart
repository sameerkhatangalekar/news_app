
import 'package:news_app/features/news/domain/entity/source_entity.dart';

final class SourceModel extends SourceEntity {
  SourceModel({super.id, required super.name});

  factory SourceModel.fromJson(Map<String, dynamic> map) =>
      SourceModel(id: map['id'], name: map['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};

  SourceModel copyWith({String? id, String? name}) =>
      SourceModel(name: name ?? this.name, id: id ?? this.id);
}