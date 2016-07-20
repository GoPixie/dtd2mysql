
import Command from "./Command";
import Container from "./Container";
import faresFeed from "../specification/fares";
import * as Bluebird from "bluebird";
import * as path from "path";
import * as readline from "readline";
import RecordStorage from "../storage/record/RecordStorage";
import FeedFile from "../feed/file/FeedFile";
import Schema from "../storage/schema/Schema";

const AdmZip = require("adm-zip");
const fs: any = Bluebird.promisifyAll(require("fs"));
const TMP_PATH = "/tmp/fares-feed/";

export default class ImportFaresFeed implements Command {
    private storage: RecordStorage;
    private schema: Schema;

    constructor(container: Container) {
        this.storage = container.get("record.storage");
        this.schema = container.get("schema");
    }

    async run(argv: string[]) {
        if (typeof argv[0] !== "string") {
            throw new Error("Please supply the path of the fares feed zip file.");
        }

        try {
            console.log("Truncating tables...");
            const truncatePromise = this.truncateTables();
            console.log("Extracting files...");
            new AdmZip(argv[0]).extractAllTo(TMP_PATH);

            await truncatePromise;
            console.log("Importing data...");
            await this.doImport();
            console.log("Data imported.");
        }
        catch (err) {
            console.log(err);
        }
    }

    async truncateTables() {
        const promises = [];

        for (const fileType in faresFeed) {
            for (const record of faresFeed[fileType].getRecordTypes()) {
                promises.push(this.storage.truncate(record.name));
            }
        }

        await Promise.all(promises);
    }

    async doImport() {
        const files = await fs.readdirAsync(TMP_PATH);
        const promises = [];

        for (const filename of files) {
            const file = faresFeed[path.extname(filename).slice(1)];

            if (!file) {
                continue;
            }

            // that's right, I'm awaiting a promise of promises o_0
            promises.concat(await this.processFile(file, filename));
        }

        await Promise.all(promises);
    }

    private processFile(file: FeedFile, filename: string) {
        const promises = [];
        const readEvents = readline.createInterface({
            input: fs.createReadStream(TMP_PATH + filename)
        });

        readEvents.on("line", line => {
            if (line.substr(0, 3) !== '/!!') {
                try {
                    const record = file.getRecord(line);
                    const data = record.extractRecord(line);

                    promises.push(this.storage.save(record.name, data));
                }
                catch (err) {
                    console.log(`Error processing ${filename} with data ${line}`);
                    console.log(err);
                }
            }
        });

        return new Promise((resolve, reject) => {
            readEvents.on('close', () => resolve(promises));
            readEvents.on('SIGINT', () => reject())
        });
    }
}