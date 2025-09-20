import mysql from "mysql"

export class DBConnection {
    constructor() {
        this.db = mysql.createConnection({
            host: "localhost",
            user: "apex_user",
            password: "senha123",
            database: "APEX_I"
        });

        this.db.connect((err) => {
            if (err) {
                console.error("Error connecting MySQL:", err);
                return;
            }
            console.log("Connected MySQL!");
        });
    }

    async execute(query) {
        return new Promise((resolve, reject) => {
            this.db.query(query, (err, results) => {
                if (err) {
                    console.error("Query error:", err);
                    return reject(err);
                }
                resolve(results);
            });
        });
    }
}