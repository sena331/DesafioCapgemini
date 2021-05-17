public class CadastroAnunciosController {
	
    public class Anuncio {
        //Classe wrraper para auxiliar no retorno para o componente aura;
        @AuraEnabled public String nomeAnuncio;
        @AuraEnabled public String investimento;
        @AuraEnabled public String visualizacoes;
        @AuraEnabled public String cliques;
        @AuraEnabled public String compartilhamentos;
        @AuraEnabled public String msg;
    }
    // metodo chamado pelo componente para bsucar os dados do anuncio;
    @AuraEnabled
    public static List<Anuncio> realizarBusca( String cliente, Date dataInicio, Date dataTermino){
        
        List<Anuncio__c> lstAnuncio = new List<Anuncio__c>();
        
        String nomeCliente = '%' + cliente + '%';
        Integer numeroDias = (dataInicio).daysBetween(dataTermino);
        numeroDias = ( numeroDias == 0) ? 1 : numeroDias;
            
        lstAnuncio = [ SELECT Name,Investimento__c, DataInicio__c, DataTerrmino__c FROM Anuncio__c
                     WHERE Cliente__r.Name Like : nomeCliente];
        
        System.debug('lstAnuncio:: ' + lstAnuncio.size());
        System.debug( lstAnuncio );
        List<Anuncio> lstAnuncioWrapper = new List<Anuncio>();
        
        Decimal totalVisualizacao;
        Decimal totalCompartilhamento;
        Decimal visuzalicaoPorComportilhamento;
        Decimal totalInvestido = 0;
        
        if ( lstAnuncio.size() > 0 ){
            for ( Anuncio__c a : lstAnuncio) {
                
                Anuncio anuncio = new Anuncio();
               
                anuncio.nomeAnuncio = a.Name;
                anuncio.investimento = String.valueOf(a.Investimento__c * numeroDias);
                totalVisualizacao = a.Investimento__c * 30;
                
                System.debug('totalVisualizacao:: ' + totalVisualizacao );
                
                visuzalicaoPorComportilhamento = calculaVisualizao( totalVisualizacao ); 
                
                System.debug('visuzalicaoPorComportilhamento:: ' + visuzalicaoPorComportilhamento );
                
                for ( Integer i=0; i <=3; i++) {
                    
                    totalVisualizacao += calculaVisualizao( visuzalicaoPorComportilhamento );        
                }
        
        		System.debug('@@@@@@@@@@@ totalVisualizacao:: ' + totalVisualizacao );
                
                anuncio.visualizacoes = String.valueOf(totalvisualizacao);
                anuncio.cliques = String.valueOf(( totalVisualizacao / 100 ) * 12);
                anuncio.compartilhamentos = String.valueOf(( Decimal.valueOf(anuncio.cliques) / 20)  * 3);
                anuncio.msg = 'Sucesso';
                
                lstAnuncioWrapper.add(anuncio);
            }
        } else {
            Anuncio anuncio = new Anuncio();
            anuncio.msg = 'Não foi encontrado dados para essa busca.';
            
            lstAnuncioWrapper.add(anuncio);
        }
        
       
        System.debug('lstAnuncioWrapperi:: ' + lstAnuncioWrapper );
        return lstAnuncioWrapper;
    }	
    

    // metodo auxiliar para calculo das visualizações, cliques e compartilhamentos
    public static Decimal calculaVisualizao( Decimal totalVisualizacao ){
        
        Decimal totalClick;
        Decimal totalCompartilhamento;
        
        totalClick = ( totalVisualizacao / 100 ) * 12;
        System.debug('@@@@@@@@@@@ totalClick:: ' + totalClick );
        
        totalCompartilhamento = ( totalClick / 20)  * 3;
        System.debug('@@@@@@@@@@@ totalCompartilhamento:: ' + totalCompartilhamento);
        
        return totalCompartilhamento * 40;
    }
}
