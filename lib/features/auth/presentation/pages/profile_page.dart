// profile_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/core/constants/app_colors.dart';
import 'package:order_now/features/auth/presentation/pages/edit_profile_page.dart';
import 'package:order_now/features/auth/presentation/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const _menuSections = [
    {
      'title': 'Account',
      'items': [
        {
          'icon': CupertinoIcons.person,
          'label': 'Edit Profile',
          'trailing': null,
        },
        {
          'icon': CupertinoIcons.location,
          'label': 'Saved Addresses',
          'trailing': null,
        },
        {
          'icon': CupertinoIcons.creditcard,
          'label': 'Payment Methods',
          'trailing': null,
        },
      ],
    },
    {
      'title': 'Preferences',
      'items': [
        {
          'icon': CupertinoIcons.bell,
          'label': 'Notifications',
          'trailing': true,
        },
        {
          'icon': CupertinoIcons.globe,
          'label': 'Language',
          'trailing': 'English',
        },
      ],
    },
    {
      'title': 'Support',
      'items': [
        {
          'icon': CupertinoIcons.question_circle,
          'label': 'Help Center',
          'trailing': null,
        },
        {
          'icon': CupertinoIcons.star,
          'label': 'Rate the App',
          'trailing': null,
        },
        {
          'icon': CupertinoIcons.doc_text,
          'label': 'Terms & Privacy',
          'trailing': null,
        },
      ],
    },
  ];

  static const _stats = [
    {'value': '12', 'label': 'Orders'},
    {'value': '5', 'label': 'Favorites'},
    {'value': '4.8', 'label': 'Avg Rating'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ──────────────────────────────────
          SliverToBoxAdapter(child: _buildHeader(context)),

          // ── Stats ───────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: _StatsRow(stats: _stats),
            ),
          ),

          // ── Menu Sections ───────────────────────────
          for (final section in _menuSections)
            SliverToBoxAdapter(
              child: _MenuSection(
                title: section['title'] as String,
                items: section['items'] as List<Map<String, dynamic>>,
              ),
            ),

          // ── Logout ──────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
              child: _LogoutButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 24,
        left: 16,
        right: 16,
      ),
      child: Column(
        children: [
          // Avatar
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: AppColors.primary.withValues(alpha: .12),
                child: Icon(
                  CupertinoIcons.person_fill,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  CupertinoIcons.camera_fill,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Name
          const Text(
            'Muhammed Amin',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),

          // Email
          Text(
            'muhammed.amin@email.com',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 12),

          // Member badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.star_fill,
                  size: 12,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 5),
                Text(
                  'Gold Member',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stats Row ──────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  final List<Map<String, String>> stats;
  const _StatsRow({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: stats.asMap().entries.map((entry) {
          final isLast = entry.key == stats.length - 1;
          return Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  right: isLast
                      ? BorderSide.none
                      : BorderSide(color: Colors.grey.shade100, width: 1),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    entry.value['value']!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.value['label']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Menu Section ───────────────────────────────────────

class _MenuSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  const _MenuSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isLast = index == items.length - 1;
                return _MenuItem(
                  icon: item['icon'] as IconData,
                  label: item['label'] as String,
                  trailing: item['trailing'],
                  showDivider: !isLast,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Menu Item ──────────────────────────────────────────

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final dynamic trailing; // null | bool (toggle) | String (value)
  final bool showDivider;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.trailing,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (label == 'Edit Profile') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 18, color: AppColors.primary),
                ),
                const SizedBox(width: 14),

                // Label
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),

                // Trailing
                if (trailing == null)
                  Icon(
                    CupertinoIcons.chevron_right,
                    size: 16,
                    color: Colors.grey.shade400,
                  )
                else if (trailing is bool)
                  _MiniToggle()
                else if (trailing is String)
                  Row(
                    children: [
                      Text(
                        trailing as String,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        CupertinoIcons.chevron_right,
                        size: 16,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 66,
            endIndent: 16,
            color: Colors.grey.shade100,
          ),
      ],
    );
  }
}

// ── Mini Toggle (notifications) ────────────────────────

class _MiniToggle extends StatefulWidget {
  @override
  State<_MiniToggle> createState() => _MiniToggleState();
}

class _MiniToggleState extends State<_MiniToggle> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: _value,
        onChanged: (v) => setState(() => _value = v),
        activeThumbColor: AppColors.primary,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

// ── Logout Button ──────────────────────────────────────

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (e) => LoginPage()),
        );
      },
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.square_arrow_left,
              color: Colors.red.shade400,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Log Out',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
