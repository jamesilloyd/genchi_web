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
          SizedBox(height: 20),
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
                          ?  getApplicationDeadline(time: task.applicationDeadline)
                  : 'OPEN APPLICATION',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          // Container(
          //   height: previewTotalHeight * 0.3,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       LargeDisplayPicture(
          //         imageUrl: hirer.displayPictureURL,
          //         height: previewTotalWidth * 0.3,
          //       ),
          //       SizedBox(
          //         // width: MediaQuery.of(context).size.width > 650 ? previewTotalWidth*0.53 :previewTotalWidth * 0.3,
          //         width:  previewTotalWidth*0.63,
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Expanded(
          //               flex: 1,
          //               child: AutoSizeText(
          //                 task.title,
          //                 style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500),
          //               ),
          //             ),
          //             Expanded(
          //               flex: 1,
          //               child: AutoSizeText(
          //                 hirer.name,
          //                 style: TextStyle(
          //                     fontSize: 30, color: Color(kGenchiOrange)),
          //               ),
          //             ),
          //             Expanded(
          //               flex: 3,
          //               child: AutoSizeText(
          //                 hirer.bio,
          //                 style: TextStyle(fontSize: 14),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //       Align(
          //         alignment: Alignment.topRight,
          //         child: IconButton(
          //             icon: Icon(Icons.close),
          //             iconSize: 20,
          //             onPressed: () {
          //               Navigator.pop(context);
          //             }),
          //       )
          //     ],
          //   ),
          // ),
          // Divider(height:0, thickness: 1,),
          // Container(
          //   height: previewTotalHeight * 0.4,
          //   child: ListView(
          //     children: [
          //       Divider(height: 0,),
          //       AutoSizeText(
          //         task.hasFixedDeadline && task.applicationDeadline != null
          //             ? 'Application Deadline: ' + getApplicationDeadline(
          //             time: task.applicationDeadline)
          //             : 'Application Deadline: OPEN APPLICATION',
          //         style:
          //             TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          //       ),
          //       AutoSizeText(
          //         'Details',
          //         style: TextStyle(
          //
          //             fontWeight: FontWeight.w500, fontSize: 16),
          //       ),
          //       AutoSizeText(
          //         task.details,
          //         textAlign: TextAlign.start,
          //         style: TextStyle(fontSize: 14),
          //       ),
          //     ],
          //   ),
          // ),
          // Divider(height:0,thickness: 1,),
          // Container(
          //   height: previewTotalHeight * 0.3,
          //   child: Column(
          //     children: [
          //       Expanded(flex: 1, child: AutoSizeText('Want to apply?',style: TextStyle(
          //         fontSize: 35,
          //         color: Color(kGenchiOrange)
          //       ),)),
          //       Expanded(flex: 1, child: AutoSizeText('Create an account on the app',style: TextStyle(
          //           fontSize: 30,
          //       ),)),
          //       Expanded(
          //         flex: 2,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: [
          //
          //
          //             MaterialButton(
          //               child: Container(
          //                 height: previewTotalHeight*0.2*0.5,
          //                 child: Image.asset('images/badges/app_store_badge.png'),
          //               ),
          //               splashColor: Colors.transparent,
          //               hoverColor: Colors.transparent,
          //               highlightColor: Colors.transparent,
          //               focusColor: Colors.transparent,
          //               onPressed: ()async{
          //
          //                 if (await canLaunch(kAppStoreURL)) {
          //                 await launch(kAppStoreURL);
          //                 } else {
          //                 print("Could not open URL");
          //                 }
          //
          //               },
          //             ),
          //             MaterialButton(
          //               child: Container(
          //                 height: previewTotalHeight*0.2*0.5,
          //                 child: Image.asset('images/badges/google-play-badge.png'),
          //               ),
          //               splashColor: Colors.transparent,
          //               hoverColor: Colors.transparent,
          //               highlightColor: Colors.transparent,
          //               focusColor: Colors.transparent,
          //               onPressed: () async {
          //                 if (await canLaunch(kPlayStoreURL)) {
          //                   await launch(kPlayStoreURL);
          //                 } else {
          //                   print("Could not open URL");
          //                 }
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
