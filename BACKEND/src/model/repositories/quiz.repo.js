"use strict";

const { questionQuiz, answersQuiz, quiz } = require("../../model/quiz.model");

const getQuizQuestion = async (quizId, select) => {
  return await questionQuiz.find({ quizId }).select(select).lean();
};

const showAnswers = async (quizId, userId, select) => {
  const printResults = await questionQuiz
    .find({ quizId })
    .select(select)
    .lean()
    .exec();

  const findAnswerQuizes = await answersQuiz.find({ quizId, userId }).lean();

  checkAnswer(printResults, findAnswerQuizes);

  const filterIsCorrect = printResults.map((item) => item.isCorrect);

  const scores = calcutalQuizScores(filterIsCorrect);

  return { quiz_scores: scores, printResults };
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

const calcutalQuizScores = (options) => {
  const questionPoint = (10 / options.length).toFixed(2);

  let pointCorrect = 0;
  let count = 0;
  for (let i = 0; i < options.length; i++) {
    if (options[i]) {
      count++;
    }
  }
  pointCorrect = count * questionPoint;
  return pointCorrect;
};

module.exports = { getQuizQuestion, showAnswers };
