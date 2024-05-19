import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

// Topics,
// Calculus 1
// Limits, Derivatives, Optimization, Integrals
// Calculus 2

final subjects = {
  "subjects": ['pre-calculus', 'trigonometry', 'calculus'],
  "calculus": {
    "subjects": ['limits', 'limit-properties', 'infinite-limits'],
    "limit": {
      "limit": "",
      "limit-properties": "",
      "infinite-limit": "",
    },
    "derivatives": {
      "subjects": [
        'derivatives',
        'product-rule',
        'quotient-rule',
        'optimizations'
      ],
      "derivative": [],
      "product-rule": [],
      "quotient-rule": [],
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Calculus',
                    style: Style.of(
                      context,
                      'displayL',
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Limits',
                  style: Style.of(
                    context,
                    'displayS',
                  ),
                ),
                Text(
                  "Limits describe the behavior of functions as their inputs approach specific values. The limit of a function f(x) as x approaches a value  c represents the value  f(x) approaches as x gets arbitrarily close to c. Key properties, like sum, difference, constant multiple, product, and quotient properties, aid in evaluating limits efficiently. Techniques such as direct substitution and L'Hôpital's Rule help determine limits in various scenarios. Understanding limits is essential as they form the basis for concepts like continuity, derivatives, and integrals, enabling the analysis of functions' behavior near critical points.",
                  style: Style.of(context, 'headlineS'),
                ),
                TextButton(
                    onPressed: () {
                      GoRouter.of(context).go('/math?category=limits');
                    },
                    child: const Text('Practice')),
                const Gap(50),
                Text(
                  'Derivatives',
                  style: Style.of(
                    context,
                    'displayS',
                  ),
                ),
                Text(
                  "Derivatives measure the rate of change of a function with respect to its input. The derivative of a function f(x) at a point x represents the slope of the tangent line to the graph of  f(x) at that point. Key properties, such as the power rule, product rule, quotient rule, and chain rule, allow for the differentiation of various functions efficiently. Techniques like implicit differentiation and logarithmic differentiation expand the scope of functions that can be differentiated. Understanding derivatives is fundamental as they provide insights into the behavior of functions, including identifying extrema, inflection points, and graph characteristics. They also have applications in physics, engineering, economics, and other fields where rates of change are essential for analysis.",
                  style: Style.of(context, 'headlineS'),
                ),
                TextButton(
                    onPressed: () {
                      GoRouter.of(context).go('/math?category=derivatives');
                    },
                    child: const Text('Practice')),
                const Gap(50),
                Text(
                  'Integrals',
                  style: Style.of(
                    context,
                    'displayS',
                  ),
                ),
                Text(
                  "Integrals are used to calculate the accumulation of quantities over an interval and to find the area under curves. The integral of a function f(x) over an interval [a,b] represents the signed area between the curve of f(x) and the x-axis within that interval. Key properties, such as linearity, the fundamental theorem of calculus, substitution, and integration by parts, facilitate the computation of integrals for various functions. Techniques like trigonometric substitution and partial fractions enable the integration of more complex functions. Understanding integrals is crucial as they provide solutions to problems involving rates of change, accumulation, and area computations across diverse fields, including physics, engineering, economics, and statistics.",
                  style: Style.of(context, 'headlineS'),
                ),
                TextButton(
                    onPressed: () {
                      GoRouter.of(context).go('/math?category=integrals');
                    },
                    child: const Text('Practice'))
              ],
            )
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