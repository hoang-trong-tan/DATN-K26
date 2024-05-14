import { PayloadAction, createSlice } from "@reduxjs/toolkit";

const initialState = {
  token: "",
  user: "",
  avatar: "",
  role: "",
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
      }>
    ) => {
      state.token = action.payload.accessToken;
      state.user = action.payload.user;
      state.avatar = action.payload.avatar;
      state.role = action.payload.role;
    },
    userLoggedOut: (state) => {
      state.token = "";
      state.user = "";
      state.avatar = "";
      state.role = "";
    },
  },
});

export const { userRegistration, userLoggedIn, userLoggedOut } =
  authSlice.actions;

export default authSlice.reducer;
