import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/features/profile/controller/auth_services.dart';
import 'package:yuvix/features/profile/view/widgets/build_login.dart';
import '../../../../core/constants/color.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 200.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: ConstC.getColor(AppColor.textC1),
        ),
        height: double.infinity,
        width: double.infinity,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildUsernameField(),
                          const SizedBox(height: 20),
                          _buildPasswordField(),
                          const SizedBox(height: 20),
                          _buildLoginButton(authService),
                          const SizedBox(height: 70),
                          buildSignUpOption(context),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Username cannot be empty';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _usernameController,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.check, color: ConstC.getColor(AppColor.text)),
        labelText: 'Username',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: ConstC.getColor(AppColor.background1),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password cannot be empty';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: ConstC.getColor(AppColor.text),
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        labelText: 'Password',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: ConstC.getColor(AppColor.background1),
        ),
      ),
    );
  }

  Widget _buildLoginButton(AuthService authService) {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          final user = await authService.loginUser(
            _usernameController.text,
            _passwordController.text,
          );
          if (user != null) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              'BottomNav',
              (route) => false,
              arguments: user,
            );
          }
        }
      },
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [
              ConstC.getColor(AppColor.background1),
              const Color(0xff281537),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'LOGIN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

}