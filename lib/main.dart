import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/pages/home_screen.dart';
import 'package:qr_reader/pages/map_screen.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';


void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  final ThemeData themeData = ThemeData(
    primaryColor: Colors.deepPurple,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.deepPurple
    )
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => new UIProvider()),
        ChangeNotifierProvider(create: ( _ ) => new ScanListProvider())
      ],
      child: MaterialApp(
        title: 'QR Reader',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home' : ( _ ) => HomeScreen(),
          'map'  : ( _ ) => MapScreen()
        },
        theme: this.themeData
      ),
    );
  }
}