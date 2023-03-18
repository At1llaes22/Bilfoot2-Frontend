import 'dart:convert';

import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/models/team_model.dart';
import 'package:bilfoot/data/networking/client.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart';

class TeamService {
  static void test() {}

  static Future<TeamModel?> getTeamModel({required String id}) async {
    try {
      var response = await BilfootClient()
          .dio
          .post("${BilfootClient.baseUrl}team/get-team-model?id=$id", data: {
      });

      if (response.statusCode == null) {
        return null;
      } else if (response.statusCode! >= 400) {
        return null;
      }

      print("get team model");
      print(response.data);
      if (response.data["team_model"] != null) {
        return TeamModel.fromJson(response.data["team_model"]);
      }

      return null;
    } on DioError catch (e) {
      print(e.response?.data);
      return null;
    } catch (e) {
      return null;
    }

  }

  static Future<List<TeamModel>> getTeamsWithIds(
      {required List<String> ids}) async {
    try {
      var response = await BilfootClient()
          .dio
          .post("${BilfootClient.baseUrl}team/get-teams-with-ids", data: {
      });

      if (response.statusCode == null) {
        return [];
      } else if (response.statusCode! >= 400) {
        return [];
      }

      print(response.data);
      if (response.data["teams"] != null) {
        List<TeamModel> teams = (response.data["teams"] as List<dynamic>)
            .map((e) => TeamModel.fromJson(e))
            .toList();

        return teams;
      }

      return [];
    } on DioError catch (e) {
      print(e.response?.data);
      return [];
    } catch (e) {
      return [];
    }

  }

  static Future<bool> createTeam({
    required String teamName,
    required String shortName,
    required String mainColor,
    required String accentColor,
  }) async {
    try {
      var response = await BilfootClient().dio.post(
          "${BilfootClient.baseUrl}team/create-team",
          data: {
            "name": teamName,
            "short_name": shortName,
            "main_color": mainColor,
            "accent_color": accentColor
          });

      if (response.statusCode == null) {
        return false;
      } else if (response.statusCode! >= 400) {
        return false;
      }
      if (response.data["team"] != null) {
        Program.program.user!.teams.add(response.data["team"]["_id"]);
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
  // TODO: bu nasıl get methodu amk
  static Future<bool> getTeamInvitation({
    required String fromId,
    required String toId,
    required String teamId,
  }) async {
    try {
      var response = await BilfootClient().dio.get(
          "${BilfootClient.baseUrl}team/get-team-invitation?from_id=$fromId&to_id=$toId&team_id=$teamId");

      if (response.statusCode == null) {
        return false;
      } else if (response.statusCode! >= 400) {
        return false;
      }


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

  static Future<bool> inviteToTeam({
    required String teamId,
    required String toId,
  }) async {
    try {
      var response = await BilfootClient().dio.post(
          "${BilfootClient.baseUrl}team/invite-to-team",
          data: {
            "team_id": teamId,
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

  static Future<bool> quitTeam({required String teamId}) async {
    try {
      var response = await BilfootClient().dio.post(
          "${BilfootClient.baseUrl}team/quit-team",
          data: {
            "team_id": teamId,
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

  static Future<bool> makeCaptain(
      {required String teamId, required String newCaptainId}) async {
    try {
      var response = await BilfootClient().dio.post(
          "${BilfootClient.baseUrl}team/make-captain",
          data: {
            "team_id": teamId,
            "new_captain_id": newCaptainId,
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
      {required String teamId, required String kickedPlayerId}) async {
    try {
      var response = await BilfootClient().dio.post(
          "${BilfootClient.baseUrl}team/kick-player",
          data: {
            "team_id": teamId,
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

  static Future<bool> editTeam({
    String? teamName,
    String? shortName,
    String? mainColor,
    String? accentColor,
    required String teamId,
  }) async {
    try {
      var response = await BilfootClient().dio.post(
          "${BilfootClient.baseUrl}team/edit-team",
          data: {
            "name": teamName,
            "short_name": shortName,
            "main_color": mainColor,
            "accent_color": accentColor,
            "team_id": teamId
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
