import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

import 'package:qr_reader/pages/directions_screen.dart';
import 'package:qr_reader/pages/maps_screen.dart';

import 'package:qr_reader/widgets/custom_navigation_bar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false).deleteAllScans();
            }, 
            icon: Icon(Icons.delete_forever)
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    
    final int currentIndex = uiProvider.selectedMenuOption;

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch ( currentIndex ) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return MapsScreen();
      case 1:
        scanListProvider.loadScansByType('http');
        return DirectionsScreen();
      default:
        return MapsScreen();
    }
  }
}