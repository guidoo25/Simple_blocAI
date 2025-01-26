import 'package:cloudinary_midu/screens/menu/swipper.dart';
import 'package:flutter/material.dart';

class ImageSwiperScreen extends StatefulWidget {
  @override
  _ImageSwiperScreenState createState() => _ImageSwiperScreenState();
}

class _ImageSwiperScreenState extends State<ImageSwiperScreen> {
  final TextEditingController _promptController = TextEditingController();
  int _currentIndex = 0;

  final List<String> images = [
    'https://picsum.photos/seed/image1/400/600',
    'https://picsum.photos/seed/image2/400/600',
    'https://picsum.photos/seed/image3/400/600',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1D2B),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Swipercard(),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _promptController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter prompt for current template...',
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Color(0xFF2A2D3E),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.edit, color: Colors.white54),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Select Template'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Handle template selection
                print('Selected template index: $_currentIndex');
                print('Entered prompt: ${_promptController.text}');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }
}
