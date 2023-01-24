import mysql from "mysql2";

const pool = mysql.createPool(
    process.env.JAWSDB_URL ?? {
        host: 'localhost',
        user:'root',
        database:'hw04',
        password: 'hyoungm41004!',
        waitForConnections:true,
        connectionLimit:10,
        queueLimit:0
    }
);

const promisePool = pool.promise();

export const selectSql={
    getBuilding:async()=>{
        const [rows] =await promisePool.query(`select * from building`);
        console.log(rows)
        return rows
    },
    get_Inha_Class:async()=>{
        const [rows] =await promisePool.query(`select * from class`);
        console.log(rows)
        return rows
    },
    getClub:async()=>{
        const [rows] =await promisePool.query(`select * from club`);
        console.log(rows)
        return rows
    },
    getDepartment:async()=>{
        const [rows] =await promisePool.query(`select * from department`);
        console.log(rows)
        return rows
    },
    getEmployee:async()=>{
        const [rows] =await promisePool.query(`select * from employee`);
        console.log(rows)
        return rows
    },
    getRoom:async()=>{
        const [rows] =await promisePool.query(`select * from room`);
        console.log(rows)
        return rows
    },
    getStudent:async()=>{
        const [rows] =await promisePool.query(`select * from student`);
        console.log(rows)
        return rows
    },
    get_Take_Class:async()=>{
        const [rows] =await promisePool.query(`select * from take_class`);
        return rows
    },
    get_Take_Club:async()=>{
        const [rows] =await promisePool.query(`select * from take_club`);
        return rows
    },
}

export const insertSql = {
    setStudent:async(data)=>{
        const sql = `insert into student values(
            "${data.S_id}", "${data.S_name}", "${data.S_email}","${data.Major}", "${data.D_id}", "${data.S_phone_number}")`;
            
            await promisePool.query(sql);
    },
}

export const updateSql = {
    updateStudent:async(data)=>{
        const sql = `update student set 
        S_id= "${data.S_id}",
        S_name= "${data.S_name}", 
        S_email= "${data.S_email}",
        major = "${data.Major}",
        D_id= "${data.D_id}",
        S_phone_number= "${data.S_phone_number}"
        where S_id = "${data.S_id}"`;
        await promisePool.query(sql);
    },
}