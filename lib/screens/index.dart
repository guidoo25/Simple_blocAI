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

        return Stack(
          children: [
            Container(
              width: width,
              height: height,
              color: Colors.black,
            ),
            Positioned(
              left: frameThickness,
              top: frameThickness,
              right: frameThickness,
              bottom: frameThickness,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(innerPadding),
                child: child,
              ),
            ),
            Positioned(
              left: 0,
              top: frameThickness,
              bottom: frameThickness,
              child: Container(
                width: frameThickness,
                color: Colors.red, // Color del marco izquierdo
                child: Center(child: Text('Left Widget')),
              ),
            ),
            Positioned(
              right: 0,
              top: frameThickness,
              bottom: frameThickness,
              child: Container(
                width: frameThickness,
                color: Colors.green, // Color del marco derecho
                child: Center(child: Text('Right Widget')),
              ),
            ),
            Positioned(
              left: frameThickness,
              right: frameThickness,
              bottom: 0,
              child: Container(
                height: frameThickness,
                color: Colors.blue, // Color del marco inferior
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.orange,
                        child: Center(child: Text('Left Bottom Widget')),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: InputPrompt(
                            controller: TextEditingController(),
                            onSubmitted: (value) => print(value))),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.purple,
                        child: Center(child: Text('Right Bottom Widget')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Thick Frame Example')),
      body: Center(
        child: ThickFrame(
          child: Container(
            color: Colors.yellow,
            child: Center(
              child: Text(
                'Content Here',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    ),
  ));
}
