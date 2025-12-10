abstract class SupabaseRepo {
  Future<void> signInWithEmail(String email, String password);
  Future<void> signUpWithEmail(String email, String password);
  Future<void> signOut();
  Future<void> getUser();
  Future<void> updateUser(String email, String password);
  Future<void> deleteUser();
}
