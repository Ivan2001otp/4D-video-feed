import 'package:flutter/material.dart';

class VideoIndexProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  ValueNotifier<int> _videoIndexNotifier = ValueNotifier(0);
  ValueNotifier<int> get videoIndexNotifier => _videoIndexNotifier;


  void setNotifierValue(int val) {
    _videoIndexNotifier.value = val;
    notifyListeners();
  }

  void set(int val) {
    _currentIndex = val;
    notifyListeners();
  }

  
}
