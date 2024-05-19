import 'package:flutter/material.dart';

// Topics,
// Calculus 1
// Limits, Derivatives, Optimization, Integrals
// Calculus 2

final subjects = {
  "calculus": {
    "limit": {
      // Good
      "limit": "",
      // Good
      "limit-properties": "",
      // Good
      "infinite-limit": "",
    },
    "derivatives": {
      // Good
      "derivatives": [],
      // Good
      "product-rule": [],
      // Good
      "quotient-rule": [],
      // Good
      "optimization": ['limit'],
    },
    "integrals": ['limit'],
  }
};

class MathIntroScreen extends StatefulWidget {
  const MathIntroScreen({super.key});

  @override
  State<MathIntroScreen> createState() => _MathIntroScreenState();
}

class _MathIntroScreenState extends State<MathIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Math Subjects'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Question Types:
// - Multiple Choice, Free Response, Checkbox, Fill in the blank, Matching, Short Answer, True/False
// - Acronyms: MC, FR, CB, FB, M, SA, TF

// Potential domains...?
// Arithmetic, Algebra, Geometry, Trigonometry, Statistics, Number Theory, Calculus, Word Problems, Finance

// Examples:
//    1. Multiple Choice or :MC:
//    Question.     What's Flutter primarily written in?
//    Choices.      [Python, Ruby, C, C++]
//    Answer.       Dart

//    2. Free Response or :FR:
//    Question.     What's 4 squared?
//    Choices.      null
//    Answer.       16

//    3. Checkbox or :CB:
//    Question.     Which are prime numbers?
//    Choices.      [1, 2, 3, 5, 7, 11, 13, 15]
//    Answer.       [2, 3, 5, 7, 11, 13]

//    4. Fill in the blank or :FB:
//    Question.     Calculus is the study of _____?
//    Choices.      [Math, Derivatives, Equations, Change]
//    Answer.       Change

//    5. Matching: :M:
//    Question.     Match the term to it's definition.
//    Term.         Asymptote, Derivative
//    Definitions.  ["a line that continually approaches a given curve but does not meet it at any finite distance.", "(of a financial product) having a value deriving from an underlying variable asset."]
//    Answer.       [[Asymptote, "a line that continually approaches a given curve but does not meet it at any finite distance."], [Derivative,"(of a financial product) having a value deriving from an underlying variable asset."]]

//    6. Short Answer or :SA:
//    Question.     If you invest $1000 at an annual interest rate of 5% for 2 years, how much will you have at the end? How about after 10 years?
//    Answer.       "After 2 years, $1102.5, then $1628.89 for 10"

//    7. True/False or :TF:
//    Question.     Studying math is good for you,
//    Answer.       "After 2 years, $1102.5, then $1628.89 for 10"