import 'package:hive/hive.dart';

// Essa linha avisa que uma parte desse código será gerada automaticamente
part 'user_profile.g.dart'; 

@HiveType(typeId: 0) // typeId deve ser único para cada modelo no app 
class UserProfile extends HiveObject {
  @HiveField(0) // 
  String name;

  @HiveField(1) // 
  String email;

  @HiveField(2) // 
  DateTime registrationDate;

  @HiveField(3) // 
  int score;

  UserProfile({
    required this.name,
    required this.email,
    required this.registrationDate,
    required this.score,
  });
}