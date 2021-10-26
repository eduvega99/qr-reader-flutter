import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_models.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  
  List<ScanModel> scans = [];
  String typeSelected   = 'http';

  Future<ScanModel> newScan(String value) async {
    final newScan = new ScanModel(value: value);
    final id = await DBProvider.db.insertScan(newScan);
    newScan.id = id;

    if(this.typeSelected == newScan.type) {
      this.scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.getScansByType(type);
    this.scans = [...scans];
    this.typeSelected = type;
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    // this.loadScansByType(this.typeSelected);
  }
}