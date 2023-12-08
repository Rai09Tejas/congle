// import 'dart:convert';

// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:videosdk/rtc.dart';
// import 'package:http/http.dart' as http;

class RoomsController extends GetxController {
  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void initTabController({required TickerProvider vsync}) {
    int initIndex = 0;

    tabController = TabController(
      initialIndex: initIndex,
      length: 2,
      vsync: vsync,
    );
  }

  // Map<String, Participant> participants = new Map();
  // Participant? localParticipant;
  // Meeting? meeting;

  // String? activeSpeakerId;
  // String? activePresenterId;

  // String? meetingId;
  // String? token;

  onMeetingStart() {
    //   this.localParticipant = null;
    //   this.activeSpeakerId = null;
    //   this.activePresenterId = null;

    //   this._fetchMeetingIdAndToken();
  }

  // handleMeetingListners(Meeting meeting) {
  //   meeting.on(
  //     "participant-joined",
  //     (Participant participant) {
  //       final newParticipants = participants;
  //       newParticipants[participant.id] = participant;
  //       participants = newParticipants;
  //     },
  //   );
  //   //
  //   meeting.on(
  //     "participant-left",
  //     (participantId) {
  //       final newParticipants = participants;

  //       newParticipants.remove(participantId);
  //       participants = newParticipants;
  //     },
  //   );
  //   //
  //   meeting.on('meeting-left', () {
  //     token = null;
  //     meetingId = null;
  //   });
  //   meeting.on('speaker-changed', (_activeSpeakerId) {
  //     activeSpeakerId = _activeSpeakerId;
  //     print("meeting speaker-changed => ${_activeSpeakerId}");
  //   });
  //   //
  //   meeting.on('presenter-changed', (_activePresenterId) {
  //     activePresenterId = _activePresenterId;

  //     print("meeting presenter-changed => ${_activePresenterId}");
  //   });
  // }

  // void _fetchMeetingIdAndToken() async {
  //   // final String API_SERVER_HOST = "http://127.0.0.1:9000";
  //   final String API_SERVER_HOST = "http://10.150.3.196:9000";

  //   final Uri getTokenUrl = Uri.parse('$API_SERVER_HOST/get-token');
  //   final http.Response tokenResponse = await http.get(getTokenUrl);

  //   final dynamic _token = json.decode(tokenResponse.body)['token'];
  //   print(_token);

  //   final Uri getMeetingIdUrl = Uri.parse('$API_SERVER_HOST/create-meeting/');

  //   final http.Response meetingIdResponse =
  //       await http.post(getMeetingIdUrl, body: {"token": _token});

  //   final _meetingId = json.decode(meetingIdResponse.body)['meetingId'];

  //   token = _token;
  //   // meetingId = "d6c2-y6xf-ku84";
  //   meetingId = _meetingId;
  // }
}
