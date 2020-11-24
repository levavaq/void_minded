class CustomUser {
  // There is an example of Firebase User data but we only need uid variable
  // User(displayName: null, email: null, emailVerified: false, isAnonymous: true, metadata: UserMetadata(creationTime: 2020-11-23 19:01:25.635, lastSignInTime: 2020-11-23 19:01:25.635), phoneNumber: null, photoURL: null, providerData, [], refreshToken: , tenantId: null, uid: xemTct8Ri9hBTFPHL2fGNOVbJpk1)
  final String uid;

  CustomUser({this.uid});
}

class CustomUserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  CustomUserData({this.uid, this.name, this.sugars, this.strength});
}
