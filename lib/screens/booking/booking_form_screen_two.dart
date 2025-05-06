import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' show min;
import 'package:provider/provider.dart';
import '../../providers/booking/booking_provider.dart';
import '../../widgets/booking/custom_appbar.dart';
import '../../widgets/booking/custom_button.dart';
import '../../widgets/booking/custom_text_field.dart';
import '../../widgets/booking/booking_status_overlay.dart';
import '../../utils/text_styles_manager.dart';
import 'booking_summary_screen.dart';

class BookingFormScreenTwo extends StatefulWidget {
  const BookingFormScreenTwo({super.key});

  @override
  State<BookingFormScreenTwo> createState() => _BookingFormScreenTwoState();
}

class _BookingFormScreenTwoState extends State<BookingFormScreenTwo> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isSuccess = false;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cardController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.replaceAll(RegExp(r'[^0-9]'), '').length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validateCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Card number is required';
    }
    if (value.replaceAll(RegExp(r'[^0-9]'), '').length != 16) {
      return 'Please enter a valid 16-digit card number';
    }
    return null;
  }

  String? _validateExpiry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }
    final expiryRegex = RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$');
    if (!expiryRegex.hasMatch(value)) {
      return 'Please enter a valid expiry date (MM/YY)';
    }
    return null;
  }

  String? _validateCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV is required';
    }
    if (value.length != 3) {
      return 'Please enter a valid 3-digit CVV';
    }
    return null;
  }

  void _formatCardNumber(TextEditingController controller) {
    String text = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 16) text = text.substring(0, 16);
    
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) formatted += ' ';
      formatted += text[i];
    }
    
    controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void _formatExpiryDate(TextEditingController controller) {
    String text = controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length > 4) text = text.substring(0, 4);
    
    String formatted = '';
    if (text.length > 0) {
      formatted = text.substring(0, min(2, text.length));
      if (text.length > 2) {
        formatted += '/${text.substring(2)}';
      }
    }
    
    controller.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  Future<void> _processBooking() async {
    setState(() {
      _isLoading = true;
      _isSuccess = false;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        setState(() {
          _isSuccess = true;
        });
        
        // Show success state for 2 seconds to ensure animation and feedback complete
        await Future.delayed(const Duration(milliseconds: 2000));
        
        if (mounted) {
          setState(() {
            _isLoading = false;
            _isSuccess = false;
          });
          // Navigate to home screen and clear the stack
          Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isLoading = false;
          _isSuccess = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Stack(
      children: [
        Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 32),
                              _buildSectionTitle(context, 'Personal Information'),
                              const SizedBox(height: 24),
                              _buildTextField(
                                controller: _nameController,
                                label: 'Full Name',
                                hint: 'Enter your full name',
                                validator: (value) => value?.isEmpty ?? true ? 'Name is required' : null,
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                controller: _emailController,
                                label: 'Email',
                                hint: 'Enter your email',
                                keyboardType: TextInputType.emailAddress,
                                validator: _validateEmail,
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                controller: _phoneController,
                                label: 'Phone Number',
                                hint: 'Enter your phone number',
                                keyboardType: TextInputType.phone,
                                validator: _validatePhone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                              ),
                              const SizedBox(height: 40),
                              _buildSectionTitle(context, 'Payment Information'),
                              const SizedBox(height: 24),
                              _buildTextField(
                                controller: _cardController,
                                label: 'Card Number',
                                hint: 'Enter card number',
                                keyboardType: TextInputType.number,
                                validator: _validateCard,
                                onChanged: (value) => _formatCardNumber(_cardController),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(19),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTextField(
                                      controller: _expiryController,
                                      label: 'Expiry Date',
                                      hint: 'MM/YY',
                                      keyboardType: TextInputType.number,
                                      validator: _validateExpiry,
                                      onChanged: (value) => _formatExpiryDate(_expiryController),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(5),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: _buildTextField(
                                      controller: _cvvController,
                                      label: 'CVV',
                                      hint: 'Enter CVV',
                                      keyboardType: TextInputType.number,
                                      validator: _validateCVV,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(3),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              Consumer<BookingProvider>(
                                builder: (context, bookingProvider, _) {
                                  return CustomButton(
                                    text: 'Confirm Booking',
                                    onPressed: _isLoading 
                                      ? () {} // Empty callback when loading
                                      : () {
                                          if (_formKey.currentState?.validate() ?? false) {
                                            _processBooking();
                                          }
                                        },
                                  );
                                },
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        BookingStatusOverlay(
          isLoading: _isLoading,
          isSuccess: _isSuccess,
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Text(
            'Guest Information',
            style: TextStyleManager.blackBold20.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).primaryColor,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return CustomTextField(
      controller: controller,
      label: label,
      hint: hint,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: onChanged,
    );
  }
} 