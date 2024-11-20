package io.yenniii.sales.customer;

import io.yenniii.conf.Conf;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerService {
    private static Customer setCustomer(ResultSet rs) throws SQLException {
        String customerId = rs.getString("customer_id");
        String customerName = rs.getString("customer_name");
        int age = rs.getInt("age");
        String grade = rs.getString("grade");
        String jobTitle = rs.getString("job_title");
        int savedMoney = rs.getInt("saved_money");

        return new Customer(customerId, customerName, age, grade, jobTitle, savedMoney);
    }


    public static List<Customer> selectAll() {
        ResultSet rs = null;
        PreparedStatement psmtQuery = null;

        List<Customer> customerList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD)) {

            String query = "SELECT * FROM customer";

            psmtQuery = conn.prepareStatement(query);

            rs = psmtQuery.executeQuery();

            while (rs.next()) {
                Customer customer = setCustomer(rs);
                customerList.add(customer);
            }
            return customerList;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;

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

    public static Customer selectById(final String customerId) {
        ResultSet rs = null;
        PreparedStatement psmtQuery = null;

        try (Connection conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD)) {

            String query = "SELECT * FROM customer WHERE customer_id = ?";

            psmtQuery = conn.prepareStatement(query);
            psmtQuery.setString(1, customerId);
            rs = psmtQuery.executeQuery();

            if (rs.next()) {
                Customer customer = setCustomer(rs);
                return customer;
            }
            return null;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;

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
    public static int insert(String customerId, String customerName, int age, String grade, String jobTitle, int savedMoney) {
        ResultSet rs = null;
        PreparedStatement psmtQuery = null;
        PreparedStatement psmtUpdate = null;


        try (Connection conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD)) {
            String query = "SELECT * FROM customer WHERE customer_id = ?";
            psmtQuery = conn.prepareStatement(query);
            psmtQuery.setString(1, customerId);
            rs = psmtQuery.executeQuery();

            if (!rs.next()) {
                String insertStatement =
                        //두 줄로 구성 시, 줄 사이에 공백을 두어야함.
                        " INSERT INTO customer(customer_id, customer_name, age, grade, job_title, saved_money) "
                                + "VALUES (?, ?, ?, ?, ?, ?)";
                psmtUpdate = conn.prepareStatement(insertStatement);
                psmtUpdate.setString(1, customerId);
                psmtUpdate.setString(2, customerName);
                psmtUpdate.setInt(3, age);
                psmtUpdate.setString(4, grade);
                psmtUpdate.setString(5, jobTitle);
                psmtUpdate.setInt(6, savedMoney);
                //결과 집합이 return되지 않는 executeUpdate()
                //영향받는 행의 개수가 return됨
                return psmtUpdate.executeUpdate();

            } else {
                return 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;

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
    public static int update(String customerId, int age, String grade, int savedMoney) {
        ResultSet rs = null;
        PreparedStatement psmtQuery = null;
        PreparedStatement psmtUpdate = null;


        try (Connection conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD)) {
            String query = "SELECT * FROM customer WHERE customer_id = ?";
            psmtQuery = conn.prepareStatement(query);
            psmtQuery.setString(1, customerId);
            rs = psmtQuery.executeQuery();

            if (rs.next()) {
                String updateStatement =
                        "UPDATE customer " +
                        "   SET age = ?, grade = ?, saved_money = ? " +
                        " WHERE customer_id = ?";
                psmtUpdate = conn.prepareStatement(updateStatement);
                psmtUpdate.setInt(1, age);
                psmtUpdate.setString(2, grade);
                psmtUpdate.setInt(3, savedMoney);
                psmtUpdate.setString(4, customerId);

                //결과 집합이 return되지 않는 executeUpdate()
                //영향받는 행의 개수가 return됨
                return psmtUpdate.executeUpdate();

            } else {
                return 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;

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
    public static int deleteById(String customerId) {
        ResultSet rs = null;
        PreparedStatement psmtQuery = null;
        PreparedStatement psmtUpdate = null;


        try (Connection conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD)) {
            String query = "SELECT * FROM customer WHERE customer_id = ?";
            psmtQuery = conn.prepareStatement(query);
            psmtQuery.setString(1, customerId);
            rs = psmtQuery.executeQuery();

            if (rs.next()) {
                String deleteStatement =
                        "DELETE FROM customer WHERE customer_id = ?";
                psmtUpdate = conn.prepareStatement(deleteStatement);
                psmtUpdate.setString(1, customerId);
                return psmtUpdate.executeUpdate();

            } else {
                return 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return 0;

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


