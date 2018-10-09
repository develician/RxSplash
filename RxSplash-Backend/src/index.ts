import Koa from "koa";
import Router from "koa-router";
import bodyParser from "koa-bodyparser";
import api from "./api";

const port = 4000;

const app = new Koa();
const router = new Router();

app.use(bodyParser());

router.use("/api", api.routes());
app.use(router.routes()).use(router.allowedMethods());

app.listen(port, () => {
  console.info("app is running on port", port);
});
