import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../../constants/constants.dart';

class QrItemCard extends StatelessWidget {
  final Map<String, dynamic> qrData;
  final bool isDynamic;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleFavorite;
  final VoidCallback onShare;
  final VoidCallback? onViewStats;

  const QrItemCard({
    super.key,
    required this.qrData,
    required this.isDynamic,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleFavorite,
    required this.onShare,
    this.onViewStats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: context.styles.cardDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingSmall),
                      decoration: BoxDecoration(
                        color: _getQrTypeColor(qrData['type']).withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusSmall),
                      ),
                      child: Icon(
                        _getQrTypeIcon(qrData['type']),
                        color: _getQrTypeColor(qrData['type']),
                        size: AppSizes.iconSmall,
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingMedium),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            qrData['title'] ?? 'Untitled',
                            style: context.styles.titleMedium.copyWith(
                              color: context.colors.text,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            qrData['type'] ?? 'Unknown',
                            style: context.styles.bodySmall.copyWith(
                              color: context.colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onToggleFavorite,
                      icon: Icon(
                        qrData['isFavorite'] == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: qrData['isFavorite'] == true
                            ? context.colors.error
                            : context.colors.textSecondary,
                        size: AppSizes.iconSmall,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSizes.paddingMedium),

                // Content
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.paddingMedium),
                  decoration: BoxDecoration(
                    color: context.colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                  child: Text(
                    qrData['content'] ?? '',
                    style: context.styles.bodyMedium.copyWith(
                      color: context.colors.text,
                      fontFamily: 'monospace',
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: AppSizes.paddingMedium),

                // Footer
                Row(
                  children: [
                    // Date
                    Icon(
                      Icons.access_time,
                      size: AppSizes.iconTiny,
                      color: context.colors.textSecondary,
                    ),
                    const SizedBox(width: AppSizes.paddingTiny),
                    Text(
                      _formatDate(qrData['createdAt']),
                      style: context.styles.bodySmall.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),

                    const Spacer(),

                    // Dynamic QR Stats
                    if (isDynamic && qrData['scans'] != null) ...[
                      Icon(
                        Icons.trending_up,
                        size: AppSizes.iconTiny,
                        color: context.colors.success,
                      ),
                      const SizedBox(width: AppSizes.paddingTiny),
                      Text(
                        '${qrData['scans']} lượt quét',
                        style: context.styles.bodySmall.copyWith(
                          color: context.colors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: AppSizes.paddingMedium),
                    ],

                    // Action Buttons
                    if (isDynamic && onViewStats != null)
                      IconButton(
                        onPressed: onViewStats!,
                        icon: Icon(
                          Icons.analytics,
                          color: context.colors.primary,
                          size: AppSizes.iconSmall,
                        ),
                      ),
                    IconButton(
                      onPressed: onShare,
                      icon: Icon(
                        Icons.share,
                        color: context.colors.secondary,
                        size: AppSizes.iconSmall,
                      ),
                    ),
                    IconButton(
                      onPressed: onEdit,
                      icon: Icon(
                        Icons.edit,
                        color: context.colors.accent,
                        size: AppSizes.iconSmall,
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: Icon(
                        Icons.delete,
                        color: context.colors.error,
                        size: AppSizes.iconSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getQrTypeIcon(String? type) {
    switch (type) {
      case 'URL':
        return Icons.link;
      case 'Text':
        return Icons.text_fields;
      case 'WiFi':
        return Icons.wifi;
      case 'Email':
        return Icons.email;
      case 'Phone':
        return Icons.phone;
      case 'SMS':
        return Icons.sms;
      case 'VCard':
        return Icons.contact_phone;
      case 'GeoLocation':
        return Icons.location_on;
      case 'Calendar':
        return Icons.calendar_today;
      case 'Social Media':
        return Icons.share;
      case 'Payment':
        return Icons.payment;
      case 'App Store':
        return Icons.shop;
      case 'Dynamic':
        return Icons.qr_code_scanner;
      default:
        return Icons.qr_code;
    }
  }

  Color _getQrTypeColor(String? type) {
    switch (type) {
      case 'URL':
        return Colors.blue;
      case 'Text':
        return Colors.green;
      case 'WiFi':
        return Colors.orange;
      case 'Email':
        return Colors.purple;
      case 'Phone':
        return Colors.red;
      case 'SMS':
        return Colors.pink;
      case 'VCard':
        return Colors.indigo;
      case 'GeoLocation':
        return Colors.teal;
      case 'Calendar':
        return Colors.amber;
      case 'Social Media':
        return Colors.cyan;
      case 'Payment':
        return Colors.lime;
      case 'App Store':
        return Colors.deepOrange;
      case 'Dynamic':
        return Colors.deepPurple;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Unknown';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} ngày trước';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} giờ trước';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} phút trước';
    } else {
      return 'Vừa xong';
    }
  }
}
