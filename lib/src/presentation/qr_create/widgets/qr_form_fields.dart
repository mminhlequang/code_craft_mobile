import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../../constants/constants.dart';

class QrFormFields extends StatelessWidget {
  final String qrType;
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
      case 'URL':
        return _buildUrlFields(context);
      case 'Text':
        return _buildTextFields(context);
      case 'WiFi':
        return _buildWiFiFields(context);
      case 'Email':
        return _buildEmailFields(context);
      case 'Phone':
        return _buildPhoneFields(context);
      case 'SMS':
        return _buildSmsFields(context);
      case 'VCard':
        return _buildVCardFields(context);
      case 'GeoLocation':
        return _buildGeoLocationFields(context);
      case 'Calendar':
        return _buildCalendarFields(context);
      case 'Social Media':
        return _buildSocialMediaFields(context);
      case 'Payment':
        return _buildPaymentFields(context);
      case 'App Store':
        return _buildAppStoreFields(context);
      default:
        return _buildDefaultFields(context);
    }
  }

  Widget _buildUrlFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin URL',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['url'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'URL',
            hintText: 'https://example.com',
            prefixIcon: const Icon(Icons.link),
          ),
          keyboardType: TextInputType.url,
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
        Text(
          'Nội dung văn bản',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['text'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Văn bản',
            hintText: 'Nhập nội dung văn bản...',
            prefixIcon: const Icon(Icons.text_fields),
          ),
          maxLines: 3,
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
        Text(
          'Thông tin WiFi',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['ssid'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Tên mạng WiFi (SSID)',
            hintText: 'Nhập tên mạng WiFi',
            prefixIcon: const Icon(Icons.wifi),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập tên mạng WiFi';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('ssid', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['password'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Mật khẩu',
            hintText: 'Nhập mật khẩu WiFi',
            prefixIcon: const Icon(Icons.lock),
          ),
          obscureText: true,
          onChanged: (value) => onDataChanged('password', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['encryption'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Loại mã hóa',
            hintText: 'WPA, WEP, nopass',
            prefixIcon: const Icon(Icons.security),
          ),
          onChanged: (value) => onDataChanged('encryption', value),
        ),
      ],
    );
  }

  Widget _buildEmailFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin Email',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['email'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Địa chỉ Email',
            hintText: 'example@email.com',
            prefixIcon: const Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
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
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['subject'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Tiêu đề',
            hintText: 'Tiêu đề email',
            prefixIcon: const Icon(Icons.subject),
          ),
          onChanged: (value) => onDataChanged('subject', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['body'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Nội dung',
            hintText: 'Nội dung email',
            prefixIcon: const Icon(Icons.message),
          ),
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
        Text(
          'Thông tin số điện thoại',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['phone'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Số điện thoại',
            hintText: '+84 123 456 789',
            prefixIcon: const Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
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
        Text(
          'Thông tin SMS',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['phone'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Số điện thoại',
            hintText: '+84 123 456 789',
            prefixIcon: const Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập số điện thoại';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('phone', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['message'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Nội dung tin nhắn',
            hintText: 'Nhập nội dung tin nhắn...',
            prefixIcon: const Icon(Icons.sms),
          ),
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
        Text(
          'Thông tin danh bạ',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['name'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Họ và tên',
            hintText: 'Nguyễn Văn A',
            prefixIcon: const Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập họ tên';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('name', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['phone'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Số điện thoại',
            hintText: '+84 123 456 789',
            prefixIcon: const Icon(Icons.phone),
          ),
          keyboardType: TextInputType.phone,
          onChanged: (value) => onDataChanged('phone', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['email'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Email',
            hintText: 'example@email.com',
            prefixIcon: const Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => onDataChanged('email', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['company'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Công ty',
            hintText: 'Tên công ty',
            prefixIcon: const Icon(Icons.business),
          ),
          onChanged: (value) => onDataChanged('company', value),
        ),
      ],
    );
  }

  Widget _buildGeoLocationFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin vị trí',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['latitude'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Vĩ độ',
            hintText: '10.762622',
            prefixIcon: const Icon(Icons.location_on),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập vĩ độ';
            }
            if (double.tryParse(value) == null) {
              return 'Vĩ độ không hợp lệ';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('latitude', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['longitude'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Kinh độ',
            hintText: '106.660172',
            prefixIcon: const Icon(Icons.location_on),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập kinh độ';
            }
            if (double.tryParse(value) == null) {
              return 'Kinh độ không hợp lệ';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('longitude', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['label'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Nhãn vị trí',
            hintText: 'Tên địa điểm',
            prefixIcon: const Icon(Icons.label),
          ),
          onChanged: (value) => onDataChanged('label', value),
        ),
      ],
    );
  }

  Widget _buildCalendarFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin sự kiện',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['title'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Tiêu đề sự kiện',
            hintText: 'Tên sự kiện',
            prefixIcon: const Icon(Icons.event),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập tiêu đề';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('title', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['description'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Mô tả',
            hintText: 'Mô tả sự kiện',
            prefixIcon: const Icon(Icons.description),
          ),
          maxLines: 2,
          onChanged: (value) => onDataChanged('description', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['location'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Địa điểm',
            hintText: 'Địa điểm tổ chức',
            prefixIcon: const Icon(Icons.location_on),
          ),
          onChanged: (value) => onDataChanged('location', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['startDate'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Ngày bắt đầu',
            hintText: '2024-01-01 09:00',
            prefixIcon: const Icon(Icons.schedule),
          ),
          onChanged: (value) => onDataChanged('startDate', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['endDate'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Ngày kết thúc',
            hintText: '2024-01-01 17:00',
            prefixIcon: const Icon(Icons.schedule),
          ),
          onChanged: (value) => onDataChanged('endDate', value),
        ),
      ],
    );
  }

  Widget _buildSocialMediaFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin mạng xã hội',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['platform'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Nền tảng',
            hintText: 'Facebook, Instagram, Twitter...',
            prefixIcon: const Icon(Icons.share),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập nền tảng';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('platform', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['username'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Tên người dùng',
            hintText: '@username',
            prefixIcon: const Icon(Icons.person),
          ),
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
        Text(
          'Thông tin thanh toán',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['amount'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Số tiền',
            hintText: '100000',
            prefixIcon: const Icon(Icons.attach_money),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập số tiền';
            }
            if (double.tryParse(value) == null) {
              return 'Số tiền không hợp lệ';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('amount', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['currency'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Đơn vị tiền tệ',
            hintText: 'VND, USD, EUR...',
            prefixIcon: const Icon(Icons.currency_exchange),
          ),
          onChanged: (value) => onDataChanged('currency', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['description'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Mô tả',
            hintText: 'Mô tả giao dịch',
            prefixIcon: const Icon(Icons.description),
          ),
          onChanged: (value) => onDataChanged('description', value),
        ),
      ],
    );
  }

  Widget _buildAppStoreFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin ứng dụng',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['appName'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Tên ứng dụng',
            hintText: 'Tên ứng dụng',
            prefixIcon: const Icon(Icons.apps),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập tên ứng dụng';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('appName', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['appId'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'ID ứng dụng',
            hintText: 'com.example.app',
            prefixIcon: const Icon(Icons.code),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập ID ứng dụng';
            }
            return null;
          },
          onChanged: (value) => onDataChanged('appId', value),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          controller: controllers['platform'],
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Nền tảng',
            hintText: 'iOS, Android, Web...',
            prefixIcon: const Icon(Icons.phone_android),
          ),
          onChanged: (value) => onDataChanged('platform', value),
        ),
      ],
    );
  }

  Widget _buildDefaultFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin QR Code',
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
        TextFormField(
          decoration: context.styles.inputDecoration.copyWith(
            labelText: 'Nội dung',
            hintText: 'Nhập nội dung...',
            prefixIcon: const Icon(Icons.qr_code),
          ),
          maxLines: 3,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập nội dung';
            }
            return null;
          },
        ),
      ],
    );
  }
}
