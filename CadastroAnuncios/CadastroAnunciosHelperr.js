({
	buscarAnuncio : function( component ) {
        
        var cliente = component.get('v.cliente');
        var dataInicio = component.get('v.dataInicio');
        var dataTermino = component.get('v.dataTermino');
        
        var action = component.get("c.realizarBusca");
        action.setParams({
                "cliente"  : cliente, 
                "dataInicio" : dataInicio,
                "dataTermino": dataTermino
        });
		
        console.log('buscar');
        action.setCallback(this, function( response ) {
            
             console.log('buscar ##########');
            var state = response.getState();
            var data = response.getReturnValue(); 
            
            console.log('data::');
            console.log( data.length );
            console.log( JSON.stringify(data));
            
            console.log('state::');
            console.log( state );
            
            if ( state === 'SUCCESS') {
                
                if(data != null){
                    console.log('if::');
                    component.set("v.step", 1);
                    component.set("v.lstAnuncio", data[0]);
                    
                } else {
                    component.set("v.step", 2);
                    component.set("v.mensgem", data.msg);
                }
                
            } else {
                
                alert('Ops. Algo deu errado tente novamente mais tarde.');
            }
        });
        $A.enqueueAction(action);
	}
})