import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:genchi_web/components/appBar.dart';
import 'package:genchi_web/components/circular_progress.dart';
import 'package:genchi_web/components/display_picture.dart';
import 'package:genchi_web/components/task_preview.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/models/task.dart';
import 'package:genchi_web/components/task_card.dart';
import 'package:genchi_web/models/user.dart';
import 'package:genchi_web/services/authentication_service.dart';
import 'package:genchi_web/services/firestore_api_service.dart';
import 'package:genchi_web/services/task_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OpportunitiesScreen extends StatefulWidget {
  static const id = '/opportunities';

  @override
  _OpportunitiesScreenState createState() => _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends State<OpportunitiesScreen> {
  FirestoreAPIService firestoreAPI = FirestoreAPIService();

  String filter = 'ALL';
  Future searchTasksFuture;
  bool showSpinner = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchTasksFuture = firestoreAPI.fetchTasksAndHirers();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskService>(context);
    final authProvider = Provider.of<AuthenticationService>(context);
    GenchiUser currentUser = authProvider.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            color: Color(kGenchiGreen),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        // _index = 0;
                      });
                    },
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight:
                            MediaQuery.of(context).size.height *
                                0.07),
                        child: Image.asset('images/Logo_Only.png')),
                  ),

                  Text(authProvider.currentUser.name),
                  // Expanded(
                  //   flex: 1,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       TextButton(
                  //         onPressed: () {
                  //
                  //           Navigator.pushNamedAndRemoveUntil(context, OpportunitiesScreen.id,
                  //                   (Route<dynamic> route) => false);
                  //         },
                  //         // highlightColor: Colors.transparent,
                  //         // splashColor: Colors.transparent,
                  //         // hoverColor: Colors.transparent,
                  //         child: Text(
                  //           'Opportunities',
                  //           style: TextStyle(
                  //               color: Colors.white, fontSize: 20),
                  //         ),
                  //       ),
                  //       SizedBox(width: 20,),
                  //       TextButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             // _index = 1;
                  //           });
                  //         },
                  //         // highlightColor: Colors.transparent,
                  //         // splashColor: Colors.transparent,
                  //         // hoverColor: Colors.transparent,
                  //         child: Text(
                  //           'Team',
                  //           style: TextStyle(
                  //               color: Colors.white, fontSize: 20),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text('OPPORTUNITIES',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
          ),
          ModalProgressHUD(
            inAsyncCall: showSpinner,
            progressIndicator: CircularProgress(),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width > 400 ? 40 : 10,
                  vertical: 0),
              child: Column(
                children: [
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    constraints: BoxConstraints(
                      minHeight: 200,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(44)),
                        color: Color(0xffEFEDE7)),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: FutureBuilder(
                        future: searchTasksFuture,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container(
                              height: 80,
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(kGenchiOrange),
                                  ),
                                  strokeWidth: 3.0,
                                ),
                              ),
                            );
                          }

                          final List<Map<String, dynamic>> tasksAndHirers =
                              snapshot.data;

                          // final List<Widget> widgets = [];
                          if (tasksAndHirers.isEmpty) {
                            return Container(
                              height: 40,
                              child: Center(
                                child: Text(
                                  'No opportunities yet. Check again later',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            );
                          } else {
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:
                                          MediaQuery.of(context).size.width > 1000
                                              ? 2
                                              : 1,
                                      childAspectRatio: 3),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: tasksAndHirers.length,
                              itemBuilder: (context, index) {
                                Map taskAndHirer = tasksAndHirers[index];
                                Task task = taskAndHirer['task'];
                                GenchiUser hirer = taskAndHirer['hirer'];

                                if ((task.service == filter) ||
                                    (filter == 'ALL')) {
                                  return WebTaskCard(
                                    hirer: hirer,
                                    newTask: task.time
                                            .toDate()
                                            .difference(DateTime.now())
                                            .inHours >
                                        -36,
                                    imageURL: hirer.displayPictureURL,
                                    task: task,
                                    onTap: () async {
                                      // setState(() {
                                      //   showSpinner = true;
                                      // });
                                      //
                                      await taskProvider.updateCurrentTask(
                                          taskId: task.taskId);

                                      // setState(() {
                                      //   showSpinner = false;
                                      // });

                                      // showModalBottomSheet(context: context, builder: (context) => Container(
                                      //   height: 50,
                                      //   color: Colors.green,
                                      // ));

                                      showBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) => Center(
                                          child: TaskPreview(
                                              hirer: hirer, task: task),
                                        ),
                                      );

                                      ///Check whether it is the users task or not
                                      // bool isUsersTask =
                                      //     taskProvider.currentTask.hirerId ==
                                      //         currentUser.id;

                                      // if (isUsersTask) {
                                      //   Navigator.pushNamed(
                                      //       context, TaskScreenHirer.id);
                                      // } else {
                                      //   ///If viewing someone else's task, add their id to the viewedIds if it hasn't been added yet
                                      //   if (!taskProvider.currentTask.viewedIds
                                      //       .contains(currentUser.id))
                                      //     await firestoreAPI.addViewedIdToTask(
                                      //         viewedId: currentUser.id,
                                      //         taskId: task.taskId);
                                      //   Navigator.pushNamed(
                                      //       context, TaskScreenApplicant.id);
                                      // }
                                    },
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
