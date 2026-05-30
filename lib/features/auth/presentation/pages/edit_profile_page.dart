// edit_profile_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:order_now/core/constants/app_colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController    = TextEditingController(text: 'Muhammed Amin');
  final _emailController   = TextEditingController(text: 'muhammed.amin@email.com');
  final _phoneController   = TextEditingController(text: '+20 101 234 5678');
  final _dobController     = TextEditingController(text: '12 / 03 / 2001');
  final _addressController = TextEditingController(text: '14 Tahrir Square, Cairo');

  int _selectedGender = 0; // 0 = Male, 1 = Female
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isSaving = false);
    _showSavedSnackbar();
  }

  void _showSavedSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        content: const Row(
          children: [
            Icon(CupertinoIcons.checkmark_circle_fill,
                color: Colors.white, size: 18),
            SizedBox(width: 10),
            Text(
              'Profile updated successfully',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F7F7),
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── App Bar ─────────────────────────────
              _buildAppBar(context),

              // ── Avatar ──────────────────────────────
              SliverToBoxAdapter(child: _AvatarSection()),

              // ── Personal Info ────────────────────────
              _buildSection(
                title: 'Personal Information',
                child: Column(
                  children: [
                    _ProfileField(
                      controller: _nameController,
                      label: 'Full Name',
                      icon: CupertinoIcons.person,
                      keyboardType: TextInputType.name,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Name is required'
                          : null,
                    ),
                    _Divider(),
                    _ProfileField(
                      controller: _emailController,
                      label: 'Email Address',
                      icon: CupertinoIcons.mail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Email is required';
                        }
                        if (!v.contains('@')) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    _Divider(),
                    _ProfileField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      icon: CupertinoIcons.phone,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[\d\s\+\-]')),
                      ],
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Phone is required'
                          : null,
                    ),
                    _Divider(),
                    _DateField(controller: _dobController),
                  ],
                ),
              ),

              // ── Gender ──────────────────────────────
              _buildSection(
                title: 'Gender',
                child: _GenderSelector(
                  selected: _selectedGender,
                  onSelect: (i) => setState(() => _selectedGender = i),
                ),
              ),

              // ── Address ─────────────────────────────
              _buildSection(
                title: 'Default Delivery Address',
                child: _ProfileField(
                  controller: _addressController,
                  label: 'Address',
                  icon: CupertinoIcons.location,
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 2,
                ),
              ),

              // ── Danger Zone ──────────────────────────
              _buildSection(
                title: 'Account',
                child: Column(
                  children: [
                    _ActionRow(
                      icon: CupertinoIcons.lock,
                      label: 'Change Password',
                      onTap: () {},
                    ),
                    _Divider(),
                    _ActionRow(
                      icon: CupertinoIcons.trash,
                      label: 'Delete Account',
                      onTap: () => _showDeleteConfirm(context),
                      isDestructive: true,
                    ),
                  ],
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 110)),
            ],
          ),
        ),

        // ── Save Button ──────────────────────────────
        bottomNavigationBar: _SaveBar(
          isSaving: _isSaving,
          onSave: _save,
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAppBar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          bottom: 14,
          left: 8,
          right: 16,
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.arrow_left, size: 20),
              color: Colors.black87,
            ),
            const Expanded(
              child: Text(
                'Edit Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            // Balances the back button
            const SizedBox(width: 44),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSection({
    required String title,
    required Widget child,
  }) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
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
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'This action is irreversible. All your data will be permanently deleted.',
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () => Navigator.pop(context),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// ── Avatar Section ─────────────────────────────────────

class _AvatarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: .1),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  width: 2,
                ),
              ),
              child: Icon(
                CupertinoIcons.person_fill,
                size: 50,
                color: AppColors.primary,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                ),
                child: const Icon(
                  CupertinoIcons.camera_fill,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Profile Field ──────────────────────────────────────

class _ProfileField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;

  const _ProfileField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade500,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 36, minHeight: 36),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          errorStyle: TextStyle(
            fontSize: 11,
            color: AppColors.error,
          ),
          isDense: false,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}

// ── Date Field (with picker) ───────────────────────────

class _DateField extends StatelessWidget {
  final TextEditingController controller;
  const _DateField({required this.controller});

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2001, 3, 12),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      controller.text =
          '${picked.day.toString().padLeft(2, '0')} / '
          '${picked.month.toString().padLeft(2, '0')} / '
          '${picked.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () => _pickDate(context),
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              labelText: 'Date of Birth',
              labelStyle: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(CupertinoIcons.calendar,
                    size: 18, color: AppColors.primary),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 36, minHeight: 36),
              suffixIcon: Icon(CupertinoIcons.chevron_down,
                  size: 14, color: Colors.grey.shade400),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              isDense: false,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Gender Selector ────────────────────────────────────

class _GenderSelector extends StatelessWidget {
  final int selected;
  final void Function(int) onSelect;

  const _GenderSelector({
    required this.selected,
    required this.onSelect,
  });

  static const _options = [
    {'label': 'Male',   'icon': CupertinoIcons.person},
    {'label': 'Female', 'icon': CupertinoIcons.person_crop_circle},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: _options.asMap().entries.map((e) {
          final index = e.key;
          final isSelected = selected == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(right: index == 0 ? 10 : 0),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      e.value['icon'] as IconData,
                      size: 18,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      e.value['label'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Action Row (Change Password / Delete Account) ──────

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : Colors.black87;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isDestructive
                    ? AppColors.error.withValues(alpha: 0.08)
                    : AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 17, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared thin divider ────────────────────────────────

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 44,
      color: Colors.grey.shade100,
    );
  }
}

// ── Save Bar ───────────────────────────────────────────

class _SaveBar extends StatelessWidget {
  final bool isSaving;
  final VoidCallback onSave;

  const _SaveBar({required this.isSaving, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 14, 16, MediaQuery.of(context).padding.bottom + 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: isSaving ? null : onSave,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 54,
          decoration: BoxDecoration(
            color: isSaving
                ? AppColors.primary.withValues(alpha: 0.7)
                : AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: isSaving
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.checkmark_alt,
                          color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Save Changes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}