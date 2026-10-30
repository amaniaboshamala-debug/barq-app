import 'package:flutter/material.dart';

class ProjectInfo {
  final String slug, name;
  final String? tagline, logoUrl, supportPhone;
  final Map<String, String> colors;

  ProjectInfo({
    required this.slug,
    required this.name,
    this.tagline,
    this.logoUrl,
    this.supportPhone,
    required this.colors,
  });

  factory ProjectInfo.fromJson(Map<String, dynamic> j) => ProjectInfo(
    slug: j['slug'] ?? '',
    name: j['name'] ?? '',
    tagline: j['tagline'],
    logoUrl: j['logo_url'],
    supportPhone: j['support_phone'],
    colors: (j['colors'] as Map? ?? {})
        .map((k, v) => MapEntry(k.toString(), v.toString())),
  );

  /// يحوّل "#RRGGBB" إلى Color، وإذا المفتاح مش موجود بيرجع fallback
  Color color(String key, Color fallback) {
    final hex = colors[key];
    if (hex == null) return fallback;
    final h = hex.replaceAll('#', '');
    final v = int.tryParse(h.length == 6 ? 'FF$h' : h, radix: 16);
    return v == null ? fallback : Color(v);
  }
}

class AppConfig {
  final ProjectInfo project;
  final String locale;
  final String? minAppVersion, termsUrl;
  final int configVersion;
  final List<String> paymentMethods;
  final Map<String, dynamic> raw; // باقي الحقول: statuses, zones, polling...

  AppConfig({
    required this.project,
    required this.locale,
    required this.minAppVersion,
    required this.termsUrl,
    required this.configVersion,
    required this.paymentMethods,
    required this.raw,
  });

  factory AppConfig.fromJson(Map<String, dynamic> j) => AppConfig(
    project: ProjectInfo.fromJson(Map<String, dynamic>.from(j['project'])),
    locale: j['locale'] ?? 'ar',
    minAppVersion: j['min_app_version'],
    termsUrl: j['terms_url'],
    configVersion: j['config_version'] ?? 0,
    paymentMethods:
    (j['payment_methods'] as List? ?? []).map((e) => e.toString()).toList(),
    raw: j,
  );
}