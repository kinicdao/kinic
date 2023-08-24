
export async function fetchMetadata(serviceActor, hosts) {

  let get_metadata = async (host) => {
    return new Promise(async (resolve) => {
      let res = await serviceActor.searchCanisterId(host.canisterid);
      res = JSON.parse(res)
      res.title = host.title; // overwrite only title because the metadata might be older
      resolve(res)
    });
  };

  // limit 30
  if (20 < hosts.length) {
    hosts = hosts.slice(0, 20)
  };
  let promises = [];
  hosts.map((host) => {
    promises.push(get_metadata(host))
  });
  
  let res = await Promise.all(promises);

  res = res.flat();
  // console.log(res)
  return res
};