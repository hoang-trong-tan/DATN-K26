"use strict";

const { questionQuiz, answersQuiz } = require("../../model/quiz.model");

const getQuizQuestion = async (quizId, select) => {
  return await questionQuiz.find({ quizId }).select(select).lean();
};

const showAnswers = async (quizId, userId, select) => {
  const printResults = await questionQuiz
    .find({ quizId })
    .select(select)
    .lean();

  const findAnswerQuizes = await answersQuiz.find({ quizId, userId }).lean();

  checkAnswer(printResults, findAnswerQuizes);

  return printResults;
};

const checkAnswer = (question, answer) => {
  for (let i = 0; i < question.length; i++) {
    let checkQuestionId =
      question[i]._id.toString() === answer[i].questionId.toString();

    let checkAnswer =
      question[i].quiz_correctAnswer === answer[i].answers_option;

    if (checkQuestionId && checkAnswer) {
      question[i].isCorrect = true;
    } else {
      question[i].isCorrect = false;
    }
    question[i].answers_option = answer[i].answers_option;
  }
};

module.exports = { getQuizQuestion, showAnswers };
