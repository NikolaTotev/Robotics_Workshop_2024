import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocadi_bot_gui/app_constants/colors.dart' as mini_colors;
import 'package:ocadi_bot_gui/backend_services/gui_streamer_bridge.dart';

import 'joint_input_row.dart' as joint;
import 'speed_slider.dart';
import 'gripper_input_row.dart' as gripper_control;
import 'recording_input_row.dart' as recording_control;
import 'package:universal_io/io.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MiniBot GUI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(body: Homepage()));
  }
}

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final GuiStreamerBridge bridge = GuiStreamerBridge();

  Widget verticalLayout(context, buttonPadding, row_padding) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'MiniBot Teach Pendant',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                        color: mini_colors.notQuiteBlack,
                        fontSize: 35,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const Divider(
              height: 5,
              thickness: 2,
              indent: 42,
              endIndent: 42,
              color: mini_colors.darkRoyalPurpleHighlight,
            ),
            Padding(
                padding: EdgeInsets.all(row_padding),
                child: joint.inputRow('Joint 1', Icons.rotate_left,
                    Icons.rotate_right, buttonPadding, (
                  (e) {
                    bridge.moveJoint(JointState.mj_1, Direction.ccw);
                  },
                  (e) {
                    bridge.moveJoint(JointState.mj_1, Direction.cw);
                  }
                ), (
                  (e) {
                    bridge.stopMovingJoint(JointState.sj_1);
                  },
                  (e) {
                    bridge.stopMovingJoint(JointState.sj_1);
                  }
                ))),
            Padding(
                padding: EdgeInsets.all(row_padding),
                child: joint.inputRow(
                    'Joint 2', Icons.undo, Icons.redo, buttonPadding, (
                  (e) {
                    bridge.moveJoint(JointState.mj_2, Direction.ccw);
                  },
                  (e) {
                    bridge.moveJoint(JointState.mj_2, Direction.cw);
                  }
                ), (
                  (e) {
                    bridge.stopMovingJoint(JointState.sj_2);
                  },
                  (e) {
                    bridge.stopMovingJoint(JointState.sj_2);
                  }
                ))),
            Padding(
                padding: EdgeInsets.all(row_padding),
                child: joint.inputRow(
                    'Joint 3', Icons.get_app, Icons.upload, buttonPadding, (
                  (e) {
                    bridge.moveJoint(JointState.mj_3, Direction.ccw);
                  },
                  (e) {
                    bridge.moveJoint(JointState.mj_3, Direction.cw);
                  }
                ), (
                  (e) {
                    bridge.stopMovingJoint(JointState.sj_3);
                  },
                  (e) {
                    bridge.stopMovingJoint(JointState.sj_3);
                  }
                ))),
            Padding(
                padding: EdgeInsets.all(row_padding),
                child: joint.inputRow(
                    'Joint 4', Icons.get_app, Icons.upload, buttonPadding, (
                  (e) {
                    bridge.moveJoint(JointState.mj_4, Direction.ccw);
                  },
                  (e) {
                    bridge.moveJoint(JointState.mj_4, Direction.cw);
                  }
                ), (
                  (e) {
                    bridge.stopMovingJoint(JointState.sj_4);
                  },
                  (e) {
                    bridge.stopMovingJoint(JointState.sj_4);
                  }
                ))),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "Movement Speed",
                style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                        color: mini_colors.notQuiteBlack,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            SpeedSlider(onChangedCallback: bridge.setJoggingSpeed),
            const Divider(
              height: 5,
              thickness: 2,
              indent: 42,
              endIndent: 42,
              color: mini_colors.darkRoyalPurpleHighlight,
            ),
            gripper_control.inputRow(context, bridge.setGripperMovement,
                bridge.toggleGripper, bridge.configureGripper),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "Gripper Speed",
                style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                        color: mini_colors.notQuiteBlack,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            SpeedSlider(onChangedCallback: bridge.setGripperSpeed),
            const Divider(
              height: 5,
              thickness: 2,
              indent: 42,
              endIndent: 42,
              color: mini_colors.darkRoyalPurpleHighlight,
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: recording_control.RecordingRow(
                    startRecording: bridge.startRecording,
                    stopRecording: bridge.stopRecording,
                    addWaypoint: bridge.addWaypoint,
                    playRecording: bridge.playRecording)),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "Replay Speed",
                style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                        color: mini_colors.notQuiteBlack,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            SpeedSlider(onChangedCallback: bridge.setReplaySpeed),
          ]),
    );
  }

  Widget horizontalLayout(context, buttonPadding, row_padding) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Ocadi Teach Pendant',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                        color: mini_colors.notQuiteBlack,
                        fontSize: 35,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const Divider(
              height: 5,
              thickness: 2,
              indent: 42,
              endIndent: 42,
              color: mini_colors.darkRoyalPurpleHighlight,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(row_padding),
                            child: joint.inputRow('Joint 1', Icons.rotate_left,
                                Icons.rotate_right, buttonPadding, (
                              (e) {
                                bridge.moveJoint(JointState.mj_1, Direction.ccw);
                              },
                              (e) {
                                bridge.moveJoint(JointState.mj_1, Direction.cw);
                              }
                            ), (
                              (e) {
                                bridge.stopMovingJoint(JointState.sj_1);
                              },
                              (e) {
                                bridge.stopMovingJoint(JointState.sj_1);
                              }
                            ))),
                        Padding(
                            padding: EdgeInsets.all(row_padding),
                            child: joint.inputRow(
                                'Joint 2', Icons.undo, Icons.redo, buttonPadding, (
                              (e) {
                                bridge.moveJoint(JointState.mj_2, Direction.ccw);
                              },
                              (e) {
                                bridge.moveJoint(JointState.mj_2, Direction.cw);
                              }
                            ), (
                              (e) {
                                bridge.stopMovingJoint(JointState.sj_2);
                              },
                              (e) {
                                bridge.stopMovingJoint(JointState.sj_2);
                              }
                            ))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(row_padding),
                            child: joint.inputRow('Joint 3', Icons.get_app,
                                Icons.upload, buttonPadding, (
                              (e) {
                                bridge.moveJoint(JointState.mj_3, Direction.ccw);
                              },
                              (e) {
                                bridge.moveJoint(JointState.mj_3, Direction.cw);
                              }
                            ), (
                              (e) {
                                bridge.stopMovingJoint(JointState.sj_3);
                              },
                              (e) {
                                bridge.stopMovingJoint(JointState.sj_3);
                              }
                            ))),
                        Padding(
                            padding: EdgeInsets.all(row_padding),
                            child: joint.inputRow('Joint 4', Icons.get_app,
                                Icons.upload, buttonPadding, (
                              (e) {
                                bridge.moveJoint(JointState.mj_4, Direction.ccw);
                              },
                              (e) {
                                bridge.moveJoint(JointState.mj_4, Direction.cw);
                              }
                            ), (
                              (e) {
                                bridge.stopMovingJoint(JointState.sj_4);
                              },
                              (e) {
                                bridge.stopMovingJoint(JointState.sj_4);
                              }
                            ))),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "Movement Speed",
                style: GoogleFonts.lexend(
                    textStyle: const TextStyle(
                        color: mini_colors.notQuiteBlack,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            SpeedSlider(onChangedCallback: bridge.setJoggingSpeed),
            const Divider(
              height: 5,
              thickness: 2,
              indent: 42,
              endIndent: 42,
              color: mini_colors.darkRoyalPurpleHighlight,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      gripper_control.inputRow(context, bridge.setGripperMovement,
                          bridge.toggleGripper, bridge.configureGripper),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Gripper Speed",
                          style: GoogleFonts.lexend(
                              textStyle: const TextStyle(
                                  color: mini_colors.notQuiteBlack,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      SpeedSlider(onChangedCallback: bridge.setGripperSpeed),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: recording_control.RecordingRow(
                              startRecording: bridge.startRecording,
                              stopRecording: bridge.stopRecording,
                              addWaypoint: bridge.addWaypoint,
                              playRecording: bridge.playRecording)),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Replay Speed",
                          style: GoogleFonts.lexend(
                              textStyle: const TextStyle(
                                  color: mini_colors.notQuiteBlack,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                      SpeedSlider(onChangedCallback: bridge.setReplaySpeed),
                    ],
                  )
                ],
              ),
            ),
            
            const Divider(
              height: 5,
              thickness: 2,
              indent: 42,
              endIndent: 42,
              color: mini_colors.darkRoyalPurpleHighlight,
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print("Width $width");
    double buttonPadding = width / 20;
    double row_padding = 10.0;
    if (width <= 700) {
      return verticalLayout(context, buttonPadding, row_padding);
    }

    return horizontalLayout(context, width/42, 5.0);
  }

  void send_to_ws() {
    // final channel = WebSocketChannel.connect(
    //   Uri.parse('ws://127.0.0.1:8888'),
    // );

    // for (var i = 0; i < 10; i++) {
    //   channel.sink.add('Hello! Iteration: $i');
    // }
  }

  //   RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889).then((socket) {
  //     socket.send(Utf8Codec().encode("single send"),
  //         InternetAddress("192.168.4.1"), 2390);
  //     socket.listen((event) {
  //       if (event == RawSocketEvent.write) {
  //         socket.close();
  //         print("single closed");
  //       }
  //     });
  //   });
  // }
// ==========================================================
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     // setState(() {
//     //   // This call to setState tells the Flutter framework that something has
//     //   // changed in this State, which causes it to rerun the build method below
//     //   // so that the display can reflect the updated values. If we changed
//     //   // _counter without calling setState(), then the build method would not be
//     //   // called again, and so nothing would appear to happen.
//     //   _counter++;
//     // });
//      int port = 2390;

//   // listen forever & send response

//   // send single packet then close the socket =================================================
//   RawDatagramSocket.bind(InternetAddress.anyIPv4, 8889).then((socket) {
//     socket.send(Utf8Codec().encode("single send"), InternetAddress("192.168.4.1"), port);
//     socket.listen((event) {
//       if (event == RawSocketEvent.write) {
//         socket.close();
//         print("single closed");
//       }
//     });
//   });
//   }
// // send single packet then close the socket =================================================
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
