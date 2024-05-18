import { apiSlice } from "../api/apiSlice";

export const uploadApi = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    uploadImage: builder.mutation({
      query: (formData) => ({
        url: "upload-images",
        method: "POST",
        headers: {
          "x-client-id": localStorage.getItem("user_id") || "",
          "x-atoken-id": localStorage.getItem("access_token") || "",
        },
        body: formData,
      }),
    }),
    uploadVideo: builder.mutation({
      query: (formData) => ({
        url: "upload-video",
        method: "POST",
        headers: {
          "x-client-id": localStorage.getItem("user_id") || "",
          "x-atoken-id": localStorage.getItem("access_token") || "",
        },
        body: formData,
      }),
    }),
  }),
});

export const { useUploadImageMutation, useUploadVideoMutation } = uploadApi;
