import 'package:accountant_pro/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Stream<User?> authStateChanges() {
    return Stream.fromIterable([MockUser()]);
  }
}

class MockUser extends Mock implements User {}

void main() {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final Auth auth = Auth(auth: mockFirebaseAuth);
  // setUp();
  // tearDown();
  test('emit occurs', () async {
    expectLater(auth.user, emitsInOrder([MockUser()]));
  });
}
