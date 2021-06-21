import 'package:video_feed/src/logic/models/video_model.dart';
import 'package:video_feed/src/logic/services/storage_service.dart';

class StorageRepo {
  StorageService storageService;
  StorageRepo({
    required this.storageService,
  });

  addFav(VideoModel videoModel) {
    storageService.addFavorite(videoModel.toMap());
  }

  Future<List<VideoModel>?>? getFav() async {
    List? videos = await storageService.getFavorite();
    if(videos == null){
      return null;
    }else{
      return videos.map((video) => VideoModel.fromMap(video!.cast<String, dynamic>())).toList();
    }
    
  }
}
