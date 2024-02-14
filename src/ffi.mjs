import fs from "node:fs";
import crypto from "node:crypto";
import JSZip from "./jszip.min.mjs";

export function zip() {
  return new JSZip();
}

export function file(zip, fileName, data) {
  zip.file(fileName, data);
  return zip;
}

export function fromFile(zip, fileName, otherFileNameOrBitArray) {
  zip.file(
    fileName.startsWith("./") ? process.cwd() + fileName : fileName,
    otherFileNameOrBitArray.buffer ?? fs.readFileSync(otherFileNameOrBitArray)
  );
  return zip;
}

export async function out(zip, name) {
  fs.writeFileSync(name, await zip.generateAsync({ type: "nodebuffer" }));
}

export function md5(bitArray) {
  return crypto
    .createHash("md5")
    .update(Buffer.from(bitArray.buffer))
    .digest("hex");
}
