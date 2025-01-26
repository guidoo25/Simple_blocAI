part of 'image_prompt_bloc.dart';

abstract class ImagePromptEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GenerateInitialImages extends ImagePromptEvent {}

class SetPromptForImage extends ImagePromptEvent {
  final int index;
  final String prompt;

  SetPromptForImage(this.index, this.prompt);

  @override
  List<Object?> get props => [index, prompt];
}
