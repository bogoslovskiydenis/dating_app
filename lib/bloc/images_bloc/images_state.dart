part of 'images_bloc.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();

  @override
  List<Object> get props => [];
}

class ImagesLoaded extends ImagesState {
  @override
List<Object> get props => [];
}

class ImagesLoading extends ImagesState {
  final List<dynamic> imageUrls;

  const ImagesLoading({this.imageUrls =const[]});

  @override
  List<Object> get props => [imageUrls];
}

