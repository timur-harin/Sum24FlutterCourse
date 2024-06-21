import 'package:flutter/material.dart';
import 'home_page_widget.dart';
import 'step_page.dart'; // Import the StepPage widget

class ContrastShowerGuideController extends StatefulWidget {
  @override
  _ContrastShowerGuideControllerState createState() =>
      _ContrastShowerGuideControllerState();
}

class _ContrastShowerGuideControllerState
    extends State<ContrastShowerGuideController> {
  int _currentStep = 0;

  List<Map<String, String>> _steps = [
    {
      "title": "Start gradually...",
      "content":
      "Start with a small temperature difference. Use comfortably warm water that you are accustomed to, then switch to slightly cool water, and back to warm. In the initial stages, a couple of minutes under the contrast shower should be sufficient.",
    },
    {
      "title": "Take a contrast shower in the morning or evening...",
      "content":
      "It's the perfect time: in the morning, it will energize you for school, work, or meeting friends, while in the evening, it will help you relieve tension.",
    },
    {
      "title": "Do not take a contrast shower for more than a few minutes...",
      "content":
      "15 minutes maximum – doctors are very categorical about this. Otherwise, there's a high chance that instead of relaxing, you will start feeling unwell.",
    },
    {
      "title": "Start with warm water...",
      "content":
      "The golden rule of contrast showers is to always start with comfortable warm water, even if you've already adjusted the temperature range to the maximum.",
    },
    {
      "title": "Maintain a specific temperature range...",
      "content":
      "The hot water should not exceed 45 degrees Celsius, and the cold water should not be colder than 15 degrees Celsius. The maximum temperature difference between hot and cold water should not exceed 30 degrees Celsius.",
    },
    {
      "title": "Set a strong water pressure...",
      "content":
      "Both cold and hot streams should massage the body. Water pressure plays an important role in achieving the desired effect.",
    },
    {
      "title": "Do not tolerate discomfort...",
      "content":
      "A contrast shower is a pleasant procedure, which should bring pleasure. Do not overdo it with the temperature and pay attention to your feelings.",
    },
    {
      "title": "Do not take a contrast shower on your head...",
      "content":
      "It's better to wash your head before or after the procedure. Temperature changes can negatively affect blood pressure and increase the risk of catching a cold.",
    },
    {
      "title": "Do not take a contrast shower when ill...",
      "content":
      "If you are ill, postpone taking a contrast shower. Your body is already under stress fighting the illness, and temperature changes may worsen your condition.",
    },
  ];

  void goToNextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void goToPrevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void finishGuide() {
    // Logic to finish guide, e.g., navigate to home page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePageWidget()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StepPage(
      // Pass current step's title and content to StepPage widget
      title: _steps[_currentStep]["title"]!,
      content: _steps[_currentStep]["content"]!,
      onNextPressed: goToNextStep, // Callback to move to next step
      onPrevPressed: goToPrevStep, // Callback to move to previous step
      onFinishPressed: finishGuide, // Callback to finish guide
      isLastStep: _currentStep == _steps.length - 1, // Check if it's the last step
    );
  }
}
