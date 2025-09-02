import 'package:doctor_appoinment/core/helpers/form_validaor.dart';
import 'package:doctor_appoinment/feature/auth/presentation/widgets/login_screen_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  });

  tearDown(() {
    emailController.dispose();
    passwordController.dispose();
  });

  testWidgets('login screen testing the email field validation', (
    tester,
  ) async {
    // arrange
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: LoginScreenForm(
              emailController: emailController,
              passwordController: passwordController,
              formKey: formKey,
            ),
          ),
        ),
      ),
    );

    // Wait for the widget to be built
    await tester.pumpAndSettle();

    // Find the email text field
    final emailField = find.descendant(
      of: find.byKey(const Key('email field')),
      matching: find.byType(TextFormField),
    );

    // Verify the email field exists
    expect(emailField, findsOneWidget);

    // act
    await tester.enterText(emailField, 'invalid-email');
    await tester.pump();

    final isValid = formKey.currentState!.validate();
    await tester.pump();

    // Assert
    expect(isValid, false);
    expect(find.text(AppStrings.invalidEmail), findsOneWidget);
  });

  testWidgets('login screen testing valid email validation', (tester) async {
    // Initialize ScreenUtil for the test
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp(
          home: Scaffold(
            body: LoginScreenForm(
              emailController: emailController,
              passwordController: passwordController,
              formKey: formKey,
            ),
          ),
        ),
      ),
    );

    // Wait for the widget to be built
    await tester.pumpAndSettle();

    // Find the email text field
    final emailField = find.descendant(
      of: find.byKey(const Key('email field')),
      matching: find.byType(TextFormField),
    );

    // Enter valid email and password
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(find.byType(TextFormField).last, 'validPassword123');
    await tester.pump();

    // Trigger form validation
    final isValid = formKey.currentState!.validate();
    await tester.pump();

    // Assert form validation passed and no error messages
    expect(isValid, true);
    expect(find.text(AppStrings.invalidEmail), findsNothing);
  });
}
