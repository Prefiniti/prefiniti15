component output=false extends="Prefiniti.LegacyAPI" displayname="Base" {

    public numeric function getPercentage(numeric given, numeric max) output=false {
        return int((given * 100) / max);
    }

    public void function validateStruct(required struct s, required array r) output=false {

        for(i in r) {
            if(!s.keyExists(i)) {
                throw("The struct is missing required key " & i, "Error" , "Required keys are " & arguments.r.toList(", "));
            }
        }

    }

}