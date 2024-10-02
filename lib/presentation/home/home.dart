import 'package:device_insight/core/widget/custom-tabbar/tabbar-view/battery_info_screen.dart';
import 'package:device_insight/core/widget/custom-tabbar/tabbar/custom_tabbar.dart';
import 'package:device_insight/core/widget/primary_layout/primary_layout.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget{

  State<HomeScreen> createState()  => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{


   List<String> tabLists =['Dashboard'];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PrimaryLayout(
      child: Column(
        children: [
          CustomTabbarScreen(
            tabLists: tabLists, tabWidgets: [BatteryInfoScreen(),],
          )
        ],
      ),
    );
  }

}
