import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:genchi_web/components/basic_nav_bar.dart';
import 'package:genchi_web/components/platform_alerts.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/models/preferences.dart';
import 'package:genchi_web/models/user.dart';
import 'package:genchi_web/screens/opportunities_screen.dart';
import 'package:genchi_web/screens/post_reg_details_screen.dart';
import 'package:genchi_web/services/account_service.dart';
import 'package:genchi_web/services/authentication_service.dart';
import 'package:genchi_web/services/firestore_api_service.dart';
import 'package:provider/provider.dart';

class PreferencesScreen extends StatefulWidget {
  static const String id = '/preferences';

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  TextEditingController otherValuesController = TextEditingController();

  FirestoreAPIService firestoreAPI = FirestoreAPIService();

  bool chip1 = false;
  bool changesMade = false;

  List<Tag> allTags = List.generate(
      originalTags.length, (index) => Tag.fromTag(originalTags[index]));

  List<Widget> _chipBuilder(
      {@required List<Tag> values, @required String filter}) {
    List<Widget> widgets = [];

    for (Tag tag in values) {
      if (tag.category == filter) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7),
            child: MaterialButton(
              highlightColor: Colors.transparent,
              padding: EdgeInsets.zero,
              onPressed: () {
                changesMade = true;
                setState(() {
                  tag.selected = !tag.selected;
                });
              },
              child: Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: Text(
                    tag.displayName,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                ),
                decoration: BoxDecoration(
                    color: tag.selected
                        ? Color(kGenchiLightOrange)
                        : Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  List<Widget> _otherChipBuilder({@required List<Tag> values}) {
    List<Widget> widgets = [];
    for (Tag tag in values) {
      if (tag.category == 'other') {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7),
            child: Chip(
              label: Text(tag.displayName),
              backgroundColor: Color(kGenchiLightOrange),
              onDeleted: () {
                allTags.remove(tag);
                setState(() {});
              },
            ),
          ),
        );
      }
    }

    return widgets;
  }

  @override
  void initState() {
    super.initState();
    final accountService = Provider.of<AccountService>(context, listen: false);
    GenchiUser currentUser = accountService.currentAccount;
    if (currentUser != null) {
      for (String preference in currentUser.preferences) {
        bool found = false;

        ///if preference in opps values mark as true
        for (Tag tag in allTags) {
          if (preference == tag.databaseValue) {
            tag.selected = true;
            found = true;
          }
        }

        /// if nothing then add to other values
        if (!found) {
          allTags.add(Tag(
              databaseValue: preference,
              displayName: preference,
              selected: true,
              category: 'other'));
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    otherValuesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AccountService accountService = Provider.of<AccountService>(context);
    GenchiUser currentAccount = accountService.currentAccount;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          children: [
            BasicNavBar(),
            SizedBox(height: 15),
            Center(
              child: Text(
                'Preferences',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            Divider(
              thickness: 1,
              endIndent: MediaQuery.of(context).size.width * 0.25,
              indent: MediaQuery.of(context).size.width * 0.25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'What type of opportunities are you after?',
                  textAlign: TextAlign.center,
                  style: kTitleTextStyle,
                ),
                IconButton(
                  icon: Icon(
                    Icons.help_outline_outlined,
                    size: 18,
                  ),
                  onPressed: () async {
                    await showDialogBox(
                        context: context,
                        title: 'Types of Opportunities',
                        body:
                            'Select the type of opportunities you are after and we will optimise our platform to get you these opportunities.');
                  },
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: 400,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: _chipBuilder(values: allTags, filter: 'type'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'In what areas?',
                      style: kTitleTextStyle,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.help_outline_outlined,
                        size: 18,
                      ),
                      onPressed: () async {
                        await showDialogBox(
                            context: context,
                            title: 'Areas',
                            body:
                                'Select the areas you would like the opportunities to be in.');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 400,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: _chipBuilder(values: allTags, filter: 'area'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'What specifications?',
                      style: kTitleTextStyle,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.help_outline_outlined,
                        size: 18,
                      ),
                      onPressed: () async {
                        await showDialogBox(
                            context: context,
                            title: 'Specification',
                            body:
                                'Select the constraints you want for these opportunities.');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 400,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: _chipBuilder(values: allTags, filter: 'spec'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 1,
              endIndent: MediaQuery.of(context).size.width * 0.25,
              indent: MediaQuery.of(context).size.width * 0.25,
            ),
            SizedBox(height: 10),
            Center(
              child: MaterialButton(
                onPressed: ()async {

                  List allPreferences = [];

                  for (Tag tag in allTags) {
                    if (tag.selected) allPreferences.add(tag.databaseValue);
                  }

                  currentAccount.preferences = allPreferences;
                  currentAccount.hasSetPreferences = true;

                  await firestoreAPI.updateUser(
                      uid: currentAccount.id, user: currentAccount);

                  await Provider.of<AuthenticationService>(context,
                      listen: false)
                      .updateCurrentUserData();

                    ///Move on to the next page
                  Navigator.pushNamedAndRemoveUntil(
                      context, OpportunitiesScreen.id, (Route<dynamic> route)=> false);

                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(kGenchiOrange),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      'ENTER PLATFORM',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 400,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: _otherChipBuilder(values: allTags),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            )
          ],
        ),
      ),
    );
  }
}
