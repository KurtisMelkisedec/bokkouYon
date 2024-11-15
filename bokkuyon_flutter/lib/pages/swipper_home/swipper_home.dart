import 'dart:async';

import 'package:bokkuyon/pages/swipper_home/first_swipper_page/first_swipper_page.dart';
import 'package:bokkuyon/pages/swipper_home/second_swipper_page/second_swipper_page.dart';
import 'package:bokkuyon/pages/swipper_home/third_swipper_page/third_swipper_page.dart';
import 'package:flutter/material.dart';

class SwipperHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  => _SwipperHome();
  
}
class _SwipperHome extends State<SwipperHome> {
  final PageController _pageController =PageController();
  Timer? _timer;
  int _currentPage =0;

  void startAutoScroll(){
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer){
       if (_currentPage<2) {
         _currentPage++;
       }
      
      _pageController.animateToPage(_currentPage, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });
  }

  @override
  void initState() {
    super.initState();
    startAutoScroll();
  }
  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page){
           _currentPage =page;
           startAutoScroll();
           
        },
        children: <Widget>[
          FirstSwipperPage(),
          SecondSwipperPage(),
          ThirdSwipperPage(),
        ],
      ),
    );
  }
  
}