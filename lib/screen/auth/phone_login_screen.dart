
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const Color cardColor = Color(0xFF151B29);
  static const Color primary = Color(0xFFFFAC16);
  static const Color borderColor = Color(0xFF252E40);
  static const Color textColor = Color(0xFFF0F1F7);
  static const Color hintColor = Color(0xFF747F9B);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.14),

                  // Logo
                  const AppLogo(),

                  const SizedBox(height: 20),

                  // App Name
                  const Text(
                    'مكوك طرود',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Subtitle
                  const Text(
                    'خدمة التوصيل الذكي',
                    style: TextStyle(
                      fontSize: 27,
                      color: hintColor,
                    ),
                  ),

                  SizedBox(height: size.height * 0.095),

                  // Login Card
                  const LoginCard(),

                  const SizedBox(height: 40),

                  // Bottom Note
                  const Text(
                    'للدخول يجب أن يكون لديك رقم هاتف مسجل على شبكة جوال أو أوريدو',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                      height: 1.8,
                      color: Color(0xFF3C4962),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= APP LOGO =================

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 185,
      child: CustomPaint(
        painter: LogoPainter(),
      ),
    );
  }
}

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final yellow = Paint()
      ..color = const Color(0xFFFFC400);

    final orange = Paint()
      ..color = const Color(0xFFFF9020);

    final white = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    // Left yellow part
    final leftPath = Path()
      ..moveTo(15, 28)
      ..quadraticBezierTo(65, 28, 92, 55)
      ..lineTo(92, 185)
      ..lineTo(15, 185)
      ..close();

    canvas.drawPath(leftPath, yellow);

    // Right orange part
    final rightPath = Path()
      ..moveTo(92, 55)
      ..quadraticBezierTo(120, 28, 170, 28)
      ..lineTo(170, 185)
      ..lineTo(92, 185)
      ..close();

    canvas.drawPath(rightPath, orange);

    // Bottom orange/yellow shape
    final bottomPath = Path()
      ..moveTo(15, 185)
      ..quadraticBezierTo(20, 110, 92, 55)
      ..quadraticBezierTo(165, 110, 170, 185)
      ..close();

    canvas.drawPath(bottomPath, orange);

    // Smile
    final smilePath = Path()
      ..moveTo(42, 67)
      ..cubicTo(42, 130, 142, 130, 142, 67);

    canvas.drawPath(smilePath, white);

    // First dot
    canvas.drawCircle(
      const Offset(75, 13),
      9,
      Paint()..color = const Color(0xFFFF9020),
    );

    // Second dot
    canvas.drawCircle(
      const Offset(115, 13),
      9,
      Paint()..color = const Color(0xFFFFC400),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// ================= LOGIN CARD =================

class LoginCard extends StatelessWidget {
  const LoginCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 42,
        vertical: 45,
      ),
      decoration: BoxDecoration(
        color: LoginScreen.cardColor,
        borderRadius: BorderRadius.circular(36),
        border: Border.all(
          color: LoginScreen.borderColor,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'تسجيل الدخول',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: LoginScreen.textColor,
            ),
          ),

          const SizedBox(height: 18),

          // Description
          const Text(
            'أدخل رقم هاتفك لاستقبال رمز التحقق',
            style: TextStyle(
              fontSize: 24,
              color: LoginScreen.hintColor,
            ),
          ),

          const SizedBox(height: 50),

          // Phone Label
          const Text(
            'رقم هاتفك',
            style: TextStyle(
              fontSize: 27,
              color: LoginScreen.hintColor,
            ),
          ),

          const SizedBox(height: 20),

          // Phone Field
          Container(
            height: 105,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: const Color(0xFF101522),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: LoginScreen.borderColor,
                width: 2,
              ),
            ),
            child: const Text(
              '059xxxxxxx',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 30,
                color: LoginScreen.hintColor,
                letterSpacing: 1,
              ),
            ),
          ),

          const SizedBox(height: 42),

          // Send Button
          SizedBox(
            width: double.infinity,
            height: 85,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: LoginScreen.primary,
                foregroundColor: const Color(0xFF171717),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: const Text(
                'إرسال الرمز',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
