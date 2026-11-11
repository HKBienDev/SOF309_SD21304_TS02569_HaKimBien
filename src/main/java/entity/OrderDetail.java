package entity;

public class OrderDetail {
	private int orderID;
	private int productID;
	private int quantity;
	private double unitPrice;
	private String status;
	private Product product;

	// --- BỔ SUNG 2 THUỘC TÍNH MỚI NÀY ---
	private String productName;
	private String customerName;

	public OrderDetail() {
	}

	public int getOrderID() {
		return orderID;
	}

	public void setOrderID(int orderID) {
		this.orderID = orderID;
	}

	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	// --- GETTER VÀ SETTER CHO PRODUCT NAME ---
	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	// --- GETTER VÀ SETTER CHO CUSTOMER NAME ---
	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	
	public Product getProduct() {
	    return product;
	}

	public void setProduct(Product product) {
	    this.product = product;
	}
}