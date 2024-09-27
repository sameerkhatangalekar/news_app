import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/common/providers/auth/auth_provider.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/constants/enums.dart';
import 'package:news_app/core/theme/theme.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isObscured = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyNews',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppPalette.primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppPalette.backgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.2,
                ),
                buildEmailField(),
                const SizedBox(
                  height: 16,
                ),
                buildPasswordField(),
                SizedBox(
                  height: size.height * 0.4,
                ),
                buildLoginButton(size),
                const SizedBox(
                  height: 8,
                ),
                buildRichText()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Consumer<AuthStatusProvider> buildLoginButton(Size size) {
    return Consumer<AuthStatusProvider>(
      builder: (context, dataProvider, child) {
        if (dataProvider.error != null &&
            dataProvider.status == AuthStatus.failed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(dataProvider.error ?? 'Something went wrong'),
                  backgroundColor: Colors.red,
                ),
              );
            dataProvider.setError = null;
          });
        }
        return TextButton(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
            backgroundColor:
                const WidgetStatePropertyAll(AppPalette.primaryColor),
            fixedSize: WidgetStatePropertyAll(Size(size.width * 0.5, 48)),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthStatusProvider>().signIn(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim());
            }
          },
          child: dataProvider.status == AuthStatus.loading
              ? const CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.white,
                )
              : Text(
                  'Login',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
        );
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      obscureText: isObscured,
      cursorColor: AppPalette.primaryColor,
      keyboardType: TextInputType.visiblePassword,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty!.';
        }
        if (value.length < 4) {
          return 'Please enter strong password!.';
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(
          'Password',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isObscured = !isObscured;
            });
          },
          icon:
              Icon(isObscured ? CupertinoIcons.eye : CupertinoIcons.eye_slash),
        ),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      cursorColor: AppPalette.primaryColor,
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email cannot be empty!.';
        }
        if (!emailRegex.hasMatch(value)) {
          return 'Enter valid email!.';
        }
        return null;
      },
      decoration: InputDecoration(
        label: Text(
          'Email',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }

  RichText buildRichText() {
    return RichText(
      text: TextSpan(
        text: 'New here? ',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black,
            ),
        children: [
          TextSpan(
              text: 'Signup',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.go('/signup');
                },
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppPalette.primaryColor, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
