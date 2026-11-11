package entity;

public class Customer {
	private int customerID;
    private String customerName;
    private String phone;
    private String address;
    private String email;
    private String password;

    public Customer() {
    }

    public Customer(int customerID, String customerName, String phone, String address, String email, String password) {
        this.customerID = customerID;
        this.customerName = customerName;
        this.phone = phone;
        this.address = address;
        this.email = email;
        this.password = password;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    public String getName() {
        return customerName;
    }
}
