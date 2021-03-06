import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColorBrightness: Brightness.dark,
          platform: TargetPlatform.iOS),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class AmbientCategory {
  String name;
  AmbientCategory(this.name);
}

class HomeState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<AmbientCategory> _tabList;
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    _initTabData();
    _initTabController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wall Ambient"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            height: 50,
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.white38,
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: _tabList.map((item) => Tab(text: item.name)).toList(),
            ),
          ),
          Container(
            color: Colors.black,
            height: 10,
          ),
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _tabList
                  .map((item) => Center(child: Text(item.name)))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _initTabData() {
    _tabList = [
      AmbientCategory('InFrame'),
      AmbientCategory('Decor'),
      AmbientCategory('Art'),
      AmbientCategory('My Colleciton'),
      AmbientCategory('Background Theme')
    ];
  }

  void _initTabController() {
    _tabController = TabController(
      length: _tabList.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _onPageChanged(_tabController.index);
      }
    });
  }

  void _onPageChanged(int index) async {
    await _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
