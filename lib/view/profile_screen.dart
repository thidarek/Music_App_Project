import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // ---------------------------------------------------------------------
  // MOCK DATA — replace with real data via a ProfileProvider.
  // ---------------------------------------------------------------------

  // PROVIDER: context.watch<ProfileProvider>().name
  static const String _userName = 'Alex Rivers';
  // PROVIDER: context.watch<ProfileProvider>().email
  static const String _userEmail = 'alex.rivers@melody.hi-fi';
  // PROVIDER: context.watch<ProfileProvider>().isPremium
  static const bool _isPremium = true;

  // PROVIDER: these four could come from ProfileProvider (or be derived
  // from PlaylistProvider/FavoriteProvider counts instead of stored here).
  static const String _hoursListened = '1,284';
  static const String _favoriteGenre = 'Electronic';
  static const String _playlistCount = '42';
  static const String _followingCount = '842';

  // PROVIDER: context.watch<ProfileProvider>().subscriptionExpiry
  static const String _premiumExpiry = 'Oct 2025';
  // PROVIDER: context.watch<ProfileProvider>().audioQuality
  static const String _audioQuality = 'High-Fidelity';

  static const Color _background = Color(0xFF0D1220);
  static const Color _cardSurface = Color(0xFF1A2033);
  static const Color _accentPurple = Color(0xFF8B7FE8);
  static const Color _accentPink = Color(0xFFE85DB0);
  static const Color _accentCoral = Color(0xFFE8846A);
  static const Color _textPrimary = Colors.white;
  static const Color _textSecondary = Color(0xFF9CA3B5);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _background,
      child: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            _buildHeader(context),
            const SizedBox(height: 24),
            _buildAvatarSection(context),
            const SizedBox(height: 20),
            _buildStatsGrid(),
            const SizedBox(height: 20),
            _buildPremiumCard(context),
            const SizedBox(height: 24),
            _buildAccountSettingsLabel(),
            const SizedBox(height: 12),
            _buildSettingsRow(
              context,
              icon: Icons.person_outline,
              label: 'Personal Information',
              onTap: () => _onPersonalInfoTap(context),
            ),
            _buildSettingsRow(
              context,
              icon: Icons.description_outlined,
              label: 'Audio Quality',
              trailingText: _audioQuality,
              onTap: () => _onAudioQualityTap(context),
            ),
            _buildSettingsRow(
              context,
              icon: Icons.history,
              label: 'Listening History',
              onTap: () => _onListeningHistoryTap(context),
            ),
            _buildSettingsRow(
              context,
              icon: Icons.logout,
              label: 'Log Out',
              labelColor: _accentCoral,
              iconColor: _accentCoral,
              showChevron: false,
              onTap: () => _onLogOutTap(context),
            ),
          ],
        ),
      ),
    );
  }

  /// Top row: small avatar, "Profile" title, notification bell, settings gear.
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // PROVIDER: swap for NetworkImage(profile.avatarUrl) once real
        // user photos are available.
        const CircleAvatar(
          radius: 18,
          backgroundColor: _cardSurface,
          child: Icon(Icons.person, color: _textSecondary, size: 18),
        ),
        const SizedBox(width: 10),
        const Text(
          'Profile',
          style: TextStyle(
            color: _textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        // Notification bell — tappable.
        _buildIconButton(
          icon: Icons.notifications_none,
          onTap: () => _onNotificationsTap(context),
        ),
        const SizedBox(width: 8),
        // Settings gear — tappable, opens app-wide settings.
        _buildIconButton(
          icon: Icons.settings_outlined,
          onTap: () => _onSettingsTap(context),
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    // Wrapped in an explicit transparent Material so the ripple always
    // shows, regardless of what ancestor widget this ends up nested in.
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, color: _accentPurple, size: 22),
        ),
      ),
    );
  }

  /// Large centered avatar with a pink ring, tappable to change photo,
  /// plus name, email, and a premium badge overlapping the bottom edge.
  Widget _buildAvatarSection(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            borderRadius: BorderRadius.circular(60),
            // Tapping the avatar itself opens photo change flow.
            onTap: () => _onAvatarTap(context),
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: _accentPink, width: 3),
                    ),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: _cardSurface,
                    // PROVIDER: swap for NetworkImage(profile.avatarUrl).
                    child: Icon(Icons.person, color: _textSecondary, size: 48),
                  ),
                ),
                // Premium badge, overlapping the bottom of the avatar ring.
                if (_isPremium)
                  Positioned(
                    bottom: -12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: _accentPurple,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 12),
                          SizedBox(width: 4),
                          Text(
                            'PREMIUM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          _userName,
          style: TextStyle(
            color: _textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          _userEmail,
          style: TextStyle(color: _textSecondary, fontSize: 13),
        ),
      ],
    );
  }

  /// 2x2 grid of stat cards: hours listened, favorite genre, playlists,
  /// following count.
  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                value: _hoursListened,
                label: 'HOURS\nLISTENED',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                value: _favoriteGenre,
                label: 'FAV GENRE',
                valueColor: _accentCoral,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(value: _playlistCount, label: 'PLAYLISTS'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                value: _followingCount,
                label: 'FOLLOWING',
                valueColor: _accentCoral,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    Color valueColor = _textPrimary,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      decoration: BoxDecoration(
        color: _cardSurface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: _textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  /// Gradient "Premium Membership" card with a "MANAGE PLAN" button.
  Widget _buildPremiumCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [_accentPurple, _accentPink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.star, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                'Premium Membership',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // PROVIDER: build this string from profile.subscriptionExpiry
          // once real subscription data exists.
          Text(
            'Your subscription is active until $_premiumExpiry. '
            'Enjoy Hi-Fi audio and unlimited offline downloads.',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // "MANAGE PLAN" button, tappable.
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => _onManagePlanTap(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Text(
                'MANAGE PLAN',
                style: TextStyle(
                  color: _accentPurple,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettingsLabel() {
    return const Text(
      'ACCOUNT SETTINGS',
      style: TextStyle(
        color: _textSecondary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }

  /// One tappable settings row: leading icon in a rounded square, label,
  /// optional trailing value text, and an optional chevron.
  Widget _buildSettingsRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    String? trailingText,
    Color labelColor = _textPrimary,
    Color iconColor = _accentPurple,
    bool showChevron = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: _cardSurface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
                const SizedBox(width: 14),
                Text(
                  label,
                  style: TextStyle(
                    color: labelColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (trailingText != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    trailingText,
                    style: const TextStyle(color: _accentPurple, fontSize: 13),
                  ),
                ],
                const Spacer(),
                if (showChevron)
                  const Icon(
                    Icons.chevron_right,
                    color: _textSecondary,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------
  // TAP HANDLERS — replace each body with real navigation once the
  // destination screens exist. Left as clear TODOs so the UI is fully
  // interactive (ripple + callback) without depending on unbuilt screens.
  // ---------------------------------------------------------------------

  void _onNotificationsTap(BuildContext context) {
    // TODO: Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
    // Temporary visible feedback so the tap is confirmable before
    // NotificationsScreen exists — remove once real navigation is wired.
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Notifications tapped')));
  }

  void _onSettingsTap(BuildContext context) {
    // TODO: Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Settings tapped')));
  }

  void _onAvatarTap(BuildContext context) {
    // TODO: open image picker / photo change flow, then update via
    // context.read<ProfileProvider>().updateAvatar(newImage).
  }

  void _onManagePlanTap(BuildContext context) {
    // TODO: Navigator.push(context, MaterialPageRoute(builder: (_) => const ManagePlanScreen()));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Manage plan tapped')));
  }

  void _onPersonalInfoTap(BuildContext context) {
    // TODO: Navigator.push(context, MaterialPageRoute(builder: (_) => const PersonalInfoScreen()));
  }

  void _onAudioQualityTap(BuildContext context) {
    // TODO: show a selection sheet/dialog for audio quality, then call
    // context.read<ProfileProvider>().setAudioQuality(selected).
  }

  void _onListeningHistoryTap(BuildContext context) {
    // TODO: Navigator.push(context, MaterialPageRoute(builder: (_) => const ListeningHistoryScreen()));
  }

  void _onLogOutTap(BuildContext context) {
    // TODO: show a confirmation dialog, then call an auth provider's
    // logOut() method and navigate back to the login/register screen.
  }
}
