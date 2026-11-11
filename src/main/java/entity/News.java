package entity;

import java.sql.Timestamp;

public class News {
	 private Integer id;
	    private String title;
	    private String summary;
	    private String content;
	    private String image;
	    private Timestamp createdDate;

	    public Integer getId() { return id; }
	    public void setId(Integer id) { this.id = id; }

	    public String getTitle() { return title; }
	    public void setTitle(String title) { this.title = title; }

	    public String getSummary() { return summary; }
	    public void setSummary(String summary) { this.summary = summary; }

	    public String getContent() { return content; }
	    public void setContent(String content) { this.content = content; }

	    public String getImage() { return image; }
	    public void setImage(String image) { this.image = image; }

	    public Timestamp getCreatedDate() { return createdDate; }
	    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }
	}
