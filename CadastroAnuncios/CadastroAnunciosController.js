({
	handleVoltar : function(component, event, helper) {
		
        component.set("v.step", 0);
	},  
    
    handleCancelar: function(component, event, helper) {
        
        $A.get("e.force:refreshView").fire(); 
	},
    
    handleBuscar: function(component, event, helper) {
        console.log('entrou buscar');
        helper.buscarAnuncio(component, event, helper);
	},
})