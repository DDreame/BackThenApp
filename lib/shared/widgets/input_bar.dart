import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

/// A text input bar with a send button for recording feelings.
///
/// The send button is disabled when the input is empty and enables
/// automatically as the user types. Fires [onSend] with the trimmed
/// content string when tapped.
class InputBar extends StatefulWidget {
  const InputBar({
    super.key,
    required this.onSend,
    this.hintText = '在这里记录你的心情...',
    this.maxLength = AppLimits.maxFeelingLength,
  });

  /// Called with the trimmed input content when the send button is tapped.
  final ValueChanged<String> onSend;

  /// Placeholder text shown when the input is empty.
  final String hintText;

  /// Maximum character count for the input field.
  final int maxLength;

  @override
  State<InputBar> createState() => _InputBarState();
}

class _InputBarState extends State<InputBar> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _handleSend() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;
    widget.onSend(content);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(AppRadius.inputRadius),
        border: Border.all(color: AppColors.borderPrimary),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: 3,
              minLines: 1,
              maxLength: widget.maxLength,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
                height: 1.5,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: 15,
                ),
                border: InputBorder.none,
                counterText: '', // hide the built-in counter
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: IconButton(
              onPressed: _hasText ? _handleSend : null,
              icon: const Icon(Icons.send_rounded),
              color: AppColors.accentPrimary,
              disabledColor: AppColors.textTertiary,
              iconSize: 22,
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(
                minWidth: 36,
                minHeight: 36,
              ),
              splashRadius: 20,
            ),
          ),
        ],
      ),
    );
  }
}