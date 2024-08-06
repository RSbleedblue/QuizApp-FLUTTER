import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:assignment6/components/Buttons/answerButton.dart';
import 'package:assignment6/provider/questionsProvider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int? selectedAnswerIndex;
  int currentQuestionIndex = 0;
  int correctAnswersCount = 0;
  int answeredQuestionCount = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<QuestionsProvider>(context, listen: false).loadJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 234, 226, 1),
      appBar: AppBar(
        title: Text(
          "Quiz App",
          softWrap: true,
          style: GoogleFonts.alexBrush(
            textStyle: const TextStyle(fontSize: 35, color: Colors.black),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<QuestionsProvider>(
        builder: (context, questionsProvider, child) {
          if (questionsProvider.questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (answeredQuestionCount >= 10) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You got $correctAnswersCount out of 10 questions correct!',
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _resetGame,
                    child: const Text('Play Again'),
                  ),
                ],
              ),
            );
          }

          final question = questionsProvider.questions[currentQuestionIndex];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 19, 2, 0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 500,
                    minWidth: 400,
                    maxHeight: 500,
                    maxWidth: 400,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question ${answeredQuestionCount + 1}",
                          style: GoogleFonts.yrsa(
                            textStyle: const TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          question['question'],
                          style: GoogleFonts.dmSans(
                            textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        AnswerButton(
                          index: 0,
                          answerText: question['A'],
                          selectedAnswerIndex: selectedAnswerIndex,
                          onSelected: (index) {
                            setState(() {
                              selectedAnswerIndex = index;
                            });
                          },
                        ),
                        AnswerButton(
                          index: 1,
                          answerText: question['B'],
                          selectedAnswerIndex: selectedAnswerIndex,
                          onSelected: (index) {
                            setState(() {
                              selectedAnswerIndex = index;
                            });
                          },
                        ),
                        AnswerButton(
                          index: 2,
                          answerText: question['C'],
                          selectedAnswerIndex: selectedAnswerIndex,
                          onSelected: (index) {
                            setState(() {
                              selectedAnswerIndex = index;
                            });
                          },
                        ),
                        AnswerButton(
                          index: 3,
                          answerText: question['D'],
                          selectedAnswerIndex: selectedAnswerIndex,
                          onSelected: (index) {
                            setState(() {
                              selectedAnswerIndex = index;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ButtonBar(
                children: [
                  IconButton(
                    onPressed: _changeQuestion,
                    icon: Icon(Icons.arrow_right),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void _changeQuestion() {
    final questionsProvider = Provider.of<QuestionsProvider>(context, listen: false);
    final currentQuestion = questionsProvider.questions[currentQuestionIndex];

    if (selectedAnswerIndex != null) {
      if (currentQuestion['answer'] == ['A', 'B', 'C', 'D'][selectedAnswerIndex!]) {
        setState(() {
          correctAnswersCount++;
        });
      }
    }

    setState(() {
      selectedAnswerIndex = null;
      answeredQuestionCount++; 
      if (currentQuestionIndex < questionsProvider.questions.length - 1) {
        currentQuestionIndex++;
      } else {
        currentQuestionIndex = 10; 
      }
    });

    if (answeredQuestionCount >= 10) {
    }
  }

  void _resetGame() {
    final questionsProvider = Provider.of<QuestionsProvider>(context, listen: false);
    final random = Random();
    setState(() {
      currentQuestionIndex = random.nextInt(min(questionsProvider.questions.length, 321));
      correctAnswersCount = 0;
      answeredQuestionCount = 0;  
      selectedAnswerIndex = null;
    });
  }
}
