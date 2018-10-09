package com.sparktg.contracts;

public class Technician {
    private int id;
    private int technicianId;
    private String technicianName;
    private String technicianNumber;

    public int getId() {
       return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public int getTechnicianId() {
        return technicianId;
    }

    public void setTechnicianId(int technicianId) {
        this.technicianId = technicianId;
    }

    public String getTechnicianName(){
        return technicianName;
    }

    public void setTechnicianName(String technicianName) {
        this.technicianName = technicianName;
    }

    public String getTechnicianNumber(){
        return technicianNumber;
    }

    public void setTechnicianNumber(String technicianNumber) {
        this.technicianNumber = technicianNumber;
    }
}
