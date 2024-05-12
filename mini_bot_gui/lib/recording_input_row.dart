import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocadi_bot_gui/app_constants/colors.dart' as mini_colors;
import 'package:universal_io/io.dart';
import 'dart:convert';

class RecordingRow extends StatefulWidget {
  const RecordingRow({
    super.key,
    required this.startRecording,
    required this.stopRecording,
    required this.addWaypoint,
    required this.playRecording,
  });

  final VoidCallback startRecording;
  final VoidCallback stopRecording;
  final VoidCallback addWaypoint;
  final VoidCallback playRecording;

  @override
  State<RecordingRow> createState() => _RecordingRowState();
}

class _RecordingRowState extends State<RecordingRow> {
  IconData recordButtonIcon = Icons.radio_button_checked;
  bool playButtonEnabled = false;
  bool isRecording = false;

  void startRecording() {
    widget.startRecording();
    print("Starting recording");
    setState(() {
      playButtonEnabled = false;
      isRecording = true;
      recordButtonIcon = Icons.stop_circle;
    });
  }

  void stopRecording() {
    widget.stopRecording();
    print("Stopping recording");
    setState(() {
      playButtonEnabled = true;
      isRecording = false;
      recordButtonIcon = Icons.radio_button_checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return inputRow(
        20.0,
        recordButtonIcon,
        playButtonEnabled,
        isRecording,
        startRecording,
        stopRecording,
        widget.addWaypoint,
        widget.playRecording);
  }
}

Widget inputRow(
    buttonPadding,
    IconData recordButtonIcon,
    bool playButtonEnabled,
    bool isRecording,
    VoidCallback startRecording,
    VoidCallback stopRecording,
    VoidCallback addWaypoint,
    VoidCallback playRecording) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          "Recording",
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
              textStyle: const TextStyle(
                  color: mini_colors.notQuiteBlack,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                IconButton(
                  onPressed: playButtonEnabled
                      ? playRecording
                      : () {
                          print("Button is disabled");
                        },
                  icon: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.play_circle_outline,
                      size: 40.0,
                      color: mini_colors.offWhite,
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: playButtonEnabled
                          ? const MaterialStatePropertyAll(
                              mini_colors.darkRoyalPurple)
                          : const MaterialStatePropertyAll(
                              mini_colors.lightPurpleGrey)),
                  hoverColor: playButtonEnabled
                      ? mini_colors.darkRoyalPurpleHighlight
                      : mini_colors.lightPurpleGrey,
                  highlightColor: playButtonEnabled
                      ? mini_colors.darkRoyalPurpleHighlight
                      : mini_colors.lightPurpleGrey,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Play",
                  style: GoogleFonts.lexend(
                      textStyle: const TextStyle(
                          color: mini_colors.notQuiteBlack,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                IconButton(
                  onPressed: addWaypoint,
                  icon: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.add_location,
                      size: 40.0,
                      color: mini_colors.offWhite,
                    ),
                  ),
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          mini_colors.darkRoyalPurple)),
                  hoverColor: mini_colors.darkRoyalPurpleHighlight,
                  highlightColor: mini_colors.darkRoyalPurpleHighlight,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Add Waypoint",
                  style: GoogleFonts.lexend(
                      textStyle: const TextStyle(
                          color: mini_colors.notQuiteBlack,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    if (isRecording) {
                      stopRecording();
                    } else {
                      startRecording();
                    }
                  },
                  icon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      recordButtonIcon,
                      size: 40.0,
                      color: mini_colors.offWhite,
                    ),
                  ),
                  style: ButtonStyle(
                      backgroundColor: isRecording
                          ? MaterialStatePropertyAll(Colors.red[600])
                          : const MaterialStatePropertyAll(
                              mini_colors.darkRoyalPurple)),
                  hoverColor: isRecording
                      ? Colors.red[300]
                      : mini_colors.darkRoyalPurpleHighlight,
                  highlightColor: isRecording
                      ? Colors.red[300]
                      : mini_colors.darkRoyalPurpleHighlight,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Clear",
                  style: GoogleFonts.lexend(
                      textStyle: const TextStyle(
                          color: mini_colors.notQuiteBlack,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}
