import express from "express";
import logger from "morgan";
import path from "path";
import liveReload from 'livereload';
import connectLiveReload from 'connect-livereload';

import loginRouter from "./routes/login";
import logoutRouter from './routes/logout';
import selectRouter from "./routes/select";

const PORT = 3000;

// 0.1초마다 refresh -> 웹에서 새로고침하지 않아도 파일이 변경되면 자동 변경
const liveReloadServer = liveReload.createServer();
liveReloadServer.server.once("connection", () => {
  setTimeout(() => {
    liveReloadServer.refresh('/');
  }, 100)
});

const app = express();

app.use(connectLiveReload());

app.use(express.urlencoded({ extended: false }));
app.use(express.json());

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "hbs");
app.use(express.static(path.join(__dirname, 'public'))) //hbs가 css를 불러오기 위해 경로 설정

app.use(logger("dev"));

app.use("/", loginRouter);
app.use("/logout", logoutRouter);
app.use("/sugang", selectRouter);

app.listen(PORT, () => {
  console.log(`Example app listening at http://localhost:${PORT}`);
});
