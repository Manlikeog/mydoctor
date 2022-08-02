import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../Services/userType/current_user.dart';
import '../widgets/rounded_input_field.dart';

class AddWindow extends StatefulWidget {
  final String? title;
  final String? startTime;
  final String? endTime;
  final String? date;
  final String? docId;
  final bool editState;
  const AddWindow(
      {Key? key,
      this.title,
      this.startTime,
      this.endTime,
      this.date,
      this.docId,
      required this.editState})
      : super(key: key);
  @override
  _AddWindowState createState() => _AddWindowState();
}

class _AddWindowState extends State<AddWindow> {
  bool inProgress = false;
  String? text;
  String? imgUrl;
  String startTime = "9";
  String endTime = "9";
  bool alteredTime = false;
  bool alteredDate = false;
  TextEditingController textEditingController = TextEditingController();
  String? _uploadedFileURL;
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 7),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    if (kDebugMode) {
      print((selectedDate.toIso8601String()).substring(0, 10));
    }
  }

  Future pushData() async {
    try {
      if (((textEditingController.text == "" ||
          textEditingController.text == null))) {
        setState(() {
          inProgress = false;
        });
        BotToast.showSimpleNotification(
            title: 'Appointment window title is empty!');
      } else {
        DocumentReference reference =
            await FirebaseFirestore.instance.collection('windows').add({
          'title': textEditingController.text,
          'startTime': startTime,
          'endTime': endTime,
          'date': (selectedDate.toIso8601String()).substring(0, 10),
          'uid': Provider.of<CurrentUser>(context, listen: false)
              .loggedInUser!
              .uid,
          'time': FieldValue.serverTimestamp(),
        });

        textEditingController.clear();
        setState(() {
          inProgress = false;
        });
        Navigator.pop(context);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        inProgress = false;
      });
    }
  }

  Future update() async {
    try {
      if (((textEditingController.text == "" ||
          textEditingController.text == null))) {
        setState(() {
          inProgress = false;
        });
        BotToast.showSimpleNotification(
            title: 'Appointment window title is empty!');
      } else {
        await FirebaseFirestore.instance
            .collection('windows')
            .doc(widget.docId)
            .update({
          'title': textEditingController.text,
          'startTime': alteredTime ? startTime : widget.startTime,
          'endTime': alteredTime ? endTime : widget.endTime,
          'date': alteredDate
              ? (selectedDate.toIso8601String()).substring(0, 10)
              : widget.date,
          'uid': Provider.of<CurrentUser>(context, listen: false)
              .loggedInUser!
              .uid,
          'time': FieldValue.serverTimestamp(),
        });

        textEditingController.clear();
        setState(() {
          inProgress = false;
        });
        Navigator.pop(context);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        inProgress = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.editState) {
      textEditingController = TextEditingController(text: widget.title);
    } else {
      textEditingController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editState
            ? 'Edit Appointment Window'
            : 'Add Appointment Window'),
        backgroundColor: Color(0xdf07D9AD),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: ModalProgressHUD(
          inAsyncCall: inProgress,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: RoundedInputField(
                        hintText: 'Create Appointment Time',
                        type: TextInputType.multiline,
                        controller: textEditingController,
                        onchanged: (value) {
                          setState(() {
                            text = value;
                          });
                        },
                      )
                      // TextField(
                      //   textCapitalization: TextCapitalization.sentences,
                      //   keyboardType: TextInputType.multiline,
                      //   maxLines: null,
                      //   controller: textEditingController,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       text = value;
                      //     });
                      //   },
                      //   decoration: InputDecoration(
                      //       hintText: "Appointment Window Title",
                      //       hintStyle: const TextStyle(color: Colors.grey),
                      //       prefixStyle:
                      //           const TextStyle(color: Color(0xFF0A0E21)),
                      //       contentPadding: const EdgeInsets.only(top: 14.0),
                      //       border: OutlineInputBorder(
                      //           //borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      //           ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             color: Color(0xFF0A0E21), width: 1.0),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(
                      //             color: Color(0xFF0A0E21), width: 2.0),
                      //       ),
                      //       errorBorder: InputBorder.none,
                      //       disabledBorder: InputBorder.none,
                      //       suffixIcon: IconButton(
                      //         icon: const Icon(
                      //           Icons.access_time,
                      //           color: Color(0xFF0A0E21),
                      //         ),
                      //         onPressed: () async {
                      //           TimeRange result = await showTimeRangePicker(
                      //             context: context,
                      //             start: const TimeOfDay(hour: 10, minute: 0),
                      //             end: const TimeOfDay(hour: 10, minute: 15),
                      //             onStartChange: (start) {
                      //               if (kDebugMode) {
                      //                 print("${start.hour} ${start.minute}");
                      //               }
                      //               startTime = "${start.hour}:${start.minute}";
                      //               alteredTime = true;
                      //               //print("start time " + start.toString());
                      //             },
                      //             onEndChange: (end) {
                      //               if (kDebugMode) {
                      //                 print(end.hour);
                      //               }
                      //               endTime = "${end.hour}:${end.minute}";
                      //               alteredTime = true;
                      //             },
                      //           );
                      //           if (kDebugMode) {
                      //             print("result $result");
                      //           }
                      //         },
                      //       )),
                      // ),
                      ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: const Color(0xff61CEFF),
                          child: Row(
                            //mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Select Available Time',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            TimeRange result = await showTimeRangePicker(
                              context: context,
                              start: const TimeOfDay(hour: 10, minute: 0),
                              end: const TimeOfDay(hour: 10, minute: 15),
                              onStartChange: (start) {
                                if (kDebugMode) {
                                  print("${start.hour} ${start.minute}");
                                }
                                startTime = "${start.hour}:${start.minute}";
                                alteredTime = true;
                                //print("start time " + start.toString());
                              },
                              onEndChange: (end) {
                                if (kDebugMode) {
                                  print(end.hour);
                                }
                                endTime = "${end.hour}:${end.minute}";
                                alteredTime = true;
                              },
                            );
                            if (kDebugMode) {
                              print("result $result");
                            }
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: const Color(0xff61CEFF),
                          child: Row(
                            //mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Select Available Date',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            alteredDate = true;
                            await _selectDate(context);
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: const Color(0xff61CEFF),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              const Icon(
                                Icons.lock_open,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.editState ? 'Edit Slot' : 'Create Slot',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            setState(() {
                              inProgress = true;
                            });
                            FocusScope.of(context).unfocus();
                            if (widget.editState) {
                              await update();
                            } else {
                              await pushData();
                            }
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Visibility(
                    visible: widget.editState,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: FlatButton(
                            color: const Color(0xFF0A0E21),
                            child: Row(
                              //mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Delete Appointment Window',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              setState(() {
                                inProgress = true;
                              });
                              try {
                                DocumentReference ref = FirebaseFirestore
                                    .instance
                                    .doc('windows/${widget.docId}');
                                await FirebaseFirestore.instance.runTransaction(
                                    (Transaction myTransaction) async {
                                  myTransaction.delete(ref);
                                });
                              } catch (e) {
                                BotToast.showSimpleNotification(
                                    title: 'Something went wrong :(');
                              }

                              setState(() {
                                inProgress = false;
                              });
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
