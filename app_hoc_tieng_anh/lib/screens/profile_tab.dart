import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../services/auth_service.dart';
import 'auth/login_screen.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key, required this.userName});

  final String userName;

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hồ sơ & Cài đặt',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Hồ sơ cá nhân', Icons.person_outline),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildProfileItem('Tên tài khoản', 'kieuphuoc1412005_56682'),
                  _buildProfileItem('Tên hiển thị', widget.userName),
                  _buildProfileItem('Trình độ tiếng Anh', 'Trung cấp'),
                  _buildProfileItem('Ngôn ngữ', 'Tiếng Việt'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionHeader('Cài đặt học tập', Icons.settings_outlined),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildSwitchItem('Phát âm tự động', true),
                  _buildSwitchItem('Nhắc nhở học hàng ngày', true),
                  _buildSwitchItem('Chế độ ban đêm', false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger.withOpacity(0.1),
                  foregroundColor: AppColors.danger,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Đăng xuất',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textColor,
            ),
          ),
          Row(
            children: [
              if (value.isNotEmpty)
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.subtitleColor,
                  ),
                ),
              if (value.isNotEmpty) const SizedBox(width: 8),
              const Icon(Icons.chevron_right, size: 18, color: AppColors.subtitleColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchItem(String label, bool value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textColor,
            ),
          ),
          Switch(
            value: value,
            onChanged: (val) => setState(() {}),
            activeColor: Colors.green,
          ),
        ],
      ),
    );
  }
}