@isTest
private  class CadastroAnunciosControllerTest {    
    @isTest
    static void anunciosTest(){
        
        Account conta = new Account( Name =  'teste');
        insert conta;
        
        Anuncio__c anuncio = new Anuncio__c ( Name='primeiro', Cliente__c = conta.Id, DataInicio__c = System.today(), DataTerrmino__c = System.today(), Investimento__c = 10);
        insert anuncio;
        
        Date dataInicio = System.today();
		Date dataTermino = System.today();
        
        List<CadastroAnunciosController.Anuncio> result = new List<CadastroAnunciosController.Anuncio>();

        Test.startTest();
        result = CadastroAnunciosController.realizarBusca(conta.Name, dataInicio, dataTermino);
        System.assertEquals(result[0].msg, 'Sucesso');
        Test.stopTest();
        
    }

}