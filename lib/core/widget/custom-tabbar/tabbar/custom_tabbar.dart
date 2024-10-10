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
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color:Colors.red,
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: TabBar(

              tabs: List.generate(
                widget.tabLists.length,
                    (index) => Tab(
                  child: Center(
                    child: Text(widget.tabLists[index]),
                  ),
                ),
              ),
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: const Color.fromRGBO(217, 217, 217, 0.72),
              labelColor: Theme.of(context).primaryColor,
              indicator: ShapeDecoration(
                color: Colors.blue,
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
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            height: MediaQuery.of(context).size.height * 0.8,
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
