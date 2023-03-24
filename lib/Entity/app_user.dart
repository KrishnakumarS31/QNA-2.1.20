import 'dart:ui';

class AppUser {
  int id;
  String locale;

  AppUser({required this.id, required this.locale});

  factory AppUser.fromMap(Map<String, dynamic> data) =>
      AppUser(id: data["id"], locale: data["locale"]);

  Map<String, dynamic> toMap() => {"id": id, "locale": locale};

  @override
  String toString() {
    return 'AppUser{id: $id,locale:$locale}';
  }
}
