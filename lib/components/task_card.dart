import 'package:auto_size_text/auto_size_text.dart';
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
    return MaterialButton(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      color: Color(kGenchiCream),
      splashColor: Colors.transparent,
      highlightColor: Colors.black12,
      elevation: 2,
      onPressed: onTap,

      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,10,0),
                      child: ListDisplayPicture(
                        imageUrl: imageURL,
                        // TODO: need to set this programatically...
                        height: MediaQuery.of(context).size.width*0.05,
                      ),
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
                              Expanded(
                                flex: 1,
                                child: AutoSizeText(
                                  'New',
                                  style: TextStyle(color: Color(kGenchiOrange)),
                                ),
                              ),
                            Expanded(
                              flex: 2,
                              child: AutoSizeText(
                                task.title,
                                maxLines: 1,
                                minFontSize: 14,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: AutoSizeText(
                                task.hasFixedDeadline &&
                                        task.applicationDeadline != null
                                    ? "Apply by " +
                                        getShortApplicationDeadline(
                                            time: task.applicationDeadline)
                                    : 'Open application',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: AutoSizeText(
                      hirer.university,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(kGenchiOrange)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            //TODO: sort out the overflow on this
            Flexible(
              flex: 1,
              child: AutoSizeText(
                task.details,
                maxLines: MediaQuery.of(context).size.width < 1000 ? 6 : MediaQuery.of(context).size.width < 1300 ? 2 : 4,
                overflow: TextOverflow.ellipsis,
                minFontSize: 14,
                style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
