import express from "express";
import {selectSql} from "../database/sql";

const router = express.Router();

let S_id ="";
export {S_id};

router.get('/',(req,res)=>{
    res.render('login');
});

router.post('/', async(req,res)=>{
    const vars = req.body;
    const users = await selectSql.getUsers();
    let whoAmI = '';
    let checkLogin = false;

    users.map((user)=>{
        console.log(user.Id);
        if(vars.id === user.Id && vars.password === user.Password){
            console.log('login success!');
            checkLogin = true;
            if(vars.id === 'admin'){
                whoAmI = 'admin';
            }else{
                whoAmI = 'student';
            }
        }
    })

    S_id = vars.id;

    if(checkLogin && whoAmI==='admin'){
        res.redirect('/select');
    }else if(checkLogin && whoAmI === 'student'){
        res.redirect('/select');
    }else{
        console.log('login failed!');
        res.send("<script>alert('로그인에 실패했습니다.'); location.href='/';</script>");
    }

})

module.exports = router;