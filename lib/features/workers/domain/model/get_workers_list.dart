import 'package:baraka_pos/shared/domain/domain.dart';

import 'user_collection.dart';

final class GetWorkersListModel extends Model {
  final String next;

  final UserCollection userCollection;

  final String previus;

  const GetWorkersListModel({
    required this.next,
    required this.userCollection,
    required this.previus,
  });

  @override
  List<String> get props => [
        "next: $next",
        "userCollection: $userCollection",
        "previus: $previus",
      ];
}
