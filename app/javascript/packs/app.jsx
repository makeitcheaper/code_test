import React from 'react';
import ReactDOM from 'react-dom';
import Dashboard from './containers/Dashboard';

document.addEventListener(
  'DOMContentLoaded',
  () => {
    ReactDOM.render(
      <Dashboard />,
      document.getElementById('root')
    );
  }
);
