@isTest
private class AnimalLocatorTest {
    @isTest 
    static void testGetCallout() {             
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String actualValue = AnimalLocator.getAnimalNameById(1);     
        String expectedValue = 'chicken';
        System.assertNotEquals(null, actualValue, 'The callout returned a null response.');        
        System.assertEquals(actualValue, expectedValue, 'The actual value is not expected.');          
    }   
}
