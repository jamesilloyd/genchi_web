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
  static const id = 'opportunities_screen';

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Color(kGenchiGreen),
          centerTitle: true,
          actions: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 70, 0),
                child: MaterialButton(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  child: AutoSizeText('Back to Landing Page',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      )),
                  onPressed: () async {

                    if(await canLaunch('https://www.genchi.app')){
                      launch('https://genchi.app');
                    } else {
                      print('could not launch');
                    }
                  },
                ),
              ),
            )
          ],
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset(
              'images/Logo_Only.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      // appBar: BasicAppNavigationBar(),
      backgroundColor: Color(kGenchiCream),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text('Opportunities', style: kHeaderTextStyle),
          ),
          ModalProgressHUD(
            inAsyncCall: showSpinner,
            progressIndicator: CircularProgress(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
              child: Column(
                // physics: AlwaysScrollableScrollPhysics(),
                // padding: const EdgeInsets.symmetric(horizontal: 15.0),
                children: [
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'FEED',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      // SizedBox(
                      //     child: Align(
                      //       alignment: Alignment.bottomCenter,
                      //       child: PopupMenuButton(
                      //           elevation: 1,
                      //           child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.end,
                      //               children: <Widget>[
                      //                 Text(
                      //                   filter.toUpperCase(),
                      //                   style: TextStyle(fontSize: 20),
                      //                 ),
                      //                 SizedBox(width: 5),
                      //                 ImageIcon(
                      //                   AssetImage('images/filter.png'),
                      //                   color: Colors.black,
                      //                   size: 30,
                      //                 ),
                      //                 SizedBox(
                      //                   width: 5,
                      //                 )
                      //               ]),
                      //           itemBuilder: (_) {
                      //             List<PopupMenuItem<String>> items = [
                      //               const PopupMenuItem<String>(
                      //                   child: const Text('ALL'), value: 'ALL'),
                      //             ];
                      //             for (Service service in servicesList) {
                      //               items.add(
                      //                 new PopupMenuItem<String>(
                      //                     child: Text(
                      //                         service.databaseValue.toUpperCase()),
                      //                     value: service.databaseValue),
                      //               );
                      //             }
                      //             return items;
                      //           },
                      //           onSelected: (value) {
                      //             setState(() {
                      //               filter = value;
                      //             });
                      //           }),
                      //     )),
                    ],
                  ),
                  Divider(
                    height: 5,
                    thickness: 1,
                  ),
                  FutureBuilder(
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
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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

                            if ((task.service == filter) || (filter == 'ALL')) {
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
                                      child:
                                          TaskPreview(hirer: hirer, task: task),
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
