package Model;

import java.sql.Timestamp;

public class Report {
    private int reportId;       // 举报ID
    private int attractionId;   // 景点ID
    private int commentId;      // 评论ID
    private String username;         // 举报用户名
    private String reason;      // 举报原因
    private Timestamp reportTime; // 举报时间
    private String status;      // 举报状态

    // 构造方法
    public Report(int reportId, int attractionId, int commentId, String username, String reason, Timestamp reportTime, String status) {
        this.reportId = reportId;
        this.attractionId = attractionId;
        this.commentId = commentId;
        this.username = username;
        this.reason = reason;
        this.reportTime = reportTime;
        this.status = status;
    }

    // Getter 和 Setter 方法
    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getAttractionId() {
        return attractionId;
    }

    public void setAttractionId(int attractionId) {
        this.attractionId = attractionId;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Timestamp getReportTime() {
        return reportTime;
    }

    public void setReportTime(Timestamp reportTime) {
        this.reportTime = reportTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // 重写 toString 方法，方便调试和日志记录
    @Override
    public String toString() {
        return "Report{" +
                "reportId=" + reportId +
                ", attractionId=" + attractionId +
                ", commentId=" + commentId +
                ", username=" + username +
                ", reason='" + reason + '\'' +
                ", reportTime=" + reportTime +
                ", status='" + status + '\'' +
                '}';
    }
}
