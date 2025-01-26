import 'package:flutter/material.dart';

class Terminal extends StatefulWidget {
  final List<String> lines;
  final double height;

  Terminal({required this.lines, required this.height});

  @override
  _TerminalState createState() => _TerminalState();
}

class _TerminalState extends State<Terminal>
    with SingleTickerProviderStateMixin {
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile =
        screenWidth < 600; // Consider screen width less than 600 as mobile
    double fontSize =
        isMobile ? 12.0 : 16.0; // Set font size based on screen size

    return Container(
      width: screenWidth,
      height: widget.height,
      color: Color(0xFF2F2B3A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.lines.length,
              itemBuilder: (context, index) {
                return Text(
                  widget.lines[index],
                  style: TextStyle(
                    color: Color(0xFF00FF00),
                    fontFamily: 'FiraCode',
                    fontSize: fontSize,
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Text(
                '> ',
                style: TextStyle(
                  color: Color(0xFF00FF00),
                  fontFamily: 'FiraCode',
                  fontSize: fontSize,
                ),
              ),
              AnimatedBuilder(
                animation: _cursorController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _cursorController.value,
                    child: Text(
                      '_',
                      style: TextStyle(
                        color: Color(0xFF00FF00),
                        fontFamily: 'FiraCode',
                        fontSize: fontSize,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
