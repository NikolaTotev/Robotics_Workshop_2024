import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocadi_bot_gui/app_constants/colors.dart' as ocadi_colors;
import 'package:ocadi_bot_gui/backend_services/gui_streamer_bridge.dart';
import 'package:universal_io/io.dart';
import 'dart:convert';

// Base Controls ============================================
  Widget inputRow(
      labelText, leftIcon, rightIcon, buttonPadding, onHold, onRelease) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: Text(
            labelText,
            style: GoogleFonts.lexend(
                textStyle: const TextStyle(
                    color: ocadi_colors.notQuiteBlack,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: buttonPadding),
          child: Listener(
            onPointerDown: (event) {
              onHold.$1(event);
            },
            onPointerUp: (event) {
              onRelease.$1(event);
            },
            child: IconButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(ocadi_colors.darkRoyalPurple)),
              onPressed: () {},
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  leftIcon,
                  color: ocadi_colors.offWhite,
                  size: 45.0,
                ),
              ),
              hoverColor: ocadi_colors.darkRoyalPurpleHighlight,
              highlightColor: ocadi_colors.darkRoyalPurpleHighlight,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: buttonPadding),
          child: Listener(
            onPointerDown: (event) {
              onHold.$2(event);
            },
            onPointerUp: (event) {
              onRelease.$2(event);
            },
            child: IconButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(ocadi_colors.darkRoyalPurple)),
              onPressed: () {},
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  rightIcon,
                  color: ocadi_colors.offWhite,
                  size: 45.0,
                ),
              ),
              hoverColor: ocadi_colors.darkRoyalPurpleHighlight,
            ),
          ),
        ),
      ],
    );
  }
  

  class SpeedSlider extends StatefulWidget {
  const SpeedSlider({super.key, required this.onChangedCallback});
  
  final SetSpeed onChangedCallback;

  @override
  State<SpeedSlider> createState() => _SpeedSliderState();
}

class _SpeedSliderState extends State<SpeedSlider> {
  double _currentSliderValue = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slider')),
      body: Slider(
        value: _currentSliderValue,
        max: 3,
        divisions: 3,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
            widget.onChangedCallback(_currentSliderValue);
          });
        },
      ),
    );
  }
}
