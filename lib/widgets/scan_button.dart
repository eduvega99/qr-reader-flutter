import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {

        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3d8bef', 'Cancelar', true, ScanMode.QR);
        // final barcodeScanRes = 'https://youtube.com';
        // final barcodeScanRes = 'geo:28.121097,-15.506593';

        if (barcodeScanRes == '-1') {
          return;
        }

        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        // scanListProvider.newScan(barcodeScanRes);
        final newScan = await scanListProvider.newScan(barcodeScanRes);

        launchURL(context, newScan);
        // scanListProvider.loadScans();
        // final foo = scanListProvider.scans;
        // print(scanListProvider.typeSelected);
        // print(foo.length);
      }
    );
  }
}