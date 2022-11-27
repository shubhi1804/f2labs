({

    captureProjectScope: function (component) {
        var action = component.get("c.getFieldRecordFromProject");
        var recId =  component.get("v.recordId");
       
        action.setParams({"recordId": recId});
        action.setCallback(this, function(a) {
            component.set("v.servicesList", a.getReturnValue());
        });
        $A.enqueueAction(action);
    }
})