import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../../constants/constants.dart';
import '../../../constants/qr_code_types.dart';
import '../../widgets/modern_input_field.dart';
import 'qr_form_fields_extended.dart';

class QrFormFields extends StatelessWidget {
  final QrCodeType qrType;
  final Map<String, TextEditingController> controllers;
  final Function(String, String) onDataChanged;

  const QrFormFields({
    super.key,
    required this.qrType,
    required this.controllers,
    required this.onDataChanged,
  });

  @override
  Widget build(BuildContext context) {
    switch (qrType) {
      // Cơ bản
      case QrCodeType.websiteUrl:
        return _buildUrlFields(context);
      case QrCodeType.textPlainText:
        return _buildTextFields(context);
      case QrCodeType.wifiAccess:
        return _buildWiFiFields(context);
      case QrCodeType.emailContact:
        return _buildEmailFields(context);
      case QrCodeType.phoneNumber:
        return _buildPhoneFields(context);
      case QrCodeType.smsMessage:
        return _buildSmsFields(context);
      case QrCodeType.vcardContact:
        return _buildVCardFields(context);
      case QrCodeType.locationMap:
        return _buildGeoLocationFields(context);
      case QrCodeType.eventCalendar:
        return _buildCalendarFields(context);

      // Liên lạc & Danh bạ
      case QrCodeType.socialMedia:
        return _buildSocialMediaFields(context);
      case QrCodeType.appStoreDownload:
        return _buildAppStoreFields(context);

      // Doanh nghiệp & Thương mại
      case QrCodeType.restaurantMenu:
        return _buildRestaurantMenuFields(context);
      case QrCodeType.paymentQr:
        return _buildPaymentFields(context);
      case QrCodeType.productInfo:
        return _buildProductFields(context);
      case QrCodeType.businessCard:
        return _buildBusinessCardFields(context);
      case QrCodeType.multiUrl:
        return _buildMultiUrlFields(context);

      // Nội dung & Tài liệu
      case QrCodeType.pdfDocument:
        return _buildPdfDocumentFields(context);
      case QrCodeType.imageGallery:
        return _buildImageGalleryFields(context);
      case QrCodeType.videoContent:
        return _buildVideoContentFields(context);
      case QrCodeType.cryptoWallet:
        return _buildCryptoWalletFields(context);

      default:
        return _buildDefaultFields(context);
    }
  }

  Widget _buildUrlFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin URL', Icons.link),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['url']!,
          label: 'URL',
          hint: 'https://example.com',
          prefixIcon: Icons.link,
          keyboardType: TextInputType.url,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập URL';
            }
            if (!(Uri.tryParse(value)?.hasAbsolutePath ?? true)) {
              return 'URL không hợp lệ';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('url', value),
        ),
      ],
    );
  }

  Widget _buildTextFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Nội dung văn bản', Icons.text_fields),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['text']!,
          label: 'Văn bản',
          hint: 'Nhập nội dung văn bản...',
          prefixIcon: Icons.text_fields,
          maxLines: 3,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập nội dung';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('text', value),
        ),
      ],
    );
  }

  Widget _buildWiFiFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin WiFi', Icons.wifi),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['ssid']!,
          label: 'Tên mạng WiFi (SSID)',
          hint: 'Nhập tên mạng WiFi',
          prefixIcon: Icons.wifi,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập tên mạng WiFi';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('ssid', value),
        ),
        ModernInputField(
          controller: controllers['password']!,
          label: 'Mật khẩu',
          hint: 'Nhập mật khẩu WiFi',
          prefixIcon: Icons.lock,
          obscureText: true,
          onChanged: (value) => onDataChanged('password', value),
        ),
        ModernDropdownField(
          label: 'Loại mã hóa',
          hint: 'Chọn loại mã hóa',
          prefixIcon: Icons.security,
          options: ['WPA', 'WEP', 'nopass'],
          value: controllers['encryption']!.text.isEmpty
              ? 'WPA'
              : controllers['encryption']!.text,
          onChanged: (value) {
            controllers['encryption']!.text = value ?? 'WPA';
            onDataChanged('encryption', value ?? 'WPA');
          },
        ),
      ],
    );
  }

  Widget _buildEmailFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin Email', Icons.email),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['email']!,
          label: 'Địa chỉ Email',
          hint: 'example@email.com',
          prefixIcon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Email không hợp lệ';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('email', value),
        ),
        ModernInputField(
          controller: controllers['subject']!,
          label: 'Tiêu đề',
          hint: 'Tiêu đề email',
          prefixIcon: Icons.subject,
          onChanged: (value) => onDataChanged('subject', value),
        ),
        ModernInputField(
          controller: controllers['body']!,
          label: 'Nội dung',
          hint: 'Nội dung email',
          prefixIcon: Icons.message,
          maxLines: 3,
          onChanged: (value) => onDataChanged('body', value),
        ),
      ],
    );
  }

  Widget _buildPhoneFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin số điện thoại', Icons.phone),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['phone']!,
          label: 'Số điện thoại',
          hint: '+84 123 456 789',
          prefixIcon: Icons.phone,
          keyboardType: TextInputType.phone,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập số điện thoại';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('phone', value),
        ),
      ],
    );
  }

  Widget _buildSmsFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin SMS', Icons.sms),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['phone']!,
          label: 'Số điện thoại',
          hint: '+84 123 456 789',
          prefixIcon: Icons.phone,
          keyboardType: TextInputType.phone,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập số điện thoại';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('phone', value),
        ),
        ModernInputField(
          controller: controllers['message']!,
          label: 'Nội dung tin nhắn',
          hint: 'Nhập nội dung tin nhắn...',
          prefixIcon: Icons.message,
          maxLines: 3,
          onChanged: (value) => onDataChanged('message', value),
        ),
      ],
    );
  }

  Widget _buildVCardFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin liên hệ', Icons.contact_phone),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['name']!,
          label: 'Họ và tên',
          hint: 'Nhập họ và tên',
          prefixIcon: Icons.person,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập họ và tên';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('name', value),
        ),
        ModernInputField(
          controller: controllers['phone']!,
          label: 'Số điện thoại',
          hint: '+84 123 456 789',
          prefixIcon: Icons.phone,
          keyboardType: TextInputType.phone,
          onChanged: (value) => onDataChanged('phone', value),
        ),
        ModernInputField(
          controller: controllers['email']!,
          label: 'Email',
          hint: 'example@email.com',
          prefixIcon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => onDataChanged('email', value),
        ),
        ModernInputField(
          controller: controllers['company']!,
          label: 'Công ty',
          hint: 'Tên công ty',
          prefixIcon: Icons.business,
          onChanged: (value) => onDataChanged('company', value),
        ),
      ],
    );
  }

  Widget _buildGeoLocationFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin vị trí', Icons.location_on),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['latitude']!,
          label: 'Vĩ độ',
          hint: '10.762622',
          prefixIcon: Icons.gps_fixed,
          keyboardType: TextInputType.number,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập vĩ độ';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('latitude', value),
        ),
        ModernInputField(
          controller: controllers['longitude']!,
          label: 'Kinh độ',
          hint: '106.660172',
          prefixIcon: Icons.gps_fixed,
          keyboardType: TextInputType.number,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập kinh độ';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('longitude', value),
        ),
        ModernInputField(
          controller: controllers['label']!,
          label: 'Nhãn vị trí',
          hint: 'Tên địa điểm',
          prefixIcon: Icons.label,
          onChanged: (value) => onDataChanged('label', value),
        ),
      ],
    );
  }

  Widget _buildCalendarFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin sự kiện', Icons.calendar_today),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['title']!,
          label: 'Tiêu đề sự kiện',
          hint: 'Nhập tiêu đề sự kiện',
          prefixIcon: Icons.event,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập tiêu đề sự kiện';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('title', value),
        ),
        ModernInputField(
          controller: controllers['description']!,
          label: 'Mô tả',
          hint: 'Mô tả sự kiện',
          prefixIcon: Icons.description,
          maxLines: 3,
          onChanged: (value) => onDataChanged('description', value),
        ),
        ModernInputField(
          controller: controllers['location']!,
          label: 'Địa điểm',
          hint: 'Địa điểm tổ chức',
          prefixIcon: Icons.location_on,
          onChanged: (value) => onDataChanged('location', value),
        ),
        ModernInputField(
          controller: controllers['startDate']!,
          label: 'Ngày bắt đầu',
          hint: 'YYYY-MM-DD HH:MM',
          prefixIcon: Icons.schedule,
          onChanged: (value) => onDataChanged('startDate', value),
        ),
        ModernInputField(
          controller: controllers['endDate']!,
          label: 'Ngày kết thúc',
          hint: 'YYYY-MM-DD HH:MM',
          prefixIcon: Icons.schedule,
          onChanged: (value) => onDataChanged('endDate', value),
        ),
      ],
    );
  }

  Widget _buildSocialMediaFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin mạng xã hội', Icons.share),
        const SizedBox(height: 16),
        ModernDropdownField(
          label: 'Nền tảng',
          hint: 'Chọn nền tảng',
          prefixIcon: Icons.share,
          options: [
            'Facebook',
            'Instagram',
            'Twitter',
            'LinkedIn',
            'YouTube',
            'TikTok'
          ],
          value: controllers['platform']!.text.isEmpty
              ? null
              : controllers['platform']!.text,
          onChanged: (value) {
            controllers['platform']!.text = value ?? '';
            onDataChanged('platform', value ?? '');
          },
          isRequired: true,
        ),
        ModernInputField(
          controller: controllers['username']!,
          label: 'Tên người dùng',
          hint: '@username',
          prefixIcon: Icons.person,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập tên người dùng';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('username', value),
        ),
      ],
    );
  }

  Widget _buildPaymentFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin thanh toán', Icons.payment),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['amount']!,
          label: 'Số tiền',
          hint: '100000',
          prefixIcon: Icons.attach_money,
          keyboardType: TextInputType.number,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập số tiền';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('amount', value),
        ),
        ModernDropdownField(
          label: 'Đơn vị tiền tệ',
          hint: 'Chọn đơn vị tiền tệ',
          prefixIcon: Icons.currency_exchange,
          options: ['VND', 'USD', 'EUR', 'JPY', 'KRW'],
          value: controllers['currency']!.text.isEmpty
              ? 'VND'
              : controllers['currency']!.text,
          onChanged: (value) {
            controllers['currency']!.text = value ?? 'VND';
            onDataChanged('currency', value ?? 'VND');
          },
        ),
        ModernInputField(
          controller: controllers['description']!,
          label: 'Mô tả',
          hint: 'Mô tả giao dịch',
          prefixIcon: Icons.description,
          maxLines: 2,
          onChanged: (value) => onDataChanged('description', value),
        ),
      ],
    );
  }

  Widget _buildAppStoreFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin ứng dụng', Icons.shop),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['appName']!,
          label: 'Tên ứng dụng',
          hint: 'Tên ứng dụng',
          prefixIcon: Icons.apps,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập tên ứng dụng';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('appName', value),
        ),
        ModernInputField(
          controller: controllers['appId']!,
          label: 'ID ứng dụng',
          hint: 'com.example.app',
          prefixIcon: Icons.tag,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập ID ứng dụng';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('appId', value),
        ),
        ModernDropdownField(
          label: 'Nền tảng',
          hint: 'Chọn nền tảng',
          prefixIcon: Icons.phone_android,
          options: ['Android', 'iOS', 'Both'],
          value: controllers['platform']!.text.isEmpty
              ? 'Android'
              : controllers['platform']!.text,
          onChanged: (value) {
            controllers['platform']!.text = value ?? 'Android';
            onDataChanged('platform', value ?? 'Android');
          },
        ),
      ],
    );
  }

  // Các method build fields cho các loại QR code mới
  Widget _buildRestaurantMenuFields(BuildContext context) {
    return buildRestaurantMenuFields(context, controllers, onDataChanged);
  }

  Widget _buildProductFields(BuildContext context) {
    return buildProductFields(context, controllers, onDataChanged);
  }

  Widget _buildBusinessCardFields(BuildContext context) {
    return buildBusinessCardFields(context, controllers, onDataChanged);
  }

  Widget _buildMultiUrlFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Nhiều URL', Icons.link),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['urls']!,
          label: 'Danh sách URL',
          hint: 'Nhập các URL, phân cách bằng dấu phẩy',
          prefixIcon: Icons.link,
          maxLines: 5,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập ít nhất một URL';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('urls', value),
        ),
      ],
    );
  }

  Widget _buildPdfDocumentFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Tài liệu PDF', Icons.picture_as_pdf),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['url']!,
          label: 'Link PDF',
          hint: 'https://example.com/document.pdf',
          prefixIcon: Icons.link,
          keyboardType: TextInputType.url,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập link PDF';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('url', value),
        ),
        ModernInputField(
          controller: controllers['title']!,
          label: 'Tiêu đề',
          hint: 'Tiêu đề tài liệu',
          prefixIcon: Icons.title,
          onChanged: (value) => onDataChanged('title', value),
        ),
        ModernInputField(
          controller: controllers['description']!,
          label: 'Mô tả',
          hint: 'Mô tả tài liệu',
          prefixIcon: Icons.description,
          maxLines: 3,
          onChanged: (value) => onDataChanged('description', value),
        ),
      ],
    );
  }

  Widget _buildImageGalleryFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thư viện ảnh', Icons.photo_library),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['url']!,
          label: 'Link thư viện ảnh',
          hint: 'https://example.com/gallery',
          prefixIcon: Icons.link,
          keyboardType: TextInputType.url,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập link thư viện ảnh';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('url', value),
        ),
        ModernInputField(
          controller: controllers['title']!,
          label: 'Tiêu đề',
          hint: 'Tiêu đề thư viện ảnh',
          prefixIcon: Icons.title,
          onChanged: (value) => onDataChanged('title', value),
        ),
        ModernInputField(
          controller: controllers['description']!,
          label: 'Mô tả',
          hint: 'Mô tả thư viện ảnh',
          prefixIcon: Icons.description,
          maxLines: 3,
          onChanged: (value) => onDataChanged('description', value),
        ),
      ],
    );
  }

  Widget _buildVideoContentFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Nội dung Video', Icons.video_library),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['url']!,
          label: 'Link video',
          hint: 'https://example.com/video.mp4',
          prefixIcon: Icons.link,
          keyboardType: TextInputType.url,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập link video';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('url', value),
        ),
        ModernInputField(
          controller: controllers['title']!,
          label: 'Tiêu đề',
          hint: 'Tiêu đề video',
          prefixIcon: Icons.title,
          onChanged: (value) => onDataChanged('title', value),
        ),
        ModernInputField(
          controller: controllers['description']!,
          label: 'Mô tả',
          hint: 'Mô tả video',
          prefixIcon: Icons.description,
          maxLines: 3,
          onChanged: (value) => onDataChanged('description', value),
        ),
      ],
    );
  }

  Widget _buildCryptoWalletFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Ví tiền điện tử', Icons.currency_bitcoin),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['address']!,
          label: 'Địa chỉ ví',
          hint: 'Nhập địa chỉ ví',
          prefixIcon: Icons.account_balance_wallet,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập địa chỉ ví';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('address', value),
        ),
        ModernInputField(
          controller: controllers['amount']!,
          label: 'Số lượng',
          hint: '0.01',
          prefixIcon: Icons.numbers,
          keyboardType: TextInputType.number,
          onChanged: (value) => onDataChanged('amount', value),
        ),
        ModernInputField(
          controller: controllers['label']!,
          label: 'Nhãn',
          hint: 'Ghi chú giao dịch',
          prefixIcon: Icons.label,
          onChanged: (value) => onDataChanged('label', value),
        ),
      ],
    );
  }

  Widget _buildDefaultFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Thông tin cơ bản', Icons.qr_code),
        const SizedBox(height: 16),
        ModernInputField(
          controller: controllers['text'] ?? TextEditingController(),
          label: 'Nội dung',
          hint: 'Nhập nội dung...',
          prefixIcon: Icons.text_fields,
          maxLines: 3,
          isRequired: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập nội dung';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('text', value),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colors.primary.withOpacity(0.1),
            context.colors.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.colors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: context.colors.primaryGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: context.styles.titleMedium.copyWith(
                color: context.colors.text,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
