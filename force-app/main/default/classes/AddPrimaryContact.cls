public class AddPrimaryContact implements Queueable {
	private Contact c;
    private String state;
    public addPrimaryContact(Contact c, String state){
        this.c = c;
        this.state = state;
    }
    
    public void execute(QueueableContext context){
        List<Account> ac = [SELECT ID, Name, (SELECT id, FirstName, LastName FROM contacts) 
                            FROM Account WHERE BillingState =: state LIMIT 200];
        List<Contact> con = new List<Contact>();
        for(Account acc : ac){
            Contact cont = c.clone(false, false, false, false);
            cont.AccountId = acc.id;
            con.add(cont);
        }
        
        if(con.size() > 0){
            insert con;
        }
    }
}