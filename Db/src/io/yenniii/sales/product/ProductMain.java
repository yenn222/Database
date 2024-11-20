package io.yenniii.sales.product;
import java.util.List;

public class ProductMain {
    public static void main(String[] args) {
        System.out.println("\n전체 상품 정보 검색하기\n");
        List<Product> productList = ProductService.selectAll();
        for (Product product : productList) {
            System.out.println(product);
        }

        //상품 검색하기
        System.out.println("\n 번호로 검색하기 - p03\n-----------");
        Product product = ProductService.selectByNo("p03");
        if(product == null) {
            System.out.println("상품이 없어요");
        } else {
            System.out.println(product);
        }

        //상품 추가하기
        System.out.println("\n 새로운 상품 추가하기 - p09 \n ----------------");
        if(ProductService.insert("p09", "맛있는떡볶이", 200, 3000, "한밭식품") > 0){
            product = ProductService.selectByNo("p09");
            if (product == null) {
                System.out.println("상품 추가에 실패했습니다");
            } else {
                System.out.println(product);
            }
        } else {
            System.out.println("p09 상품 추가에 실패했습니다.");
        }

        //상품 수정하기
        System.out.println("\n 상품 정보 수정하기 - p09 \n ----------------");
        if(ProductService.update("p09", 199) > 0 ){
            product = ProductService.selectByNo("p09");
            if (product != null) {
                System.out.println(product);
            } else {
                System.out.println("p09 not exist !!");
            }
        } else {
            System.out.println("p09 상품 수정에 실패했습니다.");
        }

        //상품 삭제하기
        System.out.println("\n 상품 정보 삭제하기 - p09 \n ----------------");
        if(ProductService.deleteByNo("p09") > 0){
            product = ProductService.selectByNo("p09");
            if (product != null) {
                System.out.println("상품 삭제에 실패했습니다");
            } else {
                System.out.println("상품 삭제에 성공했습니다");
            }
        } else {
            System.out.println("p09 상품 삭제에 실패했습니다.");
        }
    }
}
