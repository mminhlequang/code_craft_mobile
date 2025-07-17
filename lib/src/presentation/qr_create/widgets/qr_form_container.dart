import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../../constants/constants.dart';
import 'qr_form_fields.dart';

class QrFormContainer extends StatefulWidget {
  final String qrType;
  final Function(Map<String, dynamic>) onQrCreated;

  const QrFormContainer({
    super.key,
    required this.qrType,
    required this.onQrCreated,
  });

  @override
  State<QrFormContainer> createState() => _QrFormContainerState();
}

class _QrFormContainerState extends State<QrFormContainer> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    switch (widget.qrType) {
      case 'URL':
        _controllers['url'] = TextEditingController();
        break;
      case 'Text':
        _controllers['text'] = TextEditingController();
        break;
      case 'WiFi':
        _controllers['ssid'] = TextEditingController();
        _controllers['password'] = TextEditingController();
        _controllers['encryption'] = TextEditingController(text: 'WPA');
        break;
      case 'Email':
        _controllers['email'] = TextEditingController();
        _controllers['subject'] = TextEditingController();
        _controllers['body'] = TextEditingController();
        break;
      case 'Phone':
        _controllers['phone'] = TextEditingController();
        break;
      case 'SMS':
        _controllers['phone'] = TextEditingController();
        _controllers['message'] = TextEditingController();
        break;
      case 'VCard':
        _controllers['name'] = TextEditingController();
        _controllers['phone'] = TextEditingController();
        _controllers['email'] = TextEditingController();
        _controllers['company'] = TextEditingController();
        break;
      case 'GeoLocation':
        _controllers['latitude'] = TextEditingController();
        _controllers['longitude'] = TextEditingController();
        _controllers['label'] = TextEditingController();
        break;
      case 'Calendar':
        _controllers['title'] = TextEditingController();
        _controllers['description'] = TextEditingController();
        _controllers['location'] = TextEditingController();
        _controllers['startDate'] = TextEditingController();
        _controllers['endDate'] = TextEditingController();
        break;
      case 'Social Media':
        _controllers['platform'] = TextEditingController();
        _controllers['username'] = TextEditingController();
        break;
      case 'Payment':
        _controllers['amount'] = TextEditingController();
        _controllers['currency'] = TextEditingController(text: 'VND');
        _controllers['description'] = TextEditingController();
        break;
      case 'App Store':
        _controllers['appName'] = TextEditingController();
        _controllers['appId'] = TextEditingController();
        _controllers['platform'] = TextEditingController();
        break;
    }
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppSizes.radiusLarge),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: AppSizes.paddingMedium),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: context.colors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(AppSizes.paddingLarge),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: context.colors.textSecondary,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Tạo QR Code ${widget.qrType}',
                    style: context.styles.headlineSmall.copyWith(
                      color: context.colors.text,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48), // Balance the close button
              ],
            ),
          ),

          // Form Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.paddingLarge),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    QrFormFields(
                      qrType: widget.qrType,
                      controllers: _controllers,
                      onDataChanged: (key, value) {
                        _formData[key] = value;
                      },
                    ),

                    const SizedBox(height: AppSizes.paddingXLarge),

                    // Create Button
                    SizedBox(
                      width: double.infinity,
                      height: AppSizes.buttonHeightLarge,
                      child: ElevatedButton(
                        onPressed: _createQrCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusMedium),
                          ),
                        ),
                        child: Text(
                          'Tạo QR Code',
                          style: context.styles.labelLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createQrCode() {
    if (_formKey.currentState!.validate()) {
      // Collect all form data
      _controllers.forEach((key, controller) {
        _formData[key] = controller.text;
      });

      // Add QR type to data
      _formData['qrType'] = widget.qrType;
      _formData['createdAt'] = DateTime.now().toIso8601String();

      widget.onQrCreated(_formData);
    }
  }
}
