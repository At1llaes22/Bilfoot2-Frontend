import 'dart:convert';

import 'package:bilfoot/data/models/program.dart';
import 'package:bilfoot/data/networking/announcement_service.dart';
import 'package:bilfoot/data/networking/chat_service.dart';
import 'package:bilfoot/data/networking/match_service.dart';
import 'package:bilfoot/data/networking/team_service.dart';
import 'package:bilfoot/data/networking/user_service.dart';
import 'package:dio/dio.dart';
import "package:http/http.dart" as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

enum Method { post, get }

class BilfootClient {
  static final BilfootClient _instance = BilfootClient._internal();
  BilfootClient._internal();

  factory BilfootClient() {
    return _instance;
  }

  //get ip by writing ipconfig to terminal
  static String baseUrl = "https://bilfoot2-app-rr5no.ondigitalocean.app/";
  // final String baseUrl = "http://192.168.3.15:8080/";
  //User endpoints

  Dio? _dio;
  final userTest = UserService.test;
  final getHomeData = UserService.getHomeData;
  final getNotifications = UserService.getUserNotifications;
  final searchPlayers = UserService.searchPlayers;
  final registerUser = UserService.registerUser;
  final answerToNotification = UserService.answerToNotification;
  final updatePhoneNumber = UserService.updatePhoneNumber;
  final getPhoneNumber = UserService.getPhoneNumber;

  //Chat endpoints
  final chatTest = ChatService.test;

  //Match endpoints
  final matchTest = MatchService.test;
  final getMatches = MatchService.getMatches;
  final quitMatch = MatchService.quitMatch;
  final kickFromMatch = MatchService.kickPlayer;
  final giveAuth = MatchService.giveAuth;
  final getMatchInvitation = MatchService.getMatchInvitation;
  final inviteToMatch = MatchService.inviteToMatch;
  final createMatch = MatchService.createMatch;
  final editMatch = MatchService.editMatch;
  final removeMatch = MatchService.removeMatch;

  //Team endpoints
  final teamTest = TeamService.test;
  final createTeam = TeamService.createTeam;
  final getTeamModel = TeamService.getTeamModel;
  final getTeamsWithIds = TeamService.getTeamsWithIds;
  final getTeamInvitation = TeamService.getTeamInvitation;
  final inviteToTeam = TeamService.inviteToTeam;
  final quitTeam = TeamService.quitTeam;
  final makeCaptain = TeamService.makeCaptain;
  final kickFromTeam = TeamService.kickPlayer;
  final editTeam = TeamService.editTeam;

  //Announcement endpoints
  final announcementTest = AnnouncementService.test;
  final getAnnouncements = AnnouncementService.getAnnouncements;
  final sendPlayerAnnouncementJoinRequest =
      AnnouncementService.sendPlayerAnnouncementJoinRequest;

  Future<Response?> sendRequest({
    required String path,
    Map<String, dynamic>? body,
    Method method = Method.get,
  }) async {
    try {
      var url = (baseUrl + path);

      if (method == Method.get) {
        var response = await dio.get(
          url,

//        body: body == null ? null : jsonEncode(body),
          data: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${Program.program.token}",
          },
        );
        return response;
      } else if (Method.post == method) {
        var response = await dio.post(
          url,
          //body: body == null ? null : jsonEncode(body),
          data: {
            "body": {jsonEncode(body)},
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer ${Program.program.token}",
          },
        );
        return response;
      }
      /*
    Response -> is_registered = false or true;
     */
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }

  Dio get dio {
    if (_dio == null) {
      initializeDio();
    }
    return _dio!;
  }

  void initializeDio() async {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    _dio!.interceptors.add(PrettyDioLogger());
  }
}
