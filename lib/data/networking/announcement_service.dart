import 'dart:convert';

import 'package:bilfoot/data/models/announcements/opponent_announcement_model.dart';
import 'package:bilfoot/data/models/announcements/player_announcement_model.dart';
import 'package:dio/dio.dart';

import 'client.dart';

class AnnouncementService {
  static void test() {}

  static Future<Map<String, List>?> getAnnouncements() async {
    try {
      var response = await BilfootClient().dio.post(
          "${BilfootClient.baseUrl}announcement/get-announcements",
          data: {});

      if (response.statusCode == null) {
        return null;
      } else if (response.statusCode! >= 400) {
        return null;
      }

      print(response.data);

      Map<String, List> returnValue = {"player_announcements": []};
      if (response.data["player_announcements"] != null) {
        returnValue["player_announcements"] =
            (response.data["player_announcements"] as List<dynamic>)
                .map((e) => PlayerAnnouncementModel.fromJson(e))
                .toList();
      }

      if (response.data["opponent_announcements"] != null) {
        returnValue["opponent_announcements"] =
            (response.data["opponent_announcements"] as List<dynamic>)
                .map((e) => OpponentAnnouncementModel.fromJson(e))
                .toList();
      }
      return returnValue;
    } on DioError catch (e) {
      print(e.response?.data);
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> sendPlayerAnnouncementJoinRequest(
      String announcementId) async {
    try {
      var response = await BilfootClient().dio.post(
          "${BilfootClient.baseUrl}announcement/player-announcement-join-request",
          data: {
            "announcement_id": announcementId,
          });

      if (response.statusCode == null) {
        return false;
      } else if (response.statusCode! >= 400) {
        return false;
      }

      print(response.data);

      return true;
    } on DioError catch (e) {
      print(e.response?.data);
      return false;
    } catch (e) {
      return false;
    }
  }
}
