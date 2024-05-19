import 'dart:convert';

final examples = {
  "optimization": jsonEncode(
    """{
      "title": "Production Costs 3",
      "body": "The production costs per day for some widget is given by,",
      "equation": "\\[ C(x) = 2500 - 10x - 0.01x^{2} + 0.0002x^{33} \\]",
      "prompt": "What is the marginal cost when x = 200 , x = 300 and x = 400 ?",
      "answer": "10, 38, 78",
      "explanation": "So, in order to produce the 201st widget it will cost approximately \$10. To produce the 301st widget will cost around \$38. Finally, to product the 401st widget it will cost approximately \$78."
    }
    """,
  ),
};

generateGeminiPrompts(type) {
  switch (type) {
    case 'optimization':
      return """
        You're an AI that generates math problems & solutions. 
        You're provided a subject for the problem & structure for the response(JSON).
        Generate the problem & solution. Also include several wrong solutions as well.
        Your response should be a JSON string. It must have title, body, equation, prompt, answer & explanation keys to be considered valid.
        The other keys are optional. 

        Once again. The response must be JSON and it must have title, body, equation, prompt, answer & explanation keys.

        Subject: 
        Calculus Optimization problems.

        Structure:
        ${examples['optimization']}
        Generate a problem with that structure.
        Format the equation key using LATEX. 
        Heres an example of how to do it so that it's parsed correctly in the UI.

        Equation Example:
        `"\\[ C(x) = 2500 - 10x - 0.01x^{2} + 0.0002x^{33} \\]"`

        Ensure your JSON is valid JSON. Dart's jsonDecode method is complaining the response is not valid json OFTEN.
        """;
    default:
  }
}
