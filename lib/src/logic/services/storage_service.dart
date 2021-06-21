import 'package:hive/hive.dart';

class StorageService {
  final String boxName;

  StorageService(this.boxName);

  void addFavorite(Map<String, dynamic> videoData) async {
    Box storage = await Hive.openBox(boxName);
    if (storage.isOpen) {
      List? favorites = await storage.get('fav');
      
      if (favorites == null) {
        List? tempVar = [];
        tempVar.add(videoData);
        await storage.put('fav', tempVar);
      } else {
        favorites.add(videoData);
        await storage.put('fav', favorites);
      }
    } else {
      return;
    }
  }

  Future<List?> getFavorite() async {
    Box storage = await Hive.openBox(boxName);
    if (storage.isOpen) {
      return await storage.get('fav');
    } else {
      return null;
    }
  }
}
