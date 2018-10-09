"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var koa_1 = __importDefault(require("koa"));
var koa_router_1 = __importDefault(require("koa-router"));
var koa_bodyparser_1 = __importDefault(require("koa-bodyparser"));
var api_1 = __importDefault(require("./api"));
var port = 4000;
var app = new koa_1.default();
var router = new koa_router_1.default();
app.use(koa_bodyparser_1.default());
router.use("/api", api_1.default.routes());
app.use(router.routes()).use(router.allowedMethods());
app.listen(port, function () {
    console.info("app is running on port", port);
});
