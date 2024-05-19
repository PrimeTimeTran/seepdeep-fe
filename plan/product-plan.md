## SQL

- [ ] Create SQL Practice tool
- [ ] Add course outline...?

- [ ] Add Alert Dialogs Explaining the different Big O's of each sorting algorithm.
- [ ] Add Code Snippets

https://www.youtube.com/watch?v=31U9X_XD63c&ab_channel=MicroConf

"Sleep"
Testing yourself with flashcards and quizzes

https://www.youtube.com/watch?v=TjPFZaMe2yw&ab_channel=TED-Ed

      gemini.streamGenerateContent("""
        A Prompt
        """).listen(
        (data) {
          final content = data.content;
          if (content != null &&
              content.parts != null &&
              content.parts!.isNotEmpty) {
            for (var i = 0; i < content.parts!.length; i++) {
              respJson += content.parts![i].text!;
            }
          }
        },
        onError: (err) async {
          print('Error! $err');
          await FirebaseAnalytics.instance.logEvent(
            name: "error",
            parameters: {
              "type": "ai_generation",
              "provider": "gemini",
            },
          );

          getMath();
        },
        cancelOnError: false,
        onDone: () async {

        })
