import 'package:dio/dio.dart';
import 'package:video_feed/src/logic/services/api_service.dart';

class APIRepository {
  final APIService _apiService;

  APIRepository(this._apiService);

  Future<Map<String, dynamic>> getVideos(
      {required int length, required int offset}) async {
    Response response = await _apiService
        .getVideos('/sample_videos?limit=$length&offset=$offset');
    return response.data;
  }
}
