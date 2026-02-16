import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/app_constants.dart';
import '../../core/providers/database_provider.dart';
import '../../data/models/user.dart' as models;
import '../../data/repositories/feeling_repository.dart';
import '../../data/repositories/user_repository.dart';

class RetrospectPage extends ConsumerStatefulWidget {
  const RetrospectPage({super.key});

  @override
  ConsumerState<RetrospectPage> createState() => _RetrospectPageState();
}

class _RetrospectPageState extends ConsumerState<RetrospectPage> {
  late final UserRepository _userRepository;
  late final FeelingRepository _feelingRepository;

  models.User? _user;
  int _todayCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final database = ref.read(databaseProvider);
    _userRepository = UserRepository(database);
    _feelingRepository = FeelingRepository(database);
    _loadStats();
  }

  Future<void> _loadStats() async {
    setState(() => _isLoading = true);
    try {
      // Ensure default user exists
      await _userRepository.createDefaultUser();
      
      // Get user stats
      final user = await _userRepository.getUser();
      
      // Get today's feelings count
      final allFeelings = await _feelingRepository.getAll();
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final todayCount = allFeelings.where((f) => 
        f.createdAt.isAfter(todayStart) || 
        f.createdAt.isAtSameMomentAs(todayStart)
      ).length;

      if (mounted) {
        setState(() {
          _user = user;
          _todayCount = todayCount;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: Text(
          '回顾',
          style: GoogleFonts.newsreader(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
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
          : _buildStatsSection(),
    );
  }

  Widget _buildStatsSection() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '记录统计',
            style: GoogleFonts.newsreader(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          _buildStatCard(
            icon: Icons.local_fire_department_rounded,
            label: '连续记录天数',
            value: '${_user?.streakDays ?? 0}',
            unit: '天',
            color: AppColors.accentSecondary,
          ),
          const SizedBox(height: 16),
          _buildStatCard(
            icon: Icons.emoji_emotions_outlined,
            label: '总记录数',
            value: '${_user?.totalFeelings ?? 0}',
            unit: '条',
            color: AppColors.accentPrimary,
          ),
          const SizedBox(height: 16),
          _buildStatCard(
            icon: Icons.today_outlined,
            label: '今日记录数',
            value: '$_todayCount',
            unit: '条',
            color: AppColors.positive,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required String unit,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(AppRadius.cardRadius),
        border: Border.all(color: AppColors.borderPrimary),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      value,
                      style: GoogleFonts.newsreader(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      unit,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
