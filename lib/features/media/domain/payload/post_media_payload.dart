import 'package:cross_file/cross_file.dart';

import 'package:baraka_pos/shared/domain/domain.dart';

final class PostMediaPayload extends Payload {
  final XFile image;

  const PostMediaPayload({required this.image});

  @override
  List<Object> get props => [];
}
