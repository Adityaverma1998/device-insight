import 'package:flutter/material.dart';

class CustomTabbarScreen extends StatefulWidget {

  final List<String> tabLists;
  final List<Widget> tabWidgets;


  const CustomTabbarScreen({super.key, required this.tabLists, required this.tabWidgets});

  @override
  State<CustomTabbarScreen> createState() => _CustomTabbarScreenState();
}

class _CustomTabbarScreenState extends State<CustomTabbarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int current = 0;
  PageController pageController = PageController();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabLists.length, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      initialIndex: 0,
      length: widget.tabLists.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(

            tabs: List.generate(
              widget.tabLists.length,
                  (index) => Tab(
                child: Center(
                  child: Text(widget.tabLists[index]),
                ),
              ),
            ),
            controller: _tabController,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Theme.of(context).colorScheme.secondaryContainer,
            labelColor: Theme.of(context).colorScheme.primaryContainer,
            indicator: ShapeDecoration(
              color:  Theme.of(context).colorScheme.secondaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),

            indicatorPadding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 4.0),
            labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              height: 0.5,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            height: MediaQuery.of(context).size.height * 0.81 +2 ,
            child: TabBarView(

              controller: _tabController,
              children: [
                ...widget.tabWidgets,

              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
