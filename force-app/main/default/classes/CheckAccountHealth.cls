global class CheckAccountHealth implements Schedulable {
  global void execute(SchedulableContext ctx) {
    Date taskPeriod = Date.today().addDays(-90);
    Date oppPeriod = Date.today().addDays(-120);

    Set<String> accountIds = new Set<String>();

    List<Task> tasks = [
      SELECT AccountId
      FROM Task
      WHERE CreatedDate < :taskPeriod
    ];

    List<Opportunity> opportunities = [
      SELECT AccountId
      FROM Opportunity
      WHERE
        (IsClosed = FALSE
        AND CreatedDate < :oppPeriod)
        OR (IsClosed = TRUE
        AND CloseDate < :oppPeriod)
    ];

    for (Task t : tasks) {
      accountIds.add(t.AccountId);
    }

    for (Opportunity o : opportunities) {
      accountIds.add(o.AccountId);
    }

    for (Account acc : [
      SELECT Inativa__c
      FROM Account
      WHERE Id IN :accountIds
    ]) {
      acc.Inativa__c = true;
      Database.update(acc);
    }

    CheckAccountHealth reminder = new CheckAccountHealth();
    String sch = '0 0 6 ? * MON-FRI';
    String jobID = System.schedule('Everis Challenge Schedule', sch, reminder);
  }
}
