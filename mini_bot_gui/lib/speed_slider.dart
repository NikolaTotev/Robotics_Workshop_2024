import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocadi_bot_gui/app_constants/colors.dart' as mini_colors;
import 'package:ocadi_bot_gui/backend_services/gui_streamer_bridge.dart';

class SpeedSlider extends StatefulWidget {
  const SpeedSlider({super.key, required this.onChangedCallback,  this.min = 1.0,  this.max= 3.0, this.divisions = 2});

  final SetSpeed onChangedCallback;
  final double min;
  final double max;
  final int? divisions;

  @override
  State<SpeedSlider> createState() => _SpeedSliderState();
}

class _SpeedSliderState extends State<SpeedSlider> {
  double _currentSliderValue = 2;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width / 8, right: width / 8),
      child: Slider(
        value: _currentSliderValue,
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,        
        thumbColor: mini_colors.darkRoyalPurple,
        activeColor: mini_colors.lightRoyalPurpleHighlight,                
        label: _currentSliderValue.toStringAsFixed(1),
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
