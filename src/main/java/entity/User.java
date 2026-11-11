package entity;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String address;

    public User() {}

    // Constructor CŨ (Giữ lại để các DAO cũ không bị lỗi)
    public User(int id, String name, String email, String password) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
    }

    // Constructor MỚI (Nếu có query đủ thông tin)
    public User(int id, String name, String email, String password, String phone, String address) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    // Phương thức EL trong JSP gọi (${sessionScope.currentUser.phone})
    public String getPhone() { 
        return phone != null ? phone : ""; 
    }
    public void setPhone(String phone) { this.phone = phone; }

    // Phương thức EL trong JSP gọi (${sessionScope.currentUser.address})
    public String getAddress() { 
        return address != null ? address : ""; 
    }
    public void setAddress(String address) { this.address = address; }

    public String getCustomerName() { return name; }
}