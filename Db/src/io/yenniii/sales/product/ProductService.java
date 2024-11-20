package io.yenniii.sales.product;

import io.yenniii.conf.Conf;
import io.yenniii.sales.customer.Customer;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductService {
    private static Product setProduct(ResultSet rs) throws SQLException {
        String productNo = rs.getString("product_no");
        String productName = rs.getString("product_name");
        int stock = rs.getInt("stock");
        int unitPrice = rs.getInt("unit_price");
        String manufacturer = rs.getString("manufacturer");

        return new Product(productNo, productName, stock, unitPrice, manufacturer);
    }

    public static List<Product> selectAll() {
        ResultSet rs = null;
        PreparedStatement psmtQuery = null;

        List<Product> productList = new ArrayList<>();

        try (Connection conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD)) {

            String query = "SELECT * FROM product";

            psmtQuery = conn.prepareStatement(query);

            rs = psmtQuery.executeQuery();

            while (rs.next()) {
                Product product = setProduct(rs);
                productList.add(product);
            }
            return productList;

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

    public static Product selectByNo(final String productNo) {
        ResultSet rs = null;
        PreparedStatement psmtQuery = null;

        try (Connection conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD)) {

            String query = "SELECT * FROM product WHERE product_no = ?";

            psmtQuery = conn.prepareStatement(query);
            psmtQuery.setString(1, productNo);
            rs = psmtQuery.executeQuery();

            if (rs.next()) {
                Product product = setProduct(rs);
                return product;
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

    public static int insert(String productNo, String productName, int stock, int unitPrice, String manufacturer) {
        ResultSet rs = null;
        PreparedStatement psmtQuery = null;
        PreparedStatement psmtUpdate = null;


        try (Connection conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD)) {
            String query = "SELECT * FROM product WHERE product_no = ?";
            psmtQuery = conn.prepareStatement(query);
            psmtQuery.setString(1, productNo);
            rs = psmtQuery.executeQuery();

            if (!rs.next()) {
                String insertStatement =
                        //두 줄로 구성 시, 줄 사이에 공백을 두어야함.
                        " INSERT INTO product(product_no, product_name, stock, unit_price, manufacturer) "
                                + "VALUES (?, ?, ?, ?, ?)";
                psmtUpdate = conn.prepareStatement(insertStatement);
                psmtUpdate.setString(1, productNo);
                psmtUpdate.setString(2, productName);
                psmtUpdate.setInt(3, stock);
                psmtUpdate.setInt(4, unitPrice);
                psmtUpdate.setString(5, manufacturer);
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

    public static int update(String productNo, int stock) {
        ResultSet rs = null;
        PreparedStatement psmtQuery = null;
        PreparedStatement psmtUpdate = null;


        try (Connection conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD)) {
            String query = "SELECT * FROM product WHERE product_no = ?";
            psmtQuery = conn.prepareStatement(query);
            psmtQuery.setString(1, productNo);
            rs = psmtQuery.executeQuery();

            if (rs.next()) {
                String updateStatement =
                        "UPDATE product " +
                                "   SET stock = ? " +
                                " WHERE product_no = ?";
                psmtUpdate = conn.prepareStatement(updateStatement);
                psmtUpdate.setInt(1, stock);
                psmtUpdate.setString(2, productNo);

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

    public static int deleteByNo(String productNo) {
        ResultSet rs = null;
        PreparedStatement psmtQuery = null;
        PreparedStatement psmtUpdate = null;


        try (Connection conn = DriverManager.getConnection(Conf.DB_URL, Conf.DB_USER, Conf.DB_PASSWORD)) {
            String query = "SELECT * FROM product WHERE product_no = ?";
            psmtQuery = conn.prepareStatement(query);
            psmtQuery.setString(1, productNo);
            rs = psmtQuery.executeQuery();

            if (rs.next()) {
                String deleteStatement =
                        "DELETE FROM product WHERE product_no = ?";
                psmtUpdate = conn.prepareStatement(deleteStatement);
                psmtUpdate.setString(1, productNo);
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

