import { PayloadAction, createSlice } from "@reduxjs/toolkit";

const initialState = {
  token: "",
  user: "",
  avatar: "",
  role: "",
  course_bought: [""],
};

const authSlice = createSlice({
  name: "auth",
  initialState,
  reducers: {
    userRegistration: (state, action: PayloadAction<{ token: string }>) => {
      state.token = action.payload.token;
    },
    userLoggedIn: (
      state,
      action: PayloadAction<{
        accessToken: string;
        user: string;
        avatar: string;
        role: string;
        course_bought: string[];
      }>
    ) => {
      state.token = action.payload.accessToken;
      state.user = action.payload.user;
      state.avatar = action.payload.avatar;
      state.role = action.payload.role;
      state.course_bought = action.payload.course_bought;
    },
    userLoggedOut: (state) => {
      state.token = "";
      state.user = "";
      state.avatar = "";
      state.role = "";
      state.course_bought = [];
    },
  },
});

export const { userRegistration, userLoggedIn, userLoggedOut } =
  authSlice.actions;

export default authSlice.reducer;
