import fs from "node:fs";
import JSZip from "./jszip.min.mjs";

export function zip() {
  return new JSZip();
}

export function file(zip, fileName, data) {
  zip.file(fileName, data);
  return zip;
}

export async function out(zip, name) {
  fs.writeFileSync(name, await zip.generateAsync({ type: "nodebuffer" }));
}
