import mysql from 'mysql2';
import {S_id} from '../routes/login';

const pool = mysql.createPool(
    process.env.JAWSDB_URL ?? {
        host: 'localhost',
        user: 'root',
        database : "hw04",
        password: 'hyoungm41004!',
        waitForConnections: true,
        connectionLimit: 10,
        queueLimit:0,
    }
);

const promisePool = pool.promise();

export const selectSql = {
    getUsers: async () => {
        const [rows] = await promisePool.query(`select * from user`);

        return rows;
        
    },

    getStudent: async () => {
        const [rows] = await promisePool.query(`select * from student where S_id = ${S_id}`);

        return rows;
    },

    getClass: async () => {
        const [rows] = await promisePool.query(`select * from class where c_id in 
        (select c_id from take_class where s_id = "${S_id}")`);

        return rows;
    },

}

export const deleteSql = {
    deleteClass: async (data) => {
        console.log("deleteSql.deleteClass:", data.C_id);
        const sql = `delete from take_class 
        where C_id = "${data.C_id}" and S_id = "${S_id}"`;
        await promisePool.query(sql);
    },
};