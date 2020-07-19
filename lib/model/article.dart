import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:hn_app/model/serializers.dart';

part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  int get id;

  @nullable
  bool get deleted;

  String get type;

  String get by;

  int get time;

  @nullable
  String get text;

  @nullable
  bool get dead;

  @nullable
  int get parent;

  @nullable
  int get poll;

  BuiltList<int> get kids;

  @nullable
  String get url;

  @nullable
  int get score;

  @nullable
  String get title;

  BuiltList<int> get parts;

  @nullable
  int get descendants;

  Article._();

  factory Article([void Function(ArticleBuilder) updates]) = _$Article;

  static Serializer<Article> get serializer => _$articleSerializer;
}

List<int> parseTopStories(String jsonStr) {
  final parsed = jsonDecode(jsonStr);
  final listOfIds = List<int>.from(parsed);
  return listOfIds;
}

Article parseArticle(String jsonStr) {
  final parsed = jsonDecode(jsonStr);
  Article article =
      standardSerializers.deserializeWith(Article.serializer, parsed);
  return article;
}
