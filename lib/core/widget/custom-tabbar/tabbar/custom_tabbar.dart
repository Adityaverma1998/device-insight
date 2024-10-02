import 'package:flutter/material.dart';

class CustomTabbarScreen extends StatefulWidget {

  final List<String> tabLists;
  final List<Widget> tabWidgets;


  CustomTabbarScreen({required this.tabLists, required this.tabWidgets});

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
      length: widget.tabLists.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // color: Colors.red,
            margin: const EdgeInsets.only(bottom: 8.0,left: 16.0,right: 16.0),
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(18.0)),
              child: TabBar(
                // tabAlignment: TabAlignment.center,

                tabs: List.generate(
                  widget.tabLists.length,
                      (index) => Tab(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Text(
                        widget.tabLists[index],

                      ),
                    ),
                  ),
                ),
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                padding: EdgeInsets.zero,
                dividerHeight: 0,
                dividerColor: Colors.transparent,
                labelPadding: EdgeInsets.zero,
                unselectedLabelColor: Color.fromRGBO(217, 217, 217, 0.72),
                labelColor: Theme.of(context).primaryColor,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.5,
                  ),
                ),
                indicatorPadding: EdgeInsets.zero,
                labelStyle:  Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  height: 1.3,
                ),

              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
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
