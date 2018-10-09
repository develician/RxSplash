import Unsplash, { toJson } from "unsplash-js";
import { Context } from "koa";
require("es6-promise").polyfill();
require("isomorphic-fetch");

const unsplash = new Unsplash({
  applicationId:
    "17c40354e7c79eae3c9c499e63ebd55b72cf2b024b77dfa9b52265813bb350be",
  secret: "57e43f0e3abe95ffd79c9415cd30e18761d93b4418c699527dabeb8c607ca7af",
  callbackUrl: "urn:ietf:wg:oauth:2.0:oob"
});

export const getPhotoList = async (ctx: Context) => {
  const { page = 1, perPage = 15, orderBy = "latest" } = ctx.request.query;

  await unsplash.photos
    .listPhotos(page, perPage, orderBy)
    .then(toJson)
    .then((json: any) => {
      ctx.body = json;
      ctx.status = 200;
    });
};
