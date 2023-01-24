import mysql from "mysql2";
import {S_id} from '../routes/login';

// 데이터베이스 연결
const pool = mysql.createPool(
  process.env.JAWSDB_URL ?? {
    host: 'localhost',
    user: 'root',
    database: 'hw04',
    password: 'hyoungm41004!',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
  }
);

// async / await 사용
const promisePool = pool.promise();

// select query
export const selectSql = {
  getUsers: async () => {
    const [rows] = await promisePool.query(`select * from student`);

    return rows
  },
  getClass: async () => {
    const [rows] = await promisePool.query(`select * from class`);

    return rows;
  },
}

export const updateSql = {
  updateAvailability: async (data) => {
    const sql = `update class set 
        availability = (availability - 1) 
        where C_id = "${data.C_id}"`;
    const sql2 = `insert into take_class values ((select S_id from student where S_name = "${data.S_name}"), "${data.C_id}")`;
    await promisePool.query(sql);
    await promisePool.query(sql2);
  }
}