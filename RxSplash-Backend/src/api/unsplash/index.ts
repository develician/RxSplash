import Router from "koa-router";
import { getPhotoList } from "./unsplash.ctrl";

const router = new Router();

router.get("/list", getPhotoList);

export default router;
