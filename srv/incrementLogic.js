const { message } = require("@sap/cds/lib/log/cds-error");


module.exports = cds.service.impl(async function () {
    const { employee } = this.entities;
    
    this.on('hike', async req => {
        const { ID } = req.data;
        if (!ID) {
            return req.reject(400, 'ID is required.');
        }
        console.log(`Received request to increment salary for Employee with ID : ${ID}`);
     
        const tx = cds.transaction(req);
        try {
            const employees = await tx.read(employee).where({ ID });
            if (!employees || employees.length === 0) {
                return req.reject(404, `Employee with ID ${ID} not found.`);
            }
     
            const currentSalary = employees[0].salaryAmount;
            console.log(`Current salary of employee with ID ${ID}: ${currentSalary}`);
     
            const updatedSalary = currentSalary + 5000;
            await tx.update(employee).set({ salaryAmount: updatedSalary }).where({ ID });
            console.log(`Salary updated for employee with ID ${ID}`);
     
            await tx.commit();
            console.log(`Transaction committed successfully.`);
     
            return req.reply({
                message: "Incremented",
                employee: { ID, salaryAmount: updatedSalary },
            });
        } catch (error) {
            console.error(`Error during hike action for employee ID ${ID}:`, error);
            await tx.rollback();
            return req.reject(500, `Error: ${error.message}`);
        }
     });
     
   });


