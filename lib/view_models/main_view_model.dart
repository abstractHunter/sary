import 'package:flutter/material.dart';
import 'package:sary/models/anniversary.dart';
import 'package:sary/models/anniversary_database.dart';

class MainViewModel with ChangeNotifier {
  bool loading = false;
  List<Anniversary> anniversaries = [];
  AnniversaryDatabase database = AnniversaryDatabase.instance;

  MainViewModel() {
    getAnniversaries();
  }

  Future<void> getAnniversaries() async {
    loading = true;
    notifyListeners();

    anniversaries = await database.readAllAnniversaries();

    loading = false;
    notifyListeners();
  }

  Future<void> createAnniversary(Anniversary anniversary) async {
    loading = true;
    notifyListeners();

    await database.create(anniversary);
    anniversaries = await database.readAllAnniversaries();

    loading = false;
    notifyListeners();
  }

  Future<void> updateAnniversary(Anniversary anniversary) async {
    loading = true;
    notifyListeners();

    await database.update(anniversary);
    anniversaries = await database.readAllAnniversaries();

    loading = false;
    notifyListeners();
  }

  Future<void> deleteAnniversary(int id) async {
    loading = true;
    notifyListeners();

    await database.delete(id);
    anniversaries = await database.readAllAnniversaries();

    loading = false;
    notifyListeners();
  }
}
