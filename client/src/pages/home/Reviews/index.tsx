import ReviewCard from "../../../components/ui/ReviewCard";
import { styles } from "../../../styles/style";
import BusinessImage from "../../../assets/business-img.png";
export const reviews = [
  {
    name: "Gene Bates",
    avatar: "https://randomuser.me/api/portraits/men/1.jpg",
    profession: "Student | Cambridge university",
    comment:
      "Tôi đã có cơ hội khám phá Becodemy, một trang web cung cấp một loạt các khóa học phong phú về các chủ đề liên quan đến công nghệ. Tôi hoàn toàn ấn tượng với trải nghiệm của mình, vì trang web cung cấp một lựa chọn khóa học toàn diện phù hợp với các cấp độ kỹ năng và sở thích khác nhau. Nếu bạn đang tìm cách nâng cao kiến thức và kỹ năng của mình trong ngành công nghệ, tôi rất khuyến khích bạn kiểm tra Becodemy!",
  },
  {
    name: "Verna Santos",
    avatar: "https://randomuser.me/api/portraits/women/1.jpg",
    profession: "Full stack developer | Quarter ltd.",
    comment:
      "Cảm ơn bạn về những lời khen ngợi tuyệt vời! Tôi rất vui khi biết bạn cảm thấy kênh hướng dẫn lập trình của tôi hữu ích và bạn đánh giá cao phong cách giảng dạy cũng như chất lượng của các bài hướng dẫn. Mục tiêu của tôi luôn là làm cho các chủ đề phức tạp trở nên dễ hiểu và cung cấp các ví dụ thực tế để củng cố kiến thức lý thuyết. Tôi rất vui khi bạn cho rằng các bài hướng dẫn này có giá trị và góp phần vào quá trình học của bạn. Sự ủng hộ và phản hồi của bạn đối với tôi rất quan trọng, và tôi cam kết tiếp tục cung cấp nội dung có giá trị. Cảm ơn bạn về sự động viên và vì đã là một phần của cộng đồng lập trình!",
  },
  {
    name: "Jay Gibbs",
    avatar: "https://randomuser.me/api/portraits/men/2.jpg",
    profession: "computer systems engineering student | Zimbabwe",
    comment:
      "Cảm ơn bạn về kênh hướng dẫn lập trình tuyệt vời của bạn! Phong cách giảng dạy của bạn rất xuất sắc và chất lượng của các bài hướng dẫn của bạn là hàng đầu. Khả năng phân tích các chủ đề phức tạp thành các phần quản lý và bao gồm nhiều ngôn ngữ lập trình và chủ đề đa dạng của bạn thực sự ấn tượng. Cách bạn tích hợp các ứng dụng thực tế và ví dụ trong thế giới thực củng cố kiến thức lý thuyết và cung cấp những hiểu biết quý báu. Sự tương tác của bạn với khán giả tạo ra một môi trường học tập hỗ trợ. Cảm ơn bạn về sự tận tụy, chuyên môn và đam mê của bạn trong việc giảng dạy lập trình, và tiếp tục công việc tuyệt vời của bạn!",
  },
  {
    name: "Mina Davidson",
    avatar: "https://randomuser.me/api/portraits/women/2.jpg",
    profession: "Junior Web Developer | Indonesia",
    comment:
      "Tôi đã có dịp khám phá Becodemy, một trang web cung cấp một loạt các khóa học về nhiều chủ đề liên quan đến công nghệ. Tôi rất ấn tượng với trải nghiệm của mình.",
  },
  {
    name: "Rosemary Smith",
    avatar: "https://randomuser.me/api/portraits/women/3.jpg",
    profession: "Full stack web developer | Algeria",
    comment:
      "Nội dung của bạn rất đặc biệt. Điều tôi thích nhất là video dài, điều này có nghĩa là chúng phủ sóng mọi thứ một cách chi tiết. Điều này giúp bất kỳ người mới bắt đầu nào cũng có thể hoàn thành một dự án tích hợp khi họ xem video. Cảm ơn bạn rất nhiều. Tôi rất háo hức chờ đợi các video tiếp theo. Hãy tiếp tục làm công việc tuyệt vời này!",
  },
  {
    name: "Laura Mckenzie",
    avatar: "https://randomuser.me/api/portraits/women/4.jpg",
    profession: "Full stack web developer | Canada",
    comment:
      "Hãy tham gia Becodemy! Becodemy tập trung vào ứng dụng thực tiễn hơn là chỉ dạy lý thuyết đằng sau ngôn ngữ lập trình hoặc các framework. Tôi đã tham gia một bài học về việc tạo ra một thị trường web bằng React JS, và nó đã rất hữu ích trong việc giảng dạy cho tôi các giai đoạn khác nhau trong quá trình tạo dự án từ đầu đến cuối. Tổng cộng, tôi rất khuyến khích Becodemy đối với bất kỳ ai đang tìm cách cải thiện kỹ năng lập trình của mình và xây dựng các dự án thực tế. Becodemy là một nguồn tài nguyên tuyệt vời sẽ giúp bạn đưa kỹ năng của mình lên một tầm cao mới.",
  },
];

const Reviews = () => {
  return (
    <div className="w-[90%] 800px:w-[85%] m-auto">
      <div className="w-full flex items-center">
        <div className="w-full">
          <img
            className="m-auto"
            src={BusinessImage}
            alt="business"
            width={700}
            height={700}
          />
        </div>
        <div className="800px:w-[50%] w-full">
          <h3 className={`${styles.title} text-[40px]`}>
          Học Sinh Của Chúng Tôi Là Sức Mạnh Của Chúng Tôi{" "}
            <span className="text-gradient_light">Của Chúng Tôi</span> <br /> See
            Họ Nói Gì Về Chúng Tôi
          </h3>
          <br />
          <p className={styles.label}>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eaque unde những điều tuyệt vời, 
            không có gì chịu đựng được, đau đớn vì nước, không thể lớn, chia sẻ phần sinh ra của cáo buộc các viên chức gần như không có gì đáng trách,
             trình bày thực sự, mong muốn của nỗi đau.
          </p>
        </div>
        <br />
        <br />
      </div>
      <div className="grid grid-cols-1 gap-[25px] md:grid-cols-2 md:gap-[25px] lg:grid-cols-2 lg:gap-[25px] xl:grid-cols-2 xl:gap-[35px] mb-12 border-0 md:[&>*:nth-child(3)]:!mt-[-60px] md:[&>*:nth-child(6)]:!mt-[-20px]">
        {reviews &&
          reviews.map((i, index) => <ReviewCard item={i} key={index} />)}
      </div>
    </div>
  );
};

export default Reviews;
