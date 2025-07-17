import 'package:flutter/material.dart';

enum QrCodeType {
  // Cơ bản
  websiteUrl,
  textPlainText,
  wifiAccess,
  phoneNumber,
  emailContact,
  
  // Liên lạc & Danh bạ
  vcardContact,
  smsMessage,
  socialMedia,
  appStoreDownload,
  eventCalendar,
  
  // Doanh nghiệp & Thương mại
  restaurantMenu,
  paymentQr,
  productInfo,
  businessCard,
  multiUrl,
  
  // Nội dung & Tài liệu
  pdfDocument,
  imageGallery,
  videoContent,
  locationMap,
  cryptoWallet;

  // Getter cho tên hiển thị
  String get displayName {
    switch (this) {
      case QrCodeType.websiteUrl:
        return 'Website URL';
      case QrCodeType.textPlainText:
        return 'Văn bản';
      case QrCodeType.wifiAccess:
        return 'WiFi';
      case QrCodeType.phoneNumber:
        return 'Số điện thoại';
      case QrCodeType.emailContact:
        return 'Email';
      case QrCodeType.vcardContact:
        return 'Danh bạ';
      case QrCodeType.smsMessage:
        return 'SMS';
      case QrCodeType.socialMedia:
        return 'Mạng xã hội';
      case QrCodeType.appStoreDownload:
        return 'Tải ứng dụng';
      case QrCodeType.eventCalendar:
        return 'Sự kiện';
      case QrCodeType.restaurantMenu:
        return 'Menu nhà hàng';
      case QrCodeType.paymentQr:
        return 'Thanh toán';
      case QrCodeType.productInfo:
        return 'Sản phẩm';
      case QrCodeType.businessCard:
        return 'Danh thiếp';
      case QrCodeType.multiUrl:
        return 'Nhiều URL';
      case QrCodeType.pdfDocument:
        return 'Tài liệu PDF';
      case QrCodeType.imageGallery:
        return 'Thư viện ảnh';
      case QrCodeType.videoContent:
        return 'Video';
      case QrCodeType.locationMap:
        return 'Vị trí';
      case QrCodeType.cryptoWallet:
        return 'Ví tiền điện tử';
    }
  }

  // Getter cho mô tả
  String get description {
    switch (this) {
      case QrCodeType.websiteUrl:
        return 'Tạo QR code cho website';
      case QrCodeType.textPlainText:
        return 'Tạo QR code cho văn bản';
      case QrCodeType.wifiAccess:
        return 'Tạo QR code kết nối WiFi';
      case QrCodeType.phoneNumber:
        return 'Tạo QR code cho số điện thoại';
      case QrCodeType.emailContact:
        return 'Tạo QR code cho email';
      case QrCodeType.vcardContact:
        return 'Tạo QR code cho danh bạ';
      case QrCodeType.smsMessage:
        return 'Tạo QR code cho tin nhắn SMS';
      case QrCodeType.socialMedia:
        return 'Tạo QR code cho mạng xã hội';
      case QrCodeType.appStoreDownload:
        return 'Tạo QR code tải ứng dụng';
      case QrCodeType.eventCalendar:
        return 'Tạo QR code cho sự kiện';
      case QrCodeType.restaurantMenu:
        return 'Tạo QR code cho menu nhà hàng';
      case QrCodeType.paymentQr:
        return 'Tạo QR code thanh toán';
      case QrCodeType.productInfo:
        return 'Tạo QR code cho sản phẩm';
      case QrCodeType.businessCard:
        return 'Tạo QR code cho danh thiếp';
      case QrCodeType.multiUrl:
        return 'Tạo QR code cho nhiều URL';
      case QrCodeType.pdfDocument:
        return 'Tạo QR code cho tài liệu PDF';
      case QrCodeType.imageGallery:
        return 'Tạo QR code cho thư viện ảnh';
      case QrCodeType.videoContent:
        return 'Tạo QR code cho video';
      case QrCodeType.locationMap:
        return 'Tạo QR code cho vị trí';
      case QrCodeType.cryptoWallet:
        return 'Tạo QR code cho ví tiền điện tử';
    }
  }

  // Getter cho icon
  IconData get icon {
    switch (this) {
      case QrCodeType.websiteUrl:
        return Icons.link;
      case QrCodeType.textPlainText:
        return Icons.text_fields;
      case QrCodeType.wifiAccess:
        return Icons.wifi;
      case QrCodeType.phoneNumber:
        return Icons.phone;
      case QrCodeType.emailContact:
        return Icons.email;
      case QrCodeType.vcardContact:
        return Icons.contact_phone;
      case QrCodeType.smsMessage:
        return Icons.sms;
      case QrCodeType.socialMedia:
        return Icons.share;
      case QrCodeType.appStoreDownload:
        return Icons.shop;
      case QrCodeType.eventCalendar:
        return Icons.calendar_today;
      case QrCodeType.restaurantMenu:
        return Icons.restaurant_menu;
      case QrCodeType.paymentQr:
        return Icons.payment;
      case QrCodeType.productInfo:
        return Icons.shopping_bag;
      case QrCodeType.businessCard:
        return Icons.business;
      case QrCodeType.multiUrl:
        return Icons.link;
      case QrCodeType.pdfDocument:
        return Icons.picture_as_pdf;
      case QrCodeType.imageGallery:
        return Icons.photo_library;
      case QrCodeType.videoContent:
        return Icons.video_library;
      case QrCodeType.locationMap:
        return Icons.location_on;
      case QrCodeType.cryptoWallet:
        return Icons.currency_bitcoin;
    }
  }

  // Getter cho màu chính
  Color get primaryColor {
    switch (this) {
      case QrCodeType.websiteUrl:
        return Colors.blue;
      case QrCodeType.textPlainText:
        return Colors.grey;
      case QrCodeType.wifiAccess:
        return Colors.green;
      case QrCodeType.phoneNumber:
        return Colors.orange;
      case QrCodeType.emailContact:
        return Colors.red;
      case QrCodeType.vcardContact:
        return Colors.purple;
      case QrCodeType.smsMessage:
        return Colors.pink;
      case QrCodeType.socialMedia:
        return Colors.indigo;
      case QrCodeType.appStoreDownload:
        return Colors.blue;
      case QrCodeType.eventCalendar:
        return Colors.orange;
      case QrCodeType.restaurantMenu:
        return Colors.amber;
      case QrCodeType.paymentQr:
        return Colors.green;
      case QrCodeType.productInfo:
        return Colors.teal;
      case QrCodeType.businessCard:
        return Colors.indigo;
      case QrCodeType.multiUrl:
        return Colors.blue;
      case QrCodeType.pdfDocument:
        return Colors.red;
      case QrCodeType.imageGallery:
        return Colors.purple;
      case QrCodeType.videoContent:
        return Colors.red;
      case QrCodeType.locationMap:
        return Colors.blue;
      case QrCodeType.cryptoWallet:
        return Colors.orange;
    }
  }

  // Getter cho gradient
  LinearGradient get gradient {
    return LinearGradient(
      colors: [
        primaryColor,
        primaryColor.withOpacity(0.8),
      ],
    );
  }

  // Getter cho category
  String get category {
    switch (this) {
      case QrCodeType.websiteUrl:
      case QrCodeType.textPlainText:
      case QrCodeType.wifiAccess:
      case QrCodeType.phoneNumber:
      case QrCodeType.emailContact:
        return 'Cơ bản';
      
      case QrCodeType.vcardContact:
      case QrCodeType.smsMessage:
      case QrCodeType.socialMedia:
      case QrCodeType.appStoreDownload:
      case QrCodeType.eventCalendar:
        return 'Liên lạc & Danh bạ';
      
      case QrCodeType.restaurantMenu:
      case QrCodeType.paymentQr:
      case QrCodeType.productInfo:
      case QrCodeType.businessCard:
      case QrCodeType.multiUrl:
        return 'Doanh nghiệp & Thương mại';
      
      case QrCodeType.pdfDocument:
      case QrCodeType.imageGallery:
      case QrCodeType.videoContent:
      case QrCodeType.locationMap:
      case QrCodeType.cryptoWallet:
        return 'Nội dung & Tài liệu';
    }
  }

  // Getter cho validation rules
  Map<String, dynamic> get validationRules {
    switch (this) {
      case QrCodeType.websiteUrl:
        return {
          'required': ['url'],
          'url': ['url'],
        };
      case QrCodeType.textPlainText:
        return {
          'required': ['text'],
        };
      case QrCodeType.wifiAccess:
        return {
          'required': ['ssid'],
        };
      case QrCodeType.phoneNumber:
        return {
          'required': ['phone'],
        };
      case QrCodeType.emailContact:
        return {
          'required': ['email'],
          'email': ['email'],
        };
      case QrCodeType.vcardContact:
        return {
          'required': ['name'],
        };
      case QrCodeType.smsMessage:
        return {
          'required': ['phone'],
        };
      case QrCodeType.socialMedia:
        return {
          'required': ['platform', 'username'],
        };
      case QrCodeType.appStoreDownload:
        return {
          'required': ['appName', 'appId'],
        };
      case QrCodeType.eventCalendar:
        return {
          'required': ['title'],
        };
      case QrCodeType.restaurantMenu:
        return {
          'required': ['restaurantName'],
        };
      case QrCodeType.paymentQr:
        return {
          'required': ['amount'],
        };
      case QrCodeType.productInfo:
        return {
          'required': ['name'],
        };
      case QrCodeType.businessCard:
        return {
          'required': ['name'],
        };
      case QrCodeType.multiUrl:
        return {
          'required': ['urls'],
        };
      case QrCodeType.pdfDocument:
        return {
          'required': ['url'],
          'url': ['url'],
        };
      case QrCodeType.imageGallery:
        return {
          'required': ['url'],
          'url': ['url'],
        };
      case QrCodeType.videoContent:
        return {
          'required': ['url'],
          'url': ['url'],
        };
      case QrCodeType.locationMap:
        return {
          'required': ['latitude', 'longitude'],
        };
      case QrCodeType.cryptoWallet:
        return {
          'required': ['address'],
        };
    }
  }

  // Getter cho form fields
  List<String> get formFields {
    switch (this) {
      case QrCodeType.websiteUrl:
        return ['url'];
      case QrCodeType.textPlainText:
        return ['text'];
      case QrCodeType.wifiAccess:
        return ['ssid', 'password', 'encryption'];
      case QrCodeType.phoneNumber:
        return ['phone'];
      case QrCodeType.emailContact:
        return ['email', 'subject', 'body'];
      case QrCodeType.vcardContact:
        return ['name', 'phone', 'email', 'company'];
      case QrCodeType.smsMessage:
        return ['phone', 'message'];
      case QrCodeType.socialMedia:
        return ['platform', 'username'];
      case QrCodeType.appStoreDownload:
        return ['appName', 'appId', 'platform'];
      case QrCodeType.eventCalendar:
        return ['title', 'description', 'location', 'startDate', 'endDate'];
      case QrCodeType.restaurantMenu:
        return ['restaurantName', 'menuUrl', 'phone'];
      case QrCodeType.paymentQr:
        return ['amount', 'currency', 'description'];
      case QrCodeType.productInfo:
        return ['name', 'price', 'description', 'url'];
      case QrCodeType.businessCard:
        return ['name', 'title', 'company', 'phone', 'email', 'website', 'address'];
      case QrCodeType.multiUrl:
        return ['urls'];
      case QrCodeType.pdfDocument:
        return ['url', 'title', 'description'];
      case QrCodeType.imageGallery:
        return ['url', 'title', 'description'];
      case QrCodeType.videoContent:
        return ['url', 'title', 'description'];
      case QrCodeType.locationMap:
        return ['latitude', 'longitude', 'label'];
      case QrCodeType.cryptoWallet:
        return ['address', 'amount', 'label'];
    }
  }

  // Static method để lấy tất cả QR types
  static List<QrCodeType> get all => QrCodeType.values;

  // Static method để lấy QR types theo category
  static List<QrCodeType> getByCategory(String category) {
    return all.where((type) => type.category == category).toList();
  }

  // Static method để tìm QR type theo name
  static QrCodeType? fromName(String name) {
    try {
      return QrCodeType.values.firstWhere(
        (type) => type.name == name || type.displayName == name,
      );
    } catch (e) {
      return null;
    }
  }
} 