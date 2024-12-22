package Model;

import java.sql.Timestamp;

public class Attractions {

    private int id;                // 景点ID
    private String name;           // 景点名称
    private String description;    // 景点描述
    private String location;       // 景点位置
    private String imageUrl;       // 图片URL
    private Timestamp createdAt;   // 创建时间
    private Timestamp updatedAt;   // 更新时间
    private int likes;             // 点赞数
    private double ticketPrice;    // 门票价格

    // 默认构造函数
    public Attractions(int id, String name, String description, String location, String imageUrl, int likes, double ticketPrice) {}

    // 构造函数
    public Attractions(int id, String name, String description, String location, String imageUrl,
                       Timestamp createdAt, Timestamp updatedAt, int likes, double ticketPrice) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.location = location;
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.likes = likes;
        this.ticketPrice = ticketPrice;
    }

    // Getter 和 Setter 方法
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

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
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

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public double getTicketPrice() {
        return ticketPrice;
    }

    public void setTicketPrice(double ticketPrice) {
        this.ticketPrice = ticketPrice;
    }

    @Override
    public String toString() {
        return "Attractions{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", location='" + location + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", likes=" + likes +
                ", ticketPrice=" + ticketPrice +
                '}';
    }
}
