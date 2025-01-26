import 'package:cloudinary_midu/widgets/input_prompt.dart';
import 'package:flutter/material.dart';

class ThickFrame extends StatelessWidget {
  final Widget child;

  ThickFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    double frameThickness = 90.0;
    double innerPadding = 10.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        bool isMobile =
            width < 600; // Consider screen width less than 600 as mobile

        return Stack(
          children: [
            Container(
              width: width,
              height: height,
              color: Color(0xFF1F1D2B),
            ),
            Positioned(
              left: frameThickness,
              top: frameThickness,
              right: frameThickness,
              bottom: frameThickness,
              child: Container(
                color: Color(0xFF1F1D2B),
                padding: EdgeInsets.all(innerPadding),
                child: child,
              ),
            ),
            //izquierda media
            Positioned(
              left: 0,
              top: frameThickness,
              bottom: frameThickness,
              child: Container(
                width: frameThickness,
                color: Color(0xFF1F1D2B),
                child: Center(child: Text('Left Widget')),
              ),
            ),
            //derecha medio
            Positioned(
              right: 0,
              top: frameThickness,
              bottom: frameThickness,
              child: Container(
                width: frameThickness,
                color: Color(0xFF1F1D2B),
                child: Center(child: Text('Right Widget')),
              ),
            ),
            Positioned(
              left: frameThickness,
              right: frameThickness,
              bottom: 0,
              child: Container(
                height: frameThickness,
                color: Color(0xFF1F1D2B),
                child: Row(
                  children: [
                    if (isMobile)
                      Expanded(
                        child: InputPrompt(
                          controller: TextEditingController(),
                          onSubmitted: (value) => print(value),
                        ),
                      )
                    else
                      Expanded(
                        flex: 2,
                        child: InputPrompt(
                          controller: TextEditingController(),
                          onSubmitted: (value) => print(value),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (isMobile)
              Positioned(
                right: 10,
                bottom: 10,
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.yellow,
                ),
              ),
          ],
        );
      },
    );
  }
}
