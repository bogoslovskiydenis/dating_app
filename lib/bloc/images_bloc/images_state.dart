part of 'images_bloc.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();
}

List<Object> get props => [];
class ImagesLoading extends ImagesState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
class ImagesLoaded extends ImagesState {
  final List<dynamic> imageUrls;

  ImagesLoaded({this.imageUrls =const[]});

  @override
  List<Object> get props => [imageUrls];
}
