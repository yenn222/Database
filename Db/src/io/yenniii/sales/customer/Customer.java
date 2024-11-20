package io.yenniii.sales.customer;

public class Customer {
    // camel 표기법
    private String customerId;
    private String customerName;
    private int age;
    private String grade;
    private String jobTitle;
    private int savedMoney;

    public Customer(final String customerId, final String customerName, final int age, final String grade, final String jobTitle, final int savedMoney) {
        this.customerId = customerId;
        this.customerName = customerName;
        this.age = age;
        this.grade = grade;
        this.jobTitle = jobTitle;
        this.savedMoney = savedMoney;
    }

    public String getCustomerId() {
        return customerId;
    }

    public int getSavedMoney() {
        return savedMoney;
    }

    public String getCustomerName() {
        return customerName;
    }

    public int getAge() {
        return age;
    }

    public String getGrade() {
        return grade;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    @Override
    public String toString() {
        return "Customer { " +
                "customerId = " + customerId +
                ", customerName = " + customerName +
                ", age = " + age +
                ", grade = " + grade +
                ", jobTitle = " + jobTitle +
                ", savedMoney = " + savedMoney +
                '}';
    }
}
