import Router from "koa-router";
import unsplash from "./unsplash";

const router = new Router();

router.use("/unsplash", unsplash.routes());

export default router;
