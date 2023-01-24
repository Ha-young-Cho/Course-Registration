import express from "express";
import { selectSql, updateSql } from "../database/sql";

const router = express.Router();

router.get('/', async function (req, res) {
    const Class = await selectSql.getClass();

    if (req.cookies.user) {
        res.render('select', { 
            'user': req.cookies.user,
            title: '수강중인 수업',
            Class
        });
        
    } else {
        res.render('/')
    }

});

router.post('/', async(req,res)=>{
    const data = {
        S_name : req.cookies.user,
        C_id : req.body.admitBtn
    };
    await updateSql.updateAvailability(data);

    res.redirect('/sugang');
});

module.exports = router;