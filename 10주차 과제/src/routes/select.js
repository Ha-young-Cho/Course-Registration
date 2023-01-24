import express from 'express';
import { selectSql } from '../database/sql';

const router = express.Router();

router.get('/', async (req, res) => {
    const student = await selectSql.getStudent();
    
    res.render('select', {
        title: '나의 정보',
        student
    });
});

module.exports = router;