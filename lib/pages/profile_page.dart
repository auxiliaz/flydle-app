import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';
import '../widgets/rounded_bottom_nav_bar.dart';
import 'account_page.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const _options = [
    'Account',
    'Privacy policy',
    'Language',
    'Settings',
    'Rate us',
    'Help',
  ];

  String _fullName = 'Kanroji Mitsuri';
  String _email = 'obanai_lover@gmail.com';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _handleLogout() async {
    await AuthService.instance.signOut();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  Future<void> _loadProfile() async {
    final profile = await AuthService.instance.fetchProfile();
    if (profile != null && mounted) {
      setState(() {
        _fullName = profile['full_name']?.toString().trim().isNotEmpty == true
            ? profile['full_name']
            : _fullName;
        _email = profile['email']?.toString().trim().isNotEmpty == true ? profile['email'] : _email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildProfileCard(),
              const SizedBox(height: 24),
              ..._options.map(
                (title) => _ProfileOptionTile(
                  title: title,
                  onTap: () {
                    if (title == 'Account') {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                              builder: (_) => AccountPage(
                                initialFullName: _fullName,
                                initialEmail: _email,
                              ),
                            ),
                          )
                          .then((_) => _loadProfile());
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleLogout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE05C5C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: RoundedBottomNavBar(
          activeIndex: 2,
          onItemSelected: (index) {
            if (index == 0) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE05C5C)),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Profile',
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
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/gradients.png'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage('assets/mitsuri.jpeg'),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _fullName,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                _email,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileOptionTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _ProfileOptionTile({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF4A3A3A),
                  ),
                ),
                const Icon(Icons.chevron_right, color: Color(0xFFE05C5C)),
              ],
            ),
          ),
        ),
        const Divider(color: Color(0xFFE6CFCF), thickness: 1),
      ],
    );
  }
}
