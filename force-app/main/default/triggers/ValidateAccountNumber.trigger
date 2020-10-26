trigger ValidateAccountNumber on Account(before update) {
  for (Account account : Trigger.new) {
    Boolean validateNumber = false;

    String accountType = account.Type;
    accountType = (accountType.endsWith('Partner')) ? 'PARTNER' : accountType;
    accountType = (accountType.startsWith('Customer'))
      ? 'CUSTOMER'
      : accountType;

    switch on accountType {
      when 'CPF' {
        validateNumber = Utils.ValidaCPF(account.AccountNumber);
      }
      when 'CNPJ' {
        validateNumber = Utils.ValidaCNPJ(account.AccountNumber);
      }
      when 'PARTNER' {
        validateNumber = true;

        List<String> oppNameList = new List<String>{
          account.Name,
          'opp Parceiro'
        };
        String oppName = String.join(oppNameList, ' - ');

        Opportunity opportunity = new Opportunity();
        opportunity.AccountId = account.Id;
        opportunity.Name = oppName;
        opportunity.CloseDate = date.today().addDays(30);
        opportunity.StageName = 'Qualification';

        Database.insert(opportunity);
      }
      when 'CUSTOMER' {
        validateNumber = true;

        Task task = new Task();
        task.WhatId = account.Id;
        task.Subject = 'Consumidor final';
        task.Status = 'Not Started';
        task.Priority = 'Normal';

        Database.insert(task);
      }
      when else {
        validateNumber = true;
      }
    }

    if (!validateNumber) {
      account.addError('Número do cliente é inválido');
    }
  }
}
