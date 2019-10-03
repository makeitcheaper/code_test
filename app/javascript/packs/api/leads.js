import client from './client';

const create = (params) => {
  return client.post('/leads', params)
    .then(response => response.data);
};

export {
  create
};
