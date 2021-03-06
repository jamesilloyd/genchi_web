import 'package:flutter/material.dart';
import 'package:genchi_web/components/basic_nav_bar.dart';
import 'package:genchi_web/components/circular_progress.dart';
import 'package:genchi_web/components/display_picture.dart';
import 'package:genchi_web/components/edit_account_text_field.dart';
import 'package:genchi_web/constants.dart';
import 'package:genchi_web/models/user.dart';
import 'package:genchi_web/screens/opportunities_screen.dart';
import 'package:genchi_web/services/account_service.dart';
import 'package:genchi_web/services/firestore_api_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';



//TODO: not ready for this yet, waiting for file picking functionality
class PostRegDetailsScreen extends StatefulWidget {
  static const String id = '/postregdetails';

  @override
  _PostRegDetailsScreenState createState() => _PostRegDetailsScreenState();
}

class _PostRegDetailsScreenState extends State<PostRegDetailsScreen> {
  bool showSpinner = false;

  TextEditingController bioController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();

  final FirestoreAPIService fireStoreAPI = FirestoreAPIService();

  @override
  void dispose() {
    super.dispose();
    bioController.dispose();
    categoryController.dispose();
    subCategoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final accountService = Provider.of<AccountService>(context);
    // GenchiUser currentUser = accountService.currentAccount;
    GenchiUser currentUser = GenchiUser(
        name: 'James Lloyd',
        displayPictureURL: null,
        accountType: 'Individual');
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        progressIndicator: CircularProgress(),
        child: ListView(
          children: <Widget>[
            BasicNavBar(),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Account Details',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            Divider(
              thickness: 1,
              endIndent: MediaQuery.of(context).size.width * 0.25,
              indent: MediaQuery.of(context).size.width * 0.25,
            ),
            Center(
              child: Text(
                currentUser.name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () {
                //TODO: completely change this...
                // showModalBottomSheet(
                //   context: context,
                //   isScrollControlled: true,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(20.0),
                //           topRight: Radius.circular(20.0))),
                //   builder: (context) => SingleChildScrollView(
                //     child: Container(
                //       padding: EdgeInsets.only(
                //           bottom:
                //           MediaQuery.of(context).viewInsets.bottom),
                //       child: Container(
                //           height:
                //           MediaQuery.of(context).size.height * 0.75,
                //           child: AddImageScreen()),
                //     ),
                //   ),
                // );
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  LargeDisplayPicture(
                    imageUrl: currentUser.displayPictureURL,
                    height: 0.25,
                    isEdit: true,
                  ),
                  Positioned(
                    right: (MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.height * 0.25) /
                        2,
                    top: MediaQuery.of(context).size.height * 0.2,
                    child: new Container(
                      height: 30,
                      width: 30,
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                          color: Color(kGenchiCream),
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Color(0xff585858), width: 2)),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Center(
                            child: Icon(
                          Icons.edit,
                          size: 20,
                          color: Color(0xff585858),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Display Picture',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Center(
              child: Container(
                width: 400,
                child: Column(
                  children: [
                    if (currentUser.accountType != 'Individual')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: 30.0,
                          ),
                          Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          PopupMenuButton(
                              elevation: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                    border: Border.all(color: Colors.black)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 20.0),
                                  child: Text(
                                    categoryController.text,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                              itemBuilder: (_) {
                                List<PopupMenuItem<String>> items = [];
                                for (GroupType groupType in groupsList) {
                                  var newItem = new PopupMenuItem(
                                    child: Text(
                                      groupType.databaseValue,
                                    ),
                                    value: groupType.databaseValue,
                                  );
                                  items.add(newItem);
                                }
                                return items;
                              },
                              onSelected: (value) async {
                                setState(() {
                                  categoryController.text = value;
                                });
                              }),
                        ],
                      ),
                    if (currentUser.accountType != 'Individual')
                      EditAccountField(
                        field: 'Subcategory',
                        hintText:
                            'What type of ${categoryController.text == "" ? currentUser.accountType.toLowerCase() : categoryController.text.toLowerCase()} are you?',
                        onChanged: (value) {
                          // changesMade = true;
                        },
                        textController: subCategoryController,
                      ),
                    EditAccountField(
                      field: "About",
                      onChanged: (value) {
                        //Update name
                        // changesMade = true;
                      },
                      textController: bioController,
                      hintText: currentUser.accountType == 'Individual'
                          ? 'College, Interests, Societies, etc.'
                          : 'Describe what you do you.',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ),

            Divider(
              thickness: 1,
              endIndent: MediaQuery.of(context).size.width * 0.25,
              indent: MediaQuery.of(context).size.width * 0.25,
            ),
            SizedBox(height: 10),
            Center(
              child: MaterialButton(
                onPressed: () async {
                  // await fireStoreAPI.updateUser(
                  //     user: GenchiUser(
                  //         bio: bioController.text,
                  //         category: categoryController.text,
                  //         subcategory: subCategoryController.text),
                  //     uid: currentUser.id);
                  //
                  // await accountService.updateCurrentAccount(id: currentUser.id);
                  //
                  // setState(() {
                  //   showSpinner = false;
                  // });
                  //
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, OpportunitiesScreen.id, (Route<dynamic> route) => false);
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(kGenchiOrange),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                    child: Text(
                      'ENTER THE PLATFORM',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
