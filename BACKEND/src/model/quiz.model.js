"use strict";

const { Schema, model } = require("mongoose");

const DOCUMENT_NAME = "Quiz";

const COLLECTION_NAME = "Quizes";

const answersQuizShema = new Schema(
  {
    questionId: {
      type: Schema.Types.ObjectId,
      ref: "QuestionQuiz",
    },
    answers_option: {
      type: Number,
      required: true,
      min: 0,
      max: 2,
    },
    quizId: {
      type: Schema.Types.ObjectId,
      ref: "Quiz",
    },
    userId: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
  },
  {
    collection: "AnswerQuizes",
    timestamps: true,
  }
);

const questionQuizShema = new Schema(
  {
    quiz_questions: {
      type: String,
    },
    quiz_options: [String],
    quizId: {
      type: Schema.Types.ObjectId,
      ref: "Quiz",
    },
    quiz_correctAnswer: Number,
  },
  {
    collection: "QuestionQuizes",
    timestamps: true,
  }
);

const quizShema = new Schema(
  {
    quiz_Tile: {
      type: String,
    },
    courseData: {
      type: Schema.Types.ObjectId,
      ref: "CourseData",
    },
  },
  {
    collection: COLLECTION_NAME,
    timestamps: true,
  }
);

module.exports = {
  quiz: model(DOCUMENT_NAME, quizShema),
  questionQuiz: model("QuestionQuiz", questionQuizShema),
  answersQuiz: model("AnswerQuiz", answersQuizShema),
};
