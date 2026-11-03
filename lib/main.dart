import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'data/mock/mock_data.dart';
import 'data/models/food_bag.dart';
import 'data/models/merchant_order.dart';

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
import 'features/consumer/mystery_bag/presentation/mystery_bag_detail_screen.dart';
import 'features/consumer/mystery_bag/presentation/sold_out_bag_screen.dart';
import 'features/consumer/navigation/consumer_main_nav_screen.dart';
import 'features/consumer/orders/presentation/allergy_check_screen.dart';
import 'features/consumer/orders/presentation/cancel_order_screen.dart';
import 'features/consumer/orders/presentation/cart_checkout_screen.dart';
import 'features/consumer/orders/presentation/confirm_order_screen.dart';
import 'features/consumer/orders/presentation/delivery_mode_screen.dart';
import 'features/consumer/orders/presentation/order_notes_screen.dart';
import 'features/consumer/orders/presentation/order_qr_pickup_screen.dart';
import 'features/consumer/orders/presentation/order_receipt_screen.dart';
import 'features/consumer/orders/presentation/order_review_screen.dart';
import 'features/consumer/orders/presentation/payment_failed_screen.dart';
import 'features/consumer/orders/presentation/payment_methods_screen.dart';
import 'features/consumer/orders/presentation/payment_pending_screen.dart';
import 'features/consumer/orders/presentation/payment_success_screen.dart';
import 'features/consumer/profile/presentation/green_collection_screen.dart';
import 'features/consumer/profile/presentation/help_center_screen.dart';
import 'features/consumer/profile/presentation/notifications_screen.dart';
import 'features/consumer/profile/presentation/personal_info_screen.dart';
import 'features/consumer/profile/presentation/saved_addresses_screen.dart';
import 'features/consumer/profile/presentation/support_request_screen.dart';
import 'features/consumer/profile/presentation/support_success_screen.dart';
import 'features/consumer/profile/presentation/wallet_methods_screen.dart';
import 'features/consumer/orders/presentation/cancel_requested_screen.dart';
import 'features/consumer/store/presentation/store_detail_screen.dart';
import 'features/consumer/store/presentation/store_reviews_screen.dart';

// Merchant
import 'features/merchant/auth/presentation/merchant_onboarding_screen.dart';
import 'features/merchant/auth/presentation/merchant_register_screen.dart';
import 'features/merchant/auth/presentation/merchant_verification_screen.dart';
import 'features/merchant/bags/presentation/merchant_bag_ingredients_screen.dart';
import 'features/merchant/bags/presentation/merchant_bag_list_screen.dart';
import 'features/merchant/bags/presentation/merchant_bag_price_screen.dart';
import 'features/merchant/bags/presentation/merchant_bag_quantity_screen.dart';
import 'features/merchant/bags/presentation/merchant_create_bag_screen.dart';
import 'features/merchant/bags/presentation/merchant_pickup_window_screen.dart';
import 'features/merchant/dashboard/presentation/merchant_activities_screen.dart';
import 'features/merchant/dashboard/presentation/merchant_closing_shift_screen.dart';
import 'features/merchant/dashboard/presentation/merchant_dashboard_screen.dart';
import 'features/merchant/dashboard/presentation/merchant_tasks_screen.dart';
import 'features/merchant/navigation/merchant_main_nav_screen.dart';
import 'features/merchant/orders/presentation/merchant_orders_pending_screen.dart';
import 'features/merchant/reports/presentation/merchant_food_waste_report_screen.dart';
import 'features/merchant/reports/presentation/merchant_revenue_report_screen.dart';
import 'features/merchant/scanner/presentation/merchant_qr_scanner_screen.dart';
import 'features/merchant/scanner/presentation/merchant_qr_valid_screen.dart';
import 'features/merchant/settings/presentation/merchant_bank_settings_screen.dart';
import 'features/merchant/settings/presentation/merchant_staff_settings_screen.dart';
import 'features/merchant/settings/presentation/merchant_store_settings_screen.dart';

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
          // --- AUTH ---
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

          // --- CONSUMER FLOW ---
          case '/home':
            return MaterialPageRoute(builder: (_) => const ConsumerMainNavScreen(initialIndex: 0));
          case '/map-explorer':
            return MaterialPageRoute(builder: (_) => const ConsumerMainNavScreen(initialIndex: 1));
          case '/search-results':
            final q = (settings.arguments as String?) ?? 'bánh';
            return MaterialPageRoute(builder: (_) => SearchResultsScreen(initialQuery: q));
          case '/category-detail':
            final title = (settings.arguments as String?) ?? 'Thơm một góc bánh';
            return MaterialPageRoute(builder: (_) => CategoryDetailScreen(categoryTitle: title));
          case '/bag-detail':
            final bag = (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            return MaterialPageRoute(builder: (_) => MysteryBagDetailScreen(bag: bag));
          case '/sold-out-bag':
            final bag = (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            return MaterialPageRoute(builder: (_) => SoldOutBagScreen(bag: bag));
          case '/store-detail':
            final bag = (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            return MaterialPageRoute(builder: (_) => StoreDetailScreen(bag: bag));
          case '/store-reviews':
            final bag = (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            return MaterialPageRoute(builder: (_) => StoreReviewsScreen(bag: bag));
          case '/allergy-check':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            return MaterialPageRoute(builder: (_) => AllergyCheckScreen(bag: bag));
          case '/order-notes':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            final qty = (args?['quantity'] as int?) ?? 1;
            return MaterialPageRoute(builder: (_) => OrderNotesScreen(bag: bag, initialQuantity: qty));
          case '/delivery-mode':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            final qty = (args?['quantity'] as int?) ?? 1;
            final notes = args?['notes'] as String?;
            final bringOwnBag = (args?['bringOwnBag'] as bool?) ?? true;
            return MaterialPageRoute(
              builder: (_) => DeliveryModeScreen(bag: bag, quantity: qty, notes: notes, bringOwnBag: bringOwnBag),
            );
          case '/cart-checkout':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            final qty = (args?['quantity'] as int?) ?? 1;
            final notes = args?['notes'] as String?;
            final bringOwnBag = (args?['bringOwnBag'] as bool?) ?? true;
            final isDelivery = (args?['isDelivery'] as bool?) ?? false;
            return MaterialPageRoute(
              builder: (_) => CartCheckoutScreen(
                bag: bag,
                quantity: qty,
                notes: notes,
                bringOwnBag: bringOwnBag,
                isDelivery: isDelivery,
              ),
            );
          case '/payment-methods':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? mockMysteryBags.first;
            final qty = (args?['quantity'] as int?) ?? 1;
            final cur = (args?['payment'] as String?) ?? 'MoMo';
            return MaterialPageRoute(
              builder: (_) => PaymentMethodsScreen(bag: bag, quantity: qty, currentMethod: cur),
            );
          case '/confirm-order':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? mockMysteryBags.first;
            final qty = (args?['quantity'] as int?) ?? 1;
            final payment = (args?['payment'] as String?) ?? 'MoMo';
            return MaterialPageRoute(
              builder: (_) => ConfirmOrderScreen(bag: bag, quantity: qty, payment: payment),
            );
          case '/payment-pending':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? mockMysteryBags.first;
            final qty = (args?['quantity'] as int?) ?? 1;
            final payment = (args?['payment'] as String?) ?? 'MoMo';
            return MaterialPageRoute(
              builder: (_) => PaymentPendingScreen(bag: bag, quantity: qty, payment: payment),
            );
          case '/payment-failed':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? mockMysteryBags.first;
            final qty = (args?['quantity'] as int?) ?? 1;
            return MaterialPageRoute(
              builder: (_) => PaymentFailedScreen(bag: bag, quantity: qty),
            );
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
          case '/order-receipt':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? mockMysteryBags.first;
            final qty = (args?['quantity'] as int?) ?? 1;
            final code = (args?['orderCode'] as String?) ?? 'RB-1024';
            return MaterialPageRoute(builder: (_) => OrderReceiptScreen(bag: bag, quantity: qty, orderCode: code));
          case '/orders-history':
            return MaterialPageRoute(builder: (_) => const ConsumerMainNavScreen(initialIndex: 2));
          case '/cancel-order':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? mockMysteryBags.first;
            final code = (args?['orderCode'] as String?) ?? 'RB-1024';
            return MaterialPageRoute(builder: (_) => CancelOrderScreen(bag: bag, orderCode: code));
          case '/cancel-requested':
            final args = settings.arguments as Map<String, dynamic>?;
            final code = (args?['orderCode'] as String?) ?? 'RB-1024';
            return MaterialPageRoute(builder: (_) => CancelRequestedScreen(orderCode: code));
          case '/order-review':
            final args = settings.arguments as Map<String, dynamic>?;
            final bag = (args?['bag'] as MysteryBag?) ?? (settings.arguments as MysteryBag?) ?? mockMysteryBags.first;
            final code = (args?['orderCode'] as String?) ?? 'RB-1024';
            return MaterialPageRoute(builder: (_) => OrderReviewScreen(bag: bag, orderCode: code));
          case '/green-impact':
            return MaterialPageRoute(builder: (_) => const GreenImpactScreen());
          case '/green-collection':
            return MaterialPageRoute(builder: (_) => const GreenCollectionScreen());
          case '/consumer-profile':
            return MaterialPageRoute(builder: (_) => const ConsumerMainNavScreen(initialIndex: 3));
          case '/personal-info':
            return MaterialPageRoute(builder: (_) => const PersonalInfoScreen());
          case '/notifications':
            return MaterialPageRoute(builder: (_) => const NotificationsScreen());
          case '/saved-addresses':
            return MaterialPageRoute(builder: (_) => const SavedAddressesScreen());
          case '/wallet-methods':
            return MaterialPageRoute(builder: (_) => const WalletMethodsScreen());
          case '/help-center':
            return MaterialPageRoute(builder: (_) => const HelpCenterScreen());
          case '/support-request':
            final args = settings.arguments as Map<String, dynamic>?;
            final code = (args?['initialOrderCode'] as String?) ?? (settings.arguments as String?);
            return MaterialPageRoute(builder: (_) => SupportRequestScreen(initialOrderCode: code));
          case '/support-success':
            final args = settings.arguments as Map<String, dynamic>?;
            final code = (args?['orderCode'] as String?) ?? 'RB-1024';
            return MaterialPageRoute(builder: (_) => SupportSuccessScreen(orderCode: code));

          // --- MERCHANT FLOW ---
          case '/merchant-onboarding':
            return MaterialPageRoute(builder: (_) => const MerchantOnboardingScreen());
          case '/merchant-register':
            return MaterialPageRoute(builder: (_) => const MerchantRegisterScreen());
          case '/merchant-verification':
            return MaterialPageRoute(builder: (_) => const MerchantVerificationScreen());
          case '/merchant-home':
            return MaterialPageRoute(builder: (_) => const MerchantMainNavScreen(initialIndex: 0));
          case '/merchant-dashboard':
            return MaterialPageRoute(builder: (_) => const MerchantDashboardScreen());
          case '/merchant-bags':
            return MaterialPageRoute(builder: (_) => const MerchantBagListScreen());
          case '/merchant-create-bag':
            return MaterialPageRoute(builder: (_) => const MerchantCreateBagScreen());
          case '/merchant-bag-price':
            return MaterialPageRoute(builder: (_) => const MerchantBagPriceScreen());
          case '/merchant-pickup-window':
            return MaterialPageRoute(builder: (_) => const MerchantPickupWindowScreen());
          case '/merchant-bag-quantity':
            return MaterialPageRoute(builder: (_) => const MerchantBagQuantityScreen());
          case '/merchant-bag-ingredients':
            return MaterialPageRoute(builder: (_) => const MerchantBagIngredientsScreen());
          case '/merchant-tasks':
            return MaterialPageRoute(builder: (_) => const MerchantTasksScreen());
          case '/merchant-activities':
            return MaterialPageRoute(builder: (_) => const MerchantActivitiesScreen());
          case '/merchant-closing-shift':
            return MaterialPageRoute(builder: (_) => const MerchantClosingShiftScreen());
          case '/merchant-scanner':
            return MaterialPageRoute(builder: (_) => const MerchantQrScannerScreen());
          case '/merchant-qr-valid':
            final args = settings.arguments as Map<String, dynamic>?;
            final order = args?['order'] as MerchantOrder?;
            final isError = (args?['isError'] as bool?) ?? false;
            final errorType = (args?['errorType'] as String?) ?? 'used';
            return MaterialPageRoute(
              builder: (_) => MerchantQrValidScreen(order: order, isError: isError, errorType: errorType),
            );
          case '/merchant-orders-pending':
            final tab = (settings.arguments as int?) ?? 0;
            return MaterialPageRoute(builder: (_) => MerchantOrdersPendingScreen(initialTab: tab));
          case '/merchant-revenue':
            return MaterialPageRoute(builder: (_) => const MerchantRevenueReportScreen());
          case '/merchant-food-waste':
            return MaterialPageRoute(builder: (_) => const MerchantFoodWasteReportScreen());
          case '/merchant-store-settings':
            return MaterialPageRoute(builder: (_) => const MerchantStoreSettingsScreen());
          case '/merchant-bank-settings':
            return MaterialPageRoute(builder: (_) => const MerchantBankSettingsScreen());
          case '/merchant-staff':
            return MaterialPageRoute(builder: (_) => const MerchantStaffSettingsScreen());

          // --- CATALOG ---
          case '/catalog':
            return MaterialPageRoute(builder: (_) => const ScreenCatalogScreen());

          default:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
      },
    );
  }
}
