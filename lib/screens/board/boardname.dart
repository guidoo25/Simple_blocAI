import 'package:cloudinary_midu/config/const.dart';
import 'package:cloudinary_midu/providers/animation_rive/cubit/animation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CircularSwiperWithRive extends StatefulWidget {
  final List<String> images;

  const CircularSwiperWithRive({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<CircularSwiperWithRive> createState() => _CircularSwiperWithRiveState();
}

class _CircularSwiperWithRiveState extends State<CircularSwiperWithRive> {
  late RiveAnimationController _riveController;
  late RiveAnimationController _slashController;
  late RiveAnimationController _hitController;
  int _selectedImageIndex = -1;
  List<String> _images = [];
  static const String STORAGE_KEY = 'saved_images';

  @override
  void initState() {
    super.initState();

    _riveController = SimpleAnimation('Speech1');
    _loadSavedImages();
  }

  Future<void> _loadSavedImages() async {
    final prefs = await SharedPreferences.getInstance();
    final savedImages = prefs.getStringList(STORAGE_KEY);

    if (savedImages != null && savedImages.isNotEmpty) {
      setState(() {
        _images = savedImages;
      });
    } else {
      setState(() {
        _images = widget.images;
      });
      _saveImages(widget.images);
    }
  }

  Future<void> _saveImages(List<String> images) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(STORAGE_KEY, images);
  }

  void _onImageTap(int index, BuildContext context) {
    final cubit = context.read<AnimationCubit>();

    // Solo llamamos al Cubit si el índice ha cambiado
    if (_selectedImageIndex != index) {
      cubit.onCardTapped(index);
    }

    setState(() {
      _selectedImageIndex = index;
    });

    print("Image at index $index tapped");
  }

  @override
  Widget build(BuildContext context) {
    if (_images.isEmpty) {
      return const Center(child: Text('No images available'));
    }

    final imageWidth = AppConstants.getImageWidth(context) * 0.8;
    final imageHeight = 120.0; // Reduced height

    return BlocBuilder<AnimationCubit, AnimationState>(
      builder: (context, state) {
        _riveController.dispose();
        _riveController = SimpleAnimation(state.currentAnimation, mix: 0.2);

        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: RiveAnimation.asset(
                      stateMachines: [],
                      'assets/spycugly.riv',
                      controllers: [_riveController],
                      fit: BoxFit.cover,
                      onInit: (_) => print("Rive animation initialized"),
                    ),
                  ),
                ),
              ),

              // Cards at the Bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: imageHeight + 60, // Adjust space to avoid clipping
                  margin: EdgeInsets.only(bottom: 20), // Bottom margin
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedImageIndex == index;
                      return GestureDetector(
                        onTap: () => _onImageTap(index, context),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          margin: EdgeInsets.symmetric(
                              horizontal: 5), // Margin between images
                          child: Transform.scale(
                            scale: isSelected
                                ? 1.2
                                : 1.0, // Scale effect for selected card
                            child: Transform.translate(
                              offset: Offset(
                                  0, isSelected ? -20 : 0), // Elevation effect
                              child: Stack(
                                children: [
                                  // Card Image
                                  Container(
                                    clipBehavior:
                                        Clip.none, // Prevent image clipping
                                    decoration: isSelected
                                        ? BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 10,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                          )
                                        : null,
                                    child: Image.network(
                                      _images[index],
                                      width: imageWidth,
                                      height: imageHeight,
                                      fit: BoxFit
                                          .cover, // Use BoxFit.cover to avoid distortion
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Center(
                                            child: Text('Error loading image'));
                                      },
                                    ),
                                  ),

                                  // Overlay for Selected Card
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _riveController.dispose();
    super.dispose();
  }
}
