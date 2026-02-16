import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_constants.dart';
import '../../core/providers/database_provider.dart';
import '../../core/utils/date_utils.dart';
import '../../data/models/feeling.dart';
import '../../data/models/reply.dart';
import '../../data/repositories/feeling_repository.dart';
import '../../data/repositories/reply_repository.dart';
import '../../shared/widgets/reply_bubble.dart';
import '../../shared/widgets/input_bar.dart';

class FeelingDetailPage extends ConsumerStatefulWidget {
  final String feelingId;

  const FeelingDetailPage({
    super.key,
    required this.feelingId,
  });

  @override
  ConsumerState<FeelingDetailPage> createState() => _FeelingDetailPageState();
}

class _FeelingDetailPageState extends ConsumerState<FeelingDetailPage> {
  late final FeelingRepository _feelingRepository;
  late final ReplyRepository _replyRepository;

  Feeling? _feeling;
  List<Reply> _replies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    final database = ref.read(databaseProvider);
    _feelingRepository = FeelingRepository(database);
    _replyRepository = ReplyRepository(database);
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final feeling = await _feelingRepository.getById(widget.feelingId);
      final replies = await _replyRepository.getByFeelingId(widget.feelingId);
      if (mounted) {
        setState(() {
          _feeling = feeling;
          _replies = replies;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _addReply(String content) async {
    if (_feeling == null) return;

    try {
      // Calculate time offset from feeling creation to now
      final timeOffset = calculateTimeOffset(
        _feeling!.createdAt,
        DateTime.now(),
      );

      // Create the reply
      final newReply = await _replyRepository.create(
        widget.feelingId,
        content,
        timeOffset,
      );

      // Increment reply count
      await _feelingRepository.incrementReplyCount(widget.feelingId);

      if (mounted) {
        setState(() {
          _replies = [..._replies, newReply];
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('回复失败，请重试')),
        );
      }
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy年M月d日').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _feeling != null ? _formatDate(_feeling!.createdAt) : '',
          style: const TextStyle(
            fontFamily: 'Newsreader',
            fontWeight: FontWeight.w600,
            fontSize: 18,
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
          : _feeling == null
              ? _buildNotFound()
              : _buildContent(),
    );
  }

  Widget _buildNotFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 64,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            '未找到该心情记录',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Feeling content
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface,
                    borderRadius: BorderRadius.circular(AppRadius.cardRadius),
                    border: Border.all(color: AppColors.borderPrimary),
                  ),
                  child: Text(
                    _feeling!.content,
                    style: const TextStyle(
                      fontFamily: 'Newsreader',
                      fontSize: 20,
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Replies header
                if (_replies.isNotEmpty) ...[
                  Text(
                    '${_replies.length} 条回复',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Replies list
                if (_replies.isEmpty)
                  _buildEmptyReplies()
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _replies.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final reply = _replies[index];
                      return ReplyBubble(
                        reply: reply,
                        isLeftAligned: true,
                      );
                    },
                  ),
              ],
            ),
          ),
        ),

        // Input bar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: InputBar(
            hintText: '以未来的视角写下你的回复...',
            maxLength: AppLimits.maxReplyLength,
            onSend: _addReply,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyReplies() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 48,
            color: AppColors.textTertiary,
          ),
          const SizedBox(height: 12),
          Text(
            '还没有回复',
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '以未来的视角，给过去的自己一些回应',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
