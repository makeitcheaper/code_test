import axios from 'axios';
import qs from 'qs';

const AUTH = {
  pGUID: process.env.LEAD_API_PGUID,
  pAccName: process.env.LEAD_API_PACCNAME,
  pPartner: process.env.LEAD_API_PPARTNER,
  access_token: process.env.LEAD_API_ACCESS_TOKEN,
  notes: 'Luke Bennett code test',
};

const client = axios.create({
  baseURL: `${process.env.LEAD_API_URI}/api/v1/`,
  // baseURL: `http://7c9e3e84.ngrok.io`,
  headers: { 'content-type': 'application/x-www-form-urlencoded' },
});

client.interceptors.request.use((config) => {
  config.data = qs.stringify(Object.assign({}, config.data, AUTH));

  return config;
});

export default client;
