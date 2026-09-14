import 'package:go_router/go_router.dart';
import 'package:physioghar/core/router/app_routes.dart';
import 'package:physioghar/features/auth/presentation/screens/login_screen.dart';
import 'package:physioghar/features/auth/presentation/screens/register_screen.dart';
import 'package:physioghar/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:physioghar/features/dashboard/presentation/screens/bookings_screen.dart';
import 'package:physioghar/features/home/presentation/screens/home_screen.dart';
import 'package:physioghar/features/profile/presentation/screens/profile_screen.dart';
import 'package:physioghar/features/profile/presentation/screens/profile_details_screen.dart';
import 'package:physioghar/features/profile/presentation/screens/complaint_screen.dart';
import 'package:physioghar/features/profile/presentation/screens/profile_info_screen.dart';
import 'package:physioghar/features/profile/presentation/screens/profile_settings_screen.dart';
import 'package:physioghar/features/schedule/presentation/screens/schedule_screen.dart';
import 'package:physioghar/features/splash/splash.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.main,
      redirect: (context, state) => AppRoutes.dashboard,
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeScreen(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.dashboard,
              builder: (context, state) => const DashboardView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.schedule,
              builder: (context, state) => const ScheduleScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.bookings,
              builder: (context, state) => const BookingsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfileSettingsScreen(),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const ProfileDetailsScreen(),
                ),
                GoRoute(
                  path: 'edit',
                  builder: (context, state) => const ProfileScreen(),
                ),
                GoRoute(
                  path: 'complaints',
                  builder: (context, state) => const ComplaintScreen(),
                ),
                GoRoute(
                  path: 'privacy-policy',
                  builder: (context, state) => const ProfileInfoScreen(
                    title: 'Privacy policy',
                    body:
                        'Your professional information is used to help manage your PhysioGhar account and sessions. More detailed policy content can be added here.',
                  ),
                ),
                GoRoute(
                  path: 'terms',
                  builder: (context, state) => const ProfileInfoScreen(
                    title: 'Terms & conditions',
                    body:
                        'By using PhysioGhar, you agree to provide accurate professional information and use the platform responsibly. Full terms can be added here.',
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
