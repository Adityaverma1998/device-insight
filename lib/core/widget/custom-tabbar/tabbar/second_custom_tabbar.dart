import 'package:flutter/material.dart';

class SecondCustomTabbar extends StatefulWidget {
  final List<String> tabLists;
  final List<Widget> tabWidgets;

  const SecondCustomTabbar({
    super.key,
    required this.tabLists,
    required this.tabWidgets,
  });

  @override
  _SecondCustomTabbarState createState() => _SecondCustomTabbarState();
}

class _SecondCustomTabbarState extends State<SecondCustomTabbar> {
  int current = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          /// Tab Bar
          SizedBox(
            height: 80,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: widget.tabLists.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      current = index;
                    });
                    pageController.animateToPage(
                      current,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    width: 100,
                    height: 55,
                    decoration: BoxDecoration(
                      color: current == index ? Colors.white70 : Colors.white54,
                      borderRadius: BorderRadius.circular(current == index ? 12 : 7),
                      border: current == index
                          ? Border.all(color: Colors.deepPurpleAccent, width: 2.5)
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        widget.tabLists[index], // Displaying the correct tab name
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: current == index ? Colors.black : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// Page View
          // Expanded(
          //   child: PageView.builder(
          //     itemCount: widget.tabWidgets.length,
          //     controller: pageController,
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemBuilder: (context, index) {
          //       return widget.tabWidgets[index]; // Displaying the corresponding widget
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
