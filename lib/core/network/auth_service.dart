import 'package:injectable/injectable.dart';
import 'package:money_management_app/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@injectable
class AuthService {
  //Signin with email and password
  Future<AuthResponse> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await supabase.auth
        .signInWithPassword(email: email, password: password);
  }

  //Signup with email and password
  Future<AuthResponse> signupWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'displayName': name,
      },
    );
  }

  //Signup with email and password
  Future<void> signOut() async {
    return await supabase.auth.signOut();
  }

  //Get user email
  String? getCurrentUserEmail() {
    final session = supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
