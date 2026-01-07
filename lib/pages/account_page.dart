import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_service.dart';

class AccountPage extends StatefulWidget {
  final String? initialFullName;
  final String? initialEmail;

  const AccountPage({super.key, this.initialFullName, this.initialEmail});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialFullName != null && widget.initialFullName!.isNotEmpty) {
      _nameController.text = widget.initialFullName!;
    }
    if (widget.initialEmail != null && widget.initialEmail!.isNotEmpty) {
      _emailController.text = widget.initialEmail!;
    }
    _loadProfile();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final profile = await AuthService.instance.fetchProfile();
    if (profile != null && mounted) {
      _nameController.text = profile['full_name'] ?? '';
      _emailController.text = profile['email'] ?? '';
      setState(() {});
    }
  }

  Future<void> _saveChanges() async {
    final fullName = _nameController.text.trim();
    final email = _emailController.text.trim();
    final currentPassword = _passwordController.text.trim();
    final newPassword = _newPasswordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (fullName.isEmpty || email.isEmpty) {
      _showMessage('Nama dan email wajib diisi.');
      return;
    }

    if (newPassword.isNotEmpty && newPassword != confirmPassword) {
      _showMessage('Konfirmasi password tidak cocok.');
      return;
    }

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      _showMessage('Tidak ada pengguna yang login.');
      return;
    }

    final isSensitiveChange =
        newPassword.isNotEmpty || (user.email != null && user.email != email);

    if (isSensitiveChange && currentPassword.isEmpty) {
      _showMessage('Masukkan password saat ini untuk mengganti email atau password.');
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    try {
      if (isSensitiveChange) {
        await Supabase.instance.client.auth.signInWithPassword(
          email: user.email!,
          password: currentPassword,
        );
      }

      await AuthService.instance.updateProfile(
        fullName: fullName,
        email: email,
        newPassword: newPassword.isNotEmpty ? newPassword : null,
      );
      _showMessage('Profil berhasil diperbarui.');
    } on AuthException catch (e) {
      _showMessage(e.message);
    } catch (_) {
      _showMessage('Terjadi kesalahan saat menyimpan data.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      labelStyle: GoogleFonts.poppins(
        fontSize: 13,
        color: const Color(0xFF4A3A3A),
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFD8C1C1)),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFE05C5C)),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: Color(0xFFE05C5C)),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Account',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2D1E1E),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 24),
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/mitsuri.jpeg'),
                ),
              ),
              const SizedBox(height: 28),
              TextField(
                controller: _nameController,
                decoration: inputDecoration.copyWith(labelText: 'Full Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: inputDecoration.copyWith(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: inputDecoration.copyWith(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _newPasswordController,
                decoration: inputDecoration.copyWith(labelText: 'Change Password'),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _confirmPasswordController,
                decoration: inputDecoration.copyWith(labelText: 'Confirm Password'),
                obscureText: true,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE05C5C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
