import 'package:baraka_pos/features/media/data/data.dart';
import 'package:baraka_pos/shared/shared.dart';
import 'package:dio/dio.dart';

final class MediaRemoteSource extends RemoteSource {
  MediaRemoteSource({required super.client});

  Future<Safed<BaseException, MediaDto>> postImage({
    required MediaRequest request,
  }) async {
    final formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        await request.image.readAsBytes(),
        filename: request.image.name,
      ),
    });

    return await apiPostMultipart(
      path: "/media/",
      formData: formData,
    ).map(
      success: dataFactory(MediaDto.fromJson),
    );
  }
}
