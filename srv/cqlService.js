const cds = require('@sap/cds');
const {employee} = cds.entities("procurement.db.master");

const NewCQLService= function(srv){
    // read data from employee table
    srv.on("READ", "readEmployee", async(req, res)=>{
        var results = [];
        results = await cds.tx(req).run(SELECT.from(employee))

        return results;
    })
}

module.exports=NewCQLService;