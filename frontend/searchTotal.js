// See https://forum.dfinity.org/t/using-dfinity-agent-in-node-js/6169/55

import { Actor, HttpAgent } from "@dfinity/agent";
import { createActor as ServiceCreateActor } from "./tf_storage_service/index.js"; // Need to commentout "export const main = createActor(canisterId);" in this file.

import {searchContent} from "./searchContent.js";
import {searchTitle} from "./searchTitle.js";

const N_COUNT_DOCUMENTS = 724+853+333; // document count
const N_AVERAGE_COUNT_WORDS = (40674+191220+28772)/N_COUNT_DOCUMENTS; // document length
const N_AVERAGE_KIND_WORDS = (24261+90241+18266)/N_COUNT_DOCUMENTS// kinds of word in the document

export async function searchTotal(serviceCanisterId, query) {
  // set service canister client
  const fetch = window.fetch.bind(window);
  const agent = new HttpAgent({
    // host: "https://ic0.app",
    host: "http://127.0.0.1:8080",
    fetch,
  });
  const serviceActor = ServiceCreateActor(serviceCanisterId, {agent});
  console.log(serviceActor)

  console.log(await serviceActor.getPK())


  console.log("1")
  let hosts_content = await searchContent(serviceActor, query);
  console.log("2")
  let hosts_title = await searchTitle(serviceActor, query);
  console.log("3")


  const weight = 0.5;
  // delete duplication
  hosts_title = hosts_title.filter(([host, t, p, title_score]) => {
    for (let i = 0; i < hosts_content.length; i++) {
      if (hosts_content[i][0] == host) {
        let content_score = hosts_content[i][3];
        let total_score =  content_score + weight * title_score;
        hosts_content[i] = [host,  hosts_content[i][1],  hosts_content[i][2], total_score]
        return null
      };
    };
    return [host, t, p, weight*title_score];
  });

  // merge
  let hosts = hosts_content.concat(hosts_title);
  // console.log(hosts.length)

  let sorted_by_tf_idf = hosts.sort(function(a, b){
    return b[3] -  a[3]
  });

  let j = sorted_by_tf_idf.map(([h, t, p, s]) => {
    let info = {
      "id": 0,
      "canisterid": h,
      "subnetid": "sample-subnetid",
      "type": "app",
      "datalength": 80,
      "lastseen": "2023-08-10",
      "title": t,
      "subtitle": "sample-subtitle",
      "content": "",
      "apptype": "",
      "note": "",
      "status": "",
      "notnull": ""
    };

    return info
  });


  return j;
};