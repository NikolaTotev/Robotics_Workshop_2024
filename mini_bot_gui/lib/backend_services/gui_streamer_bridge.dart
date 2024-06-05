import 'dart:math';

import 'package:ocadi_bot_gui/backend_services/udp_streamer.dart';

// ignore: constant_identifier_names
enum JointState { mj_1, mj_2, mj_3, mj_4, sj_1, sj_2, sj_3, sj_4 }

enum GripperState {
  // ignore: constant_identifier_names
  gs_o,
  // ignore: constant_identifier_names
  gs_c,
}

// ignore: constant_identifier_names
enum GripperMovement { mg_o, mg_c, mg_s }

// ignore: constant_identifier_names
enum GripperConfigurations { gc_o, gc_c }

enum Direction { ccw, cw }

// ignore: constant_identifier_names
enum RecordingCommands { rc_start, rc_stop, rc_swp, rc_replay }

typedef MoveGripperFunc = void Function(GripperMovement gripperMovement);
typedef ToggleGripperFunc = void Function(GripperState gripperState);
typedef SetGripperPosFunc = void Function(
    GripperConfigurations gripperConfigurations);

typedef SetSpeed = void Function(double speed);

class GuiStreamerBridge {
  UdpStreamer streamer = UdpStreamer();

  //ToDo Add a wayt to edit this
  String robotIp = '192.168.4.1';
  int robotPort = 2390;
  int jogSpeed = 2;
  int replaySpeed = 2;
  int gripperSpeed = 2;

  double roundNumber(double value, int places) {
    num val = pow(10.0, places);
    return ((value * val).round().toDouble() / val);
  }

  void setJoggingSpeed(double newSpeed) {    
    jogSpeed = newSpeed.toInt();
    print("New jogging speed ${jogSpeed}");
  } 

  void setReplaySpeed (double newSpeed) {
    replaySpeed = newSpeed.toInt();
    print("New replay speed ${replaySpeed}");
  } 

  void setGripperSpeed (double newSpeed) {
    gripperSpeed = newSpeed.toInt();
    print("New gripper speed ${gripperSpeed}");
  } 

  void moveJoint(JointState jointState, Direction direction) {
    String command = "${jointState.name}_${direction.name}_${jogSpeed}";
    print(command);
    streamer.sendData(command, robotIp, robotPort);
  }

  void stopMovingJoint(JointState jointState) {
    String command = jointState.name;
    print(command);
    streamer.sendData(command, robotIp, robotPort);
  }

  void setGripperMovement(GripperMovement gripperState) {
    String command = "${gripperState.name}_$gripperSpeed";
    print(command);
    streamer.sendData(command, robotIp, robotPort);
  }

  void toggleGripper(GripperState gripperState) {
    String command = gripperState.name;
    print(command);
    streamer.sendData(command, robotIp, robotPort);
  }

  void configureGripper(GripperConfigurations config) {
    String command = config.name;
    print(command);
    streamer.sendData(command, robotIp, robotPort);
  }

  void startRecording() {
    String command = RecordingCommands.rc_start.name;
    print(command);
    //streamer.sendData(command, robotIp, robotPort);
  }

  void addWaypoint() {
    String command = RecordingCommands.rc_swp.name;
    print(command);
    streamer.sendData(command, robotIp, robotPort);
  }

  void stopRecording() {
    String command = RecordingCommands.rc_stop.name;
    print(command);
    //streamer.sendData(command, robotIp, robotPort);
  }

  void playRecording() {
    String command ="${RecordingCommands.rc_replay.name}_$replaySpeed";
    print(command);
    streamer.sendData(command, robotIp, robotPort);
  }
}
