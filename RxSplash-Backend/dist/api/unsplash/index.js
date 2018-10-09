"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var koa_router_1 = __importDefault(require("koa-router"));
var unsplash_ctrl_1 = require("./unsplash.ctrl");
var router = new koa_router_1.default();
router.get("/list", unsplash_ctrl_1.getPhotoList);
exports.default = router;
