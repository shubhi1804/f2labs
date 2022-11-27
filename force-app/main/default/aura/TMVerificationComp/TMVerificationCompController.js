({
    loadOptions: function (component, event, helper) {
        helper.captureProjectScope(component);
    },
    
    handleChange : function (component, event, helper){
        const selectedOption = event.detail.value;
        var currentLabel =  this.loadOptions.filter(function(option) {
            return option.value == selectedOption;
        })
        
        },
    
    handleClick : function (component, event, helper){
  
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "Sent for TM Verification"
        });
        toastEvent.fire();
        
    }
})