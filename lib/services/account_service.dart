import 'package:flutter/material.dart';
import 'package:genchi_web/models/user.dart';
import 'firestore_api_service.dart';



class AccountService extends ChangeNotifier {

  final FirestoreAPIService _firestoreCRUDModel = FirestoreAPIService();

  GenchiUser _currentAccount;
  GenchiUser get currentAccount => _currentAccount;

  Future updateCurrentAccount({String id}) async {

    print("updateCurrentAccount called: populating account with $id");
    if (id != null) {
      GenchiUser account = await _firestoreCRUDModel.getUserById(id);
      if(account!=null) {
        _currentAccount = account;
        notifyListeners();
      }
    }

    //TODO how to handle null hirer
  }


}
