import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  
  int _selectedMenuOption = 0;

  int get selectedMenuOption {
    return this._selectedMenuOption;
  }

  set selectedMenuOption(int index) {
    this._selectedMenuOption = index;
    notifyListeners();
  }




}