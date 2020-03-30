import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

class TabTitle {
  String title;
  int id;

  TabTitle(this.title, this.id);
}

class HomeState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController mTabController;
  PageController mPageController = PageController(initialPage: 0);
  List<TabTitle> tabList;
  var currentPage = 0;
  var isPageCanChanged = true;

  @override
  void initState() {
    super.initState();
    initTabData();
    mTabController = TabController(
      length: tabList.length,
      vsync: this,
    );

    mTabController.addListener(() {
      //TabBar listener
      if (mTabController.indexIsChanging) {
        print(mTabController.index);
        onPageChange(mTabController.index, p: mPageController);
      }
    });
  }

  initTabData() {
    tabList = [
      TabTitle('recommended', 10),
      TabTitle('hotspot', 0),
      TabTitle('Society', 1),
      TabTitle('Entertainment', 2),
      TabTitle('Sports', 3),
      TabTitle(' ', 4),
      TabTitle('Technology', 5),
      TabTitle(' ', 6),
      TabTitle('Fashion', 7)
    ];
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      //determine which switch is
      isPageCanChanged = false;
      await mPageController.animateToPage(index,
          duration: Duration(milliseconds: 500),
          curve: Curves
              .ease); //Wait for pageview to switch, then release pageivew listener
      isPageCanChanged = true;
    } else {
      mTabController.animateTo(index); //Switch Tabbar
    }
  }

  @override
  void dispose() {
    super.dispose();
    mTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color(0xffd43d3d),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.all_inclusive),
        backgroundColor: Color(0xffd43d3d),
        elevation: 2.0,
        highlightElevation: 2.0,
        onPressed: () {},
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Color(0xfff4f5f6),
            height: 38.0,
            child: TabBar(
              isScrollable: true,
              controller: mTabController,
              labelColor: Colors.red,
              unselectedLabelColor: Color(0xff666666),
              labelStyle: TextStyle(fontSize: 16.0),
              tabs: tabList.map((item) {
                return Tab(
                  text: item.title,
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: tabList.length,
              onPageChanged: (index) {
                if (isPageCanChanged) {
                  onPageChange(index);
                }
              },
              controller: mPageController,
              itemBuilder: (BuildContext context, int index) {
                return Text(tabList[index].title);
              },
            ),
          )
        ],
      ),
    );
  }
}
