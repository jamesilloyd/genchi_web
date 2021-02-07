import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:genchi_web/components/display_picture.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/models/task.dart';
import 'package:genchi_web/models/user.dart';
import 'package:genchi_web/services/time_formatting.dart';

class WebTaskCard extends StatelessWidget {
  final Task task;
  final bool orangeBackground;
  final String imageURL;
  final Function onTap;
  final bool isDisplayTask;
  final bool hasUnreadMessage;
  final bool newTask;
  final GenchiUser hirer;

  const WebTaskCard(
      {Key key,
        @required this.task,
        this.orangeBackground = false,
        @required this.imageURL,
        @required this.onTap,
        this.isDisplayTask = true,
        @required this.hirer,
        this.newTask = false,
        this.hasUnreadMessage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(

        clipBehavior: Clip.hardEdge,
        // style: ButtonStyle(
        //   foregroundColor: Color(kGenchiCream),
        //
        //   splashColor: Colors.transparent,
        //   highlightColor: Colors.black12,
        // ),
        // elevation: 0,

        onPressed: onTap,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: ListDisplayPicture(
                      imageUrl: imageURL,
                      height: 56,
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (newTask)
                            Text(
                              'New',
                            ),
                          Text(
                            task.title,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: hasUnreadMessage
                                    ? FontWeight.w500
                                    : FontWeight.w400),
                          ),
                          Text(
                            task.hasFixedDeadline &&
                                task.applicationDeadline != null
                                ? "Apply by " +
                                getShortApplicationDeadline(
                                    time: task.applicationDeadline)
                                : 'Open application',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(hirer.university,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(kGenchiOrange)
                    ),),
                ],
              ),
              SizedBox(height: 10),
              //TODO: sort out the overflow on this
              Text(
                task.details,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



