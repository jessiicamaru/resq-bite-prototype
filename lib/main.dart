import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'data/mock/mock_data.dart';
import 'data/models/food_bag.dart';

// Auth
import 'features/auth/presentation/forgot_password_screen.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/presentation/onboarding_screen.dart';
import 'features/auth/presentation/otp_verification_screen.dart';
import 'features/auth/presentation/register_screen.dart';
import 'features/auth/presentation/splash_screen.dart';

// Catalog
import 'features/catalog/screen_catalog_screen.dart';

// Consumer
import 'features/consumer/category/presentation/category_detail_screen.dart';
import 'features/consumer/home/presentation/search_results_screen.dart';
import 'features/consumer/impact/presentation/green_impact_screen.dart';
import 'features/consumer/map/presentation/map_explorer_screen.dart';
import 'features/consumer/mystery_bag/presentation/mystery_bag_detail_screen.dart';
import 'features/consumer/navigation/consumer_main_nav_screen.dart';
import 'features/consumer/orders/presentation/cart_checkout_screen.dart';
import 'features/consumer/orders/presentation/order_qr_pickup_screen.dart';
import 'features/consumer/orders/presentation/order_review_screen.dart';
import 'features/consumer/orders/presentation/orders_history_screen.dart';
import 'features/consumer/orders/presentation/payment_methods_screen.dart';
import 'features/consumer/orders/presentation/payment_success_screen.dart';
import 'features/consumer/profile/presentation/consumer_profile_screen.dart';
import 'features/consumer/store/presentation/store_detail_screen.dart';
import 'features/consumer/store/presentation/store_reviews_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ResQBitesApp());
}

class ResQBitesApp extends StatelessWidget {
  const ResQBitesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ResQ Bites - Nền tảng điều phối thực phẩm dư thừa',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          // Auth
          case '/splash':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/onboarding':
            return MaterialPageRoute(builder: (_) => const OnboardingScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case '/register':
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          case '/forgot-password':
            return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
          case '/verify-otp':
            final email = (settings.arguments as String?) ?? 'hau@example.com';
            return MaterialPageRoute(builder: (_) => OtpVerificationScreen(email: email));

          // Consumer Main & Home
          case '/home':
            return MaterialPageRoute(builder: (_) => const ConsumerMainNavScreen(initialIndex: 0));
          case '/map-explorer':
            return MaterialPageRoute(builder: (_) => const MapExplorerScreen());
          case '/search-results':
            final q = (settings.arguments as String?) ?? 'bánh';
            return MaterialPageRoute(builder: (_) => SearchResultsScreen(initialQuery: q));
          case '/category-detail':
            final title = (settings.arguments as String?) ?? 'Thơm một góc bánh';
            return MaterialPageRoute(builder: (_) => CategoryDetailScreen(categoryTitle: title));

          // Store & Mystery Bag
          case '/bag-detail':
            final bag = (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            return MaterialPageRoute(builder: (_) => MysteryBagDetailScreen(bag: bag));
          case '/store-detail':
            final bag = (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            return MaterialPageRoute(builder: (_) => StoreDetailScreen(bag: bag));
          case '/store-reviews':
            final bag = (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            return MaterialPageRoute(builder: (_) => StoreReviewsScreen(bag: bag));

          // Orders & Checkout
          case '/cart-checkout':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? mockMysteryBags.first;
            final qty = (args?['quantity'] as int?) ?? 1;
            return MaterialPageRoute(builder: (_) => CartCheckoutScreen(bag: bag, quantity: qty));
          case '/payment-methods':
            return MaterialPageRoute(builder: (_) => const PaymentMethodsScreen());
          case '/payment-success':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? mockMysteryBags.first;
            final qty = (args?['quantity'] as int?) ?? 1;
            final pay = (args?['payment'] as String?) ?? 'Ví MoMo';
            return MaterialPageRoute(builder: (_) => PaymentSuccessScreen(bag: bag, quantity: qty, payment: pay));
          case '/order-qr':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? mockMysteryBags.first;
            final qty = (args?['quantity'] as int?) ?? 1;
            return MaterialPageRoute(builder: (_) => OrderQrPickupScreen(bag: bag, quantity: qty));
          case '/orders-history':
            return MaterialPageRoute(builder: (_) => const OrdersHistoryScreen());
          case '/order-review':
            final bag = (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            return MaterialPageRoute(builder: (_) => OrderReviewScreen(bag: bag));

          // Impact & Profile
          case '/green-impact':
            return MaterialPageRoute(builder: (_) => const GreenImpactScreen());
          case '/consumer-profile':
            return MaterialPageRoute(builder: (_) => const ConsumerProfileScreen());

          // Catalog
          case '/catalog':
            return MaterialPageRoute(builder: (_) => const ScreenCatalogScreen());

          default:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
      },
    );
  }
}
