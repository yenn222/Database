package io.yenniii.sales;

import io.yenniii.conf.Conf;

import java.sql.*;

public class SelectCustomer {

    public static void main(String[] args) {
        //자바에서 많이쓰는 약자 rs
        ResultSet rs = null;
        PreparedStatement psmtQuery = null; //전달하기 위한 SQl 문장을 담을 곳

        // 데이터베이스의 연결을 설정한 후 연결 정보를 가져옴. 주소 정보, 사용자 ID, 사용자 암호 필요.
        //try-catch 예외처리문. try with resource
        // 연결 정보를 계속해서 담을 conn 변수
        try (Connection conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD)) {

            // 전체 고객 정보 검색문
//            String query = "SELECT * FROM customer"; // "" 안에 세미콜론 들어가지 않도록할 것.

            // vip 고객에 대한 정보를 검색해서 출력하도록 수정하시오.
            String query = "SELECT * FROM customer WHERE grade = 'vip'"; // "" 안에 세미콜론 들어가지 않도록할 것.

            // Statement를 가져온다.
            // 전달할 문장을 준비해주세요!
            psmtQuery = conn.prepareStatement(query);

            // SQL문을 실행한다.
            // rs : 검색 결과 집합
            rs = psmtQuery.executeQuery();

            // 결과 집합의 내용을 출력한다.
            while (rs.next()) { // 결과 집합으로부터 각 레코드(튜블을) 가져온다
                // TODO 고객 정보의 각 속성을 Get하는 문장들 완성
                String customerId = rs.getString("customer_id"); //속성 이름을 쓰는 것을 추천. 숫자는 권장하지 않음.
                String customerName = rs.getString("customer_name");
                int age = rs.getInt("age");
                String grade = rs.getString("grade");
                String jobTitle = rs.getString("job_title");
                int savedMoney = rs.getInt("saved_money");

                System.out.printf("%-12s : %3s : %3d : %-6s : %-3s : %5d %n", customerId, customerName, age, grade,
                        jobTitle, savedMoney);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        //예외가 발생하든 말든 실행됨.
        } finally {
            if (psmtQuery != null) {
                try {
                    psmtQuery.close();
                } catch (SQLException e) {
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                }
            }
        }
    }
}