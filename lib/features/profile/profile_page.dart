import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_constants.dart';
import '../../core/providers/database_provider.dart';
import '../../data/models/user.dart' as models;
import '../../data/repositories/user_repository.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late final UserRepository _repository;

  models.User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final database = ref.read(databaseProvider);
    _repository = UserRepository(database);
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() => _isLoading = true);
    try {
      // Ensure default user exists
      final user = await _repository.createDefaultUser();
      if (mounted) {
        setState(() {
          _user = user;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updateUsername(String newUsername) async {
    if (newUsername.trim().isEmpty) return;

    try {
      await _repository.updateUsername(newUsername.trim());
      if (mounted) {
        setState(() {
          _user = _user?.copyWith(username: newUsername.trim());
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('更新失败，请重试')),
        );
      }
    }
  }

  void _showEditUsernameDialog() {
    final controller = TextEditingController(text: _user?.username ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '修改昵称',
          style: GoogleFonts.newsreader(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.bgSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '输入新昵称',
          ),
          maxLength: 20,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              _updateUsername(controller.text);
              Navigator.of(context).pop();
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: Text(
          '个人中心',
          style: GoogleFonts.newsreader(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.bgPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.accentPrimary,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildAvatarSection(),
                  const SizedBox(height: 24),
                  _buildStatsSection(),
                  const SizedBox(height: 32),
                  _buildSettingsPlaceholder(),
                ],
              ),
            ),
    );
  }

  Widget _buildAvatarSection() {
    final username = _user?.username ?? '当';
    final initials = username.isNotEmpty ? username[0] : '当';

    return Column(
      children: [
        // Avatar circle
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accentPrimary,
            boxShadow: [
              BoxShadow(
                color: AppColors.accentPrimary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              initials,
              style: GoogleFonts.newsreader(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Username with edit button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _user?.username ?? '当时',
              style: GoogleFonts.newsreader(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _showEditUsernameDialog,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.bgMuted,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(color: AppColors.borderPrimary),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              label: '连续记录天数',
              value: '${_user?.streakDays ?? 0}',
              icon: Icons.local_fire_department_rounded,
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: AppColors.borderPrimary,
          ),
          Expanded(
            child: _buildStatItem(
              label: '总记录数',
              value: '${_user?.totalFeelings ?? 0}',
              icon: Icons.book_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 28,
          color: AppColors.accentPrimary,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.newsreader(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsPlaceholder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(color: AppColors.borderPrimary),
      ),
      child: Column(
        children: [
          Icon(
            Icons.settings_outlined,
            size: 48,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 12),
          Text(
            '更多设置',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '即将推出',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
