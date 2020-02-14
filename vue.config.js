module.exports = {
  publicPath: process.env.NODE_ENV === 'production' ? '/apollonian-gasket/' : '/',
  chainWebpack: config => {
    config.module
      .rule('json')
      .test(/\.gasket$/)
      .use('json-loader')
        .loader('json-loader')
        .end()
  }
}
