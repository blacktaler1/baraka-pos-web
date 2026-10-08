part of 'post_media_bloc.dart';

sealed class PostMediaEvent extends Equatable {
  const PostMediaEvent();

  @override
  List<Object> get props => [];
}

final class PostMediaStarted extends PostMediaEvent {
  final XFile image;

  const PostMediaStarted({required this.image});

  @override
  List<Object> get props => ["image: $image"];
}
