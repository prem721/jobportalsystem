package com.jobportal.model;

public class Application {
    private int id;
    private int jobId;
    private String name;
    private String email;
    private String resume;

    public Application() {}
    public Application(int id, int jobId, String name, String email, String resume) {
        this.id = id;
        this.jobId = jobId;
        this.name = name;
        this.email = email;
        this.resume = resume;
    }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getJobId() { return jobId; }
    public void setJobId(int jobId) { this.jobId = jobId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getResume() { return resume; }
    public void setResume(String resume) { this.resume = resume; }
}