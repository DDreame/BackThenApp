import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/onboarding/welcome_page.dart';
import '../../features/onboarding/onboarding_page.dart';
import '../../features/timeline/timeline_page.dart';
import '../../features/feeling_detail/feeling_detail_page.dart';
import '../../features/retrospect/retrospect_page.dart';
import '../../features/profile/profile_page.dart';
import '../../shared/widgets/main_shell.dart';

/// SharedPreferences key for onboarding completion status
const String kOnboardingCompletedKey = 'onboarding_completed';

/// Navigator keys
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Provider for the GoRouter instance
final routerProvider = FutureProvider<GoRouter>((ref) async {
  return createRouter();
});

/// Creates the GoRouter instance with first-launch detection
Future<GoRouter> createRouter() async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool(kOnboardingCompletedKey) ?? true;

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: isFirstLaunch ? '/welcome' : '/timeline',
    redirect: (context, state) {
      if (state.matchedLocation == '/') {
        return isFirstLaunch ? '/welcome' : '/timeline';
      }
      return null;
    },
    routes: [
      // Full-screen routes (no TabBar)
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/onboarding/record',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/feeling/:id',
        builder: (context, state) {
          final feelingId = state.pathParameters['id']!;
          return FeelingDetailPage(feelingId: feelingId);
        },
      ),

      // Shell Route with TabBar
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/timeline',
            builder: (context, state) => const TimelinePage(),
          ),
          GoRoute(
            path: '/retrospect',
            builder: (context, state) => const RetrospectPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}

/// Mark onboarding as completed
Future<void> completeOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(kOnboardingCompletedKey, true);
}
