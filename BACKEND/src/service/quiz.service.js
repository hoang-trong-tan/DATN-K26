"use strict";

const { BadRequestError } = require("../core/error.response");
const { courseData } = require("../model/course.model");
const { quiz, questionQuiz, answersQuiz } = require("../model/quiz.model");
const {
  getQuizQuestion,
  showAnswers,
} = require("../model/repositories/quiz.repo");
const userModel = require("../model/user.model");

const createQuiz = async (quizTitle, courseDataId) => {
  const checkCouseData = await courseData.findById(courseDataId);

  if (!checkCouseData) {
    throw new BadRequestError("Course data is not exits");
  }

  const newQuiz = await quiz.create({
    quiz_Tile: quizTitle,
    courseData: courseDataId,
  });

  return newQuiz;
};

const createQuestionQuiz = async ({
  question,
  options,
  correctAnswer,
  quizId,
}) => {
  const checkQuiz = await quiz.findById(quizId);

  if (!checkQuiz) {
    throw new BadRequestError("Quiz is not exits");
  }

  const newQuestionQuiz = await questionQuiz.create({
    quiz_questions: question,
    quiz_options: options,
    quiz_correctAnswer: correctAnswer,
    quizId,
  });

  return newQuestionQuiz;
};

const checkIdQuiz = async (quizId, userId) => {
  const findAnswerUser = await answersQuiz.find({ userId }).populate("quizId");

  for (let i = 0; i < findAnswerUser.length; i++) {
    if (findAnswerUser[i].quizId._id.toString() === quizId) {
      return true;
    }
  }

  return false;
};

const createAnswerQuiz = async (payload, quizId, userId) => {
  const exitsAnswer = await checkIdQuiz(quizId, userId);

  if (exitsAnswer) {
    throw new BadRequestError("Only allowed to do it once");
  }

  const questions = payload.map((item) => ({
    ...item,
    quizId: quizId,
    userId: userId,
  }));

  const addOptions = await answersQuiz.insertMany(questions);

  return addOptions;
};

const printQuizQuestion = async (quizId, userId) => {
  const isTeacher = await userModel.findById(userId);

  let result;
  if (isTeacher.user_role.includes("teacher")) {
    result = await getQuizQuestion(quizId, [
      "quiz_questions",
      "quiz_options",
      "quiz_correctAnswer",
    ]);
  } else {
    result = await getQuizQuestion(quizId, ["quiz_questions", "quiz_options"]);
  }

  return result;
};

const getQuizBySectionId = async (sectionId) => {
  return await quiz.find({ courseData: sectionId });
};

const printResultQuestion = async (quizId, userId) => {
  return await showAnswers(quizId, userId, [
    "quiz_questions",
    "quiz_correctAnswer",
    "quiz_options",
  ]);
};

module.exports = {
  createQuiz,
  createQuestionQuiz,
  printQuizQuestion,
  createAnswerQuiz,
  printResultQuestion,
  checkIdQuiz,
  getQuizBySectionId,
};
