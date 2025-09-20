import express from "express"
import cors from "cors"
import { DBConnection } from "./db_connect.js"
const app = express()
const port = process.env.PORT || 8080

app.use(cors())

app.get('/professor', async (req, res) => {
    const db = new DBConnection();
    const query = `
    SELECT 
        o.nome AS ong,
        a.nome AS aluno,
        a.area_interesse,
        p.nome AS professor,
        p.materia
    FROM aluno a
    JOIN professor p 
        ON a.idong = p.idong 
    AND a.area_interesse = p.materia
    JOIN ong o 
        ON a.idong = o.id
    ORDER BY o.nome, a.nome;
    `;

    try {
        const results = await db.execute(query);
        return res.status(200).json(results);
    } catch (err) {
        console.log(err);
        return res.status(500).json("Error while retrieving the teachers");
    }
})

app.get('/voluntario', async (req, res) => {
    const db = new DBConnection();
    const query = `
    SELECT 
        o.nome AS ong,
        v.nome AS voluntario,
        v.depto
    FROM voluntario v
    LEFT JOIN ong o 
        ON v.idong = o.id
    ORDER BY o.nome, v.nome;
    `;
    try {
        const results = await db.execute(query);
        return res.status(200).json(results);
    } catch (err) {
        return res.status(500).json("Error while retrieving the volunteers");
    }
})

app.listen(port, () => {
  console.log(`App listening on port ${port}`)
})