import express from "express";
import {selectSql} from "../database/sql";

const router = express.Router();

router.get('/',async function(req,res){
    const building = await selectSql.getBuilding();
    const inha_class = await selectSql.get_Inha_Class();
    const club = await selectSql.getClub();
    const department = await selectSql.getDepartment();
    const employee = await selectSql.getEmployee();
    const room = await selectSql.getRoom();
    const student = await selectSql.getStudent();
    const take_class = await selectSql.get_Take_Class();
    const take_club = await selectSql.get_Take_Club();

    res.render('select',{
        title:'건물 테이블',
        title2: '수업 테이블',
        title3:'동아리 테이블',
        title4: '학과 테이블',
        title5:'직원 테이블',
        title6: '강의실 테이블',
        title7: '학생 테이블',
        title8:'수업 수강 테이블',
        title9: '동아리 참여 테이블',
        building,
        inha_class,
        club,
        department,
        employee,
        room,
        student,
        take_class,
        take_club
    });
});

module.exports = router;