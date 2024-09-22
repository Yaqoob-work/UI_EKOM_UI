// import 'package:mobi_tv_entertainment/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class TopNavigationBar extends StatefulWidget {
//   final int selectedPage;
//   final ValueChanged<int> onPageSelected;
//   final bool tvenableAll;

//   const TopNavigationBar({
//     required this.selectedPage,
//     required this.onPageSelected,
//     required this.tvenableAll,
//   });

//   @override
//   _TopNavigationBarState createState() => _TopNavigationBarState();
// }

// class _TopNavigationBarState extends State<TopNavigationBar> {
//   late List<FocusNode> _focusNodes;

//   @override
//   void initState() {
//     super.initState();
//     _focusNodes = List.generate(7, (index) => FocusNode());
//   }

//   @override
//   void dispose() {
//     for (var node in _focusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: cardColor,
//       // padding: const EdgeInsets.symmetric(vertical: 10),

//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                     Padding(
//                       padding:  EdgeInsets.symmetric(horizontal: screenwdt*0.1 ,vertical: 5),
//                       child: Flexible(
//                           flex: 1,
//                           child: _buildNavigationItem('', 0, _focusNodes[0])),
//                     ),
//                 ],
//               )),
//           Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Flexible(
//                     flex: 1,
//                     child: _buildNavigationItem('Vod', 1, _focusNodes[1])),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Flexible(
//                     flex: 1,
//                     child: _buildNavigationItem('Web Series', 2, _focusNodes[2])),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Flexible(
//                     flex: 1,
//                     child: _buildNavigationItem('Live TV', 3, _focusNodes[3])),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Flexible(
//                     flex: 1,
//                     child: _buildNavigationItem('Search', 4, _focusNodes[4])),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Flexible(
//                     flex: 1,
//                     child: _buildNavigationItem('Notification', 5, _focusNodes[5])),
//               ),
//               //  Flexible(flex: 1,child: _buildNavigationItem('Sports', 4, _focusNodes[4])),
//               //  Flexible(flex: 1,child: _buildNavigationItem('Religious', 5, _focusNodes[5])),
//               //  Flexible(flex: 1,child: _buildNavigationItem('Entertainment', 6, _focusNodes[6])),
//             ],
//           )),
//         ],
//       ),
//       //  )
//     );
//   }

//   Widget _buildNavigationItem(String title, int index, FocusNode focusNode) {
//   bool isSelected = widget.selectedPage == index;
//   return Focus(
//     focusNode: focusNode,
//     onFocusChange: (hasFocus) {
//       if (hasFocus) {
//         setState(() {});
//       }
//     },
//     onKeyEvent: (node, event) {
//       if (HardwareKeyboard.instance
//               .isLogicalKeyPressed(LogicalKeyboardKey.select) ||
//           HardwareKeyboard.instance
//               .isLogicalKeyPressed(LogicalKeyboardKey.enter)) {
//         widget.onPageSelected(index);
//         return KeyEventResult.handled;
//       }
//       return KeyEventResult.ignored;
//     },
//     child: GestureDetector(
//       onTap: () {
//         widget.onPageSelected(index);
//         focusNode.requestFocus();
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           index == 0
//               ? Container(
//                 decoration: BoxDecoration(
//                         border: focusNode.hasFocus
//                             ? Border.all(
//                                 color:
//                                     borderColor, // Use your outline color here
//                                 width: 5.0, // Outline width
//                               )
//                             : Border.all(
//                                 color: Colors
//                                     .transparent, // No outline when not focused
//                                 width: 5.0,
//                               ),
//                         borderRadius: BorderRadius.circular(0)),
//                 // child: Padding(
//                   // padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Image.asset(
//                       'assets/logo.png', // Image for the "All" item
//                       // width: screenwdt * 0.1, // Adjust the size as needed
//                       height: screenhgt * 0.07, // Adjust the size as needed
//                     ),
//                 // ),
//               )
//               : index == 4 // Check if this is the "Search" item
//                   ? Icon(
//                       Icons.search, // Replace text with search icon
//                       color: focusNode.hasFocus
//                           ? Color.fromARGB(255, 247, 6, 118)
//                           : hintColor,
//                       size: screenwdt * 0.025, // Adjust icon size
//                     )
//               : index == 5 // Check if this is the "Search" item
//                   ? Icon(
//                       Icons.notifications , // Replace text with search icon
//                       color: focusNode.hasFocus
//                           ? Color.fromARGB(255, 247, 6, 118)
//                           : hintColor,
//                       size: screenwdt * 0.025, // Adjust icon size
//                     )
//                   : Text(
//                       title,
//                       style: TextStyle(
//                         color: focusNode.hasFocus
//                             ? Color.fromARGB(255, 247, 6, 118)
//                             : hintColor,
//                         fontSize: screenwdt * 0.015,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//         ],
//       ),
//     ),
//   );
// }

// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class TopNavigationBar extends StatefulWidget {
  final int selectedPage;
  final ValueChanged<int> onPageSelected;
  final bool tvenableAll;

  const TopNavigationBar({
    required this.selectedPage,
    required this.onPageSelected,
    required this.tvenableAll,
  });

  @override
  _TopNavigationBarState createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(7, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenwdt * 0.1, vertical: 5),
                  child: _buildNavigationItem('', 0, _focusNodes[0]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildNavigationItem('Vod', 1, _focusNodes[1]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildNavigationItem('Web Series', 2, _focusNodes[2]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildNavigationItem('Live TV', 3, _focusNodes[3]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildNavigationItem('Search', 4, _focusNodes[4]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:
                      _buildNavigationItem('Notification', 5, _focusNodes[5]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem(String title, int index, FocusNode focusNode) {
    bool isSelected = widget.selectedPage == index;
    return Focus(
      focusNode: focusNode,
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          setState(() {});
        }
      },
      onKeyEvent: (node, event) {
        if (HardwareKeyboard.instance
                .isLogicalKeyPressed(LogicalKeyboardKey.select) ||
            HardwareKeyboard.instance
                .isLogicalKeyPressed(LogicalKeyboardKey.enter)) {
          widget.onPageSelected(index);
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: GestureDetector(
        onTap: () {
          widget.onPageSelected(index);
          focusNode.requestFocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            index == 0
                ? Container(
                    decoration: BoxDecoration(
                        border: focusNode.hasFocus
                            ? Border.all(
                                color:
                                    borderColor, // Use your outline color here
                                width: 5.0, // Outline width
                              )
                            : Border.all(
                                color: Colors
                                    .transparent, // No outline when not focused
                                width: 5.0,
                              ),
                        borderRadius: BorderRadius.circular(0)),
                    child: Image.asset(
                      'assets/logo.png', // Image for the "All" item
                      height: screenhgt * 0.07, // Adjust the size as needed
                    ),
                  )
                : index == 4 // Check if this is the "Search" item
                    ? Icon(
                        Icons.search, // Replace text with search icon
                        color: focusNode.hasFocus
                            ? Color.fromARGB(255, 247, 6, 118)
                            : hintColor,
                        size: screenwdt * 0.025, // Adjust icon size
                      )
                    : index == 5 // Check if this is the "Notification" item
                        ? Icon(
                            Icons.notifications,
                            color: focusNode.hasFocus
                                ? Color.fromARGB(255, 247, 6, 118)
                                : hintColor,
                            size: screenwdt * 0.025, // Adjust icon size
                          )
                        : Text(
                            title,
                            style: TextStyle(
                              color: focusNode.hasFocus
                                  ? Color.fromARGB(255, 247, 6, 118)
                                  : hintColor,
                              fontSize: screenwdt * 0.015,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
          ],
        ),
      ),
    );
  }
}
