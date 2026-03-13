const path = require('path');

module.exports = {
  entry: './src/index.js',
  output: {
    filename: 'rte.js',
    path: path.resolve(__dirname, '..'),
    library: {
      name: 'RteSdk',
      type: 'window',
    },
  },
};
