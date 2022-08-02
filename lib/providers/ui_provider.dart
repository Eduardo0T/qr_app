
import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier{
  int _selectedIndex = 0;

  int get selectedIndex {
    return _selectedIndex;
  }

  set selectedIndex(int i){
    _selectedIndex = i;
    notifyListeners();
  }
}