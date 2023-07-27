import 'package:hive/hive.dart';
part 'word_model.g.dart';
@HiveType(typeId: 1)
class WordModel {
  @HiveField(0)
  String english;

  @HiveField(1)
  String turkish;

  WordModel(this.english, this.turkish);
}
