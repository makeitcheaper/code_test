import axios from 'axios';

const API_BASE_URL = 'http://localhost:3000/api/v1';

const client = axios.create({
  baseURL: API_BASE_URL,
  timeout: 5000,
  headers: {
    'Content-Type': 'application/json',
    Accept: 'application/json'
  }
});

export default client;
