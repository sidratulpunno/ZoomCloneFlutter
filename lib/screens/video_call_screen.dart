import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:meeting_app/resources/auth_method.dart';
import 'package:meeting_app/resources/jitsi_meet_methods.dart';
import 'package:meeting_app/utils/colors.dart';
import 'package:meeting_app/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  final TextEditingController meetingIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool isAudioMuted = true;
  bool isVideoMuted = true;
  bool isJoining = false;

  @override
  void initState() {
    super.initState();
    nameController.text = _authMethods.user?.displayName ?? 'Guest';
  }

  @override
  void dispose() {
    meetingIdController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Future<void> _joinMeeting() async {
    setState(() {
      isJoining = true;
    });
    await _jitsiMeetMethods.createMeeting(
      roomName: meetingIdController.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: nameController.text,
    );
    setState(() {
      isJoining = false;
    });
  }

  void _onAudioMuted(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  void _onVideoMuted(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: meetingIdController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Room ID',
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: 'Name',
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
            const SizedBox(height: 20),
            isJoining
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _joinMeeting,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
              ),
              child: const Text(
                'Join',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            MeetingOption(
              text: 'Mute Audio',
              isMute: isAudioMuted,
              onChange: _onAudioMuted,
            ),
            MeetingOption(
              text: 'Turn Off Video',
              isMute: isVideoMuted,
              onChange: _onVideoMuted,
            ),
          ],
        ),
      ),
    );
  }
}
