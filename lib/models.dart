import 'package:flutter_riverpod/flutter_riverpod.dart';

class PondInfo {
  final String first;
  final String gene;
  final bool is_alive;
  final bool is_edited;
  final bool is_private;
  final int items;
  final String last;
  final String owner;
  final int ponds;

  PondInfo({
    required this.first,
    required this.gene,
    required this.is_alive,
    required this.is_edited,
    required this.is_private,
    required this.items,
    required this.last,
    required this.owner,
    required this.ponds,
  });
}

class SessionModel {
  final String ip;
  final SessionInfoModel info;
  final int timestamp;
  final String token;

  SessionModel({
    required this.ip,
    required this.info,
    required this.timestamp,
    required this.token,
  });
}

class SessionInfoModel {
  final int client;
  final int os;
  final int browser;
  final int device;
  final int client_version;
  final int os_version;
  final int browser_version;

  SessionInfoModel({
    required this.client,
    required this.os,
    required this.browser,
    required this.device,
    required this.client_version,
    required this.os_version,
    required this.browser_version,
  });
}

class UserModel {
  //  final agent: AgentModel

  final int cc;

  final int createdAt;

  final String gene;

  final bool is_alive;
  final bool is_banned;
  final bool is_edited;
  final bool is_private;

  final String name;
  final String phone;
  final String photo;

  final PondInfo review;

  final List<int> reviews;

  final int sessionIndex;
  // final List<SessionModel> sessions;

  UserModel({
    required this.cc,
    required this.createdAt,
    required this.gene,
    required this.is_alive,
    required this.is_banned,
    required this.is_private,
    required this.is_edited,
    required this.review,
    required this.name,
    required this.phone,
    required this.photo,
    required this.reviews,
    required this.sessionIndex,
  });
}

class SelfModel {
  final bool loading;
  final bool fetch;
  final UserModel? user;
  final bool guest;
  final bool login;

  SelfModel({
    required this.loading,
    required this.fetch,
    this.user,
    required this.guest,
    required this.login,
  });

  SelfModel copyWith({
    bool? loading,
    bool? fetch,
    UserModel? user,
    bool? guest,
    bool? login,
  }) {
    return SelfModel(
      fetch: fetch ?? this.fetch,
      loading: loading ?? this.loading,
      user: user ?? this.user,
      guest: guest ?? this.guest,
      login: login ?? this.login,
    );
  }
}
