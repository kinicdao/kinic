
export async function fetchMetadata(serviceActor, hosts) {

  let get_metadata = async (canisterid) => {
    return new Promise(async (resolve) => {
      let res = await serviceActor.searchCanisterId(canisterid);
      resolve(res)
    });
  };

  // limit 30
  if (20 < hosts.length) {
    hosts = hosts.slice(0, 20)
  };
  let promises = [];
  hosts.map((host) => {
    promises.push(get_metadata(host.canisterid))
  });
  
  let res = await Promise.all(promises);

  return res;
};