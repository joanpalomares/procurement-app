const { error } = require('@sap/cds');
const { insert } = require('@sap/cds');
const cds = require('@sap/cds');
const { message } = require('@sap/cds/lib/log/cds-error');
const { rewrite } = require('@sap/cds/libx/_runtime/db/generic');
const { employee } = cds.entities("procurement.db.master");

const NewCQLService = function (srv) {
    // read data from employee table
    srv.on("READ", "readEmployee", async (req, res) => {
        var results = [];

        // option 1
        results = await SELECT.from(employee)

        // option 2
        // let query = SELECT.from (employee);
        // let employees = await cds.db.run(query)
        // return employees


        // with where
        // results = await SELECT.from (employee) .where({"salaryAmount": "55,000"})

        return results;
    })

    // insert employee data
    srv.on("CREATE", "insertEmployee", async (req) => {
        try {
            const result = await cds.transaction(req).run(
                INSERT.into(employee).entries(req.data)  
            );

            // Check if the insertion was successful
            if (result) {
                return req.data; 
            } else {
                throw req.error(500, "There was an error inserting the record.");
            }
        } catch (err) {
            throw req.error(500, "An error occurred: " + err.message);
        }
    });
}


module.exports = NewCQLService;