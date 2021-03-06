import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:newsapp/src/pages/tab3_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: Navigation(),
      ),
    );
  }
}

class Navigation extends StatelessWidget {
  const Navigation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    return BottomNavigationBar(
      currentIndex: navigationModel.currentPage,
      onTap: (i) => navigationModel.currentPage = i,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.star_border), label: "Top"),
        BottomNavigationBarItem(
            icon: Icon(Icons.category), label: "Categories"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "My News"),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    return PageView(
      controller: navigationModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab1Page(),
        Tab2Page(),
        Tab3Page(),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentPage = 0;
  PageController _pageController = PageController();

  int get currentPage => this._currentPage;
  set currentPage(int value) {
    this._currentPage = value;
    this._pageController.animateToPage(value,
        duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
