module.exports = cds.service.impl(async function () {
    const { employee } = this.entities;

    this.on('hike', async req => {
        const { ID } = req.data;

        if (!ID) {
            return req.reject(400, 'ID is required.');
        }
        console.log(`Received request to increment salary for Employee with ID: ${ID}`);

        // Start transaction
        const tx = cds.transaction(req);

        try {
            // Retrieve the current salary of the employee
            const employees = await tx.read(employee).where({ ID });

            if (!employees.length) {
                return req.reject(404, `Employee with ID ${ID} not found.`);
            }

            let currentSalary = employees[0].salaryAmount;
            console.log(`Current salary of Employee with ID ${ID}: ${currentSalary}`);

            currentSalary = currentSalary + 5000;

            // Update salary
            const updatedCount = await tx.update(employee)
                .set({ salaryAmount: currentSalary })
                .where({ ID });

            if (!updatedCount) {
                return req.reject(500, `Failed to update salary for Employee with ID ${ID}.`);
            }

            // Commit transaction
            await tx.commit();
            console.log(`Salary updated successfully for Employee with ID ${ID}`);

        } catch (error) {
            console.error("Error during hike action:", error);
            return req.reject(500, `Error: ${error.message}`);
        }

        cds.tx(async () => {
            //const updatedEmployee = await this.run(SELECT.from(employee).where({ ID }));

            const updatedEmployee = await SELECT.from(employee, ID);

            return { message: "Incremented", employee: updatedEmployee };
        })

    });
});
