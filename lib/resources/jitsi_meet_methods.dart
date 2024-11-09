import 'package:flutter/cupertino.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:meeting_app/resources/auth_method.dart';
import 'package:meeting_app/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();
  final FireStoreMethods _fireStoreMethods = FireStoreMethods();

  Future<void> createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    var jitsiMeet = JitsiMeet();

    try {
      // Use the provided username, or fallback to the user's display name if available
      final currentUser = _authMethods.user;
      String name = username.isNotEmpty ? username : (currentUser?.displayName ?? 'Guest');

      var options = JitsiMeetConferenceOptions(
        serverURL: "https://meet.ffmuc.net/",
        room: roomName,
        configOverrides: {
          "startWithAudioMuted": isAudioMuted,
          "startWithVideoMuted": isVideoMuted,
        },
        featureFlags: {"unsaferoomwarning.enabled": false},
        userInfo: JitsiMeetUserInfo(
          displayName: name,
          email: currentUser?.email, // Use null-aware operator
          avatar: currentUser?.photoURL, // Use null-aware operator
        ),
      );

      // Add meeting to history and join meeting
      await _fireStoreMethods.addMeetingHistory(roomName);
      jitsiMeet.join(options);
    } catch (error) {
      print("Error: $error");
    }
  }
}
