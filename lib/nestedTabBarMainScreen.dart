import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NestedTabBarMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NestedTabBar(),
    );
  }
}

class NestedTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("AppBarDemo")),
          backgroundColor: Colors.grey,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Tab1",
                icon: Icon(Icons.contact_phone),
              ),
              Tab(
                text: "Tab2",
                icon: Icon(Icons.person),
              ),
              Tab(
                text: "Tab3",
                icon: Icon(Icons.phone),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NestedTabBarView("Tab1"),
            NestedTabBarView("Tab2"),
            NestedTabBarView("Tab3"),
          ],
        ),
      ),
    );
  }
}

class NestedTabBarView extends StatefulWidget {
  const NestedTabBarView(this.outerTab, {super.key});

  final String outerTab;

  @override
  State<NestedTabBarView> createState() => _NestedTabBarViewState();
}

class _NestedTabBarViewState extends State<NestedTabBarView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: tabController,
          tabs: const[
            Tab(text: 'Overview'),
            Tab(text: 'Specifications'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children:[
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Center(child: Text('${widget.outerTab}: Overview tab')),
              ),
              Card(
                margin: const EdgeInsets.all(16.0),
                child: Center(
                    child: Text('${widget.outerTab}: Specifications tab')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
