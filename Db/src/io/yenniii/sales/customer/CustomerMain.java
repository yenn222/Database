package io.yenniii.sales.customer;

import java.util.List;

public class CustomerMain {
    public static void main(String[] args) {
        System.out.println("\n전체 고객 정보 검색하기\n");
        List<Customer> customerList = CustomerService.selectAll();
        for(Customer customer: customerList) {
            System.out.println(customer);
        }

        //아이디로 검색하기
        System.out.println("\n아이디로 검색하기 - banana\n-----------");
        Customer banana = CustomerService.selectById("apple");
        if(banana != null){
            System.out.println(banana);
        } else {
            System.out.println("apple not exist !!");
        }

        //새로운 고객 추가하기 -> 추가 확인 검색
        System.out.println("\n 새로운 고객 추가하기 - grape \n ----------------");
        if(CustomerService.insert("grape", "홍길동", 20, "gold", "대학생", 10000) > 0){
            Customer grape = CustomerService.selectById("grape");
            if (grape != null) {
                System.out.println(grape);
            } else {
                System.out.println("grape not exist !!");
            }
        } else {
            System.out.println("grape 고객 추가에 실패했습니다.");
        }

        //고객 정보 수정하기 -> 추가 확인 검색
        System.out.println("\n 고객 정보 수정하기 - grape \n ----------------");
        if(CustomerService.update("grape", 21, "vip", 20000) > 0){
            Customer grape = CustomerService.selectById("grape");
            if (grape != null) {
                System.out.println(grape);
            } else {
                System.out.println("grape not exist !!");
            }
        } else {
            System.out.println("grape 고객 수정에 실패했습니다.");
        }

        //고객 정보 삭제하기 -> 추가 확인 검색
        System.out.println("\n 고객 정보 삭제하기 - grape \n ----------------");
        if(CustomerService.deleteById("grape") > 0){
            Customer grape = CustomerService.selectById("grape");
            if (grape != null) {
                System.out.println("grape 고객 삭제에 실패했습니다. ");
            } else {
                System.out.println("grape 정보 삭제에 성공했습니다 !!");
            }
        } else {
            System.out.println("grape 고객 삭제에 실패했습니다.");
        }
    }
}