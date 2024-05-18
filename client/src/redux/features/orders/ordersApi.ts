import { apiSlice } from "../api/apiSlice";

export const ordersApi = apiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getAllOrders: builder.query({
      query: () => ({
        url: `get-orders`,
        method: "GET",
        credentials: "include" as const,
      }),
    }),
    getStripePublishablekey: builder.query({
      query: () => ({
        url: `payment/stripepublishablekey`,
        method: "GET",
        credentials: "include" as const,
      }),
    }),
    createPaymentIntent: builder.mutation({
      query: (amount) => ({
        url: "payment",
        method: "POST",
        body: {
          amount,
        },
        credentials: "include" as const,
      }),
    }),
    createOrder: builder.mutation({
      query: (courseId) => ({
        url: `create-order/payment/create_payment_url/${courseId}`,
        method: "POST",
      }),
    }),
  }),
});

export const {
  useGetAllOrdersQuery,
  useGetStripePublishablekeyQuery,
  useCreatePaymentIntentMutation,
  useCreateOrderMutation,
} = ordersApi;
