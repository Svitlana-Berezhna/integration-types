@IsTest
private class AccountManagerTest {
    @isTest static void testGetAccount() {
        Id recordId = createAccountTestRecord();
        RestRequest request = new RestRequest(); 
        request.requestUri =
            'https://brave-badger-3odavq-dev-ed.salesforce.com/services/apexrest/Accounts/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();
        System.assert(thisAccount != null);
        System.assertEquals('Test account record', thisAccount.Name);
    }
    
    static Id createAccountTestRecord() {
        Account accountTest = new Account(
            Name = 'Test account record',
            Rating = 'Hot');
        insert accountTest;
        return accountTest.Id;
    }          
}
