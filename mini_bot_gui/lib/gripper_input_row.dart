import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocadi_bot_gui/app_constants/colors.dart' as mini_colors;
import 'package:ocadi_bot_gui/backend_services/gui_streamer_bridge.dart';
import 'package:universal_io/io.dart';
import 'dart:convert';

Widget inputRow(context, MoveGripperFunc moveGripper,
    ToggleGripperFunc toggleGripper, SetGripperPosFunc setGripper) {
  double width = MediaQuery.of(context).size.width;
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Text(
          "Gripper Controls",
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Listener(
                        onPointerDown: (e) => moveGripper(GripperMovement.mg_o),
                        onPointerUp: (e) => moveGripper(GripperMovement.mg_s),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.swap_horiz,
                            size: 35.0,
                            color: mini_colors.offWhite,
                          ),
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  mini_colors.darkRoyalPurple)),
                          hoverColor: mini_colors.darkRoyalPurpleHighlight,
                          highlightColor: mini_colors.darkRoyalPurpleHighlight,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "Move\nOpen",
                        style: GoogleFonts.lexend(
                            textStyle: const TextStyle(
                                color: mini_colors.notQuiteBlack,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => toggleGripper(GripperState.gs_o),
                  icon: const Icon(
                    Icons.unfold_more,
                    size: 35.0,
                    color: mini_colors.offWhite,
                  ),
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          mini_colors.darkRoyalPurple)),
                  hoverColor: mini_colors.darkRoyalPurpleHighlight,
                  highlightColor: mini_colors.darkRoyalPurpleHighlight,
                ),
                Text(
                  "Open",
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Listener(
                        onPointerDown: (e) => moveGripper(GripperMovement.mg_c),
                        onPointerUp: (e) => moveGripper(GripperMovement.mg_s),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.compare_arrows,
                            size: 35.0,
                            color: mini_colors.offWhite,
                          ),
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  mini_colors.darkRoyalPurple)),
                          hoverColor: mini_colors.darkRoyalPurpleHighlight,
                          highlightColor: mini_colors.darkRoyalPurpleHighlight,
                        ),
                      ),
                      Text(
                        "Move\nClosed",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lexend(
                            textStyle: const TextStyle(
                                color: mini_colors.notQuiteBlack,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                Listener(
                  child: IconButton(
                    onPressed: () => toggleGripper(GripperState.gs_c),
                    icon: const Icon(
                      Icons.unfold_less,
                      size: 35.0,
                      color: mini_colors.offWhite,
                    ),
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            mini_colors.darkRoyalPurple)),
                    hoverColor: mini_colors.darkRoyalPurpleHighlight,
                    highlightColor: mini_colors.darkRoyalPurpleHighlight,
                  ),
                ),
                Text(
                  "Close",
                  style: GoogleFonts.lexend(
                      textStyle: const TextStyle(
                          color: mini_colors.notQuiteBlack,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          width > 500
              ? setPositionButtons(setGripper)
              : const SizedBox(
                  width: 0.0,
                  height: 0.0,
                )
        ],
      ),
      width <= 500
          ? setPositionButtons(setGripper)
          : const SizedBox(
              width: 0.0,
              height: 0.0,
            )
    ],
  );
}

Widget setPositionButtons(SetGripperPosFunc setGripper) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: mini_colors.darkRoyalPurple,
          ),
          onPressed: () => setGripper(GripperConfigurations.gc_o),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Set Open Position',
              style: GoogleFonts.lexend(
                  textStyle: const TextStyle(
                      color: mini_colors.offWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: mini_colors.darkRoyalPurple,
          ),
          onPressed: () => setGripper(GripperConfigurations.gc_c),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Set Closed Position',
              style: GoogleFonts.lexend(
                  textStyle: const TextStyle(
                      color: mini_colors.offWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
    ],
  );
}
