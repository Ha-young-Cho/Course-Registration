import express from "express";
import {insertSql, selectSql} from "../database/sql";

const router = express.Router();

router.get('/',(req,res)=>{
    res.render('home');
});

router.post('/',(req,res)=>{
    const vars = req.body;
    
    const data = {
        S_id : vars.s_id,
        S_name : vars.s_name,
        S_email : vars.s_email,
        Major : vars.major,
        D_id : vars.d_id,
        S_phone_number : vars.s_phone_number
    };

    insertSql.setStudent(data);

    res.redirect('/');
})

module.exports = router;