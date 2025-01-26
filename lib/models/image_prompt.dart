class ImagePrompt {
  final String transformedImageUrl;
  final bool isLocked;
  final bool isLoading;
  final String? urlFinal;

  ImagePrompt(
      {required this.transformedImageUrl,
      this.isLocked = false,
      this.isLoading = false,
      this.urlFinal});

  ImagePrompt copyWith(
      {String? transformedImageUrl,
      bool? isLocked,
      bool? isLoading,
      String? urlFinal}) {
    return ImagePrompt(
        transformedImageUrl: transformedImageUrl ?? this.transformedImageUrl,
        isLocked: isLocked ?? this.isLocked,
        isLoading: isLoading ?? this.isLoading,
        urlFinal: urlFinal ?? this.urlFinal);
  }
}
