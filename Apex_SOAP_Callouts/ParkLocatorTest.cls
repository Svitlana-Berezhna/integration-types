@isTest
private class ParkLocatorTest {
    @isTest static void testCallout() {              
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        String[] actualValue = ParkLocator.country('Germany');
        String[] expectedValue = new String[]{'Hamburg Wadden Sea National Park', 
            								  'Hainich National Park', 
          									  'Bavarian Forest National Park'};
        System.assertNotEquals(null, actualValue, 'The callout returned a null response.');        
        System.assertEquals(expectedValue, actualValue, 'The actual value is not expected.');    
    }
}
