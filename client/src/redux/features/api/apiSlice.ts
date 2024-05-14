import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";
import { userLoggedIn } from "../auth/authSlice";

export const apiSlice = createApi({
  reducerPath: "api",
  baseQuery: fetchBaseQuery({
    baseUrl: import.meta.env.VITE_API_URL,
    headers: {
      "x-client-id": localStorage.getItem("user_id") || "",
      "x-atoken-id": localStorage.getItem("access_token") || "",
    },
  }),
  endpoints: (builder) => ({
    refreshToken: builder.query({
      query: () => ({
        url: "refresh",
        method: "GET",
        credentials: "include" as const,
      }),
    }),
    loadUser: builder.query({
      query: () => ({
        url: "user/information",
        method: "GET",
        headers: {
          "x-client-id": localStorage.getItem("user_id") || "",
          "x-atoken-id": localStorage.getItem("access_token") || "",
        },
        // credentials: "include" as const,
      }),
      async onQueryStarted(_arg, { queryFulfilled, dispatch }) {
        try {
          const result = await queryFulfilled;
          dispatch(
            userLoggedIn({
              accessToken: localStorage.getItem("access_token") || "",
              user: result?.data?.data?._id || "",
              avatar: result?.data?.data?.user_avatar,
              role: result?.data?.data?.user_role,
            })
          );
        } catch (error: any) {
          const userId = localStorage.getItem("user_id");
          if (userId) {
            localStorage.clear();
          }
          console.log(error);
        }
      },
    }),
  }),
});

export const { useRefreshTokenQuery, useLoadUserQuery } = apiSlice;
