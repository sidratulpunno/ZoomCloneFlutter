import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:meeting_app/resources/auth_method.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
  }) async {
    var jitsiMeet = JitsiMeet();
    try {
      var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.jit.si",
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: _authMethods.user.displayName,
          email: _authMethods.user.email,
          avatar: _authMethods.user.photoURL,
        ),
      );

      // Add this line to join the meeting
      jitsiMeet.join(options);
    } catch (error) {
      print("Error: $error");
    }
  }
}
