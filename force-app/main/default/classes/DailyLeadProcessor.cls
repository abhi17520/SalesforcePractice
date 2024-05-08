public class DailyLeadProcessor implements schedulable {
    public void execute(SchedulableContext context){
        List<Lead> updateLead = new List<Lead>();
        List<Lead> leads = [SELECT id FROM Lead WHERE LeadSource = Null LIMIT 200];
        for(Lead l: leads){
            l.LeadSource = 'Dreamforce';
            updateLead.add(l);
        }
        update updateLead;
    }
}