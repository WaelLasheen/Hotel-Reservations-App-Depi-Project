import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class BookingStatusOverlay extends StatefulWidget {
  final bool isLoading;
  final bool isSuccess;

  const BookingStatusOverlay({
    Key? key,
    required this.isLoading,
    required this.isSuccess,
  }) : super(key: key);

  @override
  State<BookingStatusOverlay> createState() => _BookingStatusOverlayState();
}

class _BookingStatusOverlayState extends State<BookingStatusOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  final AudioPlayer _player = AudioPlayer();
  bool _hasPlayedSuccess = false;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutBack,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeIn,
    );

    // Start the animation immediately if we're in loading state
    if (widget.isLoading) {
      _scaleController.forward();
    }
  }

  @override
  void didUpdateWidget(BookingStatusOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (!oldWidget.isLoading && widget.isLoading) {
      _scaleController.forward();
    } else if (oldWidget.isLoading && !widget.isLoading) {
      _scaleController.reverse();
    }
    
    if (!oldWidget.isSuccess && widget.isSuccess && !_hasPlayedSuccess) {
      _hasPlayedSuccess = true;
      _playSuccessFeedback();
    }
    
    if (!widget.isLoading) {
      _hasPlayedSuccess = false;
    }
  }

  Future<void> _playSuccessFeedback() async {
    try {
      await _player.play(AssetSource('assets/success.mp3'));
      if (await Vibration.hasVibrator() ?? false) {
        Vibration.vibrate(duration: 300);
      }
      _scaleController.forward();
    } catch (e) {
      debugPrint('Error playing success feedback: $e');
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (!widget.isLoading) return const SizedBox.shrink();

    return Material(
      type: MaterialType.transparency,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.isSuccess
                      ? ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.primary.withOpacity(0.4),
                                  blurRadius: 24,
                                  spreadRadius: 6,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              color: colorScheme.onPrimary,
                              size: 40,
                            ),
                          ),
                        )
                      : Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                            ),
                          ),
                        ),
                  const SizedBox(height: 28),
                  Text(
                    widget.isSuccess ? 'Booking Confirmed!' : 'Processing Booking...',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  if (!widget.isSuccess) ...[
                    const SizedBox(height: 16),
                    Text(
                      "We're confirming your booking...",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "This won't take long.",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 