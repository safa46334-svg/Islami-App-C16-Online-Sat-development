
import 'package:flutter/material.dart';
import 'package:islami_app_online_sat/core/resources/assets_manager.dart';
import 'package:islami_app_online_sat/core/resources/colors_manager.dart';
import 'package:islami_app_online_sat/core/routes_manager/routes_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "image": ImageAssets.frame,
      "title": "Welcome To Islami App",
      "subtitle": "",
    },
    {
      "image": ImageAssets.kabba,
      "title": "Welcome To Islami App",
      "subtitle": "We Are Very Excited To Have You In Our Community",
    },
    {
      "image": ImageAssets.welcom,
      "title": "Reading the Quran",
      "subtitle": "Read,and your Load is the Most Generous",
    },
    {
      "image": ImageAssets.bearish,
      "title": "Bearish",
      "subtitle": "Praise the name of your Lord, the Most High",
    },
    {
      "image": ImageAssets.radio,
      "title": "Holy Quran Radio",
      "subtitle": "You can listen to the Holy Quran Radio through the application",
    },
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("onboarding_completed", true);
    Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202020),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Image.asset(
              ImageAssets.islamiLogo,
              height: 120,
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        page["image"]!,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        page["title"]!,
                        style: const TextStyle(
                          color: ColorsManager.gold,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (page["subtitle"]!.isNotEmpty) ...[
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            page["subtitle"]!,
                            style: const TextStyle(
                              color: ColorsManager.gold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  else
                    const SizedBox(width: 60),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 18 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? ColorsManager.gold
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  _currentPage == pages.length - 1
                      ? TextButton(
                    onPressed: _completeOnboarding,
                    child: const Text(
                      "Finish",
                      style: TextStyle(color: ColorsManager.gold),
                    ),
                  )
                      : TextButton(
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(color: ColorsManager.gold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
