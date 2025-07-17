import 'package:flutter/material.dart';
import '../../widgets/modern_input_field.dart';

// WhatsApp QR
Widget buildWhatsAppFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['phone']!,
        label: 'Số điện thoại',
        hint: '+84 123 456 789',
        prefixIcon: Icons.phone,
        keyboardType: TextInputType.phone,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập số điện thoại'
            : null,
        onChanged: (value) => onDataChanged('phone', value),
      ),
      ModernInputField(
        controller: controllers['message']!,
        label: 'Tin nhắn',
        hint: 'Nhập nội dung tin nhắn...',
        prefixIcon: Icons.message,
        maxLines: 2,
        onChanged: (value) => onDataChanged('message', value),
      ),
    ],
  );
}

// Telegram QR
Widget buildTelegramFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['username']!,
        label: 'Username',
        hint: '@username',
        prefixIcon: Icons.person,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập username' : null,
        onChanged: (value) => onDataChanged('username', value),
      ),
      ModernInputField(
        controller: controllers['message']!,
        label: 'Tin nhắn',
        hint: 'Nhập nội dung tin nhắn...',
        prefixIcon: Icons.message,
        maxLines: 2,
        onChanged: (value) => onDataChanged('message', value),
      ),
    ],
  );
}

// Skype QR
Widget buildSkypeFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['username']!,
        label: 'Skype Username',
        hint: 'username',
        prefixIcon: Icons.person,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập Skype username'
            : null,
        onChanged: (value) => onDataChanged('username', value),
      ),
      ModernDropdownField(
        label: 'Hành động',
        hint: 'Chọn hành động',
        prefixIcon: Icons.call,
        options: ['call', 'chat', 'video'],
        value: controllers['action']!.text.isEmpty
            ? 'call'
            : controllers['action']!.text,
        onChanged: (value) {
          controllers['action']!.text = value ?? 'call';
          onDataChanged('action', value ?? 'call');
        },
      ),
    ],
  );
}

// Zoom QR
Widget buildZoomFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['meetingId']!,
        label: 'Meeting ID',
        hint: '123 4567 8901',
        prefixIcon: Icons.videocam,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập Meeting ID'
            : null,
        onChanged: (value) => onDataChanged('meetingId', value),
      ),
      ModernInputField(
        controller: controllers['password']!,
        label: 'Mật khẩu',
        hint: 'Nhập mật khẩu',
        prefixIcon: Icons.lock,
        onChanged: (value) => onDataChanged('password', value),
      ),
    ],
  );
}

// Discord QR
Widget buildDiscordFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['serverId']!,
        label: 'Server ID',
        hint: 'Nhập Server ID',
        prefixIcon: Icons.numbers,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập Server ID' : null,
        onChanged: (value) => onDataChanged('serverId', value),
      ),
      ModernInputField(
        controller: controllers['channelId']!,
        label: 'Channel ID',
        hint: 'Nhập Channel ID',
        prefixIcon: Icons.numbers,
        onChanged: (value) => onDataChanged('channelId', value),
      ),
    ],
  );
}

// Bitcoin QR
Widget buildBitcoinFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['address']!,
        label: 'Địa chỉ Bitcoin',
        hint: 'Nhập địa chỉ ví',
        prefixIcon: Icons.currency_bitcoin,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập địa chỉ ví'
            : null,
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

// Ethereum QR
Widget buildEthereumFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['address']!,
        label: 'Địa chỉ Ethereum',
        hint: 'Nhập địa chỉ ví',
        prefixIcon: Icons.currency_exchange,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập địa chỉ ví'
            : null,
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
        controller: controllers['gas']!,
        label: 'Gas',
        hint: '21000',
        prefixIcon: Icons.local_gas_station,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('gas', value),
      ),
    ],
  );
}

// Bank Transfer QR
Widget buildBankTransferFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['bankName']!,
        label: 'Tên ngân hàng',
        hint: 'Nhập tên ngân hàng',
        prefixIcon: Icons.account_balance,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên ngân hàng'
            : null,
        onChanged: (value) => onDataChanged('bankName', value),
      ),
      ModernInputField(
        controller: controllers['accountNumber']!,
        label: 'Số tài khoản',
        hint: 'Nhập số tài khoản',
        prefixIcon: Icons.numbers,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập số tài khoản'
            : null,
        onChanged: (value) => onDataChanged('accountNumber', value),
      ),
      ModernInputField(
        controller: controllers['accountName']!,
        label: 'Tên chủ tài khoản',
        hint: 'Nhập tên chủ tài khoản',
        prefixIcon: Icons.person,
        onChanged: (value) => onDataChanged('accountName', value),
      ),
      ModernInputField(
        controller: controllers['amount']!,
        label: 'Số tiền',
        hint: '100000',
        prefixIcon: Icons.attach_money,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('amount', value),
      ),
    ],
  );
}

// PayPal QR
Widget buildPayPalFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['email']!,
        label: 'Email PayPal',
        hint: 'example@email.com',
        prefixIcon: Icons.email,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập email' : null,
        onChanged: (value) => onDataChanged('email', value),
      ),
      ModernInputField(
        controller: controllers['amount']!,
        label: 'Số tiền',
        hint: '100',
        prefixIcon: Icons.attach_money,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('amount', value),
      ),
      ModernInputField(
        controller: controllers['description']!,
        label: 'Mô tả',
        hint: 'Mô tả giao dịch',
        prefixIcon: Icons.description,
        onChanged: (value) => onDataChanged('description', value),
      ),
    ],
  );
}

// Momo QR
Widget buildMomoFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['phone']!,
        label: 'Số điện thoại',
        hint: '+84 123 456 789',
        prefixIcon: Icons.phone,
        keyboardType: TextInputType.phone,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập số điện thoại'
            : null,
        onChanged: (value) => onDataChanged('phone', value),
      ),
      ModernInputField(
        controller: controllers['amount']!,
        label: 'Số tiền',
        hint: '100000',
        prefixIcon: Icons.attach_money,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('amount', value),
      ),
      ModernInputField(
        controller: controllers['description']!,
        label: 'Mô tả',
        hint: 'Mô tả giao dịch',
        prefixIcon: Icons.description,
        onChanged: (value) => onDataChanged('description', value),
      ),
    ],
  );
}

// ZaloPay QR
Widget buildZaloPayFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['phone']!,
        label: 'Số điện thoại',
        hint: '+84 123 456 789',
        prefixIcon: Icons.phone,
        keyboardType: TextInputType.phone,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập số điện thoại'
            : null,
        onChanged: (value) => onDataChanged('phone', value),
      ),
      ModernInputField(
        controller: controllers['amount']!,
        label: 'Số tiền',
        hint: '100000',
        prefixIcon: Icons.attach_money,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('amount', value),
      ),
      ModernInputField(
        controller: controllers['description']!,
        label: 'Mô tả',
        hint: 'Mô tả giao dịch',
        prefixIcon: Icons.description,
        onChanged: (value) => onDataChanged('description', value),
      ),
    ],
  );
}

// VNPay QR
Widget buildVNPayFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['merchantId']!,
        label: 'Merchant ID',
        hint: 'Nhập Merchant ID',
        prefixIcon: Icons.numbers,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập Merchant ID'
            : null,
        onChanged: (value) => onDataChanged('merchantId', value),
      ),
      ModernInputField(
        controller: controllers['amount']!,
        label: 'Số tiền',
        hint: '100000',
        prefixIcon: Icons.attach_money,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('amount', value),
      ),
      ModernInputField(
        controller: controllers['description']!,
        label: 'Mô tả',
        hint: 'Mô tả giao dịch',
        prefixIcon: Icons.description,
        onChanged: (value) => onDataChanged('description', value),
      ),
    ],
  );
}

// Google Play QR
Widget buildGooglePlayFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['appName']!,
        label: 'Tên ứng dụng',
        hint: 'Tên ứng dụng',
        prefixIcon: Icons.apps,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên ứng dụng'
            : null,
        onChanged: (value) => onDataChanged('appName', value),
      ),
      ModernInputField(
        controller: controllers['packageName']!,
        label: 'Package Name',
        hint: 'com.example.app',
        prefixIcon: Icons.tag,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập package name'
            : null,
        onChanged: (value) => onDataChanged('packageName', value),
      ),
    ],
  );
}

// Spotify QR
Widget buildSpotifyFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['trackId']!,
        label: 'Track ID',
        hint: 'Nhập Track ID',
        prefixIcon: Icons.music_note,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập Track ID' : null,
        onChanged: (value) => onDataChanged('trackId', value),
      ),
      ModernInputField(
        controller: controllers['artist']!,
        label: 'Nghệ sĩ',
        hint: 'Tên nghệ sĩ',
        prefixIcon: Icons.person,
        onChanged: (value) => onDataChanged('artist', value),
      ),
    ],
  );
}

// YouTube QR
Widget buildYouTubeFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['videoId']!,
        label: 'Video ID',
        hint: 'Nhập Video ID',
        prefixIcon: Icons.play_circle,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập Video ID' : null,
        onChanged: (value) => onDataChanged('videoId', value),
      ),
      ModernInputField(
        controller: controllers['title']!,
        label: 'Tiêu đề',
        hint: 'Tiêu đề video',
        prefixIcon: Icons.title,
        onChanged: (value) => onDataChanged('title', value),
      ),
    ],
  );
}

// TikTok QR
Widget buildTikTokFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['username']!,
        label: 'Username',
        hint: '@username',
        prefixIcon: Icons.person,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập username' : null,
        onChanged: (value) => onDataChanged('username', value),
      ),
      ModernInputField(
        controller: controllers['videoId']!,
        label: 'Video ID',
        hint: 'Nhập Video ID',
        prefixIcon: Icons.music_video,
        onChanged: (value) => onDataChanged('videoId', value),
      ),
    ],
  );
}

// Instagram QR
Widget buildInstagramFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['username']!,
        label: 'Username',
        hint: '@username',
        prefixIcon: Icons.person,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập username' : null,
        onChanged: (value) => onDataChanged('username', value),
      ),
      ModernInputField(
        controller: controllers['postId']!,
        label: 'Post ID',
        hint: 'Nhập Post ID',
        prefixIcon: Icons.camera_alt,
        onChanged: (value) => onDataChanged('postId', value),
      ),
    ],
  );
}

// Facebook QR
Widget buildFacebookFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['pageId']!,
        label: 'Page ID',
        hint: 'Nhập Page ID',
        prefixIcon: Icons.facebook,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập Page ID' : null,
        onChanged: (value) => onDataChanged('pageId', value),
      ),
      ModernInputField(
        controller: controllers['postId']!,
        label: 'Post ID',
        hint: 'Nhập Post ID',
        prefixIcon: Icons.camera_alt,
        onChanged: (value) => onDataChanged('postId', value),
      ),
    ],
  );
}

// Twitter QR
Widget buildTwitterFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['username']!,
        label: 'Username',
        hint: '@username',
        prefixIcon: Icons.person,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập username' : null,
        onChanged: (value) => onDataChanged('username', value),
      ),
      ModernInputField(
        controller: controllers['tweetId']!,
        label: 'Tweet ID',
        hint: 'Nhập Tweet ID',
        prefixIcon: Icons.flutter_dash,
        onChanged: (value) => onDataChanged('tweetId', value),
      ),
    ],
  );
}

// LinkedIn QR
Widget buildLinkedInFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['profileId']!,
        label: 'Profile ID',
        hint: 'Nhập Profile ID',
        prefixIcon: Icons.work,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập Profile ID'
            : null,
        onChanged: (value) => onDataChanged('profileId', value),
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

// Business Card QR
Widget buildBusinessCardFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['name']!,
        label: 'Họ và tên',
        hint: 'Nhập họ và tên',
        prefixIcon: Icons.person,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập họ và tên' : null,
        onChanged: (value) => onDataChanged('name', value),
      ),
      ModernInputField(
        controller: controllers['title']!,
        label: 'Chức danh',
        hint: 'Chức danh',
        prefixIcon: Icons.badge,
        onChanged: (value) => onDataChanged('title', value),
      ),
      ModernInputField(
        controller: controllers['company']!,
        label: 'Công ty',
        hint: 'Tên công ty',
        prefixIcon: Icons.business,
        onChanged: (value) => onDataChanged('company', value),
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
        controller: controllers['website']!,
        label: 'Website',
        hint: 'https://example.com',
        prefixIcon: Icons.link,
        keyboardType: TextInputType.url,
        onChanged: (value) => onDataChanged('website', value),
      ),
      ModernInputField(
        controller: controllers['address']!,
        label: 'Địa chỉ',
        hint: 'Nhập địa chỉ',
        prefixIcon: Icons.location_on,
        onChanged: (value) => onDataChanged('address', value),
      ),
    ],
  );
}

// Event Ticket QR
Widget buildEventTicketFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['eventName']!,
        label: 'Tên sự kiện',
        hint: 'Nhập tên sự kiện',
        prefixIcon: Icons.event,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên sự kiện'
            : null,
        onChanged: (value) => onDataChanged('eventName', value),
      ),
      ModernInputField(
        controller: controllers['ticketId']!,
        label: 'Mã vé',
        hint: 'Nhập mã vé',
        prefixIcon: Icons.confirmation_number,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập mã vé' : null,
        onChanged: (value) => onDataChanged('ticketId', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
      ModernInputField(
        controller: controllers['venue']!,
        label: 'Địa điểm',
        hint: 'Nhập địa điểm',
        prefixIcon: Icons.location_on,
        onChanged: (value) => onDataChanged('venue', value),
      ),
    ],
  );
}

// Coupon QR
Widget buildCouponFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['code']!,
        label: 'Mã coupon',
        hint: 'Nhập mã coupon',
        prefixIcon: Icons.local_offer,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập mã coupon' : null,
        onChanged: (value) => onDataChanged('code', value),
      ),
      ModernInputField(
        controller: controllers['discount']!,
        label: 'Giảm giá (%)',
        hint: '10',
        prefixIcon: Icons.percent,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('discount', value),
      ),
      ModernInputField(
        controller: controllers['validUntil']!,
        label: 'Hạn sử dụng',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('validUntil', value),
      ),
      ModernInputField(
        controller: controllers['description']!,
        label: 'Mô tả',
        hint: 'Mô tả coupon',
        prefixIcon: Icons.description,
        onChanged: (value) => onDataChanged('description', value),
      ),
    ],
  );
}

// Product QR
Widget buildProductFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['name']!,
        label: 'Tên sản phẩm',
        hint: 'Nhập tên sản phẩm',
        prefixIcon: Icons.shopping_bag,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên sản phẩm'
            : null,
        onChanged: (value) => onDataChanged('name', value),
      ),
      ModernInputField(
        controller: controllers['price']!,
        label: 'Giá',
        hint: '100000',
        prefixIcon: Icons.attach_money,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('price', value),
      ),
      ModernInputField(
        controller: controllers['description']!,
        label: 'Mô tả',
        hint: 'Mô tả sản phẩm',
        prefixIcon: Icons.description,
        onChanged: (value) => onDataChanged('description', value),
      ),
      ModernInputField(
        controller: controllers['url']!,
        label: 'Link sản phẩm',
        hint: 'https://example.com',
        prefixIcon: Icons.link,
        keyboardType: TextInputType.url,
        onChanged: (value) => onDataChanged('url', value),
      ),
    ],
  );
}

// Restaurant Menu QR
Widget buildRestaurantMenuFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['restaurantName']!,
        label: 'Tên nhà hàng',
        hint: 'Nhập tên nhà hàng',
        prefixIcon: Icons.restaurant,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên nhà hàng'
            : null,
        onChanged: (value) => onDataChanged('restaurantName', value),
      ),
      ModernInputField(
        controller: controllers['menuUrl']!,
        label: 'Link menu',
        hint: 'https://example.com/menu',
        prefixIcon: Icons.link,
        keyboardType: TextInputType.url,
        onChanged: (value) => onDataChanged('menuUrl', value),
      ),
      ModernInputField(
        controller: controllers['phone']!,
        label: 'Số điện thoại',
        hint: '+84 123 456 789',
        prefixIcon: Icons.phone,
        keyboardType: TextInputType.phone,
        onChanged: (value) => onDataChanged('phone', value),
      ),
    ],
  );
}

// Hotel Booking QR
Widget buildHotelBookingFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['hotelName']!,
        label: 'Tên khách sạn',
        hint: 'Nhập tên khách sạn',
        prefixIcon: Icons.hotel,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên khách sạn'
            : null,
        onChanged: (value) => onDataChanged('hotelName', value),
      ),
      ModernInputField(
        controller: controllers['bookingId']!,
        label: 'Mã đặt phòng',
        hint: 'Nhập mã đặt phòng',
        prefixIcon: Icons.confirmation_number,
        onChanged: (value) => onDataChanged('bookingId', value),
      ),
      ModernInputField(
        controller: controllers['checkIn']!,
        label: 'Ngày nhận phòng',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.login,
        onChanged: (value) => onDataChanged('checkIn', value),
      ),
      ModernInputField(
        controller: controllers['checkOut']!,
        label: 'Ngày trả phòng',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.logout,
        onChanged: (value) => onDataChanged('checkOut', value),
      ),
    ],
  );
}

// Flight Ticket QR
Widget buildFlightTicketFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['airline']!,
        label: 'Hãng bay',
        hint: 'Nhập tên hãng bay',
        prefixIcon: Icons.flight,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên hãng bay'
            : null,
        onChanged: (value) => onDataChanged('airline', value),
      ),
      ModernInputField(
        controller: controllers['flightNumber']!,
        label: 'Số hiệu chuyến bay',
        hint: 'VN123',
        prefixIcon: Icons.confirmation_number,
        onChanged: (value) => onDataChanged('flightNumber', value),
      ),
      ModernInputField(
        controller: controllers['departure']!,
        label: 'Nơi đi',
        hint: 'Nhập nơi đi',
        prefixIcon: Icons.flight_takeoff,
        onChanged: (value) => onDataChanged('departure', value),
      ),
      ModernInputField(
        controller: controllers['arrival']!,
        label: 'Nơi đến',
        hint: 'Nhập nơi đến',
        prefixIcon: Icons.flight_land,
        onChanged: (value) => onDataChanged('arrival', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày bay',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
    ],
  );
}

// Student ID QR
Widget buildStudentIDFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['studentId']!,
        label: 'Mã sinh viên',
        hint: 'Nhập mã sinh viên',
        prefixIcon: Icons.school,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập mã sinh viên'
            : null,
        onChanged: (value) => onDataChanged('studentId', value),
      ),
      ModernInputField(
        controller: controllers['name']!,
        label: 'Họ và tên',
        hint: 'Nhập họ và tên',
        prefixIcon: Icons.person,
        onChanged: (value) => onDataChanged('name', value),
      ),
      ModernInputField(
        controller: controllers['major']!,
        label: 'Ngành học',
        hint: 'Nhập ngành học',
        prefixIcon: Icons.school,
        onChanged: (value) => onDataChanged('major', value),
      ),
      ModernInputField(
        controller: controllers['studentCard']!,
        label: 'Thẻ sinh viên',
        hint: 'Nhập thẻ sinh viên',
        prefixIcon: Icons.credit_card,
        onChanged: (value) => onDataChanged('studentCard', value),
      ),
    ],
  );
}

// Course QR
Widget buildCourseFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['courseCode']!,
        label: 'Mã khóa học',
        hint: 'Nhập mã khóa học',
        prefixIcon: Icons.school,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập mã khóa học'
            : null,
        onChanged: (value) => onDataChanged('courseCode', value),
      ),
      ModernInputField(
        controller: controllers['courseName']!,
        label: 'Tên khóa học',
        hint: 'Nhập tên khóa học',
        prefixIcon: Icons.school,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên khóa học'
            : null,
        onChanged: (value) => onDataChanged('courseName', value),
      ),
      ModernInputField(
        controller: controllers['instructor']!,
        label: 'Giảng viên',
        hint: 'Nhập giảng viên',
        prefixIcon: Icons.person,
        onChanged: (value) => onDataChanged('instructor', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày bắt đầu',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
    ],
  );
}

// Library QR
Widget buildLibraryFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['libraryId']!,
        label: 'Mã thư viện',
        hint: 'Nhập mã thư viện',
        prefixIcon: Icons.local_library,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập mã thư viện'
            : null,
        onChanged: (value) => onDataChanged('libraryId', value),
      ),
      ModernInputField(
        controller: controllers['bookId']!,
        label: 'Mã sách',
        hint: 'Nhập mã sách',
        prefixIcon: Icons.book,
        onChanged: (value) => onDataChanged('bookId', value),
      ),
      ModernInputField(
        controller: controllers['title']!,
        label: 'Tên sách',
        hint: 'Nhập tên sách',
        prefixIcon: Icons.title,
        onChanged: (value) => onDataChanged('title', value),
      ),
      ModernInputField(
        controller: controllers['author']!,
        label: 'Tác giả',
        hint: 'Nhập tác giả',
        prefixIcon: Icons.person,
        onChanged: (value) => onDataChanged('author', value),
      ),
    ],
  );
}

// Certificate QR
Widget buildCertificateFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['certificateId']!,
        label: 'Mã chứng chỉ',
        hint: 'Nhập mã chứng chỉ',
        prefixIcon: Icons.verified,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập mã chứng chỉ'
            : null,
        onChanged: (value) => onDataChanged('certificateId', value),
      ),
      ModernInputField(
        controller: controllers['name']!,
        label: 'Tên chứng chỉ',
        hint: 'Nhập tên chứng chỉ',
        prefixIcon: Icons.verified,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên chứng chỉ'
            : null,
        onChanged: (value) => onDataChanged('name', value),
      ),
      ModernInputField(
        controller: controllers['issuer']!,
        label: 'Nhà cung cấp',
        hint: 'Nhập nhà cung cấp',
        prefixIcon: Icons.verified,
        onChanged: (value) => onDataChanged('issuer', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày cấp',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
    ],
  );
}

// Medical Record QR
Widget buildMedicalRecordFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['recordId']!,
        label: 'Mã bản ghi',
        hint: 'Nhập mã bản ghi',
        prefixIcon: Icons.medical_services,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập mã bản ghi'
            : null,
        onChanged: (value) => onDataChanged('recordId', value),
      ),
      ModernInputField(
        controller: controllers['patientName']!,
        label: 'Tên bệnh nhân',
        hint: 'Nhập tên bệnh nhân',
        prefixIcon: Icons.person,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên bệnh nhân'
            : null,
        onChanged: (value) => onDataChanged('patientName', value),
      ),
      ModernInputField(
        controller: controllers['doctor']!,
        label: 'Bác sĩ',
        hint: 'Nhập bác sĩ',
        prefixIcon: Icons.person,
        onChanged: (value) => onDataChanged('doctor', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày khám',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
    ],
  );
}

// Vaccination QR
Widget buildVaccinationFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['vaccineName']!,
        label: 'Tên vaccine',
        hint: 'Nhập tên vaccine',
        prefixIcon: Icons.vaccines,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên vaccine'
            : null,
        onChanged: (value) => onDataChanged('vaccineName', value),
      ),
      ModernInputField(
        controller: controllers['lotNumber']!,
        label: 'Số lô',
        hint: 'Nhập số lô',
        prefixIcon: Icons.confirmation_number,
        onChanged: (value) => onDataChanged('lotNumber', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày tiêm',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
      ModernInputField(
        controller: controllers['dose']!,
        label: 'Liều lượng',
        hint: '1',
        prefixIcon: Icons.local_hospital,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('dose', value),
      ),
    ],
  );
}

// Health Card QR
Widget buildHealthCardFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['cardId']!,
        label: 'Mã thẻ',
        hint: 'Nhập mã thẻ',
        prefixIcon: Icons.credit_card,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập mã thẻ' : null,
        onChanged: (value) => onDataChanged('cardId', value),
      ),
      ModernInputField(
        controller: controllers['name']!,
        label: 'Tên chủ thẻ',
        hint: 'Nhập tên chủ thẻ',
        prefixIcon: Icons.person,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên chủ thẻ'
            : null,
        onChanged: (value) => onDataChanged('name', value),
      ),
      ModernInputField(
        controller: controllers['dob']!,
        label: 'Ngày sinh',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.cake,
        onChanged: (value) => onDataChanged('dob', value),
      ),
      ModernInputField(
        controller: controllers['bloodType']!,
        label: 'Nhóm máu',
        hint: 'Nhập nhóm máu',
        prefixIcon: Icons.bloodtype,
        onChanged: (value) => onDataChanged('bloodType', value),
      ),
    ],
  );
}

// Pharmacy QR
Widget buildPharmacyFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['pharmacyId']!,
        label: 'Mã nhà thuốc',
        hint: 'Nhập mã nhà thuốc',
        prefixIcon: Icons.local_pharmacy,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập mã nhà thuốc'
            : null,
        onChanged: (value) => onDataChanged('pharmacyId', value),
      ),
      ModernInputField(
        controller: controllers['name']!,
        label: 'Tên nhà thuốc',
        hint: 'Nhập tên nhà thuốc',
        prefixIcon: Icons.local_pharmacy,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên nhà thuốc'
            : null,
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
        controller: controllers['address']!,
        label: 'Địa chỉ',
        hint: 'Nhập địa chỉ',
        prefixIcon: Icons.location_on,
        onChanged: (value) => onDataChanged('address', value),
      ),
    ],
  );
}

// Bus Ticket QR
Widget buildBusTicketFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['busId']!,
        label: 'Mã xe buýt',
        hint: 'Nhập mã xe buýt',
        prefixIcon: Icons.directions_bus,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập mã xe buýt'
            : null,
        onChanged: (value) => onDataChanged('busId', value),
      ),
      ModernInputField(
        controller: controllers['route']!,
        label: 'Tuyến đường',
        hint: 'Nhập tuyến đường',
        prefixIcon: Icons.directions,
        onChanged: (value) => onDataChanged('route', value),
      ),
      ModernInputField(
        controller: controllers['seat']!,
        label: 'Ghế',
        hint: 'Nhập ghế',
        prefixIcon: Icons.airline_seat_recline_normal,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('seat', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày đi',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
    ],
  );
}

// Train Ticket QR
Widget buildTrainTicketFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['trainId']!,
        label: 'Mã tàu',
        hint: 'Nhập mã tàu',
        prefixIcon: Icons.train,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập mã tàu' : null,
        onChanged: (value) => onDataChanged('trainId', value),
      ),
      ModernInputField(
        controller: controllers['route']!,
        label: 'Tuyến đường',
        hint: 'Nhập tuyến đường',
        prefixIcon: Icons.directions,
        onChanged: (value) => onDataChanged('route', value),
      ),
      ModernInputField(
        controller: controllers['seat']!,
        label: 'Ghế',
        hint: 'Nhập ghế',
        prefixIcon: Icons.airline_seat_recline_normal,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('seat', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày đi',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
    ],
  );
}

// Parking QR
Widget buildParkingFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['parkingId']!,
        label: 'Mã bãi đỗ',
        hint: 'Nhập mã bãi đỗ',
        prefixIcon: Icons.local_parking,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập mã bãi đỗ' : null,
        onChanged: (value) => onDataChanged('parkingId', value),
      ),
      ModernInputField(
        controller: controllers['vehicleId']!,
        label: 'Biển số xe',
        hint: 'Nhập biển số xe',
        prefixIcon: Icons.directions_car,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập biển số xe'
            : null,
        onChanged: (value) => onDataChanged('vehicleId', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Thời gian đỗ',
        hint: 'YYYY-MM-DD HH:MM',
        prefixIcon: Icons.access_time,
        onChanged: (value) => onDataChanged('date', value),
      ),
    ],
  );
}

// Taxi QR
Widget buildTaxiFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['taxiId']!,
        label: 'Mã taxi',
        hint: 'Nhập mã taxi',
        prefixIcon: Icons.directions_car,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập mã taxi' : null,
        onChanged: (value) => onDataChanged('taxiId', value),
      ),
      ModernInputField(
        controller: controllers['vehicleId']!,
        label: 'Biển số xe',
        hint: 'Nhập biển số xe',
        prefixIcon: Icons.directions_car,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập biển số xe'
            : null,
        onChanged: (value) => onDataChanged('vehicleId', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Thời gian đi',
        hint: 'YYYY-MM-DD HH:MM',
        prefixIcon: Icons.access_time,
        onChanged: (value) => onDataChanged('date', value),
      ),
    ],
  );
}

// Bike Sharing QR
Widget buildBikeSharingFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['bikeId']!,
        label: 'Mã xe',
        hint: 'Nhập mã xe',
        prefixIcon: Icons.directions_bike,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập mã xe' : null,
        onChanged: (value) => onDataChanged('bikeId', value),
      ),
      ModernInputField(
        controller: controllers['stationId']!,
        label: 'Bãi đỗ',
        hint: 'Nhập bãi đỗ',
        prefixIcon: Icons.local_parking,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập bãi đỗ' : null,
        onChanged: (value) => onDataChanged('stationId', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Thời gian thuê',
        hint: 'YYYY-MM-DD HH:MM',
        prefixIcon: Icons.access_time,
        onChanged: (value) => onDataChanged('date', value),
      ),
    ],
  );
}

// Movie Ticket QR
Widget buildMovieTicketFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['movieId']!,
        label: 'Mã phim',
        hint: 'Nhập mã phim',
        prefixIcon: Icons.movie,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập mã phim' : null,
        onChanged: (value) => onDataChanged('movieId', value),
      ),
      ModernInputField(
        controller: controllers['title']!,
        label: 'Tên phim',
        hint: 'Nhập tên phim',
        prefixIcon: Icons.movie,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập tên phim' : null,
        onChanged: (value) => onDataChanged('title', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày xem',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
      ModernInputField(
        controller: controllers['seat']!,
        label: 'Ghế',
        hint: 'Nhập ghế',
        prefixIcon: Icons.airline_seat_recline_normal,
        keyboardType: TextInputType.number,
        onChanged: (value) => onDataChanged('seat', value),
      ),
    ],
  );
}

// Concert QR
Widget buildConcertFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['concertId']!,
        label: 'Mã sự kiện',
        hint: 'Nhập mã sự kiện',
        prefixIcon: Icons.music_note,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập mã sự kiện'
            : null,
        onChanged: (value) => onDataChanged('concertId', value),
      ),
      ModernInputField(
        controller: controllers['artist']!,
        label: 'Nghệ sĩ',
        hint: 'Nhập nghệ sĩ',
        prefixIcon: Icons.person,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập nghệ sĩ' : null,
        onChanged: (value) => onDataChanged('artist', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày diễn',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
      ModernInputField(
        controller: controllers['venue']!,
        label: 'Địa điểm',
        hint: 'Nhập địa điểm',
        prefixIcon: Icons.location_on,
        onChanged: (value) => onDataChanged('venue', value),
      ),
    ],
  );
}

// Sports Event QR
Widget buildSportsEventFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['eventId']!,
        label: 'Mã sự kiện',
        hint: 'Nhập mã sự kiện',
        prefixIcon: Icons.sports_soccer,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập mã sự kiện'
            : null,
        onChanged: (value) => onDataChanged('eventId', value),
      ),
      ModernInputField(
        controller: controllers['name']!,
        label: 'Tên sự kiện',
        hint: 'Nhập tên sự kiện',
        prefixIcon: Icons.sports_soccer,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên sự kiện'
            : null,
        onChanged: (value) => onDataChanged('name', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày diễn',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
      ModernInputField(
        controller: controllers['venue']!,
        label: 'Địa điểm',
        hint: 'Nhập địa điểm',
        prefixIcon: Icons.location_on,
        onChanged: (value) => onDataChanged('venue', value),
      ),
    ],
  );
}

// Gym Membership QR
Widget buildGymMembershipFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['membershipId']!,
        label: 'Mã thành viên',
        hint: 'Nhập mã thành viên',
        prefixIcon: Icons.fitness_center,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập mã thành viên'
            : null,
        onChanged: (value) => onDataChanged('membershipId', value),
      ),
      ModernInputField(
        controller: controllers['name']!,
        label: 'Tên thành viên',
        hint: 'Nhập tên thành viên',
        prefixIcon: Icons.fitness_center,
        isRequired: true,
        validator: (value) => (value == null || value.isEmpty)
            ? 'Vui lòng nhập tên thành viên'
            : null,
        onChanged: (value) => onDataChanged('name', value),
      ),
      ModernInputField(
        controller: controllers['dob']!,
        label: 'Ngày sinh',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.cake,
        onChanged: (value) => onDataChanged('dob', value),
      ),
      ModernInputField(
        controller: controllers['expirationDate']!,
        label: 'Ngày hết hạn',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('expirationDate', value),
      ),
    ],
  );
}

// Game QR
Widget buildGameFields(
    BuildContext context,
    Map<String, TextEditingController> controllers,
    Function(String, String) onDataChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ModernInputField(
        controller: controllers['gameId']!,
        label: 'Mã game',
        hint: 'Nhập mã game',
        prefixIcon: Icons.videogame_asset,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập mã game' : null,
        onChanged: (value) => onDataChanged('gameId', value),
      ),
      ModernInputField(
        controller: controllers['name']!,
        label: 'Tên game',
        hint: 'Nhập tên game',
        prefixIcon: Icons.videogame_asset,
        isRequired: true,
        validator: (value) =>
            (value == null || value.isEmpty) ? 'Vui lòng nhập tên game' : null,
        onChanged: (value) => onDataChanged('name', value),
      ),
      ModernInputField(
        controller: controllers['platform']!,
        label: 'Nền tảng',
        hint: 'Nhập nền tảng',
        prefixIcon: Icons.phone_android,
        onChanged: (value) => onDataChanged('platform', value),
      ),
      ModernInputField(
        controller: controllers['date']!,
        label: 'Ngày chơi',
        hint: 'YYYY-MM-DD',
        prefixIcon: Icons.date_range,
        onChanged: (value) => onDataChanged('date', value),
      ),
    ],
  );
}
