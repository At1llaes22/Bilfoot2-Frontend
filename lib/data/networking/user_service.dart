import 'dart:convert';

import 'package:bilfoot/data/models/notification_model.dart';
import 'package:bilfoot/data/models/player_model.dart';
import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';

class UserService {
  static void test() {}

  static Future<bool> registerUser({
    required String email,
    required List<String> specialSkills,
    required List<String> preferredPositions,
    required List<String> dominantFeet,
    required String firebaseId,
  }) async {
    try {
      var response = await BilfootClient()
          .dio
          .post("${BilfootClient.baseUrl}auth/register-user", data: {
        "email": email,
        "special_skills": specialSkills,
        "preferred_positions": preferredPositions,
        "dominant_feet": dominantFeet,
        "firebase_id": firebaseId
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

  static Future<PlayerModel?> getHomeData() async {
    try {
      var response = await BilfootClient()
          .dio
          .get("${BilfootClient.baseUrl}player/get-home-data");

      if (response.statusCode == null) {
        //TODO
        print("null responde getHomeData");
        return null;
      }

      if (response.statusCode! >= 400) {
        //TODO
        print("error status getHomeData");

        return null;
      }

      print("getHomeData");
      print(response.data);
      if (response.data["player"] != null) {
        PlayerModel playerModel = PlayerModel.fromJson(response.data["player"]);
        Program.program.user = playerModel;
        return playerModel;
      }

      return null;
    } on DioError catch (e) {
      print(e.response?.data);
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> getUserNotifications() async {
    try {
      var response = await BilfootClient()
          .dio
          .get("${BilfootClient.baseUrl}player/get-player-notifications");

      if (response.statusCode == null) {
        //TODO
        print("null responde getHomeData");
        return false;
      }

      if (response.statusCode! >= 400) {
        //TODO
        print("error status getUserNotifications");

        return false;
      }

      print(response.data);
      if (response.data["notifications"] != null) {
        List<NotificationModel> notifications =
            (response.data["notifications"] as List<dynamic>)
                .map((e) => NotificationModel.fromJson(e))
                .toList();

        Program.program.notifications = notifications;
        return true;
      }

      return false;
    } on DioError catch (e) {
      print(e.response?.data);
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<List<PlayerModel>> searchPlayers(
      {required String value}) async {
    try {
      var response = await BilfootClient().dio.get(
            "${BilfootClient.baseUrl}search-players?value=$value",
          );

      if (response.statusCode == null) {
        return [];
      } else if (response.statusCode! >= 400) {
        return [];
      }

      print(response.data);
      if (response.data["players"] != null) {
        return List.from(response.data['players'])
            .map((e) => PlayerModel.fromJson(e))
            .toList();
      }

      return [];
    } on DioError catch (e) {
      print(e.response?.data);
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> answerToNotification({
    required String notificationId,
    required String answer,
  }) async {
    try {
      var response = await BilfootClient()
          .dio
          .post("${BilfootClient.baseUrl}player/answer-to-notification", data: {
        "notification_id": notificationId,
        "answer": answer,
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

  static Future<bool> updatePhoneNumber({required String phoneNumber}) async {
    try {
      var response = await BilfootClient().dio.post(
          "${BilfootClient.baseUrl}player/update-player-phone-number",
          data: {
            "phone_number": phoneNumber,
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

  static Future<String?> getPhoneNumber({required String userId}) async {
    try {
      var response = await BilfootClient().dio.get(
            "${BilfootClient.baseUrl}player/get-player-phone-number?user_id=$userId",
          );

      if (response.statusCode == null) {
        return null;
      } else if (response.statusCode! >= 400) {
        return null;
      }

      print(response.data);
      if (response.data["phone_number"] != null) {
        return response.data["phone_number"];
      }

      return null;
    } on DioError catch (e) {
      print(e.response?.data);
      return null;
    } catch (e) {
      return null;
    }
  }
}
