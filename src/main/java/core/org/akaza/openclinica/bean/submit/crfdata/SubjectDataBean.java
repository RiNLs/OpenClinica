package core.org.akaza.openclinica.bean.submit.crfdata;

import java.util.ArrayList;

import core.org.akaza.openclinica.bean.odmbeans.AuditLogsBean;
import core.org.akaza.openclinica.bean.odmbeans.DiscrepancyNotesBean;

public class SubjectDataBean {
    private String studySubjectID;
    private ArrayList<StudyEventDataBean> studyEventData;
    private String subjectOID;
    private AuditLogsBean auditLogs;
    private DiscrepancyNotesBean discrepancyNotes;
    
    public SubjectDataBean() {
        studyEventData = new ArrayList<StudyEventDataBean>();
        auditLogs = new AuditLogsBean();
        discrepancyNotes = new DiscrepancyNotesBean();
    }

    public String getSubjectOID() {
        return subjectOID;
    }

    public void setSubjectOID(String subjectOID) {
        this.subjectOID = subjectOID;
    }

    public ArrayList<StudyEventDataBean> getStudyEventData() {
        return studyEventData;
    }

    public void setStudyEventData(ArrayList<StudyEventDataBean> studyEventData) {
        this.studyEventData = studyEventData;
    }
    
    public AuditLogsBean getAuditLogs() {
        return auditLogs;
    }

    public void setAuditLogs(AuditLogsBean auditLogs) {
        this.auditLogs = auditLogs;
    }

    public DiscrepancyNotesBean getDiscrepancyNotes() {
        return discrepancyNotes;
    }

    public void setDiscrepancyNotes(DiscrepancyNotesBean discrepancyNotes) {
        this.discrepancyNotes = discrepancyNotes;
    }

    public String getStudySubjectID() {
        return studySubjectID;
    }

    public void setStudySubjectID(String studySubjectID) {
        this.studySubjectID = studySubjectID;
    }
}
