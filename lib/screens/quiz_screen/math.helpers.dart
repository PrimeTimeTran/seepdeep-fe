final allSubjects = [
  'Tangent Lines and Rates of Change',
  'The Limit',
  'One Sided Limits',
  'Limit Properties',
  'Computing Limits',
  'Infinite Limits',
  'Limits At Infinity Part I',
  'Limits At Infinity Part II',
  'Continuity',
  'The Definition of the Limit',
  // Derivatives
  'The Definition of the Derivative',
  'Interpretation of the Derivative Differentiation',
  'Product and Quotient Rule',
  'Derivatives of Trig Functions',
  'Derivatives of Exponential and Logarithm Functions',
  'Derivatives of Inverse Trig Functions',
  'Derivatives of Hyperbolic Functions',
  'Chain Rule',
  'Implicit Differentiation',
  'Related Rates',
  'Higher Order Derivatives',
  'Logarithmic Differentiation',
  // Application of Derivatives
  'Rates of Change',
  'Critical Points',
  'Minimum and Maximum Values',
  'Finding Absolute Extreme',
  'The Shape of a Graph Part I',
  'The Shape of a Graph Part II',
  'The Mean Value Theorem',
  'Optimization Problems',
  'More Optimization Problems',
  'LHospitals Rule and Indeterminate Forms',
  'Linear Approximations',
  'Differentials',
  'Newtons Method',
  'Business Applications',
  // Integrals
  'Indefinite Integrals',
  'Computing Indefinite Integrals',
  'Substitution Rule for Indefinite Integrals',
  'More Substitution Rule',
  'Area Problem',
  'Definition of the Definite Integral',
  'Computing Definite Integrals',
  'Substitution Rule for Definite Integrals',
  // Application of Integrals
  'Average Function Value',
  'Area Between Curves',
  'Volumes of Solids of Revolution / Method of Rings',
  'Volumes of Solids of Revolution / Method of Cylinders',
  'More Volume Problems',
  'Work',
];

Map<String, String> categoryIntroMap = {
  "Limits":
      "Limits describe the behavior of functions as their inputs approach specific values. The limit of a function f(x) as x approaches a value c represents the value f(x) approaches as x gets arbitrarily close to c. Key properties, like sum, difference, constant multiple, product, and quotient properties, aid in evaluating limits efficiently. Techniques such as direct substitution and L'Hôpital's Rule help determine limits in various scenarios. Understanding limits is essential as they form the basis for concepts like continuity, derivatives, and integrals, enabling the analysis of functions' behavior near critical points.",
  "Derivatives":
      "Derivatives measure the rate of change of a function with respect to its input. The derivative of a function f(x) at a point x represents the slope of the tangent line to the graph of f(x) at that point. Key properties, such as the power rule, product rule, quotient rule, and chain rule, allow for the differentiation of various functions efficiently. Techniques like implicit differentiation and logarithmic differentiation expand the scope of functions that can be differentiated. Understanding derivatives is fundamental as they provide insights into the behavior of functions, including identifying extrema, inflection points, and graph characteristics. They also have applications in physics, engineering, economics, and other fields where rates of change are essential for analysis.",
  "Applications of Derivatives":
      "Applications of derivatives encompass various techniques and concepts that leverage the derivative of a function to solve practical problems. This includes finding rates of change in different contexts, identifying critical points where functions attain maximum or minimum values, and determining the concavity and inflection points that describe the shape of a graph. The Mean Value Theorem links the derivative to average rates of change, while optimization problems use derivatives to find optimal solutions. Additionally, L'Hôpital's Rule resolves indeterminate forms in limits, linear approximations provide close estimates of function values, differentials estimate error margins, Newton's Method approximates roots, and business applications optimize cost, revenue, and profit analysis.",
  "Integrals":
      "Integrals calculate the accumulation of quantities, which can represent areas under curves, total distance traveled, or accumulated change. The indefinite integral of a function f(x) represents a family of functions whose derivative is f(x), including a constant of integration. Techniques for finding integrals include substitution, integration by parts, and partial fractions. The Fundamental Theorem of Calculus connects differentiation and integration, allowing the evaluation of definite integrals as the net change over an interval. Integrals are crucial for solving problems in physics, engineering, and other fields where total accumulation is important.",
  "Applications of Integrals":
      "Applications of integrals involve using integration to solve real-world problems. This includes calculating areas under curves, volumes of solids of revolution, and lengths of curves. Integrals determine accumulated quantities, such as total distance traveled, work done by a force, or the center of mass of an object. Techniques like the disk and shell methods are used to find volumes, while double and triple integrals extend the concept to higher dimensions. Applications in physics include finding the center of mass, moment of inertia, and solving differential equations. In economics, integrals calculate consumer and producer surplus, while in biology, they model population growth and decay."
};

final optionLabels = [
  'i',
  'ii',
  'iii',
  'iv',
  'v',
  'vi',
  'vii',
  'viii',
  'ix',
  'x'
];

Map<String, dynamic> subjects = {
  "subjects": ['pre-calculus', 'trigonometry', 'calculus'],
  "calculus": {
    "subjects": [
      'Limits',
      'Derivatives',
      'Applications of Derivatives',
      'Integrals',
      'Applications of Integrals',
    ],
    "Limits": {
      "subjects": [
        'Tangent Lines and Rates of Change',
        'The Limit',
        'One Sided Limits',
        'Limit Properties',
        'Computing Limits',
        'Infinite Limits',
        'Limits At Infinity Part I',
        'Limits At Infinity Part II',
        'Continuity',
        'The Definition of the Limit',
      ],
      'Tangent Lines and Rates of Change': {
        "description":
            "Tangent lines represent the instantaneous rate of change of a function at a particular point, akin to the slope of the function at that point. This concept is fundamental in calculus as it bridges the idea of derivative, showing how a function changes instantaneously. Rates of change can be applied to various contexts, such as velocity in physics, where the slope of the tangent line to a position-time graph gives the object's velocity."
      },
      'The Limit': {
        "description":
            "The limit is a core concept in calculus that describes the value that a function approaches as the input approaches a particular point. Limits help define continuity, derivatives, and integrals. They are essential for handling situations where direct substitution might lead to indeterminate forms or undefined values, allowing mathematicians to rigorously deal with the behavior of functions at boundaries or points of discontinuity."
      },
      'One Sided Limits': {
        "description":
            """One Sided limits focus on the behavior of a function as the input approaches a specific value from one side—either from the left (x→c−x→c −) or the right (x→c+x→c +). These limits are crucial for understanding discontinuities and defining limits in cases where the function behaves differently depending on the direction of approach, such as at jump discontinuities or in piecewise-defined functions."""
      },
      'Limit Properties': {
        "description":
            "Limit properties are rules that allow the manipulation and simplification of limits. These include the sum, difference, product, and quotient rules, as well as limits involving constants and powers. These properties facilitate the process of evaluating limits by breaking down complex expressions into simpler components whose limits are easier to determine."
      },
      'Computing Limits': {
        "description":
            "Computing limits involves applying various techniques and strategies to find the limit of a function as the input approaches a particular value. Techniques include direct substitution, factoring, rationalizing, and using special limit theorems like L'Hôpital's rule for indeterminate forms. Mastery of these techniques is essential for solving real-world problems and for further studies in calculus."
      },
      'Infinite Limits': {
        "description":
            "Infinite limits describe the behavior of functions as they grow without bound near certain points or as inputs approach infinity. These limits can indicate vertical asymptotes when a function approaches infinity or negative infinity at finite points. They are used to understand the unbounded growth or decay of functions, which is important in fields such as physics and economics where such behavior is observed."
      },
      'Limits At Infinity Part I': {
        "description":
            "Limits at infinity examine the behavior of functions as the input grows increasingly large in the positive or negative direction. This involves determining whether the function approaches a particular finite value (indicating a horizontal asymptote) or grows without bound. Understanding these limits helps in analyzing the long-term behavior of functions and is crucial in fields such as engineering and natural sciences."
      },
      'Limits At Infinity Part II': {
        "description":
            "This part continues the exploration of limits at infinity, delving deeper into more complex functions and their asymptotic behaviors. It includes functions that oscillate, polynomial and rational functions, and exponential growth or decay. These advanced concepts are vital for accurately modeling and predicting long-term trends in various applications, from population growth to financial projections."
      },
      'Continuity': {
        "description":
            "Continuity describes a function that has no breaks, jumps, or holes at any point within its domain. A function is continuous at a point if the limit exists at that point and equals the function's value. Continuity ensures smooth behavior and is critical for the applicability of many calculus theorems, such as the Intermediate Value Theorem and the Fundamental Theorem of Calculus."
      },
      'The Definition of the Limit': {
        "description":
            "The formal definition of the limit, known as the epsilon-delta definition, provides a precise way to understand limits in mathematics. It explains that a function ( f(x) ) approaches a value ( L ) as ( x ) gets closer to a point ( c ) if the following is true: for every tiny margin of error we choose around ( L ) (no matter how small), there is a corresponding small range around ( c ) (that may be just as small) within which all the function values fall inside our margin of error around ( L ). This rigorous approach ensures that our understanding of limits is both exact and consistent, avoiding ambiguities and providing a strong foundation for further study in calculus."
      },
    },
    "Derivatives": {
      "subjects": [
        'The Definition of the Derivative',
        'Interpretation of the Derivative Differentiation',
        'Product and Quotient Rule',
        'Derivatives of Trig Functions',
        'Derivatives of Exponential and Logarithm Functions',
        'Derivatives of Inverse Trig Functions',
        'Derivatives of Hyperbolic Functions',
        'Chain Rule',
        'Implicit Differentiation',
        'Related Rates',
        'Higher Order Derivatives',
        'Logarithmic Differentiation',
      ],
      'The Definition of the Derivative': {
        "description":
            "The derivative of a function at a point provides the rate at which the function's value changes as the input changes. It is essentially the slope of the tangent line to the function's graph at that point, representing instantaneous change. This concept is foundational in calculus, enabling the analysis of dynamic systems and rates of change in various fields such as physics, economics, and engineering."
      },
      'Interpretation of the Derivative Differentiation': {
        "description":
            "Differentiation formulas are rules that simplify the process of finding derivatives of functions. These formulas include the basic rules for power, product, and quotient operations on functions, among others. Understanding these formulas allows one to quickly and accurately determine the rate of change of complex functions, facilitating problem-solving in real-world applications."
      },
      'Product and Quotient Rule': {
        "description":
            "The product and quotient rules are specific differentiation techniques used when dealing with functions that are products or quotients of other functions. The product rule helps find the derivative of two multiplied functions, while the quotient rule is used for functions divided by one another. These rules are essential for handling more complicated expressions in calculus, ensuring accurate calculation of derivatives in various contexts."
      },
      'Derivatives of Trig Functions': {
        "description":
            "Derivatives of trigonometric functions involve finding the rates of change for sine, cosine, tangent, and other trigonometric functions. These derivatives are crucial in fields like physics and engineering, where wave motion, oscillations, and circular movements are analyzed. Understanding these derivatives helps in solving problems involving periodic phenomena."
      },
      'Derivatives of Exponential and Logarithm Functions': {
        "description":
            "Derivatives of exponential and logarithmic functions are fundamental in calculus due to their widespread applications in natural and social sciences. The derivative of an exponential function shows how rapidly exponential growth or decay occurs, while the derivative of a logarithmic function helps in understanding rates of change in logarithmic scales, which are common in fields like biology and economics."
      },
      'Derivatives of Inverse Trig Functions': {
        "description":
            "Derivatives of inverse trigonometric functions, such as arcsine, arccosine, and arctangent, provide the rates of change for these functions. These derivatives are important for solving problems involving angles and distances in geometry and trigonometry. They help in finding the slopes and understanding the behavior of curves defined by inverse trigonometric relationships."
      },
      'Derivatives of Hyperbolic Functions': {
        "description":
            "Derivatives of hyperbolic functions, which include hyperbolic sine, cosine, and tangent, describe the rates of change for these functions. Hyperbolic functions are used in various applications, such as modeling hyperbolic geometry, describing catenary curves in physics, and solving certain differential equations. Understanding their derivatives aids in these and other advanced mathematical contexts."
      },
      'Chain Rule': {
        "description":
            "The chain rule is a fundamental differentiation technique used to find the derivative of composite functions, where one function is nested inside another. It allows us to differentiate complex expressions by breaking them down into simpler parts. The chain rule is essential for dealing with multi-step processes and understanding how changes in one variable affect another through a series of intermediate steps."
      },
      'Implicit Differentiation': {
        "description":
            "Implicit differentiation is used when a function is not explicitly solved for one variable in terms of another but rather given implicitly by an equation involving both variables. This technique allows us to find derivatives even when the relationship between variables is complex. It is particularly useful in cases involving curves and surfaces defined by equations rather than explicit functions."
      },
      'Related Rates': {
        "description":
            "Related rates involve finding the rate at which one quantity changes in relation to another quantity that is also changing. This method is used to solve problems where multiple variables are interconnected and changing over time. Applications include scenarios like the changing dimensions of a balloon being inflated or the speed at which the shadow of a moving object changes."
      },
      'Higher Order Derivatives': {
        "description":
            "Higher order derivatives refer to the derivatives of a function taken multiple times. The first derivative represents the rate of change of the function, while the second derivative shows the rate of change of the rate of change, providing information about the curvature or concavity of the function's graph. Higher order derivatives are used in physics to analyze motion and in other fields to study more complex dynamic behaviors."
      },
      'Logarithmic Differentiation': {
        "description":
            "Logarithmic differentiation is a technique used to simplify the process of differentiating functions that are products, quotients, or powers of other functions. By taking the natural logarithm of both sides of an equation and then differentiating, we can make the differentiation process more manageable. This method is particularly useful for dealing with complicated expressions that would be difficult to differentiate directly."
      },
    },
    "Applications of Derivatives": {
      'subjects': [
        'Rates of Change',
        'Critical Points',
        'Minimum and Maximum Values',
        'Finding Absolute Extreme',
        'The Shape of a Graph Part I',
        'The Shape of a Graph Part II',
        'The Mean Value Theorem',
        'Optimization Problems',
        'More Optimization Problems',
        'LHospitals Rule and Indeterminate Forms',
        'Linear Approximations',
        'Differentials',
        'Newtons Method',
        'Business Applications',
      ],
      'Indefinite Integrals': {
        "description":
            "Indefinite integrals represent the family of all antiderivatives of a function. They are used to find the general form of functions given their rate of change and are represented with the integral symbol and a constant of integration."
      },
      "Rates of Change": {
        'description':
            "The derivative represents the rate of change of a function with respect to a variable. This concept is applied to understand how a quantity changes over time or in relation to other variables."
      },
      "Critical Points": {
        'description':
            "Critical points are points on a graph where the derivative is zero or undefined. These points are used to find local maximums, minimums, or saddle points."
      },
      "Minimum and Maximum Values": {
        'description':
            "These are the highest or lowest values that a function can reach on a given interval. The first and second derivative tests help identify these values."
      },
      "Finding Absolute Extreme": {
        'description':
            "Absolute extreme values are the global maximum and minimum values a function attains on a given interval. These are found by evaluating the function at critical points and endpoints."
      },
      "The Shape of a Graph Part I": {
        'description':
            "The first derivative of a function provides information about the function's increasing or decreasing behavior, which helps in sketching the graph."
      },
      "The Shape of a Graph Part II": {
        'description':
            "The second derivative of a function gives information about the concavity of the graph and helps identify inflection points where the concavity changes."
      },
      "The Mean Value Theorem": {
        'description':
            "This theorem states that for a continuous function on a closed interval, there exists at least one point where the derivative equals the average rate of change over that interval."
      },
      "Optimization Problems": {
        'description':
            "Optimization involves finding the maximum or minimum values of a function in a real-world context, such as minimizing cost or maximizing profit."
      },
      "More Optimization Problems": {
        'description':
            "This involves more complex or additional real-world scenarios where optimization techniques are applied to find the best possible solution."
      },
      "LHospitals Rule and Indeterminate Forms": {
        'description':
            "L'Hospital's Rule is used to find the limit of indeterminate forms like 0/0 or ∞/∞ by differentiating the numerator and the denominator."
      },
      "Linear Approximations": {
        'description':
            "Linear approximations use the tangent line at a point to approximate the value of a function near that point, simplifying complex calculations."
      },
      "Differentials": {
        'description':
            "Differentials provide an approximate change in the function value resulting from a small change in the input value, useful for error estimation."
      },
      "Newtons Method": {
        'description':
            "Newton's Method is an iterative numerical technique for finding approximate roots of a real-valued function using tangents."
      },
      "Business Applications": {
        'description':
            "Applications in business include cost, revenue, and profit analysis, using derivatives to optimize production, minimize costs, and maximize profits."
      },
    },
    "Integrals": {
      "subjects": [
        'Indefinite Integrals',
        'Computing Indefinite Integrals',
        'Substitution Rule for Indefinite Integrals',
        'More Substitution Rule',
        'Area Problem',
        'Definition of the Definite Integral',
        'Computing Definite Integrals',
        'Substitution Rule for Definite Integrals',
      ],
      'Indefinite Integrals': {
        "description":
            "Indefinite integrals represent the process of finding the anti-derivative of a function, essentially reversing differentiation. The result of an indefinite integral is a family of functions, differing by a constant, which when differentiated, give back the original function. Indefinite integrals are fundamental in solving problems related to accumulation and area under curves, providing a key tool in calculus for understanding the general behavior of functions."
      },
      'Computing Indefinite Integrals': {
        "description":
            "Computing indefinite integrals involves applying various techniques and rules to determine the anti-derivative of a given function. This process requires recognizing patterns, using algebraic manipulation, and applying known integral rules. Mastery of these techniques is crucial for solving a wide range of problems in physics, engineering, and other fields where functions describe changing quantities."
      },
      'Substitution Rule for Indefinite Integrals': {
        "description":
            "The substitution rule for indefinite integrals, also known as u-substitution, simplifies the integration process by changing variables. By substituting part of the integrand with a new variable, the integral becomes easier to solve. This technique is particularly useful for integrals involving composite functions, allowing for the simplification of complex expressions into more manageable forms."
      },
      'More Substitution Rule': {
        "description":
            "Building on the basic substitution rule, more advanced substitution techniques involve recognizing when multiple substitutions or more complex changes of variables are needed. These techniques extend the power of substitution to a broader class of integrals, enabling the integration of more complicated functions. Understanding and applying these advanced methods are essential for tackling integrals that are not easily simplified with basic rules."
      },
      'Area Problem': {
        "description":
            "The area problem in calculus involves finding the area under a curve over a specified interval. This problem is fundamental because it links integration to geometric concepts, allowing the calculation of areas bounded by functions and the x-axis. The area problem provides a practical application of definite integrals, demonstrating how integration can solve real-world problems involving space and quantity accumulation."
      },
      'Definition of the Definite Integral': {
        "description":
            "The definite integral is defined as the limit of a sum of areas of rectangles under a curve as the width of the rectangles approaches zero. This concept formalizes the process of finding the exact area under a curve over a given interval. The definite integral has a wide range of applications, from calculating total accumulated quantities to determining physical properties like mass and center of gravity."
      },
      'Computing Definite Integrals': {
        "description":
            "Computing definite integrals involves evaluating the integral of a function over a specific interval, resulting in a numerical value that represents the accumulated area under the curve between two points. This process often requires applying the fundamental theorem of calculus, which connects antiderivatives with definite integrals. Accurate computation of definite integrals is crucial for precise measurements and analyses in various scientific and engineering disciplines."
      },
      'Substitution Rule for Definite Integrals': {
        "description":
            "The substitution rule for definite integrals extends the concept of u-substitution to definite integrals, allowing for a change of variables that simplifies the integral over a specified interval. This technique involves adjusting the limits of integration according to the substitution, ensuring the correct evaluation of the integral. It is particularly useful for integrating functions where direct integration is challenging, making it a powerful tool for solving complex integrals in practical applications."
      },
    },
    'Applications of Integrals': {
      'subjects': [
        'Average Function Value',
        'Area Between Curves',
        'Volumes of Solids of Revolution / Method of Rings',
        'Volumes of Solids of Revolution / Method of Cylinders',
        'More Volume Problems',
        'Work',
      ],
      "Average Function Value": {
        "description":
            "The average function value of a function f(x) on the interval [a, b] is given by the integral of f(x) over [a, b], divided by the length of the interval (b - a). It represents the average height of the function over that interval."
      },
      "Area Between Curves": {
        "description":
            "The area between two curves y = f(x) and y = g(x) on the interval [a, b] is found by taking the difference between the integrals of the upper curve and the lower curve over that interval, |∫[a,b] (f(x) - g(x)) dx|. It calculates the total area enclosed between the curves."
      },
      "Volumes of Solids of Revolution / Method of Rings": {
        "description":
            "The volume of a solid generated by rotating a region bounded by two curves around a horizontal or vertical axis can be found using the method of rings. This involves integrating the area of infinitesimally thin rings formed by the rotation."
      },
      "Volumes of Solids of Revolution / Method of Cylinders": {
        "description":
            "Similar to the method of rings, the method of cylinders calculates the volume of a solid of revolution by integrating the area of infinitesimally thin cylinders formed by the rotation of a region bounded by two curves around an axis."
      },
      "More Volume Problems": {
        "description":
            "Involves additional scenarios where integration is used to find volumes of solids, such as when cross-sections perpendicular to a given axis are not circular, requiring integration techniques tailored to the specific geometry."
      },
      "Work": {
        "description":
            "In physics, work is calculated as the integral of force over distance. It represents the energy transferred to or from an object by means of a force acting along a path of displacement. Integration is used to sum up the infinitesimal amounts of work done."
      }
    }
  }
};

String? matchSubject(String urlSafeString) {
  String convertUrlSafeString(String urlSafeString) {
    String converted = urlSafeString.replaceAll('-', ' ');
    List<String> words = converted.split(' ');
    words = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return word;
    }).toList();

    return words.join(' ');
  }

  String convertedString = convertUrlSafeString(urlSafeString);
  for (var subject in allSubjects) {
    if (subject.toLowerCase() == convertedString.toLowerCase()) {
      return subject;
    }
  }
  return '';
}
