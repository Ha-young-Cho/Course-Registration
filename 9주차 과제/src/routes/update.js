import express from 'express';
import {selectSql, updateSql} from '../database/sql';

const router = express.Router();

router.get('/student', async (req, res) => {
    const stu_res = await selectSql.getStudent();
    res.render('updateStudent', {
        title: '학생 테이블 갱신',
        stu_res
    });
});

router.post('/student', async (req, res) => {
    const vars = req.body;
    console.log(vars.s_name);

    const data = {
        S_id: vars.s_id,
        S_name: vars.s_name,
        S_email: vars.s_email,
        Major: vars.major,
        D_id: vars.d_id,
        S_phone_number: vars.s_phone_number
    }
    await updateSql.updateStudent(data);

    res.redirect('/select');
});

module.exports = router;