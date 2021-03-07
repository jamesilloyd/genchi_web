import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:genchi_web/components/display_picture.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/models/task.dart';
import 'package:genchi_web/models/user.dart';
import 'package:genchi_web/services/time_formatting.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskPreview extends StatelessWidget {
  Task task;
  GenchiUser hirer;

  TaskPreview({@required this.hirer, @required this.task});

  double previewTotalHeight;
  double previewTotalWidth;

  String _universities() {
    String unis = "";
    int count = 0;

    for (String uni in task.universities) {
      if (count == 0) {
        unis += uni;
      } else if (count == task.universities.length) {
        unis += 'and ${uni}';
      } else {
        unis += ', ${uni}';
      }
      count++;
    }

    return unis;
  }

  @override
  Widget build(BuildContext context) {
    previewTotalHeight = MediaQuery.of(context).size.height * 0.75;
    previewTotalWidth = MediaQuery.of(context).size.width > 650
        ? 650
        : MediaQuery.of(context).size.width * 0.9;
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Color(kGenchiCream),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: previewTotalWidth + 30,
      height: previewTotalHeight + 30,
      child: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          SizedBox(
            width: previewTotalWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Flexible(
                  child: Center(
                    child: AutoSizeText(
                      task.title,
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.close),
                    iconSize: 20,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
          Divider(
            thickness: 1,
            height: 0,
          ),
          SizedBox(height: 10),
          SizedBox(
            height: previewTotalHeight * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: LargeDisplayPicture(
                      imageUrl: hirer.displayPictureURL,
                      height: previewTotalHeight * 0.2),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      hirer.name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),

          if (hirer.bio != '')
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: SelectableText(
                  hirer.bio,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
            ),
          SizedBox(height: 10),
          Center(
            child: AutoSizeText(
              'For Students At',
              maxLines: 1,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          Divider(
            thickness: 1,
            height: 0,
          ),
          Center(
            child: AutoSizeText(
              _universities(),
              maxLines: 1,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(height: 20),

          Center(
            child: AutoSizeText(
              'Application Deadline',
              maxLines: 1,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          Divider(
            thickness: 1,
            height: 0,
          ),
          Center(
            child: AutoSizeText(
              task.hasFixedDeadline && task.applicationDeadline != null
                  ? getApplicationDeadline(time: task.applicationDeadline)
                  : 'Open Application',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: AutoSizeText(
              'Details',
              maxLines: 1,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          Divider(
            thickness: 1,
            height: 0,
          ),
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: SelectableText(
                task.details,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 1,
            height: 10,
          ),
          //TODO: add in application button if it's a link apply otherwise just put the app links
          task.linkApplicationType
              ? MaterialButton(
                  onPressed: ()async {
                    ///Send them to the location
                    if (await canLaunch(task.applicationLink)) {
                    await launch(task.applicationLink);
                    } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(kApplicationLinkNotWorking);
                    print("Could not open URL");
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Color(kGenchiGreen),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Text(
                        'APPLY',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    Center(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Want to Apply?\n',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'FuturaPT',
                                  color: Color(kGenchiOrange),
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: 'Sign up on the app',
                              style: TextStyle(
                                  fontFamily: 'FuturaPT',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500)),
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          child: Container(
                            height: previewTotalHeight * 0.2 * 0.5,
                            child: Image.asset(
                                'images/badges/app_store_badge.png'),
                          ),
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onPressed: () async {
                            if (await canLaunch(kAppStoreURL)) {
                              await launch(kAppStoreURL);
                            } else {
                              print("Could not open URL");
                            }
                          },
                        ),
                        MaterialButton(
                          child: Container(
                            height: previewTotalHeight * 0.2 * 0.5,
                            child: Image.asset(
                                'images/badges/google-play-badge.png'),
                          ),
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onPressed: () async {
                            if (await canLaunch(kPlayStoreURL)) {
                              await launch(kPlayStoreURL);
                            } else {
                              print("Could not open URL");
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
