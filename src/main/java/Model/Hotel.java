package Model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Hotel {

    private int id;
    private String name;
    private String description;
    private String location;
    private String contactPhone;
    private String email;
    private String imageUrl;
    private BigDecimal pricePerNight;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Hotel() {
    }
    // 构造方法
    public Hotel(int id, String name, String description, String location, String contactPhone, String email, String imageUrl, BigDecimal pricePerNight, Timestamp createdAt, Timestamp updatedAt) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.location = location;
        this.contactPhone = contactPhone;
        this.email = email;
        this.imageUrl = imageUrl;
        this.pricePerNight = pricePerNight;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters 和 Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getContactPhone() {
        return contactPhone;
    }

    public void setContactPhone(String contactPhone) {
        this.contactPhone = contactPhone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public BigDecimal getPricePerNight() {
        return pricePerNight;
    }

    public void setPricePerNight(BigDecimal pricePerNight) {
        this.pricePerNight = pricePerNight;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
