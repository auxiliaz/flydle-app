import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();

  static final instance = AuthService._();

  final SupabaseClient _client = Supabase.instance.client;

  Future<void> signIn({required String email, required String password}) async {
    await _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUp({required String email, required String password, required String fullName}) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
    );

    final userId = response.user?.id;
    if (userId != null) {
      await _client.from('profiles').upsert({
        'id': userId,
        'full_name': fullName,
        'email': email,
      });
    }

    if (response.session == null) {
      await _client.auth.signInWithPassword(email: email, password: password);
    }
  }

  Future<Map<String, dynamic>?> fetchProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    Map<String, dynamic>? data;
    try {
      data = await _client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();
    } on PostgrestException {
      data = null;
    }

    if (data != null) {
      return data;
    }

    final fallbackName = user.userMetadata?['full_name']?.toString().trim();
    final inferredName = fallbackName?.isNotEmpty == true
        ? fallbackName
        : (user.email?.split('@').first ?? '');

    return {
      'full_name': inferredName,
      'email': user.email ?? '',
    };
  }

  Future<void> updateProfile({String? fullName, String? email, String? newPassword}) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw const AuthException('User not logged in');
    }

    final updates = {
      'id': user.id,
      if (fullName != null) 'full_name': fullName,
      if (email != null) 'email': email,
    };

    if (updates.length > 1) {
      await _client.from('profiles').upsert(updates);
    }

    final attributes = UserAttributes(
      data: {
        if (fullName != null) 'full_name': fullName,
      },
      email: email,
      password: newPassword,
    );

    await _client.auth.updateUser(attributes);
  }

  Future<void> signOut() => _client.auth.signOut();
}
