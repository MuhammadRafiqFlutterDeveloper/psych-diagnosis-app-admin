class User {
  String about, birth, race, sex, status, profile;

  User({
    required this.about,
    required this.birth,
    required this.profile,
    required this.race,
    required this.sex,
    required this.status,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          sex == other.sex &&
          birth == other.birth &&
          profile == other.profile &&
          race == other.race &&
          about == other.about);

  @override
  int get hashCode =>
      sex.hashCode ^
      status.hashCode ^
      birth.hashCode ^
      profile.hashCode ^
      race.hashCode ^
      about.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' status: $status,' +
        ' sex: $sex,' +
        ' about: $about,' +
        ' profile: $profile,' +
        ' birth: $birth,' +
        ' race: $race,' +
        '}';
  }

  User copyWith({
    String? status,
    String? sex,
    String? about,
    String? profile,
    String? birth,
    String? race,
  }) {
    return User(
      status: status ?? this.status,
      sex: sex ?? this.sex,
      about: about ?? this.about,
      birth: birth ?? this.birth,
      profile: profile ?? this.profile,
      race: race ?? this.race,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'sex': sex,
      'about': about,
      'birth': birth,
      'profile': profile,
      'race': race,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      status: map['status'] as String,
      sex: map['sex'] as String,
      about: map['about'] as String,
      birth: map['birth'] as String,
      profile: map['profile'] as String,
      race: map['race'] as String,
    );
  }
}
