@IsTest
private class AccountManagerTest {
    @isTest static void testGetAccountById() {
        Id recordId = createAccountTestRecord();
        RestRequest request = new RestRequest(); 
        request.requestUri =
            'https://brave-badger-3odavq-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccountById();
        System.assert(thisAccount != null);
        System.assertEquals('Test account record', thisAccount.Name);
    }
    
    @isTest static void testCreateAccount() {
        ID thisAccountId = AccountManager.createAccount(
            'Test Account', 'Hot');
        System.assert(thisAccountId != null);
        Account thisAccount = [SELECT Id, Name, Rating FROM Account WHERE Id =: thisAccountId];
        System.assert(thisAccount != null);
        System.assertEquals(thisAccount.Name, 'Test Account');
    }
    
    @isTest static void testDeleteAccount() {
        Id recordId = createAccountTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://brave-badger-3odavq-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        AccountManager.deleteAccount();
        List<Account> accounts = [SELECT Id FROM Account WHERE Id=:recordId];
        System.assert(accounts.size() == 0);
    }
    
    @isTest static void testUpsertAccount() {
        ID account1Id = AccountManager.upsertAccount(
            null, 'Test Account', 'Hot');
        System.assert(account1Id != null);
        Account account1 = [SELECT Id, Name, Rating FROM Account WHERE Id = :account1Id];
        System.assert(account1 != null);
        System.assertEquals(account1.Name, 'Test Account');
        ID account2Id = AccountManager.upsertAccount(
            account1Id, 'Test Account', 'Warm');
        System.assertEquals(account1Id, account2Id);
        Account account2 = [SELECT Id, Name, Rating FROM Account WHERE Id =: account2Id];
        System.assert(account2 != null);
        System.assertEquals(account2.Rating, 'Warm');
    } 
    
    @isTest static void testUpdateAccountFields() {
        Id recordId = createAccountTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://brave-badger-3odavq-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + recordId;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"rating": "Hot"}');
        RestContext.request = request;        
        ID thisAccountId = AccountManager.updateAccountFields();
        System.assert(thisAccountId != null);
        Account thisAccount = [SELECT Id, Name, Rating FROM Account WHERE Id =: thisAccountId];
        System.assert(thisAccount != null);
        System.assertEquals(thisAccount.Rating, 'Hot');
    } 
    
    static Id createAccountTestRecord() {
        Account accountTest = new Account(
            Name = 'Test account record',
            Rating = 'Hot');
        insert accountTest;
        return accountTest.Id;
    }          
}
