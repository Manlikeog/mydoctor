import 'package:flutter/material.dart';

class ScheduleTile extends StatelessWidget {
  final String? title;
  final String? startTime;
  final String? endTime;
  final String? date;
  final String? docId;
  final Function()? onLongPress;
  final Function()? onPress;

  const ScheduleTile(
      {Key? key,
      this.title,
      this.startTime,
      this.endTime,
      this.date,
      this.docId,
      this.onLongPress,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'SLOT: ',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$title',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: <Widget>[
                    const Text(
                      'Start Time: ',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      '$startTime',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      'EndTime: ',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      '$endTime',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Text(
                      'Date: ',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$date',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
