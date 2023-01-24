import express from "express";
import { selectSql, deleteSql} from "../database/sql";

const router = express.Router();

router.get('/',async(req,res)=>{
    const Class = await selectSql.getClass();
    res.render('delete',{
        title:"수강 취소가 가능한 수업",
        Class
    })
});

router.post('/', async(req,res)=>{
    console.log('delete router:',req.body.delBtn);
    const data = {
        C_id : req.body.delBtn,
    };
    await deleteSql.deleteClass(data);

    res.redirect('/delete');
});

module.exports = router;