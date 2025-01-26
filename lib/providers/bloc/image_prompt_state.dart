part of 'image_prompt_bloc.dart';

class ImagePromptState extends Equatable {
  final List<ImagePrompt> images;
  final bool isLoading;

  const ImagePromptState({
    this.images = const [],
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [images, isLoading];

  ImagePromptState copyWith({
    List<ImagePrompt>? images,
    bool? isLoading,
  }) {
    return ImagePromptState(
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
