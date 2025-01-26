import 'package:flutter/material.dart';
import 'dart:math';

class CircularSwiper extends StatefulWidget {
  final List<String> images;
  final Function(int) onChange;

  CircularSwiper({required this.images, required this.onChange});

  @override
  _CircularSwiperState createState() => _CircularSwiperState();
}

class _CircularSwiperState extends State<CircularSwiper> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              _currentPage = index % widget.images.length;
              widget.onChange(_currentPage);
            });
          },
          itemBuilder: (context, index) {
            final imageIndex = index % widget.images.length;
            final angle = (index - _currentPage) * 0.1;
            final scale = max(0.8, 1 - (index - _currentPage).abs() * 0.1);
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle)
                ..scale(scale),
              child: GestureDetector(
                onTap: () {
                  print(widget.images[imageIndex]);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    widget.images[imageIndex],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
