
import Command from "./Command";
import files from '../specification/fares';
import Container from "./Container";
import Schema from "../storage/schema/Schema";

export default class InitDB implements Command {
    private schema: Schema;

    constructor(container: Container) {
        this.schema = container.get("schema");
    }

    async run(argv: string[]) {
        let results = [];

        for (const fileType in files) {
            for (const record of files[fileType].getRecordTypes()) {
                try {
                    results.push(this.schema.createSchema(record));
                }
                catch (err) {
                    console.log(err);
                }
            }
        }

        await Promise.all(results);

        console.log("Database schema created");
    }

}