"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var koa_router_1 = __importDefault(require("koa-router"));
var unsplash_1 = __importDefault(require("./unsplash"));
var router = new koa_router_1.default();
router.use("/unsplash", unsplash_1.default.routes());
exports.default = router;
