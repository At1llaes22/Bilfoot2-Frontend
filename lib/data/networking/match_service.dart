import 'dart:convert';

import 'package:bilfoot/data/models/match_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';

class MatchService {
  static void test() {}

  static Future<Map<String, List<MatchModel>>?> getMatches() async {
    try {
      var response = await BilfootClient()
          .dio
          .get("${BilfootClient.baseUrl}match/get-matches");

      if (response.statusCode == null) {
        return null;
      } else if (response.statusCode! >= 400) {
        return null;
      }

      print("getmatches");
      print(response.data);
      if (response.data["upcoming_matches"] != null &&
          response.data["past_matches"] != null) {
        return {
          "upcoming_matches":
              (response.data["upcoming_matches"] as List<dynamic>)
                  .map((e) => MatchModel.fromJson(e))
                  .toList(),
          "past_matches": (response.data["past_matches"] as List<dynamic>)
              .map((e) => MatchModel.fromJson(e))
              .toList(),
        };
      }

      print(response.data);
    } on DioError catch (e) {
      print(e.response?.data);
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> quitMatch({required String matchId}) async {
    try {
      var response = await BilfootClient()
          .dio
          .post("${BilfootClient.baseUrl}match/quiz-player", data: {
        "match_id": matchId,
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

  static Future<bool> kickPlayer(
      {required String matchId, required String kickedPlayerId}) async {
    try {
      var response = await BilfootClient()
          .dio
          .post("${BilfootClient.baseUrl}match/kick-player", data: {
        "match_id": matchId,
        "kicked_player_id": kickedPlayerId,
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

  static Future<bool> giveAuth(
      {required String matchId, required String newAuthId}) async {
    try {
      var response = await BilfootClient()
          .dio
          .post("${BilfootClient.baseUrl}match/give-auth", data: {
        "match_id": matchId,
        "auth_player_id": newAuthId,
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

  static Future<bool> getMatchInvitation({
    required String fromId,
    required String toId,
    required String matchId,
  }) async {
    try {
      var response = await BilfootClient().dio.get(
          "${BilfootClient.baseUrl}match/get-match-invitation?from_id=$fromId&to_id=$toId&match_id=$matchId");

      if (response.statusCode == null) {
        return false;
      } else if (response.statusCode! >= 400) {
        return false;
      }

      print("get match invitation");

      if (response.data["invitation"] != null) {
        return true;
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

  static Future<bool> inviteToMatch({
    required String matchId,
    required String toId,
  }) async {
    try {
      var response = await BilfootClient()
          .dio
          .post("${BilfootClient.baseUrl}match/invite-to-match", data: {
        "match_id": matchId,
        "to_id": toId,
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

//  const { date, hour, pitch, is_pitch_approved, show_on_table, people_limit } =
  static Future<MatchModel?> createMatch({
    required DateTime date,
    required String hour,
    required String pitch,
    required bool isPitchApproved,
    required bool showOnTable,
    required int peopleLimit,
  }) async {
    try {
      var response = await BilfootClient()
          .dio
          .post("${BilfootClient.baseUrl}match/create-match", data: {
        "date": date.toIso8601String(),
        "hour": hour,
        "pitch": pitch,
        "is_pitch_approved": isPitchApproved,
        "show_on_table": showOnTable,
        "people_limit": peopleLimit,
      });
      if (response.statusCode == null) {
        return null;
      } else if (response.statusCode! >= 400) {
        return null;
      }

      print(response.data);
      if (response.data["match"] != null) {
        return MatchModel.fromJson(response.data["match"]);
      }

      return null;
    } on DioError catch (e) {
      print(e.response?.data);
      return null;
    } catch (e) {
      return null;
    }
  }

  //  const { date, hour, pitch, is_pitch_approved, show_on_table, people_limit } =
  static Future<MatchModel?> editMatch({
    required String id,
    required DateTime date,
    required String hour,
    required String pitch,
    required bool isPitchApproved,
    required bool showOnTable,
    required int peopleLimit,
  }) async {
    try {
      var response = await BilfootClient()
          .dio
          .post("${BilfootClient.baseUrl}match/edit-match", data: {
        "match_id": id,
        "date": date.toIso8601String(),
        "hour": hour,
        "pitch": pitch,
        "is_pitch_approved": isPitchApproved,
        "show_on_table": showOnTable,
        "people_limit": peopleLimit,
      });

      if (response.statusCode == null) {
        return null;
      } else if (response.statusCode! >= 400) {
        return null;
      }

      print(response.data);
      if (response.data["match"] != null) {
        return MatchModel.fromJson(response.data["match"]);
      }

      return null;
    } on DioError catch (e) {
      print(e.response?.data);
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> removeMatch({
    required String id,
  }) async {
    try {
      var response = await BilfootClient()
          .dio
          .post("${BilfootClient.baseUrl}match/remove-match", data: {
        "match_id": id,
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
