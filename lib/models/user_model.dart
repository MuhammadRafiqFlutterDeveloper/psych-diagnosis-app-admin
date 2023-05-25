class User {
  String about, birth, uid, firstName, currentDate, email, password, confirm, lastSeen, race, sex, status, lastName, profile;
  String notificationToken;

  User({
    required this.uid,
    required this.about,
    required this.birth,
    required this.lastSeen,
    required this.profile,
    required this.race,
    required this.sex,
    required this.status,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.password,
    required this.confirm,
    required this.currentDate,
    required this.notificationToken,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is User &&
              runtimeType == other.runtimeType &&
              uid == other.uid &&
              status == other.status &&
              sex == other.sex &&
              birth == other.birth &&
              lastSeen == other.lastSeen &&
              profile == other.profile &&
              race == other.race &&
              about == other.about &&
              lastName == other.lastName &&
              firstName == other.firstName &&
              email == other.email &&
              password == other.password &&
              confirm == other.confirm &&
              currentDate == other.currentDate &&
              notificationToken == other.notificationToken);

  @override
  int get hashCode =>
      uid.hashCode ^
      sex.hashCode ^
      status.hashCode ^
      birth.hashCode ^
      profile.hashCode ^
      lastSeen.hashCode ^
      race.hashCode ^
      about.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      password.hashCode ^
      confirm.hashCode ^
      currentDate.hashCode ^
      notificationToken.hashCode;

  @override
  String toString() {
    return 'User{' +
        ' uid: $uid,' +
        ' status: $status,' +
        ' sex: $sex,' +
        ' about: $about,' +
        ' profile: $profile,' +
        ' birth: $birth,' +
        ' lastSeen: $lastSeen,' +
        ' race: $race,' +
        ' firstName: $firstName,' +
        ' lastName: $lastName,' +
        ' email: $email,' +
        ' password: $password,' +
        ' confirm: $confirm,' +
        ' currentDate: $currentDate,' +
        ' notificationToken: $notificationToken,' +
        '}';
  }

  User copyWith({
    String? uid,
    String? status,
    String? sex,
    String? about,
    String? profile,
    String? birth,
    String? lastSeen,
    String? race,
    String? currentDate,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirm,
    String? notificationToken,
  }) {
    return User(
      uid: uid ?? this.uid,
      status: status ?? this.status,
      sex: sex ?? this.sex,
      about: about ?? this.about,
      birth: birth ?? this.birth,
      lastSeen: lastSeen ?? this.lastSeen,
      profile: profile ?? this.profile,
      race: race ?? this.race,
      currentDate: currentDate ?? this.currentDate,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirm: confirm ?? this.confirm,
      notificationToken: notificationToken ?? this.notificationToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'status': status,
      'sex': sex,
      'about': about,
      'birth': birth,
      'lastSeen': lastSeen,
      'profile': profile,
      'race': race,
      'currentDate': currentDate,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'confirm': confirm,
      'notificationToken': notificationToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      status: map['status'] as String,
      sex: map['sex'] as String,
      about: map['about'] as String,
      birth: map['birth'] as String,
      lastSeen: map['lastSeen'] as String,
      profile: map['profile'] as String,
      race: map['race'] as String,
      currentDate: map['currentDate'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      confirm: map['confirm'] as String,
      notificationToken: map['notificationToken'] as String,
    );
  }
}
