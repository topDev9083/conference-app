import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import '../serializers.dart';

part 'document_data.g.dart';

abstract class DocumentData
    implements Built<DocumentData, DocumentDataBuilder> {
  factory DocumentData([final void Function(DocumentDataBuilder) updates]) =
      _$DocumentData;

  DocumentData._();

  static Serializer<DocumentData> get serializer => _$documentDataSerializer;

  static void _initializeBuilder(final DocumentDataBuilder b) => b;

  int get id;

  String get updatedOn;

  String get createdOn;

  String get name;

  String? get file;

  int? get parentId;

  // custom fields
  DocumentData? get parent;

  static DocumentData fromDynamic(final dynamic json) {
    return serializers.deserializeWith(DocumentData.serializer, json)!;
  }
}
