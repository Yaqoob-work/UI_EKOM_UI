import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobi_tv_entertainment/main.dart';

class TopNavigationBarTwo extends StatefulWidget {
  final int selectedPage;
  final ValueChanged<int> onPageSelected;
  final bool tvenableAll;

  const TopNavigationBarTwo({
    required this.selectedPage,
    required this.onPageSelected,
    required this.tvenableAll,
  });

  @override
  _TopNavigationBarTwoState createState() => _TopNavigationBarTwoState();
}

class _TopNavigationBarTwoState extends State<TopNavigationBarTwo> {
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
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //  Flexible(flex: 1,child: _buildNavigationItem('Home', 0, _focusNodes[0])),
          //  Flexible(flex: 1,child: _buildNavigationItem('News', 1, _focusNodes[1])),
          //  Flexible(flex: 1,child: _buildNavigationItem('Movies', 2, _focusNodes[2])),
          //  Flexible(flex: 1,child: _buildNavigationItem('Music', 3, _focusNodes[3])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Flexible(
                flex: 1,
                child: _buildNavigationItem('Live', 0, _focusNodes[0])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Flexible(
                flex: 1,
                child: _buildNavigationItem('News', 1, _focusNodes[1])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Flexible(
                flex: 1,
                child: _buildNavigationItem('Sports', 2, _focusNodes[2])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Flexible(
                flex: 1,
                child: _buildNavigationItem('Religious', 3, _focusNodes[3])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Flexible(
                flex: 1,
                child: _buildNavigationItem('Movies', 4, _focusNodes[4])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Flexible(
                flex: 1,
                child: _buildNavigationItem('Music', 5, _focusNodes[5])),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Flexible(
                flex: 1,
                child:
                    _buildNavigationItem('Entertainment', 6, _focusNodes[6])),
          ),
        ],
      ),
      //  )
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
            // FittedBox(
            // child:
            Text(
              title,
              style: TextStyle(
                color: focusNode.hasFocus
                    ? Color.fromARGB(255, 247, 6, 118)
                    : Colors.white,
                fontSize: screenwdt * 0.015,
                fontWeight: FontWeight.bold,
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
