const { error } = require('@sap/cds');
const { insert } = require('@sap/cds');
const cds = require('@sap/cds');
const { data } = require('@sap/cds/lib/dbs/cds-deploy');
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
            let result = await INSERT.into(employee).entries(req.data);

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


    // update table records
    srv.on("UPDATE", "updateEmployee", async (req) => {
        try {
            let returnData = await cds.transaction(req).run(
                UPDATE(employee)
                    .set({
                        firstName: req.data.firstName,
                        lastName: req.data.lastName
                    }).where({ ID: req.data.ID })
            );

            if (returnData) {
                return req.data;
            } else {
                throw req.error(500, "There was an error updating the record.");
            }
        } catch (err) {
            throw req.error(500, "An error occured:" + err.message);
        }
    });

    // delete table records
    srv.on("DELETE", "deleteEmployee", async (req) => {
        try {
            let returnData = await cds.transaction(req).run(
                DELETE.from(employee).where({ ID: req.data.ID })
            );

            if (returnData) {
                return { message: "Employee deleted successfully", data: req.data };
            } else {
                return req.error(404, "Employee not found.");
            }
        } catch (err) {
            return req.error(500, "An error occured:" + err.message);
        }
    });

}


module.exports = NewCQLService;