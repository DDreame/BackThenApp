import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../core/providers/database_provider.dart';
import '../../data/models/feeling.dart' as models;
import '../../data/repositories/feeling_repository.dart';
import '../../shared/widgets/feeling_card.dart';
import '../../shared/widgets/input_bar.dart';

class TimelinePage extends ConsumerStatefulWidget {
  const TimelinePage({super.key});

  @override
  ConsumerState<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends ConsumerState<TimelinePage> {
  late final FeelingRepository _repository;
  
  List<models.Feeling> _feelings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final database = ref.read(databaseProvider);
    _repository = FeelingRepository(database);
    _loadFeelings();
  }

  Future<void> _loadFeelings() async {
    setState(() => _isLoading = true);
    try {
      final feelings = await _repository.getAll();
      if (mounted) {
        setState(() {
          _feelings = feelings;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _createFeeling(String content) async {
    try {
      final newFeeling = await _repository.create(content);
      if (mounted) {
        setState(() {
          _feelings = [newFeeling, ..._feelings];
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('记录失败，请重试')),
        );
      }
    }
  }

  void _navigateToDetail(models.Feeling feeling) {
    context.push('/feeling/${feeling.id}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        title: const Text(
          '当时',
          style: TextStyle(
            fontFamily: 'Newsreader',
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        backgroundColor: AppColors.bgPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.accentPrimary,
                    ),
                  )
                : _feelings.isEmpty
                    ? _buildEmptyState()
                    : _buildFeelingsList(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: InputBar(
              onSend: _createFeeling,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_note_rounded,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            '记录你的第一个心情',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '点击下方输入框开始记录',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textTertiary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeelingsList() {
    return RefreshIndicator(
      onRefresh: _loadFeelings,
      color: AppColors.accentPrimary,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        itemCount: _feelings.length,
        itemBuilder: (context, index) {
          final feeling = _feelings[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: FeelingCard(
              feeling: feeling,
              onTap: () => _navigateToDetail(feeling),
            ),
          );
        },
      ),
    );
  }
}
