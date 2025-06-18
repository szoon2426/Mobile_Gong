import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _idController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              /// 로고
              Image.asset('assets/images/login_logo.png', width: 500),

              const Text(
                '회원가입',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(
                  hintText: '아이디를 입력하세요',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _nicknameController,
                decoration: const InputDecoration(
                  hintText: '닉네임을 입력하세요',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: '이메일을 입력하세요',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),


              /// 비밀번호
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: '영문, 숫자, 특수문자가 모두 들어간 8~20자',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),

              /// 비밀번호 확인
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  hintText: '비밀번호를 한 번 더 입력해주세요',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// 가입 버튼
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // 가입 로직
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('가입',
                  style: TextStyle(color: Colors.black),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}