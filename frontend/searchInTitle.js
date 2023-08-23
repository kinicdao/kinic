import page_count_include_the_word from "./page_count_include_the_word.json";

const N_COUNT_DOCUMENTS = 724+853+333; // document count
const N_AVERAGE_COUNT_WORDS = (40674+191220+28772)/N_COUNT_DOCUMENTS; // document length
const N_AVERAGE_KIND_WORDS = (24261+90241+18266)/N_COUNT_DOCUMENTS// kinds of word in the document

export async function searchInTitle(serviceActor, query) {

  let candb_scan_limit = 30
  let sks = await serviceActor.getNextKeysForParallelSearchTitle(candb_scan_limit);
  console.log("debug")
  // sks.unshift([])

  let data = []
  let query_data = async (query, sk) => {
    return new Promise(async (resolve) => {
      let res = await serviceActor.searchTitle(query, sk, candb_scan_limit)
        .then(res => {
          return res
        })
        .catch(e => {
          console.log(e);
          throw e
        });
      if (res.length != 0) {
        // console.log("get")
        data.push(res)
      }
      // res.forEach((r) => {console.log(r)})
      // else console.log("non")
      resolve(res)
    });
  }

  const MAX = sks.length;
  const CONCURRENCY = 40;
  console.log("Max", MAX)
  let cnt = 0;
  let promises = [];

  promises.push(query_data(query, []))

  for (let i = 0; i < CONCURRENCY; i++) {
    let p = new Promise((resolve) => {
      (async function loop(index) {
        if (index < MAX) {
          await query_data(query, [sks[index]]);
          // console.log(index)
          loop(cnt++);
          return;
        }
        resolve();
      })(cnt++);
    });
    promises.push(p);
  }
  await Promise.all(promises);

  let res = data.flat()
  // console.log(sks)


  // const page_count_include_the_word = JSON.parse(fs.readFileSync("./page_count_include_the_word.json", 'utf8'));

  let hosts = res.map(([host, pages]) => {
    // console.log(host)
    let max_tf_idf_page = ['', '', 0.0];
    let total_it_idf_score = 0;
    pages.forEach(([title, path, count_words, kind_words, tfs]) => {
      let sum_tf_idf = 0;
      tfs.forEach((tf, i) => {
        let word = query[i];
        let wd = page_count_include_the_word[word];
        if (wd == null) wd = 1;
        let idf = Math.log2(N_COUNT_DOCUMENTS/wd) //  IDF[word]
        // similer Okapi BM25
        const k = 2.0;
        const b = 0.75;
        sum_tf_idf += idf*(((k+1)*tf) / (tf+k*(1-b+b*(N_AVERAGE_COUNT_WORDS/Number(count_words))))); // 通常のBM25は|d|/aver(D)だが、これだと文章が短い方が高スコアになってしまうので、逆にしている。
        // sum_tf_idf += idf*tf;
      });
      if (sum_tf_idf > max_tf_idf_page[2]) max_tf_idf_page = [title, path, sum_tf_idf];
      total_it_idf_score += sum_tf_idf;
    });

    let show_page = [];
    if (pages[0][1] == "") {
      show_page = pages[0];
    }
    else {
      show_page = max_tf_idf_page;
    };
    
    // console.log(host, show_page[0], show_page[1], total_it_idf_score);
    return [host, show_page[0], show_page[1], total_it_idf_score]
  });
  
  return hosts

};