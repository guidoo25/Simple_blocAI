import 'package:cloudinary_midu/providers/bloc/image_prompt_bloc.dart';
import 'package:cloudinary_midu/screens/board/boardname.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloudinary_midu/widgets/drip_button.dart';
import 'package:cloudinary_midu/screens/menu/swipper.dart';

class ImageSwiperScreen extends StatefulWidget {
  @override
  _ImageSwiperScreenState createState() => _ImageSwiperScreenState();
}

class _ImageSwiperScreenState extends State<ImageSwiperScreen> {
  final TextEditingController _promptController = TextEditingController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagePromptBloc(),
      child: Scaffold(
        backgroundColor: Color(0xFF1F1D2B),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              BlocBuilder<ImagePromptBloc, ImagePromptState>(
                builder: (context, state) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: state.images.isEmpty
                        ? Center(
                            child: Text(
                              'No images available',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : CircularSwiper(
                            images: state.images
                                .map((img) => img.transformedImageUrl)
                                .toList(),
                            onChange: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                  );
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<ImagePromptBloc, ImagePromptState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final isEnabled = state.images.isNotEmpty &&
                        !state.isLoading &&
                        !state.images[currentIndex].isLocked;
                    return TextField(
                      controller: _promptController,
                      style: TextStyle(color: Colors.white),
                      enabled: isEnabled,
                      decoration: InputDecoration(
                        hintText: state.images.isEmpty
                            ? 'Generate images first'
                            : state.images[currentIndex].isLocked
                                ? 'Prompt already set for this template'
                                : 'Enter prompt for current template...',
                        hintStyle: TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Color(0xFF2A2D3E),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.edit, color: Colors.white54),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              BlocBuilder<ImagePromptBloc, ImagePromptState>(
                builder: (context, state) {
                  if (state.images.isEmpty) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200.0, 48.0),
                      ),
                      onPressed: () {
                        context.read<ImagePromptBloc>().generateInitialImages();
                      },
                      child: const Text(
                        "Generate Images",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }

                  if (state.isLoading) {
                    return CircularProgressIndicator();
                  }

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200.0, 48.0),
                    ),
                    onPressed: state.images[currentIndex].isLocked
                        ? null
                        : () {
                            final prompt = _promptController.text;
                            if (prompt.isNotEmpty) {
                              context
                                  .read<ImagePromptBloc>()
                                  .setPromptForImage(currentIndex, prompt);
                              _promptController.clear();
                            }
                          },
                    child: const Text(
                      "Apply Prompt",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CircularSwiperWithRive(
                        images: context
                            .read<ImagePromptBloc>()
                            .state
                            .images
                            .map((img) => img.transformedImageUrl)
                            .toList(),
                      ),
                    ),
                  );
                },
                child: Text("Go "),
              ),
            ],
          ),
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
