import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String? photoUrl;
  final String? userName;
  final Function()? onPress;
  final bool? request;
  final Function()? accept;
  final Function()? decline;

  const UserTile(
      {Key? key,
      this.photoUrl,
      this.userName,
      this.onPress,
      this.accept,
      this.decline,
      this.request = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 24,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: photoUrl != null
                  ? FadeInImage(
                      image: NetworkImage(photoUrl!),
                      placeholder:
                          const AssetImage('assets/images/blurblue.png'),
                    )
                  : Image.asset('assets/images/blurblue.png'),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    '$userName',
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Visibility(
                visible: request!,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: accept,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(0xFF0A0E21),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    GestureDetector(
                      onTap: decline,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        child: const Icon(
                          Icons.close,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      onTap: onPress,
    );
  }
}
