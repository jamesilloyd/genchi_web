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

  @override
  Widget build(BuildContext context) {
    previewTotalHeight = MediaQuery.of(context).size.height * 0.75 - 40;
    previewTotalWidth = MediaQuery.of(context).size.width * 0.5 - 40;
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
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.75,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: previewTotalHeight * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LargeDisplayPicture(
                    imageUrl: hirer.displayPictureURL,
                    height: previewTotalWidth * 0.3,
                  ),
                  SizedBox(
                    width: previewTotalWidth * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AutoSizeText(
                            task.title,
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: AutoSizeText(
                            hirer.name,
                            style: TextStyle(
                                fontSize: 30, color: Color(kGenchiOrange)),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: AutoSizeText(
                            hirer.bio,
                            style: TextStyle(fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: previewTotalWidth * 0.05,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: previewTotalHeight * 0.4,
              child: ListView(
                children: [
                  Divider(height: 0,),
                  AutoSizeText(
                    'Application Deadline',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  AutoSizeText(
                    task.hasFixedDeadline && task.applicationDeadline != null
                        ? getApplicationDeadline(
                            time: task.applicationDeadline)
                        : 'OPEN',
                    style: task.hasFixedDeadline &&
                            task.applicationDeadline != null
                        ? kBodyTextStyle
                        : TextStyle(
                            fontSize: 20, color: Color(kGenchiOrange)),
                  ),
                  AutoSizeText(
                    'Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  AutoSizeText(
                    task.details,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              height: previewTotalHeight * 0.3,
              child: Column(
                children: [
                  Expanded(flex: 1, child: AutoSizeText('Want to apply?',style: TextStyle(
                    fontSize: 35,
                    color: Color(kGenchiOrange)
                  ),)),
                  Expanded(flex: 1, child: AutoSizeText('Create an account on the app',style: TextStyle(
                      fontSize: 30,
                  ),)),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        
                        
                        MaterialButton(
                          child: Container(
                            height: previewTotalHeight*0.2*0.5,
                            child: Image.asset('images/badges/app_store_badge.png'),
                          ),
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onPressed: ()async{

                            if (await canLaunch(kAppStoreURL)) {
                            await launch(kAppStoreURL);
                            } else {
                            print("Could not open URL");
                            }

                          },
                        ),
                        MaterialButton(
                          child: Container(
                            height: previewTotalHeight*0.2*0.5,
                            child: Image.asset('images/badges/google-play-badge.png'),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
